<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Home</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f9fafb;
            margin: 0;
            padding: 40px;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-top: 20px;
        }

        .card {
            background: white;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            border: 1px solid #e5e7eb;
        }

        /* Recent Users Table */
        .u-table { width: 100%; border-collapse: collapse; }
        .u-table td { padding: 14px 0; border-bottom: 1px solid #f3f4f6; }
        
        .user-name {
            display: block;
            font-size: 16px;
            font-weight: 700; /* Extra bold */
            color: #111827;
            margin-bottom: 2px;
        }

        .user-id-badge {
            font-size: 12px;
            color: #6b7280;
            font-weight: 500;
        }

        .role-tag { 
            font-size: 11px; 
            background: #f3f4f6; 
            padding: 4px 10px; 
            border-radius: 6px; 
            text-transform: uppercase; 
            font-weight: 600;
            color: #374151;
            letter-spacing: 0.025em;
        }

        /* Distribution Bars */
        .bar-container { margin-bottom: 20px; }
        .bar-label { display: flex; justify-content: space-between; margin-bottom: 8px; font-size: 14px; }
        .bar-bg { height: 8px; background: #e5e7eb; border-radius: 4px; overflow: hidden; }
        .bar-fill { height: 100%; transition: 1s ease; }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/includes/admin-header.jsp" />

    <div class="dashboard-grid">
        
        <div class="card">
            <h3 style="margin-top:0; color: #111827;">Recent Members</h3>
            <table class="u-table">
                <c:forEach items="${recentUsers}" var="u">
                    <tr>
                        <td>
                            <span class="user-name">${u.fullName}</span>
                            <span class="user-id-badge">User ID: #${u.id}</span>
                        </td>
                        <td style="text-align: right;">
                            <span class="role-tag">${u.role}</span>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty recentUsers}">
                    <tr><td colspan="2" style="text-align:center; color:#9ca3af; padding: 40px;">No new members to show.</td></tr>
                </c:if>
            </table>
        </div>

        <div class="card">
            <h3 style="margin-top:0; color: #111827;">User Breakdown</h3>
            <div class="bar-container">
                <div class="bar-label"><span>Students</span><strong>${studentPercent}%</strong></div>
                <div class="bar-bg"><div class="bar-fill" style="width: ${studentPercent}%; background: #06b6d4;"></div></div>
            </div>
            <div class="bar-container">
                <div class="bar-label"><span>MHPs</span><strong>${mhpPercent}%</strong></div>
                <div class="bar-bg"><div class="bar-fill" style="width: ${mhpPercent}%; background: #3b82f6;"></div></div>
            </div>
            <div class="bar-container">
                <div class="bar-label"><span>Admins</span><strong>${adminPercent}%</strong></div>
                <div class="bar-bg"><div class="bar-fill" style="width: ${adminPercent}%; background: #ec4899;"></div></div>
            </div>
        </div>

    </div>

</body>
</html>