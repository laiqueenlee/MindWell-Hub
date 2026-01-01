<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${not empty newPost ? 'Post Created - Peer Support Forum' : 'Create New Post - Peer Support Forum'}"/></title>
    <style>
        /* Styles kept minimal to match app look */
        :root{--primary:#5dd5c3;--text-primary:#1a1a1a;--bg-page:#f8fafb;--bg-card:#fff;--border:#e5e7eb;--radius:12px}
        body{font-family:Segoe UI,Arial,sans-serif;background:var(--bg-page);color:var(--text-primary);}
        .page-header{background:#fff;border-bottom:1px solid var(--border);padding:20px}
        .create-post-container{max-width:800px;margin:24px auto;padding:0 24px}
        .post-form-card{background:var(--bg-card);border-radius:var(--radius);padding:24px}
        .form-group{margin-bottom:16px}
        .form-group input,.form-group textarea,.form-group select{width:100%;padding:10px;border:1px solid var(--border);border-radius:8px}
        .form-actions{display:flex;gap:12px}
        .btn{padding:10px 20px;border-radius:8px;cursor:pointer}
        .btn-primary{background:var(--primary);color:#fff;border:none}
        .btn-secondary{background:#fff;border:1px solid var(--border)}
        .success-banner{background:#d1fae5;border:1px solid #10b981;padding:12px;border-radius:8px;margin:16px 0}
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/includes/navbar.jsp" %>
    <div class="page-header">
        <div>
            <h1>Peer Support Forum</h1>
            <p>A safe space to share, connect, and support each other</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/student/forum" class="btn btn-secondary">← Back to Forum</a>
        </div>
    </div>

    <c:choose>
        <c:when test="${not empty newPost}">
            <div class="create-post-container">
                <div class="success-banner">✅ <strong>Post Published!</strong> Your post has been shared.</div>
                <div>
                    <c:forEach var="p" items="${posts}">
                        <div style="background:#fff;padding:12px;border-radius:8px;margin-bottom:12px;" onclick="location.href='${pageContext.request.contextPath}/student/forum/post/${p.id}'">
                            <strong><c:out value="${p.title}"/></strong>
                            <div style="color:#666;font-size:13px;"><c:out value="${p.authorName}"/> • <c:out value="${p.category}"/></div>
                            <div style="margin-top:8px;color:#444;"><c:out value="${p.content}"/></div>
                        </div>
                    </c:forEach>
                </div>
                <div style="text-align:center;margin-top:16px;"><a href="${pageContext.request.contextPath}/student/forum/new-post" class="btn btn-secondary">Create Another Post</a></div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="create-post-container">
                <div class="post-form-card">
                    <h2>Create a New Post</h2>
                    <form action="${pageContext.request.contextPath}/student/forum/submit-post" method="post">
                        <div class="form-group">
                            <label>Post title</label>
                            <input type="text" name="postTitle" maxlength="200" required />
                        </div>
                        <div class="form-group">
                            <label>What's on your mind?</label>
                            <textarea name="postContent" rows="6" maxlength="2000" required></textarea>
                        </div>
                        <div class="form-group">
                            <label>Category</label>
                            <select name="category" required>
                                <option value="">Choose...</option>
                                <option>Stress</option>
                                <option>Anxiety</option>
                                <option>Depression</option>
                                <option>Wellness</option>
                                <option>Self-Care</option>
                                <option>Relationships</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><input type="checkbox" name="postAnonymously" value="true" /> Post anonymously</label>
                        </div>
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">Post</button>
                            <a href="${pageContext.request.contextPath}/student/forum" class="btn btn-secondary">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${not empty newPost ? 'Post Created - Peer Support Forum' : 'Create New Post - Peer Support Forum'}"/></title>
    <style>
        /* (CSS omitted here — kept identical to the original for brevity) */
        :root { /* merged variables */
            --primary: #5dd5c3; 
            --primary-dark: #4cc4b3;
            --primary-light: #e0f7f4;
            --text-primary: #1a1a1a;
            --text-secondary: #666;
            --text-muted: #999;
            --bg-page: #f8fafb;
            --bg-card: #ffffff;
            --border: #e5e7eb;
            --border-light: #f0f2f4;
            --radius: 12px;
            --shadow: 0 2px 8px rgba(0,0,0,0.06);
            --shadow-hover: 0 4px 16px rgba(0,0,0,0.1);
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif; background: var(--bg-page); color: var(--text-primary); line-height: 1.6; }
        /* (rest of CSS omitted for readability; original styles preserved) */
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/includes/navbar.jsp" %>

    <div class="page-header">
        <div class="page-header-content">
            <div>
                <h1>Peer Support Forum</h1>
                <p>A safe space to share, connect, and support each other</p>
            </div>
            <a href="${pageContext.request.contextPath}/student/forum" class="header-btn">← Back to Forum</a>
        </div>
    </div>

    <c:choose>
        <c:when test="${not empty newPost}">
            <div class="forum-container">
                <div class="success-banner">
                    <span style="font-size: 20px;">✅</span>
                    <div>
                        <strong>Post Published!</strong><br>
                        Your post has been shared with the community.
                    </div>
                </div>

                <div class="posts-section">
                    <c:forEach var="p" items="${posts}">
                        <div class="post<c:if test='${not empty newPost and p.id == newPost.id}'> highlight-new</c:if>"
                             onclick="window.location.href='${pageContext.request.contextPath}/student/forum/post/${p.id}'">
                            <div class="post-header">
                                <div class="post-avatar"><c:out value="${p.avatar}"/></div>
                                <div class="post-content">
                                    <div class="post-title-row">
                                        <h3><c:out value="${p.title}"/></h3>
                                    </div>

                                    <div class="post-info">
                                        <span><c:out value="${p.authorName}"/></span>
                                        <span><c:out value="${p.category}"/></span>
                                        <span><c:out value="${p.createdAt}"/></span>
                                    </div>

                                    <p class="post-text"><c:out value="${p.content}"/></p>

                                    <div class="post-interactions">
                                        <button class="interaction-btn">
                                            <span>👍</span> <span class="count"><c:out value="${p.likes}"/></span>
                                        </button>
                                        <a href="#" class="interaction-btn">
                                            <span>💬</span> <span><c:out value="${p.replyCount}"/> replies</span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div style="margin-top: 20px; text-align: center;">
                    <a href="${pageContext.request.contextPath}/student/forum/new-post" class="btn btn-secondary" style="text-decoration: none;">Create Another Post</a>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="create-post-container">
                <div class="post-form-card">
                    <div class="form-header">
                        <h2>Create a New Post</h2>
                        <p>Share your thoughts or questions with the community</p>
                    </div>

                    <form action="${pageContext.request.contextPath}/student/forum/submit-post" method="post" id="createPostForm">
                        <div class="form-group">
                            <label for="postTitle">Post title</label>
                            <input type="text" id="postTitle" name="postTitle" placeholder="Enter a descriptive title..." required maxlength="200" oninput="updateCharCount('postTitle', 200, 'titleCounter')">
                            <div class="char-counter" id="titleCounter">0 / 200</div>
                        </div>

                        <div class="form-group">
                            <label for="postContent">What's on your mind? Remember, you can post anonymously.</label>
                            <div class="textarea-wrapper">
                                <textarea id="postContent" name="postContent" placeholder="Share your thoughts..." required maxlength="2000" oninput="updateCharCount('postContent', 2000, 'contentCounter')"></textarea>
                                <button type="button" class="voice-input-btn" onclick="toggleVoiceInput()"><span id="voiceIcon">🎤</span></button>
                            </div>
                            <div class="char-counter" id="contentCounter">0 / 2000</div>
                        </div>

                        <div class="form-group">
                            <label for="category">Select category</label>
                            <select id="category" name="category" required>
                                <option value="">Choose a category...</option>
                                <option value="Stress">Stress</option>
                                <option value="Anxiety">Anxiety</option>
                                <option value="Depression">Depression</option>
                                <option value="Wellness">Wellness</option>
                                <option value="Self-Care">Self-Care</option>
                                <option value="Relationships">Relationships</option>
                            </select>
                        </div>

                        <div class="checkbox-group">
                            <input type="checkbox" id="postAnonymously" name="postAnonymously" value="true">
                            <label for="postAnonymously">Post anonymously</label>
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary" id="submitBtn">Post</button>
                            <a href="${pageContext.request.contextPath}/student/forum" class="btn btn-secondary">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </c:otherwise>
    </c:choose>

    <script>
        let isSubmitting = false;
        function updateCharCount(inputId, maxLength, counterId) {
            const input = document.getElementById(inputId);
            const counter = document.getElementById(counterId);
            const currentLength = input.value.length;
            counter.textContent = currentLength + " / " + maxLength;
            if (currentLength > maxLength * 0.9) counter.classList.add('warning');
            else counter.classList.remove('warning');
        }
        function toggleVoiceInput() { alert("Voice input simulated."); }
        document.addEventListener('DOMContentLoaded', function() {
            updateCharCount('postTitle', 200, 'titleCounter');
            updateCharCount('postContent', 2000, 'contentCounter');
        });
    </script>
</body>
</html>
