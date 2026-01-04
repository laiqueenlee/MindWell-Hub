<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book Counselling Session | MindWell</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #17a88b;
            --primary-hover: #138d74;
            --bg-gradient: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
            --text-main: #1f2937;
            --text-muted: #6b7280;
        }

        body { 
            margin: 0; padding: 0; 
            font-family: 'Inter', sans-serif; 
            background: var(--bg-gradient);
            color: var(--text-main);
            min-height: 100vh;
        }

        .container { max-width: 1200px; margin: auto; padding: 60px 20px; }
        header { text-align: center; margin-bottom: 50px; }
        h1 { font-size: 36px; font-weight: 800; margin-bottom: 12px; }
        .subtitle { color: var(--text-muted); font-size: 18px; max-width: 600px; margin: 0 auto; }

        .cards-grid { 
            display: grid; 
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); 
            gap: 32px; 
        }

        .card { 
            background: #ffffff; 
            border-radius: 20px; 
            box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1); 
            display: flex; flex-direction: column; overflow: hidden; 
            transition: transform 0.2s ease;
        }

        .card:hover { transform: translateY(-5px); }

        .image-wrapper { width: 100%; height: 220px; background: #f3f4f6; overflow: hidden; }
        .card img { width: 100%; height: 100%; object-fit: cover; display: block; }

        .card-content { padding: 24px; flex-grow: 1; display: flex; flex-direction: column; }
        .mhp-name { font-size: 20px; font-weight: 700; margin: 0 0 12px 0; }
        .mhp-info { font-size: 14px; color: var(--text-muted); margin: 4px 0; }

        .slots-section { margin-top: 20px; flex-grow: 1; }
        .section-label { font-size: 11px; font-weight: 700; text-transform: uppercase; color: var(--text-muted); margin-bottom: 10px; }

        .slots-scroll { 
            max-height: 100px; overflow-y: auto; 
            display: flex; flex-wrap: wrap; gap: 6px; 
            margin-bottom: 20px;
        }

        .slot-pill { background: #f3f4f6; color: #374151; padding: 4px 10px; border-radius: 6px; font-size: 11px; font-weight: 500; }

        .btn-book { 
            width: 100%; padding: 14px; 
            background: var(--primary); border: none; color: #fff; 
            font-size: 16px; border-radius: 10px; cursor: pointer; font-weight: 600; 
            transition: background 0.2s; 
        }
        .btn-book:hover { background: var(--primary-hover); }
        .empty-state { color: #9ca3af; font-size: 12px; font-style: italic; }
        .message-banner { background: #dcfce7; color: #166534; padding: 16px; border-radius: 12px; margin-bottom: 30px; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/includes/navbar.jsp" />

<div class="container">
    <header>
        <h1>Find Your Counselor</h1>
        <p class="subtitle">Secure, confidential support from qualified professionals.</p>
    </header>

    <c:if test="${not empty param.success}">
        <div class="message-banner">✓ Your booking request has been sent!</div>
    </c:if>

    <div class="cards-grid">
        <c:forEach var="mhp" items="${mhps}">
            <div class="card">
                <div class="image-wrapper">
                    <img src="${pageContext.request.contextPath}/images/mhp${mhp.username}.jpg" 
                         onerror="this.onerror=null;this.src='https://ui-avatars.com/api/?name=${mhp.fullName}&background=random&size=200';" 
                         alt="${mhp.fullName}">
                </div>

                <div class="card-content">
                    <h3 class="mhp-name">Dr. ${mhp.fullName}</h3>
                    <p class="mhp-info"><strong>Role:</strong> ${mhp.role}</p>
                    <p class="mhp-info"><strong>Email:</strong> ${mhp.email}</p>

                    <div class="slots-section">
                        <div class="section-label">Routine Preview</div>
                        <div class="slots-scroll">
                            <c:choose>
                                <c:when test="${not empty availableSlotsMap[mhp.username]}">
                                    <c:forEach var="slot" items="${availableSlotsMap[mhp.username]}">
                                        <span class="slot-pill">${slot}</span>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <span class="empty-state">No weekly slots listed.</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <form action="${pageContext.request.contextPath}/sessions/book" method="post">
                        <input type="hidden" name="mhpId" value="${mhp.id}"/>
                        <button type="submit" class="btn-book">Request Booking</button>
                    </form>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>