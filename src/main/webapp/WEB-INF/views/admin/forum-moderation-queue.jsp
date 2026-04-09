<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>Forum Moderation Queue</title>
    <link rel="icon" href="data:,">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { margin: 0; font-family: 'Inter', sans-serif; background-color: #f9fafb; padding: 40px; }

        .mq-main-card { background-color: white; border-radius: 12px; padding: 24px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); border: 1px solid #e5e7eb; }

        .mq-header-section { margin-bottom: 24px; }
        .mq-page-title { font-size: 20px; font-weight: 600; margin: 0 0 4px 0; color: #111827; }
        .mq-page-subtitle { color: #6b7280; font-size: 14px; margin: 0; }

        .mq-item-card { border: 1px solid #e5e7eb; border-radius: 12px; padding: 20px; margin-bottom: 16px; background-color: #fff; position: relative; transition: box-shadow 0.2s; }
        .mq-item-card:hover { box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1); }
        
        .mq-tags-row { display: flex; gap: 8px; margin-bottom: 12px; align-items: center; }
        .mq-tag-type { border: 1px solid #e5e7eb; color: #374151; font-size: 12px; font-weight: 500; padding: 4px 10px; border-radius: 6px; background-color: #f3f4f6; }
        
        .mq-badge { font-size: 12px; font-weight: 600; padding: 4px 12px; border-radius: 9999px; color: white; text-transform: lowercase; }
        .priority-medium { background-color: #14b8a6; } 

        .mq-content-title { font-size: 16px; font-weight: 700; color: #111827; margin-bottom: 4px; display: block; }
        .mq-content-author { font-size: 14px; color: #6b7280; margin-bottom: 12px; display: block; }
        .mq-flag-reason { font-size: 14px; color: #6b7280; margin-bottom: 16px; }

        .mq-columns-container { display: flex; gap: 20px; align-items: flex-start; flex-wrap: wrap; }
        .mq-column { flex: 1 1 420px; min-width: 320px; }
        .mq-column h3 { font-size: 16px; font-weight: 600; color: #111827; margin-bottom: 16px; }

        .mq-actions { display: flex; gap: 10px; }
        .btn-mq { padding: 8px 16px; border-radius: 6px; font-size: 14px; font-weight: 500; cursor: pointer; text-decoration: none; border: none; display: inline-block; transition: 0.2s ease; }
        .btn-approve { background-color: #06b6d4; color: white; }
        .btn-review { background-color: white; border: 1px solid #d1d5db; color: #374151; }
        .btn-remove { background-color: #ec4899; color: white; }
        
        .btn-flag { background-color: #f59e0b; color: white; }
        .btn-cancel { background-color: #e5e7eb; color: #374151; }

        .modal-overlay { 
            display: none; 
            position: fixed; 
            top: 0; 
            left: 0; 
            width: 100%; 
            height: 100%; 
            background: linear-gradient(135deg, rgba(0, 0, 0, 0.6) 0%, rgba(0, 0, 0, 0.4) 100%);
            z-index: 1000; 
            justify-content: center; 
            align-items: center; 
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
        }

        .modal-box { 
            background: linear-gradient(145deg, #ffffff 0%, #fafafa 100%);
            padding: 0;
            border-radius: 20px; 
            width: 90%; 
            max-width: 850px; 
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25),
                        0 0 0 1px rgba(0, 0, 0, 0.05);
            position: relative; 
            animation: modalFadeIn 0.3s cubic-bezier(0.16, 1, 0.3, 1);
            display: flex; 
            flex-direction: column; 
            max-height: 90vh;
            overflow: hidden;
        }

        @keyframes modalFadeIn { 
            from { 
                transform: translateY(-20px) scale(0.96); 
                opacity: 0; 
            } 
            to { 
                transform: translateY(0) scale(1); 
                opacity: 1; 
            } 
        }

        .modal-header { 
            margin: 0;
            background: linear-gradient(135deg, #14b8a6 0%, #0d9488 100%);
            color: white;
            padding: 24px 30px;
            border-bottom: none;
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            flex-shrink: 0;
            border-radius: 20px 20px 0 0;
        }

        .modal-title { 
            font-size: 20px; 
            font-weight: 700; 
            color: white;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .modal-title::before {
            content: '📋';
            font-size: 24px;
        }

        .close-btn { 
            background: rgba(255, 255, 255, 0.2);
            border: none; 
            width: 36px;
            height: 36px;
            border-radius: 50%;
            font-size: 24px; 
            color: white;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s ease;
        }

        .close-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: rotate(90deg);
        }

        .modal-body { 
            margin: 0;
            padding: 30px;
            overflow-y: auto; 
            flex-grow: 1;
            background: white;
        }

        .modal-body section {
            background: #f9fafb;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .modal-body section:last-child {
            margin-bottom: 0;
        }

        .modal-body hr {
            display: none;
        }

        .modal-body p {
            margin: 0 0 12px 0;
            line-height: 1.6;
        }

        .modal-body p:last-child {
            margin-bottom: 0;
        }

        .modal-body strong {
            color: #111827;
            font-weight: 600;
            display: inline-block;
            margin-right: 8px;
        }

        .modal-body section > p:first-child strong {
            font-size: 16px;
            color: #14b8a6;
            display: block;
            margin-bottom: 16px;
            padding-bottom: 12px;
            border-bottom: 2px solid #e5e7eb;
        }

        .detail-row { 
            margin-bottom: 16px;
            padding: 12px;
            background: white;
            border-radius: 8px;
        }

        .detail-label { 
            font-size: 11px; 
            color: #14b8a6;
            font-weight: 700; 
            text-transform: uppercase; 
            letter-spacing: 0.5px;
            display: block; 
            margin-bottom: 6px;
        }

        .detail-value { 
            font-size: 15px; 
            color: #111827;
            line-height: 1.5;
        }

        .full-content-preview { 
            background: #ffffff;
            padding: 20px; 
            border-radius: 12px; 
            border: 1px solid #e5e7eb;
            color: #374151; 
            font-size: 14px; 
            line-height: 1.7;
            margin-top: 10px;
        }

        .full-content-preview h4 { 
            margin-top: 15px; 
            margin-bottom: 8px; 
            color: #14b8a6;
            font-size: 15px;
        }

        .full-content-preview ul { 
            padding-left: 20px;
            margin: 8px 0;
        }

        .correct-answer { 
            color: #059669; 
            font-weight: bold;
        }

        .modal-actions { 
            display: flex; 
            justify-content: flex-end; 
            gap: 12px; 
            flex-shrink: 0; 
            padding: 20px 30px;
            background: #f9fafb;
            border-top: 1px solid #e5e7eb;
            border-radius: 0 0 20px 20px;
        }

        .modal-actions .btn-mq {
            padding: 10px 24px;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        .modal-actions .btn-cancel {
            background: white;
            border: 2px solid #e5e7eb;
            color: #374151;
        }

        .modal-actions .btn-cancel:hover {
            background: #f9fafb;
            border-color: #d1d5db;
            transform: translateY(-1px);
        }

        #flagFormContainer { 
            display: none; 
            margin-top: 15px; 
            background: #fffbeb; 
            border: 1px solid #fcd34d; 
            padding: 15px; 
            border-radius: 8px; 
        }
        .flag-textarea { width: 100%; border: 1px solid #d1d5db; border-radius: 6px; padding: 8px; font-family: inherit; font-size: 14px; margin-bottom: 10px; resize: vertical; }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/includes/admin-header.jsp" />

    <div>
        <div class="mq-main-card">
            <div class="mq-header-section">
                <h2 class="mq-page-title">Forum Moderation Queue</h2>
                <p class="mq-page-subtitle">Items requiring review</p>
            </div>

            <c:choose>
                <c:when test="${not empty moderationItems}">
                    <div class="mq-columns-container">
        <div class="mq-column">
            <h3><i class="bi bi-chat-dots-fill"></i> Forum Posts</h3>
            <c:forEach var="item" items="${moderationItems}">
                <c:if test="${item.type == 'Forum Post'}">
                    <div class="mq-item-card">
                        <c:choose>
                            <c:when test="${not empty studentReports[item.id]}">
                                <div class="mq-content-title">${fn:escapeXml(studentReports[item.id].reason)}</div>
                                <div class="mq-content-author" style="font-size:13px;color:#6b7280;">by ${fn:escapeXml(studentReporters[item.id])}</div>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${not empty item.flagReason}">
                                        <div class="mq-content-title">${fn:escapeXml(item.flagReason)}</div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="mq-content-title">${fn:escapeXml(item.title)}</div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="mq-content-author" style="font-size:13px;color:#6b7280;">by ${not empty item.author ? item.author : 'Unknown'}</div>
                            </c:otherwise>
                        </c:choose>

                        <div class="mq-flag-reason">
                            <div>Status: <strong>${item.status}</strong></div>
                        </div>

                        <div class="mq-actions">
                            <a href="${pageContext.request.contextPath}/admin/moderation/dismiss/${item.id}" class="btn-mq btn-review">Ignore</a>
                            <button type="button" class="btn-mq btn-review" onclick="openReviewModal(this)" data-id="${item.id}">Review</button>
                            <a href="${pageContext.request.contextPath}/admin/moderation/removePost/${item.id}" class="btn-mq btn-remove" onclick="return confirm('Delete referenced post and remove the report?');">Delete Post</a>
                        </div>

                        <div id="content-details-${item.id}" style="display:none; margin-top:10px;">
                            <div class="full-content-preview">
                                <div class="mq-report-section">
                                    <p><strong>Report details</strong></p>
                                    <c:choose>
                                        <c:when test="${not empty studentReports[item.id]}">
                                            <p><strong>Reason:</strong> ${fn:escapeXml(studentReports[item.id].reason)}</p>
                                            <c:if test="${not empty studentReports[item.id].details}">
                                                <p><strong>Details:</strong> <c:out value="${studentReports[item.id].details}"/></p>
                                            </c:if>
                                        </c:when>
                                        <c:when test="${not empty item.flagReason}">
                                            <p><strong>Reason:</strong> ${fn:escapeXml(item.flagReason)}</p>
                                        </c:when>
                                        <c:otherwise>
                                            <p><strong>Reason:</strong> No reason provided.</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <hr />

                                <div class="mq-post-section">
                                    <p><strong>Post details</strong></p>
                                    <c:choose>
                                        <c:when test="${not empty reportedPosts[item.id]}">
                                            <p><strong>Title:</strong> ${fn:escapeXml(reportedPosts[item.id].title)}</p>
                                            <p>${fn:escapeXml(reportedPosts[item.id].content)}</p>
                                        </c:when>
                                        <c:otherwise>
                                            <p><strong>Title:</strong> ${fn:escapeXml(item.title)}</p>
                                            <p><em>No post excerpt available.</em></p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                </c:if>
            </c:forEach>
        </div>
        

        <div class="mq-column">
            <h3><i class="bi bi-chat-square-text-fill"></i> Comments</h3>
            <c:forEach var="item" items="${moderationItems}">
                <c:if test="${item.type == 'Comment'}">
                    <div class="mq-item-card">
                        <c:choose>
                            <c:when test="${not empty studentReports[item.id]}">
                                <div class="mq-content-title">${fn:escapeXml(studentReports[item.id].reason)}</div>
                            </c:when>
                            <c:when test="${not empty item.flagReason}">
                                <div class="mq-content-title">${fn:escapeXml(item.flagReason)}</div>
                            </c:when>
                            <c:when test="${not empty reportedReplyExcerpts[item.id]}">
                                <div class="mq-content-title">${fn:escapeXml(reportedReplyExcerpts[item.id])}</div>
                            </c:when>
                            <c:otherwise>
                                <div class="mq-content-title">${fn:escapeXml(item.title)}</div>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${not empty reportedReplies[item.id]}">
                                <div class="mq-content-author">by ${fn:escapeXml(reportedReplies[item.id].authorName)}</div>
                            </c:when>
                            <c:otherwise>
                                <div class="mq-content-author">by ${not empty item.author ? item.author : 'Unknown'}</div>
                            </c:otherwise>
                        </c:choose>
                        <div class="mq-flag-reason">
                            <c:choose>
                                <c:when test="${item.status == 'Flagged'}">
                                    <div>Status: <strong>${item.status}</strong></div>
                                    <div><strong>Reason:</strong> ${not empty item.flagReason ? item.flagReason : 'No reason provided.'}</div>
                                </c:when>
                                <c:otherwise>
                                    <div>Status: <strong>${item.status}</strong></div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="mq-actions">
                            <a class="btn-mq btn-review" href="${pageContext.request.contextPath}/admin/moderation/dismiss/${item.id}">Ignore</a>
                            <button type="button" class="btn-mq btn-review" onclick="openReviewModal(this)" data-id="${item.id}">Review</button>
                            <a class="btn-mq btn-remove" href="${pageContext.request.contextPath}/admin/moderation/removeReply/${item.id}" onclick="return confirm('Delete referenced comment and remove the report?');">Delete Comment</a>
                        </div>
                        <div id="content-details-${item.id}" style="display:none; margin-top:10px;">
                            <div class="full-content-preview">
                                <div class="mq-report-section">
                                    <p><strong>Report details</strong></p>
                                    <c:choose>
                                        <c:when test="${not empty studentReports[item.id]}">
                                            <p><strong>Reason:</strong> ${fn:escapeXml(studentReports[item.id].reason)}</p>
                                            <c:if test="${not empty studentReports[item.id].details}">
                                                <p><strong>Details:</strong> <c:out value="${studentReports[item.id].details}"/></p>
                                            </c:if>
                                        </c:when>
                                        <c:when test="${not empty item.flagReason}">
                                            <p><strong>Reason:</strong> ${fn:escapeXml(item.flagReason)}</p>
                                        </c:when>
                                        <c:otherwise>
                                            <p><strong>Reason:</strong> No reason provided.</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <hr />

                                <div class="mq-post-section">
                                    <p><strong>Comment details</strong></p>
                                    <c:choose>
                                        <c:when test="${not empty reportedReplies[item.id]}">
                                            <p>${fn:escapeXml(reportedReplies[item.id].content)}</p>
                                        </c:when>
                                        <c:otherwise>
                                            <p>${fn:escapeXml(item.title)}</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        <div id="parent-post-details-${item.id}" style="display:none; margin-top:10px;">
                            <div class="full-content-preview">
                                <div class="mq-post-section">
                                    <p><strong>Parent post</strong></p>
                                    <c:choose>
                                        <c:when test="${not empty reportedParentPosts[item.id]}">
                                            <p><strong>Title:</strong> ${fn:escapeXml(reportedParentPosts[item.id].title)}</p>
                                            <p>${fn:escapeXml(reportedParentPosts[item.id].content)}</p>
                                        </c:when>
                                        <c:otherwise>
                                            <p><em>No parent post information available.</em></p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>

        
                    </div>
                </c:when>

                <c:otherwise>
                    <div style="text-align: center; color: #6b7280; padding: 40px;">
                        <i class="bi bi-check-circle" style="font-size: 48px; color: #10b981; display: block; margin-bottom: 10px;"></i>
                        <p>All caught up! No reported forum posts or comments to review.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

<div id="mq-modal" class="modal-overlay" style="display:none;">
    <div class="modal-box">
        <div class="modal-header">
            <h3 class="modal-title">Report details</h3>
            <button class="close-btn" onclick="closeModal()">&times;</button>
        </div>
        <div class="modal-body" id="mq-modal-body">
        </div>
        <div class="modal-actions">
            <button class="btn-mq btn-cancel" onclick="closeModal()">Close</button>
        </div>
    </div>
</div>

<script>
    function openReviewModal(btn){
        var id = btn.getAttribute('data-id');
        var details = document.getElementById('content-details-' + id);
        var modal = document.getElementById('mq-modal');
        var body = document.getElementById('mq-modal-body');
        if(details){
            var reportSection = details.querySelector('.mq-report-section');
            var postSection = details.querySelector('.mq-post-section');
            var parentPostBlock = document.getElementById('parent-post-details-' + id);
            var html = '';
            if(reportSection) html += '<section>' + reportSection.innerHTML + '</section>';
            if(postSection) html += '<hr/>' + '<section>' + postSection.innerHTML + '</section>';
            if(parentPostBlock){
                var parentSection = parentPostBlock.querySelector('.mq-post-section');
                if(parentSection) html += '<hr/>' + '<section>' + parentSection.innerHTML + '</section>';
            }
            body.innerHTML = html || '<p>No additional details available.</p>';
        } else {
            body.innerHTML = '<p>No additional details available.</p>';
        }
        modal.style.display = 'flex';
        document.body.style.overflow = 'hidden';
    }

    function closeModal(){
        var modal = document.getElementById('mq-modal');
        modal.style.display = 'none';
        document.body.style.overflow = '';
    }
</script>
</body>
</html>