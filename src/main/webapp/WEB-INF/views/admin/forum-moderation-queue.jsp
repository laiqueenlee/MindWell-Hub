<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Moderation Queue</title>
    <link rel="icon" href="data:,">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        /* Global Body (MATCHED) */
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f9fafb;
            margin: 0;
            padding: 40px;
        }

        /* Main Card (MATCHED) */
        .mq-main-card {
            background: white;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            border: 1px solid #e5e7eb;
        }

        /* Header */
        .mq-header-section { margin-bottom: 24px; }
        .mq-page-title {
            font-size: 20px;
            font-weight: 600;
            margin: 0;
            color: #111827;
        }
        .mq-page-subtitle {
            font-size: 14px;
            color: #6b7280;
            margin-top: 4px;
        }

        /* Item Cards */
        .mq-item-card {
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 16px;
            transition: 0.2s ease;
        }
        .mq-item-card:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }

        .mq-tags-row {
            display: flex;
            gap: 8px;
            margin-bottom: 12px;
            align-items: center;
        }

        .mq-tag-type {
            border: 1px solid #e5e7eb;
            color: #374151;
            font-size: 12px;
            font-weight: 500;
            padding: 4px 10px;
            border-radius: 6px;
            background-color: #f3f4f6;
        }

        .mq-badge {
            font-size: 12px;
            font-weight: 600;
            padding: 4px 12px;
            border-radius: 9999px;
            color: white;
            text-transform: lowercase;
        }
        .priority-medium { background-color: #14b8a6; }

        .mq-content-title {
            font-size: 16px;
            font-weight: 700;
            color: #111827;
            margin-bottom: 4px;
            display: block;
        }

        .mq-content-author {
            font-size: 14px;
            color: #6b7280;
            margin-bottom: 12px;
            display: block;
        }

        .mq-flag-reason {
            font-size: 14px;
            color: #6b7280;
            margin-bottom: 16px;
        }

        /* Buttons (MATCHED COLORS) */
        .mq-actions { display: flex; gap: 10px; }

        .btn-mq {
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            border: none;
            display: inline-block;
            transition: 0.2s ease;
        }

        .btn-approve { background-color: #06b6d4; color: white; }
        .btn-review {
            background-color: white;
            border: 1px solid #d1d5db;
            color: #374151;
        }
        .btn-remove { background-color: #ec4899; color: white; }
        .btn-flag { background-color: #f59e0b; color: white; }
        .btn-cancel { background-color: #e5e7eb; color: #374151; }

        /* Modal (MATCHED) */
        .modal-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background-color: rgba(0,0,0,0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
            backdrop-filter: blur(2px);
        }

        .modal-box {
            background: white;
            border-radius: 12px;
            width: 90%;
            max-width: 800px;
            padding: 30px;
            display: flex;
            flex-direction: column;
            max-height: 90vh;
            box-shadow: 0 20px 25px -5px rgba(0,0,0,0.1);
            animation: modalFadeIn 0.2s ease-out;
        }

        @keyframes modalFadeIn {
            from { transform: translateY(10px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            border-bottom: 1px solid #e5e7eb;
            padding-bottom: 15px;
        }

        .modal-title {
            font-size: 18px;
            font-weight: 700;
            color: #111827;
        }

        .close-btn {
            background: none;
            border: none;
            font-size: 24px;
            color: #9ca3af;
            cursor: pointer;
        }

        .modal-body {
            flex-grow: 1;
            overflow-y: auto;
            margin-bottom: 25px;
            padding-right: 10px;
        }

        .detail-label {
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            color: #6b7280;
            display: block;
            margin-bottom: 4px;
        }

        .detail-value {
            font-size: 15px;
            color: #111827;
        }

        .full-content-preview {
            background: #f9fafb;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #f3f4f6;
            font-size: 14px;
            line-height: 1.6;
            margin-top: 10px;
        }

        .correct-answer {
            color: #059669;
            font-weight: bold;
        }

        .modal-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            padding-top: 15px;
            border-top: 1px solid #e5e7eb;
        }

        /* Flag Form */
        #flagFormContainer {
            display: none;
            margin-top: 15px;
            background: #fffbeb;
            border: 1px solid #fcd34d;
            padding: 15px;
            border-radius: 8px;
        }

        .flag-textarea {
            width: 100%;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            padding: 8px;
            font-family: inherit;
            font-size: 14px;
            margin-bottom: 10px;
            resize: vertical;
        }
    </style>
</head>

<body>

    <jsp:include page="/WEB-INF/views/includes/admin-header.jsp" />

    <div>
        <div class="mq-main-card">
            
            <div class="mq-header-section">
                <h2 class="mq-page-title">Content Moderation Queue</h2>
                <p class="mq-page-subtitle">Items requiring review</p>
            </div>

            <c:if test="${not empty moderationItems}">
                <c:forEach var="item" items="${moderationItems}">
                    <div class="mq-item-card">

                        <div class="mq-tags-row">
                            <span class="mq-tag-type">${item.category}</span>
                            <span class="mq-badge priority-medium">Pending</span>
                        </div>

                        <span class="mq-content-title">${item.title}</span>
                        <span class="mq-content-author">by ${not empty item.author ? item.author : 'Unknown'}</span>
                        
                        <div class="mq-flag-reason">
                            <c:choose>
                                <%-- 1. IF ITEM IS FLAGGED: Show Warning Status and Reason Box --%>
                                <c:when test="${item.status == 'Flagged'}">
                                    <div style="display: flex; flex-direction: column; gap: 8px;">
                                        <div>
                                            Status: <span style="color:#f59e0b; font-weight:700;">
                                                <i class="bi bi-flag-fill"></i> ${item.status}
                                            </span>
                                        </div>
                                        
                                        <div style="background-color: #fffbeb; border: 1px solid #fcd34d; padding: 10px; border-radius: 6px; font-size: 13px; color: #92400e;">
                                            <strong>Reason for flagging:</strong><br>
                                            ${not empty item.flagReason ? item.flagReason : 'No reason provided.'}
                                        </div>
                                    </div>
                                </c:when>

                                <%-- 2. ELSE: Show Standard Status --%>
                                <c:otherwise>
                                    Status: <span style="color:#10b981; font-weight:600;">${item.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="mq-actions">
                            <a href="${pageContext.request.contextPath}/admin/moderation/approve/${item.id}" 
                               class="btn-mq btn-approve"
                               onclick="return confirm('Approve this published content?');">
                               Approve
                            </a>
                            
                            <button type="button" class="btn-mq btn-review" 
                                data-id="${item.id}"
                                data-title="${fn:escapeXml(item.title)}"
                                data-author="${not empty item.author ? fn:escapeXml(item.author) : 'Unknown'}"
                                onclick="openReviewModal(this)">
                               Review 
                            </button>
                            
                            <a href="${pageContext.request.contextPath}/admin/moderation/remove/${item.id}" 
                               class="btn-mq btn-remove"
                               onclick="return confirm('Are you sure you want to REMOVE this published content?');">
                               Remove
                            </a>
                        </div>

                        <div id="content-details-${item.id}" style="display:none;">
                            <div class="full-content-preview">
                                <p><strong>Description:</strong> ${item.description}</p>
                                <hr style="margin: 15px 0; border: 0; border-top: 1px solid #e5e7eb;">

                                <c:if test="${item.type == 'Article'}">
                                    <c:forEach var="sec" items="${item.articleSections}">
                                        <div style="margin-bottom: 20px;">
                                            <h4 style="font-size: 16px;">${sec.subtitle}</h4>
                                            <div>${sec.body}</div>
                                        </div>
                                    </c:forEach>
                                </c:if>

                                <c:if test="${item.type == 'Video'}">
                                    <c:forEach var="vid" items="${item.videoSections}">
                                        <div style="margin-bottom: 15px;">
                                            <p><strong>Video URL:</strong> <a href="${vid.videoUrl}" target="_blank" style="color:#2563eb;">${vid.videoUrl}</a></p>
                                            <p><strong>Description:</strong> ${vid.description}</p>
                                        </div>
                                    </c:forEach>
                                </c:if>

                                <c:if test="${item.type == 'Interactive'}">
                                    <c:forEach var="q" items="${item.quizQuestions}" varStatus="status">
                                        <div style="margin-bottom: 15px; background: #fff; padding: 15px; border-radius: 8px; border: 1px solid #eee;">
                                            <strong style="display:block; margin-bottom: 8px;">Question ${status.count}: ${q.questionText}</strong>
                                            <ul style="margin: 0; padding-left: 20px;">
                                                <c:forEach var="opt" items="${q.options}">
                                                    <li class="${opt.correct ? 'correct-answer' : ''}">
                                                        ${opt.optionText}
                                                        <c:if test="${opt.correct}"> (Correct Answer)</c:if>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>
                        </div>
                        </div>
                </c:forEach>
            </c:if>

            <c:if test="${empty moderationItems}">
                <div style="text-align: center; color: #6b7280; padding: 40px;">
                    <i class="bi bi-check-circle" style="font-size: 48px; color: #10b981; display: block; margin-bottom: 10px;"></i>
                    <p>All caught up! No pending content to review.</p>
                </div>
            </c:if>

        </div>
    </div>

    <div id="reviewModal" class="modal-overlay">
        <div class="modal-box">
            <div class="modal-header">
                <span class="modal-title">Review Content</span>
                <button class="close-btn" onclick="closeReviewModal()">&times;</button>
            </div>
            
            <div class="modal-body">
                <div class="detail-row">
                    <span class="detail-label">Title</span>
                    <div class="detail-value" id="modalTitle">Loading...</div>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">Author</span>
                    <div class="detail-value" id="modalAuthor">Loading...</div>
                </div>

                <div class="detail-row">
                    <span class="detail-label">Full Content</span>
                    <div id="modalContentContainer"></div>
                </div>

                <div id="flagFormContainer">
                    <strong style="display:block; margin-bottom:8px; color:#b45309;">🚩 Flag Content</strong>
                    <form id="submitFlagForm" action="${pageContext.request.contextPath}/admin/moderation/flag" method="post">
                        <input type="hidden" name="contentId" id="flagContentId">
                        <textarea name="reason" class="flag-textarea" rows="3" placeholder="Enter reason for flagging (e.g., Inappropriate content, Misleading info)..." required></textarea>
                        <div style="text-align: right; margin-top: 5px;">
                            <button type="button" class="btn-mq btn-cancel" onclick="toggleFlagForm()">Cancel</button>
                            <button type="submit" class="btn-mq btn-flag">Submit Flag</button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="modal-actions">
                <button type="button" class="btn-mq btn-flag" onclick="toggleFlagForm()">
                    <i class="bi bi-flag-fill"></i> Flag
                </button>
                
                <a href="#" id="modalBtnRemove" class="btn-mq btn-remove" onclick="return confirm('Confirm Removal?')">Remove</a>
                <a href="#" id="modalBtnApprove" class="btn-mq btn-approve" onclick="return confirm('Approve this published content?')">Approve</a>
            </div>
        </div>
    </div>

    <script>
        var contextPath = '${pageContext.request.contextPath}';

        function openReviewModal(btn) {
            // Reset Flag Form visibility
            document.getElementById('flagFormContainer').style.display = 'none';

            var id = btn.getAttribute('data-id');
            var title = btn.getAttribute('data-title');
            var author = btn.getAttribute('data-author');

            document.getElementById('modalTitle').innerText = title;
            document.getElementById('modalAuthor').innerText = author;
            
            // Set ID for Flag Form
            document.getElementById('flagContentId').value = id;

            // Load Full Content
            var hiddenContentDiv = document.getElementById('content-details-' + id);
            var modalContainer = document.getElementById('modalContentContainer');
            
            if (hiddenContentDiv) {
                modalContainer.innerHTML = hiddenContentDiv.innerHTML;
            } else {
                modalContainer.innerHTML = "<p>Error loading content details.</p>";
            }

            // Set Action Links
            var basePath = contextPath.endsWith('/') ? contextPath.slice(0, -1) : contextPath;
            document.getElementById('modalBtnApprove').href = basePath + "/admin/moderation/approve/" + id;
            document.getElementById('modalBtnRemove').href = basePath + "/admin/moderation/remove/" + id;

            document.getElementById('reviewModal').style.display = 'flex';
        }

        function toggleFlagForm() {
            var form = document.getElementById('flagFormContainer');
            if (form.style.display === 'none' || form.style.display === '') {
                form.style.display = 'block';
                // Scroll to bottom to see the form
                var modalBody = document.querySelector('.modal-body');
                modalBody.scrollTop = modalBody.scrollHeight;
            } else {
                form.style.display = 'none';
            }
        }

        function closeReviewModal() {
            document.getElementById('reviewModal').style.display = 'none';
        }

        window.onclick = function(event) {
            var modal = document.getElementById('reviewModal');
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
</body>
</html>