<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="admin-header-container">
    <style>
        /* Scope styles to this container only */
        .admin-header-container {
            width: 100%;
            margin-bottom: 30px;
            position: relative;
        }

        .header-top-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
        }

        .header-top-row h1 {
            font-size: 28px;
            margin: 0;
            color: #111827;
        }

        .logout-btn {
            background: #6c6c6c;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            transition: 0.2s;
        }

        .logout-btn:hover {
            background: #111827;
            color: white;
        }

        /* Summary Cards */
        .summary-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .summary-card {
            background-color: #ffffff;
            border-radius: 12px;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05); 
            border: 1px solid #e5e7eb;
        }

        .summary-card .number {
            font-size: 24px;
            font-weight: 700;
        }

        .summary-card .percent {
            color: #10b981; 
            font-weight: 500;
            font-size: 14px;
        }

        .summary-card .icon {
            font-size: 24px; 
            background-color: #e0f7f6;
            border-radius: 8px;
            padding: 8px;
            color: #14b8a6;
        }

        /* Tabs - Updated for long labels */
        .tabs {
            display: flex;
            gap: 8px;
            background-color: #f3f5f7;
            padding: 6px;
            border-radius: 12px;
            width: fit-content;
            margin-bottom: 20px;
            flex-wrap: wrap; /* Allows wrapping if screen is small */
        }

        .tab-link {
            cursor: pointer;
            font-weight: 500;
            font-size: 14px;
            padding: 8px 16px;
            border-radius: 8px;
            color: #6b7280; 
            text-decoration: none;
            transition: 0.2s;
            white-space: nowrap; /* Keeps long labels on one line */
        }

        .tab-link.active {
            background-color: #ffffff;
            color: #111827;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }
    </style>

    <div class="header-top-row">
        <div>
            <h1>Admin Dashboard</h1>
            <small style="color: #6b7280;">Monitor platform health and user activity</small>
        </div>
        <form action="${pageContext.request.contextPath}/auth/logout" method="get">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </div>

    <div class="summary-cards">
        <div class="summary-card">
            <div class="info">
                <div style="font-size: 14px; color: #6b7280;">Total Users</div>
                <div class="number">${not empty totalUsers ? totalUsers : '0'}</div>
                <div class="percent">+12%</div>
            </div>
            <div class="icon">👤</div> 
        </div>

        <div class="summary-card">
            <div class="info">
                <div style="font-size: 14px; color: #6b7280;">Active Content</div>
                <div class="number">${not empty activeContentCount ? activeContentCount : 0}</div>
                <div class="percent">+8%</div>
            </div>
            <div class="icon">📄</div>
        </div>

        <div class="summary-card">
            <div class="info">
                <div style="font-size: 14px; color: #6b7280;">Forum Posts</div>
                <div class="number">${not empty totalForumPosts ? totalForumPosts : '0'}</div>
                <div class="percent" style="color: #10b981;">Live</div>
            </div>
            <div class="icon">💬</div>
        </div>

        <div class="summary-card">
            <div class="info">
                <div style="font-size: 14px; color: #6b7280;">Daily Active</div>
                <div class="number">432</div>
                <div class="percent">+5%</div>
            </div>
            <div class="icon">📈</div>
        </div>
    </div>

    <div class="tabs">
        <a href="${pageContext.request.contextPath}/admin/home" 
           class="tab-link ${fn:contains(pageContext.request.requestURI, '/admin/home') ? 'active' : ''}">Overview</a>

        <a href="${pageContext.request.contextPath}/admin/content-quality" 
           class="tab-link ${fn:contains(pageContext.request.requestURI, '/admin/content-quality') ? 'active' : ''}">Content Quality</a>

        <a href="${pageContext.request.contextPath}/admin/moderation-queue" 
           class="tab-link ${fn:contains(pageContext.request.requestURI, '/admin/moderation-queue') ? 'active' : ''}">Content Moderation Queue</a>

        <a href="${pageContext.request.contextPath}/admin/forum-moderation-queue" 
           class="tab-link ${fn:contains(pageContext.request.requestURI, '/admin/forum-moderation-queue') ? 'active' : ''}">Forum Moderation Queue</a>

        <a href="${pageContext.request.contextPath}/admin/platform-analytics" 
           class="tab-link ${fn:contains(pageContext.request.requestURI, '/admin/platform-analytics') ? 'active' : ''}">Platform Analytics</a>
    </div>
</div>