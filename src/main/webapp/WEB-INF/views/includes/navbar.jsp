<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- Fragment include: no DOCTYPE/html/body wrappers -->
<style>
    .navbar{background:#fff;box-shadow:0 1px 3px rgba(0,0,0,0.1);position:sticky;top:0;z-index:1000;border-bottom:1px solid #e5e7eb}
    .navbar-container{max-width:1400px;margin:0 auto;display:flex;align-items:center;justify-content:space-between;padding:0 24px;height:64px}
    .navbar-brand{text-decoration:none;color:#111827;font-size:24px;font-weight:700}
    .navbar-menu{display:flex;align-items:center;gap:8px;list-style:none;margin:0;padding:0}
    .navbar-link{display:block;padding:8px 16px;text-decoration:none;color:#4b5563;border-radius:6px}
    .navbar-link:hover{background:#f3f4f6;color:#111827}
    .navbar-link.active{background:#e0f2fe;color:#0369a1}
    .logout-btn{padding:8px 20px;background:#78ad88;color:#fff;border:none;border-radius:6px;cursor:pointer}
    .user-info{display:flex;align-items:center;gap:12px;padding:8px 16px;background:#f9fafb;border-radius:6px}
    .user-avatar{width:32px;height:32px;border-radius:50%;background:linear-gradient(135deg,#5eead4 0%,#22d3ee 100%);color:#fff;display:flex;align-items:center;justify-content:center;font-weight:600}
</style>
<nav class="navbar"> 
    <div class="navbar-container">
        <a href="${pageContext.request.contextPath}/student/home" class="navbar-brand">MindWell</a>
        <ul class="navbar-menu">
            <li><a href="${pageContext.request.contextPath}/student/home" class="navbar-link ${pageContext.request.requestURI.contains('/home') ? 'active' : ''}">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/student/forum" class="navbar-link ${pageContext.request.requestURI.contains('/forum') ? 'active' : ''}">Forum</a></li>
            <li><a href="${pageContext.request.contextPath}/student/chatbot" class="navbar-link ${pageContext.request.requestURI.contains('/chatbot') ? 'active' : ''}">Chatbot</a></li>

            <c:if test="${not empty sessionScope.loggedInUser}">
                <li>
                        <div class="user-info">
                            <div class="user-avatar">${fn:toUpperCase(fn:substring(sessionScope.loggedInUser.username, 0, 1))}</div>
                            <span>${sessionScope.loggedInUser.username}</span>
                        </div>
                </li>
            </c:if>

            <li>
                <form action="${pageContext.request.contextPath}/student/logout" method="get" style="margin:0;">
                    <button type="submit" class="logout-btn">Logout</button>
                </form>
            </li>
        </ul>
    </div>
</nav>

