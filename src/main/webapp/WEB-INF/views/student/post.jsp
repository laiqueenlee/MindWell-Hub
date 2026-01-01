<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${post.title} + ' - Peer Support Forum'"/></title>
    <style>
        :root { --primary: #5dd5c3; --primary-dark: #4cc4b3; --primary-light: #e0f7f4; --text-primary: #1a1a1a; --text-secondary: #666; --bg-page: #f8fafb; --bg-card: #ffffff; --border: #e5e7eb; --radius: 12px; --shadow: 0 2px 8px rgba(0,0,0,0.06); }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif; background-color: var(--bg-page); color: var(--text-primary); line-height: 1.6; }
        .container { max-width: 900px; margin: 0 auto; padding: 24px 20px; }
        .header { margin-bottom: 24px; display:flex; justify-content:space-between; align-items:center; }
        .back-link { display:inline-flex; align-items:center; color:var(--text-secondary); text-decoration:none; font-size:14px; font-weight:600; background-color:white; padding:8px 16px; border-radius:8px; border:1px solid var(--border); }
        .post-card { background-color: var(--bg-card); border-radius: var(--radius); padding: 30px; margin-bottom: 24px; box-shadow: var(--shadow); }
        .avatar { width:48px; height:48px; border-radius:50%; background:linear-gradient(135deg, var(--primary), var(--primary-dark)); color:white; display:flex; align-items:center; justify-content:center; font-weight:600; font-size:18px; margin-right:16px; }
        .reply-form-card { background-color: var(--bg-card); border-radius: var(--radius); padding:24px; margin-bottom:24px; box-shadow: var(--shadow); }
        .reply-textarea { width:100%; padding:16px; border:1px solid var(--border); border-radius:8px; min-height:120px; margin-bottom:16px; }
        .submit-btn { background-color: var(--primary); color: white; border: none; padding: 12px 28px; border-radius: 8px; font-weight: 600; cursor: pointer; }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/includes/navbar.jsp" %>
    <div class="container">
        <div class="header">
            <div>
                <h1>Peer Support Forum</h1>
                <p>A safe space to share, connect, and support each other</p>
            </div>
            <a href="${pageContext.request.contextPath}/student/forum" class="back-link">← Back to Forum</a>
        </div>

        <div class="post-card" data-post-id="${post.id}">
            <div class="post-header">
                <div class="avatar"><c:out value="${post.avatar}"/></div>
                <div class="post-meta">
                    <div class="post-title"><c:out value="${post.title}"/></div>
                    <div class="post-info">
                        <span><c:out value="${post.authorName}"/></span>
                        <span>•</span>
                        <c:if test="${not empty post.badge}"><span class="badge"><c:out value="${post.badge}"/></span><span>•</span></c:if>
                        <span><c:out value="${post.category}"/></span>
                        <span>•</span>
                        <span><c:out value="${post.createdAt}"/></span>
                    </div>
                </div>
            </div>
            <div class="post-content"><c:out value="${post.content}"/></div>
            <div class="post-stats">
                <div class="stat">
                    <button class="interaction-btn" onclick="toggleLikePost(event, this)" id="likeBtn">
                        <span class="interaction-icon">👍</span>
                        <span class="count"><c:out value="${post.likes}"/></span>
                    </button>
                </div>
                <div class="stat"><span>💬</span><span><c:out value="${post.replyCount}"/> replies</span></div>
            </div>
        </div>

        <form action="${pageContext.request.contextPath}/student/forum/addReply" method="post" class="reply-form-card">
            <input type="hidden" name="postId" value="${post.id}" />
            <textarea name="content" class="reply-textarea" placeholder="Type your reply..." required></textarea>
            <button type="submit" class="submit-btn">Post Reply</button>
        </form>

        <div class="replies-section">
            <c:if test="${empty replies}">
                <div style="text-align:center; color:#999; padding:40px 20px;">
                    <div style="font-size:24px; margin-bottom:10px;">💬</div>
                    <p>No replies yet. Be the first to share your thoughts!</p>
                </div>
            </c:if>
            <c:forEach var="r" items="${replies}">
                <div class="reply">
                    <div class="reply-header">
                        <div class="reply-avatar"><c:out value="${r.avatar}"/></div>
                        <div class="reply-meta">
                            <div class="reply-author"><c:out value="${r.authorName}"/></div>
                            <div class="reply-time"><c:out value="${r.createdAt}"/></div>
                        </div>
                    </div>
                    <div class="reply-content"><c:out value="${r.content}"/></div>
                </div>
            </c:forEach>
        </div>
    </div>

    <script>
        const contextPath = '${pageContext.request.contextPath}/';
        async function toggleLikePost(event, btn) {
            event && event.stopPropagation && event.stopPropagation();
            const postEl = btn.closest('.post-card');
            if (!postEl) return;
            const postId = postEl.getAttribute('data-post-id');
            if (!postId) return;
            try {
                const form = new URLSearchParams();
                form.append('postId', postId);
                const res = await fetch(contextPath + 'student/forum/toggle-like', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: form.toString()
                });
                const data = await res.json();
                if (data.ok) {
                    const countSpan = btn.querySelector('.count');
                    if (countSpan) countSpan.textContent = data.likes;
                    if (data.liked) btn.classList.add('liked'); else btn.classList.remove('liked');
                } else {
                    if (data.error === 'not-authenticated') {
                        window.location.href = contextPath + 'login';
                    } else {
                        console.warn('toggle-like failed', data);
                    }
                }
            } catch (e) { console.error('toggleLikePost error', e); }
        }
    </script>
</body>
</html>
