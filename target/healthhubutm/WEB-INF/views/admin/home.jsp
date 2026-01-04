<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    
    <style>
        /* 1. PAGE SETUP (Matches JSP padding and font) */
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f9fafb;
            margin: 0;
        }

        /* 2. GRID LAYOUT (Restored from JSP) */
        .dashboard-grid {
            display: grid;
            grid-template-columns: 1fr 1fr; /* Two equal columns */
            gap: 25px;
        }

        /* 3. CARD STYLING (Restored from JSP) */
        .card {
            background: white;
            border-radius: 14px;
            padding: 25px;
            box-shadow: 0 1px 2px rgba(0,0,0,0.04);
        }

        h2 {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 2px;
            margin-top: 0;
        }

        small {
            font-size: 14px;
            color: #6b7280;
        }

        /* 4. RECENT REGISTRATIONS (Restored "Boxed" Row Style) */
        .user-list {
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .user-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 14px;
            border: 1px solid #e5e7eb; /* The border around each user */
            border-radius: 12px;
            background: white;
        }

        .user-left {
            display: flex;
            flex-direction: column;
            gap: 8px; /* Spacing between Name, Role, Time */
        }

        .role-badge {
            font-size: 12px;
            color: #374151; 
            padding: 3px 10px;
            border-radius: 9999px;      
            border: 1px solid #d1d5db;  
            background-color: transparent; 
            display: inline-block;
            width: fit-content;
        }

        .time {
            font-size: 13px;
            color: #9ca3af;
        }

        /* 5. STATUS BADGES (Restored Cyan Color) */
        .status-badge {
            padding: 5px 14px;
            border-radius: 9999px;
            font-size: 12px;
            font-weight: 500;
            text-transform: lowercase;
        }

        .status-active {
            background: #06b6d4; /* Cyan */
            color: white;
        }

        .status-inactive {
            background: #e5e7eb;
            color: #6b7280;
        }

        /* 6. USER DISTRIBUTION (Restored Colors & Shapes) */
        .distribution-section {
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .dist-item .label-row {
            display: flex;
            justify-content: space-between;
            font-size: 14px;
            margin-bottom: 6px;
        }

        .progress-container {
            width: 100%;
            height: 10px;
            background: #e5e7eb;
            border-radius: 12px;
            overflow: hidden;
        }

        .bar {
            height: 100%;
        }

        .bar-student {
            width: 87%;
            background: #06b6d4; /* Cyan */
        }

        .bar-mhp {
            width: 11%;
            background: #3b82f6; /* Blue */
        }

        .bar-admin {
            width: 2%;
            background: #ec4899; /* Pink */
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/includes/admin-header.jsp" />

    <div class="dashboard-grid">

        <div class="card">
            <h2>Recent Registrations</h2>
            <small>New users in the last 7 days</small>

            <div class="user-list">

                <div class="user-row">
                    <div class="user-left">
                        <strong>Sarah Johnson</strong>
                        <div class="role-badge">student</div>
                        <span class="time">2 hours ago</span>
                    </div>
                    <span class="status-badge status-active">active</span>
                </div>

                <div class="user-row">
                    <div class="user-left">
                        <strong>Dr. Mike Chen</strong>
                        <div class="role-badge">mhp</div>
                        <span class="time">5 hours ago</span>
                    </div>
                    <span class="status-badge status-active">active</span>
                </div>

                <div class="user-row">
                    <div class="user-left">
                        <strong>Alex Thompson</strong>
                        <div class="role-badge">student</div>
                        <span class="time">1 day ago</span>
                    </div>
                    <span class="status-badge status-active">active</span>
                </div>

                <div class="user-row">
                    <div class="user-left">
                        <strong>Emma Wilson</strong>
                        <div class="role-badge">student</div>
                        <span class="time">2 days ago</span>
                    </div>
                    <span class="status-badge status-inactive">inactive</span>
                </div>

            </div>
        </div>

        <div class="card">
            <h2>User Distribution</h2>
            <small>By role and activity</small>

            <div class="distribution-section">

                <div class="dist-item">
                    <div class="label-row">
                        <span>Students</span>
                        <span>1,089 (87%)</span>
                    </div>
                    <div class="progress-container">
                        <div class="bar bar-student"></div>
                    </div>
                </div>

                <div class="dist-item">
                    <div class="label-row">
                        <span>MHPs</span>
                        <span>142 (11%)</span>
                    </div>
                    <div class="progress-container">
                        <div class="bar bar-mhp"></div>
                    </div>
                </div>

                <div class="dist-item">
                    <div class="label-row">
                        <span>Admins</span>
                        <span>16 (2%)</span>
                    </div>
                    <div class="progress-container">
                        <div class="bar bar-admin"></div>
                    </div>
                </div>

            </div>
        </div>

    </div>

</body>
</html>