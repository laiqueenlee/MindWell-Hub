<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div>
    <style>
        /* 1. Global Page Styles (Copied from JSP) */
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f9fafb;
            margin: 0;
            padding: 20px 40px; /* Matches JSP padding */
            color: #111827;
            position: relative;
        }

        h1 {
            font-size: 28px;
            margin-bottom: 5px;
            margin-top: 0;
        }

        small {
            color: #6b7280;
        }

        /* 2. Logout Button - UPDATED TO MATCH JSP */
        .right-logout {
            position: absolute;
            top: 20px;   /* Changed from 0 to 20px to match body padding */
            right: 40px; /* Changed from 0 to 40px to match body padding */
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
            background: white;
            color: black;
        }

        /* 3. Summary Cards (with Emojis) */
        .summary-cards {
            display: flex;
            gap: 20px;
            margin: 20px 0 30px 0;
            flex-wrap: wrap;
        }

        .summary-card {
            background-color: #ffffff;
            border-radius: 12px;
            padding: 20px;
            flex: 1;
            min-width: 180px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #111827;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05); 
        }

        .summary-card .info {
            display: flex;
            flex-direction: column;
        }

        .summary-card .info .number {
            font-size: 24px;
            font-weight: 700;
        }

        .summary-card .info .percent {
            color: #10b981; 
            font-weight: 500;
        }

        .summary-card .icon {
            font-size: 28px; 
            background-color: #e0f7f6;
            border-radius: 8px;
            padding: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #14b8a6;
            height: 40px; 
            width: 40px;
        }

        /* 4. Tabs */
        .tabs {
            display: flex;
            gap: 8px;
            margin-bottom: 20px;
            background-color: #f3f5f7;
            padding: 6px;
            border-radius: 12px;
            align-items: center;
            width: fit-content;
        }

        .tab-link {
            all: unset; 
            cursor: pointer;
            display: inline-block;
            font-weight: 500;
            font-size: 14px;
            line-height: 1;
            padding: 8px 16px;
            border-radius: 8px;
            transition: background-color 0.15s ease, color 0.15s ease;
            color: #6b7280; 
            text-decoration: none;
        }

        .tab-link.active {
            background-color: #ffffff;
            color: #111827;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }

        .tab-link:not(.active):hover {
            background-color: #e5e8eb;
            color: #374151;
        }
    </style>

    <div class="top-bar">
        <div class="left-tabs">
            <h1>Admin Dashboard</h1>
            <small>Monitor platform health and user activity</small>
        </div>

        <div class="right-logout">
            <form action="${pageContext.request.contextPath}/auth/logout" method="get">
                <button type="submit" class="logout-btn">Logout</button>
            </form>
        </div>
    </div>

    <div class="summary-cards">
        <div class="summary-card">
            <div class="info">
                <div>Total Users</div>
                <div class="number">${not empty totalUsers ? totalUsers : '0'}</div>
                <div class="percent">+12%</div>
            </div>
            <div class="icon">👤</div> 
        </div>

        <div class="summary-card">
            <div class="info">
                <div>Active Content</div>
                <div class="number">${not empty activeContentCount ? activeContentCount : 0}</div>
                <div class="percent">+8%</div>
            </div>
            <div class="icon">📄</div>
        </div>

        <div class="summary-card">
            <div class="info">
                <div>Forum Posts</div>
                <div class="number">892</div>
                <div class="percent">+23%</div>
            </div>
            <div class="icon">💬</div>
        </div>

        <div class="summary-card">
            <div class="info">
                <div>Daily Active</div>
                <div class="number">432</div>
                <div class="percent">+5%</div>
            </div>
            <div class="icon">📈</div>
        </div>
    </div>

    <div class="tabs">
        <a href="${pageContext.request.contextPath}/admin/user-management" 
           class="tab-link ${fn:contains(pageContext.request.requestURI, 'user-management') ? 'active' : ''}">
           User Management
        </a>

        <a href="${pageContext.request.contextPath}/admin/content-quality" 
           class="tab-link ${fn:contains(pageContext.request.requestURI, 'content-quality') ? 'active' : ''}">
           Content Quality
        </a>

        <a href="${pageContext.request.contextPath}/admin/moderation-queue" 
           class="tab-link ${fn:contains(pageContext.request.requestURI, 'moderation-queue') ? 'active' : ''}">
           Moderation Queue
        </a>

        <a href="${pageContext.request.contextPath}/admin/platform-analytics" 
           class="tab-link ${fn:contains(pageContext.request.requestURI, 'platform-analytics') ? 'active' : ''}">
           Platform Analytics
        </a>
    </div>
    
</div>