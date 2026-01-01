<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${post.title} + ' - Peer Support Forum'"/></title>
    <style>
        :root { --primary: #5dd5c3; --primary-dark: #4cc4b3; --primary-light: #e0f7f4; --text-primary: #1a1a1a; --text-secondary: #666; --bg-page: #f8fafb; --bg-card: #ffffff; --border: #e5e7eb; --radius: 12px; --shadow: 0 2px 8px rgba(0,0,0,0.06); }
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Arial; background:var(--bg-page); color:var(--text-primary); }
        .container { max-width:900px; margin:0 auto; padding:24px 20px; }
        .header { margin-bottom:24px; display:flex; justify-content:space-between; align-items:center; }
        .back-link { display:inline-flex; align-items:center; text-decoration:none; color:var(--text-secondary); background:#fff; padding:8px 16px; border-radius:8px; border:1px solid var(--border); }
        .post-card { background:var(--bg-card); border-radius:var(--radius); padding:30px; margin-bottom:24px; box-shadow:var(--shadow); }
        .avatar { width:48px; height:48px; border-radius:50%; background:linear-gradient(135deg,var(--primary),var(--primary-dark)); color:#fff; display:flex; align-items:center; justify-content:center; font-weight:600; font-size:18px; margin-right:16px; }
        .reply-form-card { background:var(--bg-card); border-radius:var(--radius); padding:24px; margin-bottom:24px; box-shadow:var(--shadow); }
        .reply-textarea { width:100%; padding:16px; border:1px solid var(--border); border-radius:8px; min-height:120px; }
        .submit-btn { background:var(--primary); color:#fff; padding:12px 28px; border-radius:8px; border:none; cursor:pointer; }
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

        <div class="notice">Your reply was posted successfully.</div>

        <div class="post-card">
            <div style="display:flex; align-items:flex-start;">
                <div class="avatar"><c:out value="${post.avatar}"/></div>
                <div style="flex:1;">
                    <div class="post-title"><c:out value="${post.title}"/></div>
                    <div style="color:var(--text-secondary); font-size:13px; margin-top:6px;">
                        <span><c:out value="${post.authorName}"/></span>
                        <span> • </span>
                        <c:if test="${not empty post.badge}"><span class="badge"><c:out value="${post.badge}"/></span><span> • </span></c:if>
                        <span><c:out value="${post.category}"/></span>
                        <span> • </span>
                        <span><c:out value="${post.createdAt}"/></span>
                    </div>
                </div>
            </div>

            <div class="post-content">
                <p><c:out value="${post.content}"/></p>
            </div>

            <div class="post-stats">
                <div><span>👍</span> <span><c:out value="${post.likes}"/></span></div>
                <div><span>💬</span> <span><c:out value="${post.replyCount}"/> replies</span></div>
            </div>
        </div>

        <div class="reply-form-card">
            <div style="font-weight:700; margin-bottom:12px;">Join the discussion</div>
            <form action="${pageContext.request.contextPath}/student/forum/addReply" method="POST">
                <input type="hidden" name="postId" value="${post.id}" />
                <textarea name="content" class="reply-textarea" placeholder="Type your reply..." required></textarea>
                <div style="margin-top:12px;">
                    <button type="submit" class="submit-btn">Post Reply</button>
                </div>
            </form>
        </div>

        <div class="replies-section">
            <c:if test="${empty replies}">
                <div style="text-align:center; color:#999; padding:40px 20px;">
                    <div style="font-size:24px; margin-bottom:10px;">💬</div>
                    <p>No replies yet. Be the first to share your thoughts!</p>
                </div>
            </c:if>

            <c:forEach var="r" items="${replies}">
                <div class="reply">
                    <div style="display:flex; align-items:center; margin-bottom:12px;">
                        <div class="reply-avatar"><c:out value="${r.avatar}"/></div>
                        <div style="display:flex; flex-direction:column;">
                            <div style="font-weight:700;"><c:out value="${r.authorName}"/></div>
                            <div style="font-size:12px; color:#999;"><c:out value="${r.createdAt}"/></div>
                        </div>
                    </div>
                    <div class="reply-content"><c:out value="${r.content}"/></div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
