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
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Arial, sans-serif;
            background-color: #f8fafb;
            color: #1a1a1a;
        }

        /* Main content wrapper like chatbot */
        .page-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 20px;
        }

        h1 {
            color: #00b9b7;
            font-size: 26px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        p.page-subtext {
            color: #6b7280;
            font-size: 14px;
            margin-bottom: 20px;
        }

        /* Session Card Container */
        table.card {
            width: 100%;
            background-color: #ffffff;
            border-radius: 12px;
            padding: 20px;
            border-collapse: separate;
            border-spacing: 0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        table.session-item {
            width: 100%;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 15px 20px;
            margin-bottom: 14px;
            background-color: #fff;
        }

        td.session-info {
            vertical-align: top;
        }

        .avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background-color: #00c4c3;
            color: #fff;
            font-weight: bold;
            text-align: center;
            line-height: 42px;
            font-size: 14px;
        }

        .session-text h3 {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .badge {
            font-size: 10px;
            padding: 3px 8px;
            font-weight: 600;
            border-radius: 10px;
        }

        .badge-confirmed { background-color: #34d399; color: #fff; }
        .badge-pending { background-color: #d1d5db; color: #6b7280; }

        .session-subtext {
            font-size: 13px;
            color: #6b7280;
        }

        td.session-actions {
            text-align: right;
            vertical-align: middle;
        }

        .btn-view, .btn-start {
            padding: 8px 14px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 500;
            text-decoration: none;
            display: inline-block;
            transition: 0.2s;
        }

        .btn-view {
            background-color: #f1f2f6;
            color: #1a1a1a;
        }

        .btn-view:hover {
            background-color: #e6e8ed;
            transform: translateY(-1px);
        }

        .btn-start {
            background-color: #00c4c3;
            color: #fff;
        }

        .btn-start:hover {
            background-color: #00aaa8;
            transform: translateY(-1px);
        }

        .btn-start.disabled {
            background-color: #d1d5db;
            color: #6b7280;
            cursor: not-allowed;
            box-shadow: none;
        }
    </style>
</head>

<body>

    <!-- Navbar identical to chatbot.jsp -->
    <jsp:include page="/WEB-INF/views/includes/mhp-navbar.jsp" />

    <div class="page-container">

        <h1>Manage Upcoming Sessions</h1>
        <p class="page-subtext">Manage your schedule and upcoming counseling sessions</p>

        <table class="card">
            <tr>
                <td>

                    <!-- Session #1 -->
                    <table class="session-item">
                        <tr>
                            <td class="session-info">
                                <table>
                                    <tr>
                                        <td><div class="avatar">JS</div></td>
                                        <td style="padding-left: 15px;">
                                            <div class="session-text">
                                                <h3>John Smith <span class="badge badge-confirmed">Confirmed</span></h3>
                                                <div class="session-subtext">
                                                    Initial Consultation <br>
                                                    &#128337; 12 Dec 2025 • 60 min
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>

                            <td class="session-actions">
                                <a href="${pageContext.request.contextPath}/sessions/detail" class="btn-view">View Details</a>
                                <a href="${pageContext.request.contextPath}/sessions/meeting" class="btn-start">&#127909; Start Session</a>
                            </td>
                        </tr>
                    </table>

                    <!-- Session #2 -->
                    <table class="session-item">
                        <tr>
                            <td class="session-info">
                                <table>
                                    <tr>
                                        <td><div class="avatar">AM</div></td>
                                        <td style="padding-left: 15px;">
                                            <div class="session-text">
                                                <h3>Alice Moore <span class="badge badge-pending">Pending</span></h3>
                                                <div class="session-subtext">
                                                    Follow Up Session <br>
                                                    &#128337; 13 Dec 2025 • 45 min
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>

                            <td class="session-actions">
                                <a href="${pageContext.request.contextPath}/sessions/detail" class="btn-view">View Details</a>
                                <span class="btn-start disabled">&#127909; Start Session</span>
                            </td>
                        </tr>
                    </table>

                </td>
            </tr>
        </table>

    </div>
</body>
</html>
