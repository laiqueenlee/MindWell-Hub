<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />
    <title>Peer Support Forum - MindWell</title>
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

        .forum-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 24px 20px;
        }

        /* Header */
        header {
            margin-bottom: 24px;
            animation: fadeInDown 0.5s ease-out;
        }

        header h1 {
            font-size: 28px;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 6px;
        }

        header p {
            font-size: 14px;
            color: var(--text-secondary);
        }

        /* Top Bar - Tabs and New Post */
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            gap: 16px;
            animation: fadeIn 0.5s ease-out 0.1s backwards;
        }

        .tabs {
            display: flex;
            gap: 6px;
            align-items: center;
        }

        .tab-btn {
            padding: 8px 16px;
            background: transparent;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            color: var(--text-secondary);
            cursor: pointer;
            transition: var(--transition);
            font-weight: 500;
        }

        .tab-btn:hover {
            background: var(--border-light);
            color: var(--text-primary);
        }

        .tab-btn.active {
            background: var(--bg-card);
            color: var(--text-primary);
            box-shadow: var(--shadow);
        }

        .new-post-btn {
            padding: 10px 20px;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            white-space: nowrap;
            box-shadow: 0 2px 8px rgba(0, 191, 165, 0.3);
            text-decoration: none;
            display: inline-block;
        }

        .new-post-btn:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 191, 165, 0.4);
        }

        /* Search Bar */
        .search-container {
            margin-bottom: 20px;
            animation: fadeIn 0.5s ease-out 0.2s backwards;
        }

        .search-wrapper {
            position: relative;
        }

        .search-input {
            width: 100%;
            padding: 12px 16px 12px 44px;
            border: 1px solid var(--border);
            border-radius: 10px;
            font-size: 14px;
            background: var(--bg-card);
            transition: var(--transition);
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px var(--primary-light);
        }

        .search-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            font-size: 16px;
        }

        #searchClear {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            background: transparent;
            border: none;
            cursor: pointer;
            font-size: 18px;
            color: var(--text-muted);
            display: none;
            padding: 4px;
            line-height: 1;
            transition: var(--transition);
        }

        #searchClear:hover {
            color: var(--text-primary);
        }

        /* Category Filter */
        .filter-container {
            display: flex;
            gap: 8px;
            margin-bottom: 24px;
            overflow-x: auto;
            padding: 8px 4px 4px;
            -webkit-overflow-scrolling: touch;
            animation: fadeIn 0.5s ease-out 0.3s backwards;
        }

        .filter-container::-webkit-scrollbar {
            height: 4px;
        }

        .filter-container::-webkit-scrollbar-thumb {
            background: var(--border);
            border-radius: 4px;
        }

        .category-btn {
            padding: 8px 16px;
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: 20px;
            font-size: 13px;
            color: var(--text-secondary);
            cursor: pointer;
            transition: var(--transition);
            white-space: nowrap;
            font-weight: 500;
            background-clip: padding-box;
            -webkit-background-clip: padding-box;
            position: relative;
        }

        .category-btn:hover {
            border-color: var(--primary);
            color: var(--primary);
            background: var(--primary-light);
        }

        .category-btn.active {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(0, 191, 165, 0.06);
        }

        /* Posts Section */
        .posts-section {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .post {
            background: var(--bg-card);
            border-radius: var(--radius);
            padding: 20px;
            box-shadow: var(--shadow);
            transition: var(--transition);
            cursor: pointer;
            animation: fadeInUp 0.5s ease-out backwards;
        }

        .post:nth-child(1) { animation-delay: 0.1s; }
        .post:nth-child(2) { animation-delay: 0.2s; }
        .post:nth-child(3) { animation-delay: 0.3s; }
        .post:nth-child(4) { animation-delay: 0.4s; }

        .post:hover {
            box-shadow: var(--shadow-hover);
            transform: translateY(-2px);
        }

        .post-header {
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }

        .post-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 16px;
            flex-shrink: 0;
        }

        .post-content {
            flex: 1;
        }

        .post-title-row {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 6px;
        }

        .post h3 {
            font-size: 16px;
            font-weight: 600;
            color: var(--text-primary);
            flex: 1;
        }

        .post-badge {
            padding: 4px 10px;
            background: var(--primary-light);
            color: var(--primary-dark);
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .post-badge.moderated {
            background: #e8f5e9;
            color: #2e7d32;
        }

        .post-info {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 13px;
            color: var(--text-muted);
            margin-bottom: 8px;
        }

        .post-info span {
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .post-info span::after {
            content: "•";
            margin-left: 8px;
        }

        .post-info span:last-child::after {
            content: "";
            margin-left: 0;
        }

        .post-text {
            font-size: 14px;
            color: var(--text-secondary);
            line-height: 1.5;
            margin-bottom: 14px;
        }

        .post-interactions {
            display: flex;
            gap: 12px;
            align-items: center;
            padding-top: 12px;
            border-top: 1px solid var(--border-light);
        }

        .interaction-btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: transparent;
            border: 1px solid var(--border);
            color: var(--text-secondary);
            font-size: 13px;
            cursor: pointer;
            transition: var(--transition);
            padding: 6px 12px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
        }

        .interaction-btn:hover {
            background: var(--border-light);
            border-color: var(--primary);
            color: var(--text-primary);
        }

        .interaction-btn.liked {
            background: var(--primary-light);
            border-color: var(--primary);
            color: var(--primary-dark);
        }

        .interaction-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .interaction-icon {
            font-size: 16px;
        }

        .interaction-btn .count {
            font-weight: 600;
            color: var(--text-primary);
        }

        .interaction-btn.liked .count {
            color: var(--primary-dark);
        }

        /* Community Guidelines */
        .guidelines {
            background: var(--bg-card);
            border-radius: var(--radius);
            padding: 20px;
            margin-top: 32px;
            box-shadow: var(--shadow);
            animation: fadeIn 0.5s ease-out 0.5s backwards;
        }

        .guidelines h3 {
            font-size: 16px;
            font-weight: 700;
            margin-bottom: 12px;
            color: var(--text-primary);
        }

        .guidelines ul {
            list-style: none;
            padding: 0;
        }

        .guidelines li {
            font-size: 13px;
            color: var(--text-secondary);
            padding: 6px 0;
            padding-left: 24px;
            position: relative;
        }

        .guidelines li::before {
            content: "•";
            position: absolute;
            left: 8px;
            color: var(--primary);
            font-weight: bold;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--text-muted);
        }

        .empty-state-icon {
            font-size: 48px;
            margin-bottom: 16px;
            opacity: 0.3;
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
            .forum-container {
                padding: 16px 12px;
            }

            header h1 {
                font-size: 24px;
            }

            .top-bar {
                flex-direction: column;
                align-items: stretch;
            }

            .tabs {
                overflow-x: auto;
                padding-bottom: 4px;
            }

            .new-post-btn {
                width: 100%;
                text-align: center;
            }

            .post {
                padding: 16px;
            }

            .post-header {
                gap: 10px;
            }

            .post-avatar {
                width: 36px;
                height: 36px;
                font-size: 14px;
            }

            .post h3 {
                font-size: 15px;
            }

            .post-text {
                font-size: 13px;
            }

            .post-interactions {
                gap: 8px;
            }

            .interaction-btn {
                padding: 5px 10px;
                font-size: 12px;
            }
        }

        /* Accessibility */
        @media (prefers-reduced-motion: reduce) {
            * {
                animation: none !important;
                transition: none !important;
            }
        }

        button:focus, .category-btn:focus, .tab-btn:focus {
            outline: 2px solid var(--primary);
            outline-offset: 2px;
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/includes/navbar.jsp" %>

    <div class="forum-container">
        <header>
            <h1>Peer Support Forum</h1>
            <p>A safe space to share, connect, and support each other</p>
        </header>

        <!-- Top Bar with Tabs and New Post Button -->
        <div class="top-bar">
            <div class="tabs">
                <button class="tab-btn active" data-tab="recent" onclick="switchTab('recent', event)">
                    <span>🕐</span> Recent
                </button>
                <button class="tab-btn" data-tab="popular" onclick="switchTab('popular', event)">
                    <span>⭐</span> Popular
                </button>
            </div>
            <a href="${pageContext.request.contextPath}/student/forum/new-post" class="new-post-btn">+ New Post</a>
        </div>

        <!-- Search Bar -->
        <div class="search-container">
            <div class="search-wrapper">
                <span class="search-icon">🔍</span>
                <input type="text" class="search-input" placeholder="Search posts..." id="searchInput" />
                <button id="searchClear" aria-label="Clear search">✖</button>
            </div>
        </div>

        <!-- Category Filter -->
        <div class="filter-container">
            <button class="category-btn active" data-category="All" onclick="filterByCategory(this, 'All')">All</button>
            <button class="category-btn" data-category="Stress" onclick="filterByCategory(this, 'Stress')">Stress</button>
            <button class="category-btn" data-category="Anxiety" onclick="filterByCategory(this, 'Anxiety')">Anxiety</button>
            <button class="category-btn" data-category="Depression" onclick="filterByCategory(this, 'Depression')">Depression</button>
            <button class="category-btn" data-category="Wellness" onclick="filterByCategory(this, 'Wellness')">Wellness</button>
            <button class="category-btn" data-category="Self-Care" onclick="filterByCategory(this, 'Self-Care')">Self-Care</button>
            <button class="category-btn" data-category="Relationships" onclick="filterByCategory(this, 'Relationships')">Relationships</button>
        </div>

        <!-- Posts Section -->
        <div class="posts-section" id="postsSection">
            <c:forEach var="p" items="${posts}">
                <div class="post" data-category="${p.category}" onclick="viewPost('${p.id}')">
                    <div class="post-header">
                        <div class="post-avatar"><c:out value="${p.avatar}"/></div>
                        <div class="post-content">
                            <div class="post-title-row">
                                <h3><c:out value="${p.title}"/></h3>
                                <c:if test="${not empty p.badge}">
                                    <div class="post-badge moderated"><c:out value="${p.badge}"/></div>
                                </c:if>
                            </div>

                            <div class="post-info">
                                <span><c:out value="${p.authorName}"/></span>
                                <span><c:out value="${p.category}"/></span>
                                <span><c:out value="${fn:replace(p.createdAt,'T',' ')}"/></span>
                            </div>

                            <p class="post-text"><c:out value="${p.content}"/></p>

                            <div class="post-interactions">
                                <c:set var="isLiked" value="false"/>
                                <c:forEach var="lid" items="${likedPostIds}">
                                    <c:if test="${lid == p.id}">
                                        <c:set var="isLiked" value="true"/>
                                    </c:if>
                                </c:forEach>
                                <button class="interaction-btn ${isLiked ? 'liked' : ''}"
                                        onclick="toggleLike(event, this, '${p.id}')">
                                    <span class="interaction-icon">👍</span>
                                    <span class="count"><c:out value="${p.likes}"/></span>
                                </button>

                                <a class="interaction-btn"
                                   href="${pageContext.request.contextPath}/student/forum/post/${p.id}"
                                   onclick="event.stopPropagation()"
                                   role="button"
                                   aria-label="View replies">
                                    <span class="interaction-icon">💬</span>
                                    <span><c:out value="${p.replyCount}"/> replies</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Community Guidelines -->
        <div class="guidelines">
            <h3>Community Guidelines</h3>
            <ul>
                <li>Be respectful and supportive of others</li>
                <li>Keep discussions constructive and on-topic</li>
                <li>Protect privacy - no personal information or photos</li>
                <li>Report any concerning content to moderators</li>
                <li>Remember: This is peer support, not professional therapy</li>
            </ul>
        </div>
    </div>

    <script>
        const contextPath = '${pageContext.request.contextPath}/';
        
        function filterByCategory(btn, category) {
            document.querySelectorAll('.category-btn').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            document.querySelectorAll('.post').forEach(post => {
                post.style.display = (category === 'All' || post.dataset.category === category) ? 'block' : 'none';
            });
            checkEmptyState();
        }

        function checkEmptyState() {
            const postsSection = document.getElementById('postsSection');
            const visiblePosts = Array.from(document.querySelectorAll('.post')).filter(p => p.style.display !== 'none');
            
            const existingEmpty = postsSection.querySelector('.empty-state');
            if (existingEmpty) {
                existingEmpty.remove();
            }

            if (visiblePosts.length === 0) {
                const emptyState = document.createElement('div');
                emptyState.className = 'empty-state';
                emptyState.innerHTML = `
                    <div class="empty-state-icon">💬</div>
                    <p>No posts found</p>
                `;
                postsSection.appendChild(emptyState);
            }
        }

        // Search functionality
        function searchPosts() {
            const input = document.getElementById('searchInput');
            const clearBtn = document.getElementById('searchClear');
            const filter = input ? input.value.toLowerCase().trim() : '';

            if (clearBtn) clearBtn.style.display = filter ? 'block' : 'none';

            const posts = document.querySelectorAll('.post');
            posts.forEach(post => {
                const titleEl = post.querySelector('h3');
                const title = titleEl ? titleEl.textContent.toLowerCase() : '';
                const match = !filter || title.includes(filter);
                post.style.display = match ? 'block' : 'none';
            });
            checkEmptyState();
        }

        // Clear button and input wiring
        document.addEventListener('DOMContentLoaded', () => {
            const input = document.getElementById('searchInput');
            const clearBtn = document.getElementById('searchClear');
            if (!input || !clearBtn) return;
            
            clearBtn.addEventListener('click', (e) => {
                e.stopPropagation();
                input.value = '';
                searchPosts();
                input.focus();
            });
            
            input.addEventListener('input', () => searchPosts());
            searchPosts();
        });

        function viewPost(postId) {
            window.location.href = '${pageContext.request.contextPath}/student/forum/post/' + postId;
        }

        // store original order for 'recent' sorting
        document.addEventListener('DOMContentLoaded', () => {
            document.querySelectorAll('.post').forEach((p, i) => p.dataset.origOrder = i);
        });

        // sort posts for 'popular' or restore 'recent'
        function switchTab(tab, evt) {
            // update active button
            document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.toggle('active', btn.dataset.tab === tab));

            const postsSection = document.getElementById('postsSection');
            const posts = Array.from(postsSection.querySelectorAll('.post'));

            if (tab === 'popular') {
                posts.sort((a, b) => {
                    const aLikes = parseInt((a.querySelector('.interaction-btn .count') || {textContent: '0'}).textContent) || 0;
                    const bLikes = parseInt((b.querySelector('.interaction-btn .count') || {textContent: '0'}).textContent) || 0;
                    if (bLikes !== aLikes) return bLikes - aLikes;
                    // tie-breaker: replies
                    const aReplyEl = a.querySelector('a.interaction-btn');
                    const bReplyEl = b.querySelector('a.interaction-btn');
                    const aReplies = aReplyEl ? parseInt((aReplyEl.textContent || '').match(/(\d+)/)?.[0] || 0) : 0;
                    const bReplies = bReplyEl ? parseInt((bReplyEl.textContent || '').match(/(\d+)/)?.[0] || 0) : 0;
                    return bReplies - aReplies;
                });
            } else {
                // recent: restore original server-provided order
                posts.sort((a, b) => (parseInt(a.dataset.origOrder) || 0) - (parseInt(b.dataset.origOrder) || 0));
            }

            // re-append in new order
            posts.forEach(p => postsSection.appendChild(p));
        }

        async function toggleLike(event, btn, postId) {
            event.stopPropagation();
            try {
                const csrfMeta = document.querySelector('meta[name="_csrf"]');
                const csrfHeaderMeta = document.querySelector('meta[name="_csrf_header"]');
                const headers = { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' };
                
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
                let resp;
                
                try {
                    console.debug('toggleLike headers:', headers);
                    resp = await fetch('${pageContext.request.contextPath}/student/forum/toggle-like', {
                        method: 'POST',
                        headers,
                        body: new URLSearchParams({ postId })
                    });
                } catch (fetchErr) {
                    console.error('fetch error', fetchErr);
                    alert('Network error. Please try again.');
                    return;
                }

                if (!resp.ok) {
                    const txt = await resp.text().catch(() => '');
                    console.error('toggle-like non-OK response', resp.status, txt);
                    alert('Server error: ' + resp.status);
                    return;
                }

                let data;
                try {
                    data = await resp.json();
                } catch (parseErr) {
                    console.error('invalid json from toggle-like', parseErr);
                    alert('Server returned invalid response.');
                    return;
                }

                if (!data.ok) {
                    if (data.error === 'not-authenticated') {
                        window.location.href = '${pageContext.request.contextPath}/login';
                        return;
                    }
                    console.warn('toggle-like error', data);
                    alert('Unable to like: ' + (data.error || 'unknown'));
                    return;
                }

                // Success - update UI
                btn.classList.toggle('liked', !!data.liked);
                const countSpan = btn.querySelector('.count');
                if (countSpan) countSpan.textContent = data.likes;
            } catch (e) {
                console.error('unexpected error in toggleLike', e);
                alert('Network error. Please try again.');
            } finally {
                try { btn.disabled = false; } catch (_) {}
            }
        }
    </script>
</body>
</html>