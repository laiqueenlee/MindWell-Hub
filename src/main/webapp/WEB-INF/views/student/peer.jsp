<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Peer Support Forum - MindWell</title>
    <style>
        :root { --primary: #00bfa5; --primary-dark: #00897b; --primary-light: #e0f7f4; --text-primary: #1a1a1a; --text-secondary: #666; --text-muted: #999; --bg-page: #f8fafb; --bg-card: #ffffff; --border: #e5e7eb; --border-light: #f0f2f4; --radius: 12px; --shadow: 0 2px 8px rgba(0,0,0,0.06); --shadow-hover: 0 4px 16px rgba(0,0,0,0.1); --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif; background: var(--bg-page); color: var(--text-primary); line-height: 1.6; }
        .forum-container { max-width: 900px; margin: 0 auto; padding: 24px 20px; }
        header { margin-bottom: 24px; animation: fadeInDown 0.5s ease-out; }
        header h1 { font-size: 28px; font-weight: 700; color: var(--text-primary); margin-bottom: 6px; }
        header p { font-size: 14px; color: var(--text-secondary); }
        .top-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; gap: 16px; }
        .new-post-btn { padding: 10px 20px; background: var(--primary); color: white; border: none; border-radius: 8px; font-size: 14px; font-weight: 600; cursor: pointer; text-decoration: none; }
        .posts-section { display: flex; flex-direction: column; gap: 16px; align-items: stretch; }
        .post { background: var(--bg-card); border-radius: var(--radius); padding: 20px; box-shadow: var(--shadow); transition: var(--transition); cursor: pointer; }
        .post-header { display: flex; align-items: flex-start; gap: 12px; margin-bottom: 12px; }
        .post-avatar { width: 40px; height: 40px; border-radius: 50%; background: linear-gradient(135deg, var(--primary), var(--primary-dark)); display: flex; align-items: center; justify-content: center; color: white; font-weight: 600; flex-shrink: 0; }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/includes/navbar.jsp" %>

    <div class="forum-container">
        <header>
            <h1>Peer Support Forum</h1>
            <p>A safe space to share, connect, and support each other</p>
        </header>

        <div class="top-bar">
            <div class="tabs">
                <!-- tabs omitted -->
            </div>
            <a href="${pageContext.request.contextPath}/student/forum/new-post" class="new-post-btn">+ New Post</a>
        </div>

        <div class="search-container">
            <div class="search-wrapper">
                <!-- search input omitted -->
            </div>
        </div>

        <div class="filter-container">
            <button class="category-btn active" data-category="All" onclick="filterByCategory(this, 'All')">All</button>
            <button class="category-btn" data-category="Stress" onclick="filterByCategory(this, 'Stress')">Stress</button>
            <button class="category-btn" data-category="Anxiety" onclick="filterByCategory(this, 'Anxiety')">Anxiety</button>
            <button class="category-btn" data-category="Depression" onclick="filterByCategory(this, 'Depression')">Depression</button>
            <button class="category-btn" data-category="Wellness" onclick="filterByCategory(this, 'Wellness')">Wellness</button>
            <button class="category-btn" data-category="Self-Care" onclick="filterByCategory(this, 'Self-Care')">Self-Care</button>
            <button class="category-btn" data-category="Relationships" onclick="filterByCategory(this, 'Relationships')">Relationships</button>
        </div>

        <div class="posts-section" id="postsSection">
            <!-- posts rendered by server or client-side script -->
            <c:forEach var="p" items="${posts}">
                <div class="post" data-post-id="${p.id}" data-category="${p.category}">
                    <div class="post-header">
                        <div class="post-avatar"><c:out value="${p.avatar}"/></div>
                        <div>
                            <div class="post-title-row"><h3><c:out value="${p.title}"/></h3></div>
                            <div class="post-info"><span><c:out value="${p.authorName}"/></span> • <span><c:out value="${p.category}"/></span></div>
                            <p class="post-text"><c:out value="${p.content}"/></p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="guidelines">
            <h3>Community Guidelines</h3>
            <ul>
                <li>Be respectful and supportive.</li>
                <li>Protect your privacy—avoid sharing personal details.</li>
                <li>Seek help if you are in crisis; this forum is not a substitute for emergency services.</li>
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
        function checkEmptyState() { /* minimal client helper */ }
    </script>
</body>
</html>
