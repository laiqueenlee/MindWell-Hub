<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />
    <title><c:out value="${post.title}"/> - Peer Support Forum</title>
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
            background-color: var(--bg-page);
            color: var(--text-primary);
            line-height: 1.6;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 24px 20px;
        }

        /* Header Section */
        .header {
            margin-bottom: 24px;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 16px;
            animation: fadeInDown 0.5s ease-out;
        }

        .header-content h1 {
            font-size: 28px;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 6px;
        }

        .header-content p {
            font-size: 14px;
            color: var(--text-secondary);
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            color: var(--text-secondary);
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            background-color: white;
            padding: 10px 18px;
            border-radius: 8px;
            border: 1px solid var(--border);
            transition: var(--transition);
            white-space: nowrap;
        }

        .back-link:hover {
            background-color: var(--border-light);
            border-color: var(--primary);
            color: var(--primary);
            transform: translateX(-2px);
        }

        /* Post Card */
        .post-card {
            background-color: var(--bg-card);
            border-radius: var(--radius);
            padding: 32px;
            margin-bottom: 24px;
            box-shadow: var(--shadow);
            animation: fadeInUp 0.5s ease-out 0.1s backwards;
        }

        .post-header {
            display: flex;
            align-items: flex-start;
            gap: 16px;
            margin-bottom: 20px;
        }

        .avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 18px;
            flex-shrink: 0;
        }

        .post-meta {
            flex: 1;
        }

        .post-title {
            font-size: 20px;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 8px;
            line-height: 1.4;
        }

        .post-info {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 13px;
            color: var(--text-muted);
            flex-wrap: wrap;
        }

        .post-info span {
            display: inline-flex;
            align-items: center;
        }

        .badge {
            padding: 4px 10px;
            background: #e8f5e9;
            color: #2e7d32;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .post-content {
            font-size: 15px;
            color: var(--text-secondary);
            line-height: 1.7;
            margin-bottom: 20px;
            padding: 20px 0;
            border-top: 1px solid var(--border-light);
            border-bottom: 1px solid var(--border-light);
        }

        .post-stats {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .stat {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-size: 14px;
            color: var(--text-secondary);
        }

        .stat span {
            font-size: 16px;
        }

        .interaction-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            border: 1px solid var(--border);
            background: transparent;
            padding: 8px 16px;
            border-radius: 8px;
            cursor: pointer;
            color: var(--text-secondary);
            font-size: 14px;
            font-weight: 500;
            transition: var(--transition);
        }

        .interaction-btn:hover {
            background: var(--border-light);
            border-color: var(--primary);
            color: var(--text-primary);
        }

        .interaction-btn .count {
            font-weight: 600;
            color: var(--text-primary);
        }

        .interaction-btn.liked {
            background: var(--primary-light);
            border-color: var(--primary);
            color: var(--primary-dark);
        }

        .interaction-btn.liked .count {
            color: var(--primary-dark);
        }

        .interaction-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .interaction-icon {
            font-size: 18px;
        }

        /* Reply Form */
        .reply-form-card {
            background-color: var(--bg-card);
            border-radius: var(--radius);
            padding: 24px;
            margin-bottom: 24px;
            box-shadow: var(--shadow);
            animation: fadeInUp 0.5s ease-out 0.2s backwards;
        }

        .reply-form-card h3 {
            font-size: 18px;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 16px;
        }

        .reply-textarea {
            width: 100%;
            padding: 16px;
            border: 1px solid var(--border);
            border-radius: 8px;
            min-height: 120px;
            margin-bottom: 16px;
            font-family: inherit;
            font-size: 14px;
            color: var(--text-primary);
            resize: vertical;
            transition: var(--transition);
        }

        .reply-textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px var(--primary-light);
        }

        .reply-textarea::placeholder {
            color: var(--text-muted);
        }

        .submit-btn {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 12px 28px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 2px 8px rgba(0, 191, 165, 0.3);
        }

        .submit-btn:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 191, 165, 0.4);
        }

        .submit-btn:active {
            transform: translateY(0);
        }

        /* Replies Section */
        .replies-section {
            animation: fadeIn 0.5s ease-out 0.3s backwards;
        }

        .replies-header {
            font-size: 18px;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 16px;
        }

        .reply {
            background-color: var(--bg-card);
            border-radius: var(--radius);
            padding: 20px;
            margin-bottom: 16px;
            box-shadow: var(--shadow);
            transition: var(--transition);
            animation: fadeInUp 0.5s ease-out backwards;
        }

        .reply:nth-child(1) { animation-delay: 0.1s; }
        .reply:nth-child(2) { animation-delay: 0.2s; }
        .reply:nth-child(3) { animation-delay: 0.3s; }
        .reply:nth-child(4) { animation-delay: 0.4s; }

        .reply:hover {
            box-shadow: var(--shadow-hover);
        }

        .reply-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 12px;
        }

        .reply-avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 14px;
            flex-shrink: 0;
        }

        .reply-meta {
            flex: 1;
        }

        .reply-author {
            font-size: 14px;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 2px;
        }

        .reply-time {
            font-size: 12px;
            color: var(--text-muted);
        }

        .reply-content {
            font-size: 14px;
            color: var(--text-secondary);
            line-height: 1.6;
            padding-left: 48px;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            color: var(--text-muted);
            padding: 60px 20px;
            background-color: var(--bg-card);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
        }

        .empty-state-icon {
            font-size: 48px;
            margin-bottom: 16px;
            opacity: 0.3;
        }

        .empty-state p {
            font-size: 15px;
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
            .container {
                padding: 16px 12px;
            }

            .header {
                flex-direction: column;
                align-items: flex-start;
            }

            .header-content h1 {
                font-size: 24px;
            }

            .back-link {
                align-self: flex-start;
            }

            .post-card {
                padding: 20px;
            }

            .post-header {
                gap: 12px;
            }

            .avatar {
                width: 40px;
                height: 40px;
                font-size: 16px;
            }

            .post-title {
                font-size: 18px;
            }

            .reply-form-card {
                padding: 20px;
            }

            .reply {
                padding: 16px;
            }

            .reply-content {
                padding-left: 0;
                margin-top: 8px;
            }
        }

        /* Accessibility */
        @media (prefers-reduced-motion: reduce) {
            * {
                animation: none !important;
                transition: none !important;
            }
        }

        button:focus, textarea:focus {
            outline: 2px solid var(--primary);
            outline-offset: 2px;
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/includes/navbar.jsp" %>
    
    <div class="container">
        <!-- Header -->
        <div class="header">
            <div class="header-content">
                <h1>Peer Support Forum</h1>
                <p>A safe space to share, connect, and support each other</p>
            </div>
            <a href="${pageContext.request.contextPath}/student/forum" class="back-link">
                ← Back to Forum
            </a>
        </div>

        <!-- Post Card -->
        <div class="post-card" data-post-id="${post.id}">
            <div class="post-header">
                <div class="avatar"><c:out value="${post.avatar}"/></div>
                <div class="post-meta">
                    <div class="post-title"><c:out value="${post.title}"/></div>
                    <div class="post-info">
                        <span><c:out value="${post.authorName}"/></span>
                        <span>•</span>
                        <c:if test="${not empty post.badge}">
                            <span class="badge"><c:out value="${post.badge}"/></span>
                            <span>•</span>
                        </c:if>
                        <span><c:out value="${post.category}"/></span>
                        <span>•</span>
                            <span><c:out value="${fn:replace(post.createdAt,'T',' ')}"/></span>
                    </div>
                </div>
            </div>
            
            <div class="post-content">
                <c:out value="${post.content}"/>
            </div>
            
            <div class="post-stats">
                <button class="interaction-btn" onclick="toggleLikePost(event, this)" id="likeBtn">
                    <span class="interaction-icon">👍</span>
                    <span class="count"><c:out value="${post.likes}"/></span>
                </button>
                <div class="stat">
                    <span>💬</span>
                    <span><c:out value="${post.replyCount}"/> replies</span>
                </div>
            </div>
        </div>

        <!-- Reply Form -->
        <form action="${pageContext.request.contextPath}/student/forum/addReply" method="post" class="reply-form-card">
            <h3>Join the discussion</h3>
            <input type="hidden" name="postId" value="${post.id}" />
            <textarea name="content" class="reply-textarea" placeholder="Type your reply here... Be kind and supportive." required></textarea>
            <button type="submit" class="submit-btn">Post Reply</button>
        </form>

        <!-- Replies Section -->
        <div class="replies-section">
            <c:if test="${not empty replies}">
                <h2 class="replies-header">Replies</h2>
            </c:if>
            
            <c:if test="${empty replies}">
                <div class="empty-state">
                    <div class="empty-state-icon">💬</div>
                    <p>No replies yet. Be the first to share your thoughts!</p>
                </div>
            </c:if>
            
            <c:forEach var="r" items="${replies}">
                <div class="reply">
                    <div class="reply-header">
                        <div class="reply-avatar"><c:out value="${r.avatar}"/></div>
                        <div class="reply-meta">
                            <div class="reply-author"><c:out value="${r.authorName}"/></div>
                            <div class="reply-time"><c:out value="${fn:replace(r.createdAt,'T',' ')}"/></div>
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
                
                // Include CSRF header if present (sanitize header name)
                const csrfMeta = document.querySelector('meta[name="_csrf"]');
                const csrfHeaderMeta = document.querySelector('meta[name="_csrf_header"]');
                const headers = { 'Content-Type': 'application/x-www-form-urlencoded' };
                
                if (csrfMeta && csrfHeaderMeta) {
                    const headerNameRaw = csrfHeaderMeta.getAttribute('content');
                    const headerName = headerNameRaw ? headerNameRaw.trim() : '';
                    const token = csrfMeta.getAttribute('content');
                    const validName = headerName && /^[!#$%&'*+\-.^_`|~0-9A-Za-z]+$/.test(headerName);
                    
                    if (validName) {
                        headers[headerName] = token;
                    } else {
                        console.warn('Skipping invalid CSRF header name:', headerNameRaw);
                    }
                }

                btn.disabled = true;
                let res;
                
                try {
                    console.debug('toggleLikePost headers:', headers);
                    res = await fetch(contextPath + 'student/forum/toggle-like', {
                        method: 'POST',
                        headers,
                        body: form.toString()
                    });
                } catch (fetchErr) {
                    console.error('fetch error', fetchErr);
                    alert('Network error. Please try again.');
                    btn.disabled = false;
                    return;
                }

                if (!res.ok) {
                    const txt = await res.text().catch(() => '');
                    console.error('toggle-like non-OK', res.status, txt);
                    alert('Server error: ' + res.status);
                    btn.disabled = false;
                    return;
                }

                let data;
                try {
                    data = await res.json();
                } catch (parseErr) {
                    console.error('invalid json', parseErr);
                    alert('Server returned invalid response.');
                    btn.disabled = false;
                    return;
                }

                if (data.ok) {
                    const countSpan = btn.querySelector('.count');
                    if (countSpan) countSpan.textContent = data.likes;
                    if (data.liked) btn.classList.add('liked'); 
                    else btn.classList.remove('liked');
                } else {
                    if (data.error === 'not-authenticated') {
                        window.location.href = contextPath + 'login';
                    } else {
                        console.warn('toggle-like failed', data);
                    }
                }

                btn.disabled = false;
            } catch (e) {
                console.error('toggleLikePost error', e);
                btn.disabled = false;
            }
        }
    </script>
</body>
</html>