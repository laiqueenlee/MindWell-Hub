<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${not empty newPost ? 'Post Created - Peer Support Forum' : 'Create New Post - Peer Support Forum'}"/></title>
    <style>
        :root {
            --primary: #00bfa5;
            --primary-dark: #00897b;
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

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: var(--bg-page);
            color: var(--text-primary);
            line-height: 1.6;
        }

        /* Header Section */
        .page-header {
            background: #fff;
            border-bottom: 1px solid var(--border);
            padding: 20px 24px;
            animation: fadeInDown 0.5s ease-out;
        }

        .header-container {
            max-width: 800px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
        }

        .header-content h1 {
            font-size: 24px;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 4px;
        }

        .header-content p {
            font-size: 14px;
            color: var(--text-secondary);
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 10px 18px;
            background: white;
            border: 1px solid var(--border);
            border-radius: 8px;
            color: var(--text-secondary);
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: var(--transition);
            white-space: nowrap;
        }

        .back-link:hover {
            background: var(--border-light);
            border-color: var(--primary);
            color: var(--primary);
            transform: translateX(-2px);
        }

        /* Main Container */
        .create-post-container {
            max-width: 800px;
            margin: 32px auto;
            padding: 0 24px;
        }

        /* Success Banner */
        .success-banner {
            background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
            border: 1px solid #10b981;
            border-radius: var(--radius);
            padding: 16px 20px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.1);
            animation: fadeInUp 0.5s ease-out;
        }

        .success-banner .icon {
            font-size: 24px;
            flex-shrink: 0;
        }

        .success-banner strong {
            color: #065f46;
            font-weight: 700;
        }

        .success-banner span {
            color: #047857;
        }

        /* Post Form Card */
        .post-form-card {
            background: var(--bg-card);
            border-radius: var(--radius);
            padding: 32px;
            box-shadow: var(--shadow);
            animation: fadeInUp 0.5s ease-out 0.1s backwards;
        }

        .post-form-card h2 {
            font-size: 22px;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 8px;
        }

        .post-form-card > p {
            font-size: 14px;
            color: var(--text-secondary);
            margin-bottom: 24px;
        }

        /* Form Groups */
        .form-group {
            margin-bottom: 24px;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 8px;
        }

        .form-group input[type="text"],
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-family: inherit;
            font-size: 14px;
            color: var(--text-primary);
            transition: var(--transition);
            background: white;
        }

        .form-group input[type="text"]:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px var(--primary-light);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 140px;
        }

        .form-group select {
            cursor: pointer;
        }

        .char-count {
            text-align: right;
            font-size: 12px;
            color: var(--text-muted);
            margin-top: 6px;
        }

        /* Checkbox */
        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px;
            background: var(--primary-light);
            border-radius: 8px;
            border: 1px solid transparent;
            transition: var(--transition);
        }

        .checkbox-group:hover {
            border-color: var(--primary);
        }

        .checkbox-group input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
            accent-color: var(--primary);
        }

        .checkbox-group label {
            margin: 0;
            font-weight: 500;
            font-size: 14px;
            color: var(--text-primary);
            cursor: pointer;
            user-select: none;
        }

        /* Form Actions */
        .form-actions {
            display: flex;
            gap: 12px;
            margin-top: 32px;
        }

        .btn {
            padding: 12px 28px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            text-decoration: none;
            display: inline-block;
            text-align: center;
            border: none;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
            box-shadow: 0 2px 8px rgba(0, 191, 165, 0.3);
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 191, 165, 0.4);
        }

        .btn-primary:active {
            transform: translateY(0);
        }

        .btn-secondary {
            background: white;
            color: var(--text-secondary);
            border: 1px solid var(--border);
        }

        .btn-secondary:hover {
            background: var(--border-light);
            border-color: var(--primary);
            color: var(--text-primary);
        }

        /* Success Post Preview */
        .post-preview {
            background: white;
            padding: 20px;
            border-radius: var(--radius);
            margin-bottom: 16px;
            box-shadow: var(--shadow);
            cursor: pointer;
            transition: var(--transition);
            animation: fadeInUp 0.5s ease-out backwards;
        }

        .post-preview:hover {
            box-shadow: var(--shadow-hover);
            transform: translateY(-2px);
        }

        .post-preview-title {
            font-size: 16px;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 8px;
        }

        .post-preview-meta {
            color: var(--text-muted);
            font-size: 13px;
            margin-bottom: 12px;
        }

        .post-preview-content {
            color: var(--text-secondary);
            font-size: 14px;
            line-height: 1.6;
        }

        .action-center {
            text-align: center;
            margin-top: 24px;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .page-header {
                padding: 16px 12px;
            }

            .header-container {
                flex-direction: column;
                align-items: flex-start;
            }

            .header-content h1 {
                font-size: 20px;
            }

            .create-post-container {
                padding: 0 12px;
                margin: 24px auto;
            }

            .post-form-card {
                padding: 20px;
            }

            .form-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }

        /* Accessibility */
        @media (prefers-reduced-motion: reduce) {
            * {
                animation: none !important;
                transition: none !important;
            }
        }

        button:focus,
        input:focus,
        textarea:focus,
        select:focus {
            outline: 2px solid var(--primary);
            outline-offset: 2px;
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/includes/navbar.jsp" %>
    
    <!-- Page Header -->
    <div class="page-header">
        <div class="header-container">
            <div class="header-content">
                <h1>Peer Support Forum</h1>
                <p>A safe space to share, connect, and support each other</p>
            </div>
            <a href="${pageContext.request.contextPath}/student/forum" class="back-link">
                ← Back to Forum
            </a>
        </div>
    </div>

    <c:choose>
        <c:when test="${not empty newPost}">
            <!-- Success State -->
            <div class="create-post-container">
                <div class="success-banner">
                    <span class="icon">✅</span>
                    <div>
                        <strong>Post Published!</strong>
                        <span>Your post has been shared with the community.</span>
                    </div>
                </div>
                
                <div>
                    <c:forEach var="p" items="${posts}">
                        <div class="post-preview" onclick="location.href='${pageContext.request.contextPath}/student/forum/post/${p.id}'">
                            <div class="post-preview-title"><c:out value="${p.title}"/></div>
                            <div class="post-preview-meta">
                                <c:out value="${p.authorName}"/> • <c:out value="${p.category}"/>
                            </div>
                            <div class="post-preview-content"><c:out value="${p.content}"/></div>
                        </div>
                    </c:forEach>
                </div>
                
                <div class="action-center">
                    <a href="${pageContext.request.contextPath}/student/forum/new-post" class="btn btn-secondary">
                        Create Another Post
                    </a>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <!-- Create Post Form -->
            <div class="create-post-container">
                <div class="post-form-card">
                    <h2>Create a New Post</h2>
                    <p>Share your thoughts or questions with the community</p>
                    
                    <form action="${pageContext.request.contextPath}/student/forum/submit-post" method="post">
                        <div class="form-group">
                            <label for="postTitle">Post title</label>
                            <input type="text" id="postTitle" name="postTitle" maxlength="200" required placeholder="Give your post a clear title..." />
                            <div class="char-count">0 / 200</div>
                        </div>
                        
                        <div class="form-group">
                            <label for="postContent">What's on your mind? Remember, you can post anonymously.</label>
                            <textarea id="postContent" name="postContent" rows="6" maxlength="2000" required placeholder="Share your thoughts, questions, or experiences..."></textarea>
                            <div class="char-count">0 / 2000</div>
                        </div>
                        
                        <div class="form-group">
                            <label for="category">Select category</label>
                            <select id="category" name="category" required>
                                <option value="">Choose a category...</option>
                                <option>Stress</option>
                                <option>Anxiety</option>
                                <option>Depression</option>
                                <option>Wellness</option>
                                <option>Self-Care</option>
                                <option>Relationships</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <div class="checkbox-group">
                                <input type="checkbox" id="anonymous" name="postAnonymously" value="true" />
                                <label for="anonymous">Post anonymously</label>
                            </div>
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

    <script>
        // Character counter for title
        const titleInput = document.getElementById('postTitle');
        if (titleInput) {
            const titleCounter = titleInput.nextElementSibling;
            titleInput.addEventListener('input', function() {
                if (titleCounter && titleCounter.classList.contains('char-count')) {
                    titleCounter.textContent = this.value.length + ' / 200';
                }
            });
        }

        // Character counter for content
        const contentInput = document.getElementById('postContent');
        if (contentInput) {
            const contentCounter = contentInput.nextElementSibling;
            contentInput.addEventListener('input', function() {
                if (contentCounter && contentCounter.classList.contains('char-count')) {
                    contentCounter.textContent = this.value.length + ' / 2000';
                }
            });
        }
    </script>
</body>
</html>