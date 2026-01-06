<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Upcoming Sessions</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Arial, sans-serif; background-color: #f8fafb; color: #1a1a1a; }
        .page-container { max-width: 900px; margin: 0 auto; padding: 20px; }
        h1 { color: #00b9b7; font-size: 26px; font-weight: 700; margin-bottom: 5px; }
        p.page-subtext { color: #6b7280; font-size: 14px; margin-bottom: 20px; }
        table.card { width: 100%; background-color: #ffffff; border-radius: 12px; padding: 20px; border-collapse: separate; border-spacing: 0; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        table.session-item { width: 100%; border: 1px solid #e5e7eb; border-radius: 12px; padding: 15px 20px; margin-bottom: 14px; background-color: #fff; }
        td.session-info { vertical-align: top; }
        .avatar { width: 42px; height: 42px; border-radius: 50%; background-color: #00c4c3; color: #fff; font-weight: bold; text-align: center; line-height: 42px; font-size: 14px; text-transform: uppercase; }
        .session-text h3 { font-size: 16px; font-weight: 600; margin-bottom: 5px; }
        .badge { font-size: 10px; padding: 3px 8px; font-weight: 600; border-radius: 10px; }
        .badge-confirmed { background-color: #34d399; color: #fff; }
        .badge-pending { background-color: #d1d5db; color: #6b7280; }
        .session-subtext { font-size: 13px; color: #6b7280; }
        td.session-actions { text-align: right; vertical-align: middle; }
        .btn-view, .btn-start, .btn-confirm { padding: 8px 14px; border-radius: 8px; font-size: 13px; font-weight: 500; text-decoration: none; display: inline-block; transition: 0.2s; border: none; cursor: pointer; }
        .btn-view { background-color: #f1f2f6; color: #1a1a1a; margin-right: 5px; }
        .btn-start { background-color: #00c4c3; color: #fff; }
        .btn-confirm { background-color: #f59e0b; color: #fff; }
        .btn-start.disabled { background-color: #d1d5db; color: #6b7280; cursor: not-allowed; }
        .no-sessions { text-align: center; padding: 40px; color: #6b7280; }
    </style>
</head>

<body>
    <jsp:include page="/WEB-INF/views/includes/mhp-navbar.jsp" />

    <div class="page-container">
        <h1>Manage Upcoming Sessions</h1>
        <p class="page-subtext">Manage your schedule and upcoming counseling sessions</p>

        <table class="card">
            <tr>
                <td>
                    <c:choose>
                        <c:when test="${not empty sessions}">
                            <c:forEach items="${sessions}" var="s">
                                <table class="session-item">
                                    <tr>
                                        <td class="session-info">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <div class="avatar">
                                                            ${fn:substring(s.student.username, 0, 2)}
                                                        </div>
                                                    </td>
                                                    <td style="padding-left: 15px;">
                                                        <div class="session-text">
                                                            <h3>${s.student.username} 
                                                                <c:choose>
                                                                    <c:when test="${s.confirmed}">
                                                                        <span class="badge badge-confirmed">Confirmed</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge badge-pending">Pending</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </h3>
                                                            <div class="session-subtext">
                                                                Session ID: #${s.id} <br>
                                                                <i class="far fa-clock"></i> ${s.time}
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                        <td class="session-actions">
                                            <a href="${pageContext.request.contextPath}/sessions/detail?id=${s.id}" class="btn-view">
                                                <i class="fas fa-eye"></i> View Details
                                            </a>
                                            
                                            <c:choose>
                                                <c:when test="${s.confirmed}">
                                                    <a href="${pageContext.request.contextPath}/sessions/meeting?sessionId=${s.id}" class="btn-start">
                                                        <i class="fas fa-video"></i> Start Session
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <form action="${pageContext.request.contextPath}/sessions/confirm" method="POST" style="display:inline;">
                                                        <input type="hidden" name="sessionId" value="${s.id}">
                                                        <button type="submit" class="btn-confirm">
                                                            <i class="fas fa-check"></i> Confirm Request
                                                        </button>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </table>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="no-sessions">
                                <i class="fas fa-calendar-times fa-3x" style="margin-bottom: 10px; color: #d1d5db;"></i>
                                <p>No upcoming sessions found.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>