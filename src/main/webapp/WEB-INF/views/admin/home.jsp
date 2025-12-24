<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f9fafb;
            margin: 0;
            padding: 30px;
            color: #111827;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
        }

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
        }

        small {
            font-size: 14px;
            color: #6b7280;
        }

        /* Recent Registration User List */
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
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            background: white;
        }

        
        .user-left {
            display: flex;
            flex-direction: column;
            gap: 8px; /* more space between name, role, time */
        }

        .role-badge {
            font-size: 12px;
            color: #374151; /* dark gray text */
            padding: 3px 10px;
            border-radius: 9999px;      /* pill shape */
            border: 1px solid #d1d5db;  /* light gray outline */
            background-color: transparent; /* no fill */
            display: inline-block;
            width: fit-content;
        }

        .time {
            font-size: 13px;
            color: #9ca3af;
        }


        .status-badge {
            padding: 5px 14px;
            border-radius: 9999px;
            font-size: 12px;
            font-weight: 500;
            text-transform: lowercase;
        }

        .status-active {
            background: #06b6d4;
            color: white;
        }

        .status-inactive {
            background: #e5e7eb;
            color: #6b7280;
        }

        /* Progress Bars */
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
            background: #06b6d4;
        }

        .bar-mhp {
            width: 11%;
            background: #3b82f6;
        }

        .bar-admin {
            width: 2%;
            background: #ec4899;
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/includes/admin-header.jsp" />

    <div class="dashboard-grid">

        <!-- Recent Registrations -->
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

        <!-- User Distribution -->
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
