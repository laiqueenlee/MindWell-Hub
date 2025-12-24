<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Content Management - HealthHub MHP</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* [Keeping CSS exactly the same] */
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background-color: #ffffff; color: #333; padding: 40px; }
        .main-layout { display: flex; gap: 40px; max-width: 1400px; margin: 0 auto; }
        .content-column { flex: 3; }
        .sidebar-column { flex: 1; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .page-header h1 { font-size: 1.8rem; color: #2c3e50; margin-bottom: 5px; }
        .page-header p { color: #95a5a6; font-size: 0.9rem; }
        .btn-new { background-color: #00d2d3; color: white; padding: 10px 20px; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; display: flex; align-items: center; gap: 8px; font-size: 0.9rem; }
        .tabs { display: flex; gap: 10px; margin-bottom: 20px; border-bottom: 1px solid #eee; padding-bottom: 10px; }
        .tab-btn { background: none; border: none; padding: 8px 15px; font-weight: 600; color: #95a5a6; cursor: pointer; border-radius: 20px; }
        .tab-btn.active { background-color: #f1f2f6; color: #2c3e50; }
        .content-item { border: 1px solid #eee; border-radius: 10px; padding: 20px; margin-bottom: 15px; display: flex; justify-content: space-between; align-items: center; background-color: #fff; box-shadow: 0 2px 5px rgba(0,0,0,0.02); }
        .content-info h3 { font-size: 1.1rem; color: #2c3e50; margin-bottom: 8px; display: flex; align-items: center; gap: 10px; }
        .content-meta { color: #95a5a6; font-size: 0.85rem; }
        .badge { font-size: 0.75rem; padding: 3px 10px; border-radius: 12px; font-weight: 600; }
        .badge-published { background-color: #00d2d3; color: white; }
        .badge-draft { background-color: #ecf0f1; color: #7f8c8d; }
        .badge-type { background-color: #f8f9fa; border: 1px solid #eee; color: #7f8c8d; }
        .actions { display: flex; gap: 15px; color: #95a5a6; }
        .actions i { cursor: pointer; transition: color 0.2s; }
        .actions i:hover { color: #2c3e50; }
        .actions .fa-trash:hover { color: #e74c3c; }
        .schedule-section { margin-top: 40px; }
        .section-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .section-header h2 { font-size: 1.5rem; color: #2c3e50; }
        .btn-manage { background-color: #00d2d3; color: white; border: none; padding: 8px 15px; border-radius: 5px; cursor: pointer; font-size: 0.9rem; }
        .stats-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }
        .stat-card { border: 1px solid #e0e0e0; border-radius: 10px; padding: 20px; background: #fff; }
        .stat-card small { color: #95a5a6; font-size: 0.85rem; display: block; margin-bottom: 5px; }
        .stat-card strong { font-size: 1.8rem; color: #00d2d3; }
/* --- Updated AI Card Styling --- */
        .ai-link-wrapper {
            text-decoration: none; /* Remove underline from link */
            display: block; /* Make link fill the width */
        }

        .ai-card {
            border: 1px solid #eee;
            border-radius: 12px;
            padding: 24px;
            background-color: #fff;
            transition: all 0.3s ease;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* Hover Effect: Pop up slightly and change border color */
        .ai-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 210, 211, 0.15); /* Soft teal shadow */
            border-color: #00d2d3;
        }

        .ai-content {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .ai-title {
            font-size: 1.3rem;
            color: #2c3e50;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .ai-subtitle {
            font-size: 0.95rem;
            color: #95a5a6;
        }

        .ai-action-icon {
            font-size: 1.2rem;
            color: #e0e0e0;
            transition: 0.3s;
        }

        /* On hover, turn the arrow teal and move it right */
        .ai-card:hover .ai-action-icon {
            color: #00d2d3;
            transform: translateX(5px);
        }
        
        /* New Link Styling for Actions */
        .actions a { color: inherit; text-decoration: none; }
        
        /* Header Logout Link specific to MHP Dashboard to match page style */
        .logout-link {
            float: right;
            font-size: 0.9rem;
            color: #e74c3c;
            text-decoration: none;
            margin-top: -10px;
        }
    </style>
</head>
<body>

    <!-- Small Logout Link added for functionality -->
    <a href="${pageContext.request.contextPath}/auth/logout" class="logout-link">
        <i class="fas fa-sign-out-alt"></i> Logout
    </a>

    <div class="main-layout">
        <div class="content-column">
            
            <div class="page-header">
                <div>
                    <h1>Content Management</h1>
                    <p>Welcome back, ${user.fullName}. Create and manage educational content.</p>
                </div>
                <!-- <button class="btn-new" onclick="window.location.href='${pageContext.request.contextPath}/mhp/create-content'">
                    <i class="fas fa-plus"></i> New Content
                </button> -->
            </div>

            <div class="tabs">
                <button class="tab-btn active">My Content</button>
                <button class="tab-btn" onclick="window.location.href='${pageContext.request.contextPath}/mhp/create-content'">Create New</button>
                <button class="tab-btn">Analytics</button>
            </div>

            <!-- DYNAMIC CONTENT LIST -->
            <c:forEach var="item" items="${contentList}">
                <div class="content-item">
                    <div class="content-info">
                        <h3>
                            ${item.title} 
                            <span class="badge ${item.statusClass}">${item.status}</span>
                            <span class="badge badge-type">${item.type}</span>
                        </h3>
                        <div class="content-meta">
                            ${item.category} &nbsp; • &nbsp; Created ${item.date}
                        </div>
                    </div>
                    <div class="actions">
                        <!-- EDIT BUTTON -->
                        <a href="${pageContext.request.contextPath}/mhp/edit-content?id=${item.id}" title="Edit Content">
                            <i class="fas fa-pen"></i>
                        </a>
                        <!-- DELETE BUTTON -->
                        <a href="${pageContext.request.contextPath}/mhp/delete-content?id=${item.id}" 
                           onclick="return confirm('Are you sure you want to delete this content?');" 
                           title="Delete Content">
                            <i class="fas fa-trash"></i>
                        </a>
                    </div>
                </div>
            </c:forEach>

            <div class="schedule-section">
                <div class="section-header">
                    <h2>Schedule Sessions</h2>
                    <button class="btn-manage" onclick="window.location.href='${pageContext.request.contextPath}/sessions/confirm'">
                        Manage Upcoming Session
                    </button>
                </div>
                <div class="stats-grid">
                    <div class="stat-card"><small>Today's Sessions</small><strong>4</strong></div>
                    <div class="stat-card"><small>This Week</small><strong>12</strong></div>
                    <div class="stat-card"><small>Total Students</small><strong>34</strong></div>
                </div>
            </div>
        </div>

        <div class="sidebar-column">
            <a href="${pageContext.request.contextPath}/mhp/chatbot" class="ai-link-wrapper">
                <div class="ai-card">
                    <div class="ai-content">
                        <div class="ai-title">
                            Ask AI <i class="fas fa-robot" style="color:#00d2d3;"></i>
                        </div>
                        
                        <div class="ai-subtitle">
                            Ask me anything!
                        </div>
                    </div>
                    
                    <div class="ai-action-icon">
                        <i class="fas fa-arrow-right"></i>
                    </div>
                </div>
            </a>
        </div>
    </div>
</body>
</html>