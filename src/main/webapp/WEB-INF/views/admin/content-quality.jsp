<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"> 
    <title>Content Quality</title>
    <link rel="icon" href="data:,">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f9fafb;
            margin: 0;
            padding: 40px;
        }

        .cq-main-card {
            background: white;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            border: 1px solid #e5e7eb;
        }

        .cq-header-section { margin-bottom: 24px; }
        .cq-page-title { font-size: 20px; font-weight: 600; margin: 0; color: #111827; }
        .cq-page-subtitle { font-size: 14px; color: #6b7280; margin-top: 4px; }

        .cq-metrics-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .cq-metric-card {
            background: white;
            border-radius: 12px;
            border: 1px solid #e5e7eb;
            padding: 20px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            transition: 0.2s ease;
        }
        .cq-metric-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }

        .cq-metric-header { display: flex; align-items: center; gap: 8px; margin-bottom: 10px; font-size: 15px; font-weight: 600; }
        .status-published { color: #06b6d4; } 
        .status-review { color: #3b82f6; } 
        .status-flagged { color: #ec4899; } 

        .cq-metric-value { font-size: 28px; font-weight: 700; color: #111827; margin-bottom: 4px; }
        .cq-metric-sub { font-size: 14px; color: #6b7280; }

        .cq-list-header { font-size: 18px; font-weight: 600; margin-bottom: 16px; color: #111827; }

        .cq-content-item {
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 16px 20px;
            margin-bottom: 12px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: 0.2s ease;
        }
        .cq-content-item:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }

        .cq-content-info { display: flex; flex-direction: column; }
        .cq-content-title { font-size: 16px; font-weight: 700; color: #111827; margin-bottom: 2px; }
        .cq-content-stats { font-size: 13px; color: #6b7280; }

        .cq-rating-box { font-size: 16px; font-weight: 700; color: #111827; display: flex; align-items: center; gap: 6px; }
        .star-icon { color: #ffc107; font-size: 16px; }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/includes/admin-header.jsp" />

    <div class="cq-main-card">
        
        <div class="cq-header-section">
            <h2 class="cq-page-title">Content Performance Overview</h2>
            <p class="cq-page-subtitle">Quality metrics and engagement</p>
        </div>

        <div class="cq-metrics-grid">
            <div class="cq-metric-card">
                <div class="cq-metric-header status-published">
                    <i class="bi bi-check-circle"></i>
                    <span>Published</span>
                </div>
                <div class="cq-metric-value">${publishedCount}</div>
                <div class="cq-metric-sub">All content types</div>
            </div>

            <div class="cq-metric-card">
                <div class="cq-metric-header status-review">
                    <i class="bi bi-activity"></i>
                    <span>In Review</span>
                </div>
                <div class="cq-metric-value">${pendingCount}</div>
                <div class="cq-metric-sub">Pending approval</div>
            </div>

            <div class="cq-metric-card">
                <div class="cq-metric-header status-flagged">
                    <i class="bi bi-x-circle"></i>
                    <span>Flagged</span>
                </div>
                <div class="cq-metric-value">${flaggedCount}</div>
                <div class="cq-metric-sub">Needs attention</div>
            </div>
        </div>

       <div class="cq-list-section" id="contentListContainer">
            <h4 class="cq-list-header">All Content</h4>

            <c:if test="${empty contentList}">
                <p style="color:#9ca3af; text-align:center; padding: 40px;">No content available.</p>
            </c:if>

            <c:forEach var="content" items="${contentList}">
                <c:if test="${content.status == 'Published'}">
                    
                    <c:set var="rawRating" value="${ratingMap[content.id]}" />
                    <c:set var="displayRating" value="${rawRating != null ? rawRating : 0}" />

                    <div class="cq-content-item" data-rating="${displayRating}">
                        <div class="cq-content-info">
                            <span class="cq-content-title">${content.title}</span>
                            <span class="cq-content-stats">${content.category}</span>
                        </div>
                        
                        <div class="cq-rating-box">
                            <i class="bi bi-star-fill star-icon"></i>
                            
                            <c:choose>
                                <c:when test="${displayRating > 0}">
                                    <fmt:formatNumber value="${displayRating}" type="number" minFractionDigits="1" maxFractionDigits="1" />
                                </c:when>
                                <c:otherwise>
                                    N/A
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:if>
            </c:forEach>

        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const container = document.getElementById('contentListContainer');
            const items = Array.from(container.querySelectorAll('.cq-content-item'));
            items.sort((a, b) => {
                const ratingA = parseFloat(a.getAttribute('data-rating')) || 0;
                const ratingB = parseFloat(b.getAttribute('data-rating')) || 0;
                return ratingB - ratingA;
            });
            items.forEach(item => container.appendChild(item));
        });
    </script>

</body>
</html>
