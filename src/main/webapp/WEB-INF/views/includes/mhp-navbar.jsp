<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<style>
    .navbar {
        background-color: #ffffff;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        padding: 0;
        position: sticky;
        top: 0;
        z-index: 1000;
        border-bottom: 1px solid #e5e7eb;
    }

    .navbar-container {
        max-width: 1400px;
        margin: 0 auto;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 24px;
        height: 64px;
    }

    .navbar-brand {
        display: flex;
        align-items: center;
        text-decoration: none;
        color: #111827;
        font-size: 24px;
        font-weight: 700;
        letter-spacing: -0.5px;
    }

    .navbar-brand:hover {
        color: #22d3ee;
    }

    .navbar-menu {
        display: flex;
        align-items: center;
        gap: 8px;
        list-style: none;
        margin: 0;
        padding: 0;
    }

    .navbar-item {
        margin: 0;
    }

    .navbar-link {
        display: block;
        padding: 8px 16px;
        text-decoration: none;
        color: #4b5563;
        font-size: 15px;
        font-weight: 500;
        border-radius: 6px;
        transition: all 0.2s;
    }

    .navbar-link:hover {
        background-color: #f3f4f6;
        color: #111827;
    }

    .navbar-link.active {
        background-color: #e0f2fe;
        color: #0369a1;
    }

    .logout-btn {
        padding: 8px 20px;
        background-color: #78ad88;
        color: white;
        border: none;
        border-radius: 6px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: background-color 0.2s;
        margin-left: 8px;
    }

    .logout-btn:hover {
        background-color: #435337;
    }

    .user-info {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 8px 16px;
        background-color: #f9fafb;
        border-radius: 6px;
        font-size: 14px;
        color: #6b7280;
    }

    .user-avatar {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        background: linear-gradient(135deg, #5eead4 0%, #22d3ee 100%);
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 600;
        font-size: 14px;
    }

    @media (max-width: 768px) {
        .navbar-container {
            flex-wrap: wrap;
            height: auto;
            padding: 12px 16px;
        }

        .navbar-menu {
            width: 100%;
            flex-wrap: wrap;
            margin-top: 8px;
            gap: 4px;
        }

        .user-info {
            display: none;
        }
    }
</style>

<nav class="navbar">
    <div class="navbar-container">
        <a href="${pageContext.request.contextPath}/mhp/home" class="navbar-brand">
            MindWell
        </a>

        <ul class="navbar-menu">
            <li class="navbar-item">
                <a href="${pageContext.request.contextPath}/mhp/home" 
                   class="navbar-link ${pageContext.request.requestURI.contains('/home') ? 'active' : ''}">
                    Home
                </a>
            </li>
            <li class="navbar-item">
                <a href="${pageContext.request.contextPath}/mhp/create-content" 
                   class="navbar-link ${pageContext.request.requestURI.contains('/create-content') ? 'active' : ''}">
                    Create Content
                </a>
            </li>
            <li class="navbar-item">
                <a href="${pageContext.request.contextPath}/sessions/confirm" 
                   class="navbar-link ${pageContext.request.requestURI.contains('/confirm') ? 'active' : ''}">
                    Manage Sessions
                </a>
            </li>
            <li class="navbar-item">
                <a href="${pageContext.request.contextPath}/mhp/chatbot" 
                   class="navbar-link ${pageContext.request.requestURI.contains('/chatbot') ? 'active' : ''}">
                    Chatbot
                </a>
            </li>

            
            <!-- <c:if test="${not empty user}">
                <li class="navbar-item">
                    <div class="user-info">
                        <div class="user-avatar">
                            ${fn:substring(user.username, 0, 1).toUpperCase()}
                        </div>
                        <span>${user.username}</span>
                    </div>
                </li>
            </c:if> -->

            <li class="navbar-item">
                <div class="user-info">
                    <div class="user-avatar">
                        <!-- ${fn:substring(displayName, 0, 1).toUpperCase()} -->
                         M
                    </div>
                    <!-- <span>${displayName}</span> -->
                     <span>mhp1</span>
                </div>
            </li>
            
            <li class="navbar-item">
                <form action="${pageContext.request.contextPath}/mhp/logout" method="get" style="margin: 0;">
                    <button type="submit" class="logout-btn">Logout</button>
                </form>
            </li>
        </ul>
    </div>
</nav>
