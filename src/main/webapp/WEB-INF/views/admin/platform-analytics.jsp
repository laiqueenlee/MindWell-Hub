<!-- remove from final demo and menu -->

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
            padding: 20px 40px;
            color: #111827;
        }

        h1 {
            font-size: 28px;
            margin-bottom: 5px;
        }

        h2 {
            font-size: 18px;
            margin-bottom: 5px;
            font-weight: 600;
        }

        small {
            color: #6b7280;
        }

        /* Top Summary Cards */
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
        }

        .summary-card .info {
            display: flex;
            flex-direction: column;
        }

        .summary-card .info .number {
            font-size: 24px;
            font-weight: 700;
        }

        .summary-card .percent {
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
        }

        /* Tabs */
        .tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        .tab {
            padding: 8px 16px;
            border-radius: 12px;
            background-color: #f3f4f6;
            color: #6b7280;
            font-weight: 500;
            cursor: pointer;
        }

        .tab.active {
            background-color: #ffffff;
            color: #111827;
            border: 1px solid #e5e7eb;
        }

        /* Dashboard Content Layout */
        .dashboard-content {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }

        /* Dashboard Cards */
        .card {
            background-color: #ffffff;
            border-radius: 12px;
            padding: 20px;
            flex: 1;
            min-width: 300px;
            display: flex;
            flex-direction: column;
        }

        /* Metric Layout */
        .metric-block {
            margin-top: 25px;
            display: flex;
            flex-direction: column;
            gap: 22px;
        }

        .metric-item strong {
            font-size: 15px;
            color: #111827;
        }

        .metric-value {
            margin-top: 4px;
            font-size: 15px;
        }

        .metric-positive {
            color: #10b981;
            font-weight: 600;
        }

        /* --- Existing User List / Distribution (kept for compatibility, not used now) --- */

        .user-list,
        .distribution-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
            margin-top: 15px;
        }

        .user-entry {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 15px;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            width: 100%;
        }

        .user-info {
            display: flex;
            flex-direction: column;
        }

        .user-info span {
            font-size: 12px;
            color: #6b7280;
            margin-top: 3px;
        }

        .badge {
            padding: 4px 12px;
            border-radius: 9999px;
            font-size: 12px;
            font-weight: 500;
            color: #ffffff;
            text-transform: capitalize;
        }

        .badge.active {
            background-color: #14b8a6;
        }

        .badge.inactive {
            background-color: #d1d5db;
            color: #6b7280;
        }

        /* Distribution bars */
        .distribution-item {
            width: 100%;
        }

        .distribution-item .label {
            display: flex;
            justify-content: space-between;
            margin-bottom: 5px;
            font-size: 14px;
        }

        .progress-bar-container {
            background-color: #e5e7eb;
            border-radius: 8px;
            height: 10px;
            overflow: hidden;
        }

        .progress-bar {
            height: 100%;
            border-radius: 8px;
        }

        .progress-student {
            width: 87%;
            background-color: #14b8a6;
        }

        .progress-mhp {
            width: 11%;
            background-color: #3b82f6;
        }

        .progress-admin {
            width: 2%;
            background-color: #ec4899;
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/includes/admin-header.jsp" />

    <!-- Dashboard Content -->
    <div class="dashboard-content">

        <!-- Platform Growth -->
        <div class="card">
            <h2>Platform Growth</h2>
            <small>User acquisition trends</small>

            <div class="metric-block">

                <div class="metric-item">
                    <strong>This Month</strong>
                    <div class="metric-value metric-positive">
                        +156 users ↑
                    </div>
                </div>

                <div class="metric-item">
                    <strong>Last Month</strong>
                    <div class="metric-value">
                        +124 users
                    </div>
                </div>

                <div class="metric-item">
                    <strong>Growth Rate</strong>
                    <div class="metric-value metric-positive">
                        +25.8%
                    </div>
                </div>

            </div>
        </div>

        <!-- Engagement Metrics -->
        <div class="card">
            <h2>Engagement Metrics</h2>
            <small>User activity overview</small>

            <div class="metric-block">

                <div class="metric-item">
                    <strong>Avg. Session Duration</strong>
                    <div class="metric-value">
                        18 min
                    </div>
                </div>

                <div class="metric-item">
                    <strong>Daily Active Users</strong>
                    <div class="metric-value">
                        432
                    </div>
                </div>

                <div class="metric-item">
                    <strong>Completion Rate</strong>
                    <div class="metric-value">
                        72%
                    </div>
                </div>

            </div>
        </div>

    </div>

</body>
</html>
