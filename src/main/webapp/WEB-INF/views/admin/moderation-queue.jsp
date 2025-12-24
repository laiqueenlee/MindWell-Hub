<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 1. Include the Layout Header -->
<jsp:include page="/WEB-INF/views/includes/admin-header.jsp" />

<!-- 2. Page-Specific Assets -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">

<style>
    /* --- Main Page Styles --- */
    .mq-dashboard-container {
        margin-top: 30px;
        font-family: 'Inter', sans-serif; 
        color: #111827;
        width: 100%;
    }

    .mq-main-card {
        background-color: #ffffff;
        border: 1px solid #e5e7eb;
        border-radius: 12px;
        padding: 32px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.05);
    }

    .mq-header-section { margin-bottom: 24px; }
    .mq-page-title { font-size: 20px; font-weight: 700; margin: 0 0 4px 0; color: #111827; }
    .mq-page-subtitle { color: #6b7280; font-size: 14px; margin: 0; }

    /* Item Card */
    .mq-item-card {
        border: 1px solid #e5e7eb;
        border-radius: 12px;
        padding: 20px;
        margin-bottom: 16px;
        background-color: #fff;
        position: relative;
        transition: box-shadow 0.2s;
    }
    .mq-item-card:hover {
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
    }

    .mq-tags-row { display: flex; gap: 8px; margin-bottom: 12px; align-items: center; }
    
    .mq-tag-type {
        border: 1px solid #e5e7eb;
        color: #374151;
        font-size: 12px;
        font-weight: 500;
        padding: 4px 10px;
        border-radius: 6px;
        background-color: #ffffff;
    }

    .mq-badge {
        font-size: 12px;
        font-weight: 600;
        padding: 4px 12px;
        border-radius: 9999px;
        color: white;
        text-transform: lowercase;
    }
    .priority-high { background-color: #ef4444; }
    .priority-medium { background-color: #14b8a6; }
    .priority-low { background-color: #e5e7eb; color: #374151; }

    .mq-content-title { font-size: 16px; font-weight: 700; color: #111827; margin-bottom: 4px; display: block; }
    .mq-content-author { font-size: 14px; color: #6b7280; margin-bottom: 12px; display: block; }
    .mq-flag-reason { font-size: 14px; color: #6b7280; margin-bottom: 16px; }

    .mq-warning-icon { position: absolute; top: 20px; right: 20px; color: #ef4444; font-size: 20px; }
    
    .mq-actions { display: flex; gap: 10px; }

    /* Buttons */
    .btn-mq {
        padding: 8px 16px;
        border-radius: 6px;
        font-size: 14px;
        font-weight: 500;
        cursor: pointer;
        text-decoration: none;
        border: none;
        display: inline-block;
    }
    .btn-approve { background-color: #14b8a6; color: white; }
    .btn-approve:hover { background-color: #0d9488; }
    
    .btn-review { background-color: white; border: 1px solid #d1d5db; color: #374151; }
    .btn-review:hover { background-color: #f3f4f6; }
    
    .btn-remove { background-color: #ef4444; color: white; }
    .btn-remove:hover { background-color: #dc2626; }

    /* --- MODAL STYLES --- */
    .modal-overlay {
        display: none; /* Hidden by default */
        position: fixed;
        top: 0; left: 0;
        width: 100%; height: 100%;
        background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent black */
        z-index: 1000;
        justify-content: center;
        align-items: center;
        backdrop-filter: blur(2px);
    }

    .modal-box {
        background-color: white;
        padding: 30px;
        border-radius: 12px;
        width: 90%;
        max-width: 600px;
        box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
        position: relative;
        animation: modalFadeIn 0.2s ease-out;
    }

    @keyframes modalFadeIn {
        from { transform: translateY(10px); opacity: 0; }
        to { transform: translateY(0); opacity: 1; }
    }

    .modal-header {
        margin-bottom: 20px;
        border-bottom: 1px solid #e5e7eb;
        padding-bottom: 15px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .modal-title { font-size: 18px; font-weight: 700; color: #111827; }
    
    .close-btn {
        background: none; border: none; font-size: 24px; color: #9ca3af; cursor: pointer;
    }
    .close-btn:hover { color: #111827; }

    .modal-body { margin-bottom: 25px; }
    .detail-row { margin-bottom: 12px; }
    .detail-label { font-size: 12px; color: #6b7280; font-weight: 600; text-transform: uppercase; display: block; margin-bottom: 4px; }
    .detail-value { font-size: 15px; color: #111827; }
    
    .dummy-content {
        background: #f9fafb;
        padding: 15px;
        border-radius: 8px;
        border: 1px solid #f3f4f6;
        color: #4b5563;
        font-size: 14px;
        line-height: 1.6;
        margin-top: 10px;
    }

    .modal-actions {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
    }
</style>

<div class="mq-dashboard-container">
    <div class="mq-main-card">
        
        <div class="mq-header-section">
            <h2 class="mq-page-title">Content Moderation Queue</h2>
            <p class="mq-page-subtitle">Items requiring review</p>
        </div>

        <c:choose>
            <c:when test="${not empty moderationItems}">
                <c:forEach var="item" items="${moderationItems}">
                    
                    <!-- Generate Simluated Content based on Type (since model lacks contentBody field for now) -->
                    <c:set var="previewText" value="Content not available." />
                    <c:choose>
                        <c:when test="${item.type == 'Forum Post'}">
                            <c:set var="previewText" value="I have been feeling really overwhelmed lately. Every time I try to study, I get panic attacks and cannot focus. Does anyone else feel this way? I am scared I will fail my exams." />
                        </c:when>
                        <c:when test="${item.type == 'Comment'}">
                            <c:set var="previewText" value="This is such a stupid post. You should just toughen up and stop complaining. Nobody cares about your anxiety." />
                        </c:when>
                        <c:when test="${item.type == 'Article'}">
                            <c:set var="previewText" value="Depression is a mood disorder that causes a persistent feeling of sadness and loss of interest. It affects how you feel, think, and behave and can lead to a variety of emotional and physical problems." />
                        </c:when>
                    </c:choose>

                    <div class="mq-item-card">
                        
                        <c:if test="${item.priority == 'high'}">
                            <i class="bi bi-exclamation-triangle mq-warning-icon"></i>
                        </c:if>

                        <div class="mq-tags-row">
                            <span class="mq-tag-type">${item.type}</span>
                            <span class="mq-badge priority-${item.priority}">${item.priority}</span>
                        </div>

                        <span class="mq-content-title">${item.title}</span>
                        <span class="mq-content-author">by ${item.author}</span>
                        
                        <div class="mq-flag-reason">
                            Flagged for: ${item.flagReason}
                        </div>

                        <div class="mq-actions">
                            <!-- Approve -->
                            <a href="${pageContext.request.contextPath}/admin/moderation/approve/${item.id}" 
                               class="btn-mq btn-approve"
                               onclick="return confirm('Are you sure you want to APPROVE this item?');">
                               Approve
                            </a>
                            
                            <!-- Review Button (Trigger JS Modal) -->
                            <!-- We pass the 'previewText' as the new last argument -->
                            <button type="button" class="btn-mq btn-review" 
                                onclick="openReviewModal(
                                    '${item.id}', 
                                    '${item.title}', 
                                    '${item.author}', 
                                    '${item.flagReason}',
                                    '${item.priority}',
                                    '${previewText}'
                                )">
                               Review
                            </button>
                            
                            <!-- Remove -->
                            <a href="${pageContext.request.contextPath}/admin/moderation/remove/${item.id}" 
                               class="btn-mq btn-remove"
                               onclick="return confirm('Are you sure you want to REMOVE this item?');">
                               Remove
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div style="text-align: center; color: #6b7280; padding: 40px;">
                    <i class="bi bi-check-circle" style="font-size: 48px; color: #10b981; display: block; margin-bottom: 10px;"></i>
                    <p>All caught up! No items in the moderation queue.</p>
                </div>
            </c:otherwise>
        </c:choose>

    </div>
</div>

<!-- === REVIEW MODAL POPUP === -->
<div id="reviewModal" class="modal-overlay">
    <div class="modal-box">
        <div class="modal-header">
            <span class="modal-title">Review Content</span>
            <button class="close-btn" onclick="closeReviewModal()">&times;</button>
        </div>
        
        <div class="modal-body">
            <!-- Dynamic Priority Warning -->
            <div id="modalHighPriorityAlert" style="display:none; background:#fee2e2; color:#991b1b; padding:10px; border-radius:6px; margin-bottom:15px; font-size:14px;">
                <strong>⚠️ High Priority:</strong> Proceed with caution.
            </div>

            <div class="detail-row">
                <span class="detail-label">Title</span>
                <div class="detail-value" id="modalTitle">Loading...</div>
            </div>
            
            <div class="detail-row">
                <span class="detail-label">Author</span>
                <div class="detail-value" id="modalAuthor">Loading...</div>
            </div>

            <div class="detail-row">
                <span class="detail-label">Flagged Reason</span>
                <div class="detail-value" id="modalReason" style="color: #ef4444; font-weight: 500;">Loading...</div>
            </div>

            <div class="detail-row">
                <span class="detail-label">Content Preview</span>
                <!-- Added ID here to target with JS -->
                <div class="dummy-content" id="modalContent">
                    Loading content...
                </div>
            </div>
        </div>

        <div class="modal-actions">
            <!-- Action links will be updated by JS to include the correct ID -->
            <a href="#" id="modalBtnRemove" class="btn-mq btn-remove" onclick="return confirm('Confirm Removal?')">Remove</a>
            <a href="#" id="modalBtnApprove" class="btn-mq btn-approve" onclick="return confirm('Confirm Approval?')">Approve</a>
        </div>
    </div>
</div>

<script>
    // Open Modal and populate data, now including 'content'
    function openReviewModal(id, title, author, reason, priority, content) {
        // 1. Populate Text Fields
        document.getElementById('modalTitle').innerText = title;
        document.getElementById('modalAuthor').innerText = author;
        document.getElementById('modalReason').innerText = reason;
        
        // Populate the content preview
        document.getElementById('modalContent').innerText = content;

        // 2. Handle High Priority Alert
        var alertBox = document.getElementById('modalHighPriorityAlert');
        if (priority === 'high') {
            alertBox.style.display = 'block';
        } else {
            alertBox.style.display = 'none';
        }

        // 3. Update Action Links with the correct ID
        var contextPath = "${pageContext.request.contextPath}";
        document.getElementById('modalBtnApprove').href = contextPath + "/admin/moderation/approve/" + id;
        document.getElementById('modalBtnRemove').href = contextPath + "/admin/moderation/remove/" + id;

        // 4. Show Modal
        document.getElementById('reviewModal').style.display = 'flex';
    }

    // Close Modal
    function closeReviewModal() {
        document.getElementById('reviewModal').style.display = 'none';
    }

    // Close if clicking outside the box
    window.onclick = function(event) {
        var modal = document.getElementById('reviewModal');
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>