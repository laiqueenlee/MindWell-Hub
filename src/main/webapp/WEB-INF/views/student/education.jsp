<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Educational Modules - HealthHub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root { --teal: #00c4cc; --teal-dark: #00b8b9; --bg-light: #f6fbfa; }
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Segoe UI', sans-serif; }
        body { background-color: var(--bg-light); color: #333; }
        .container { max-width: 1100px; margin: 0 auto; padding: 40px 20px; }
        .header { text-align: center; margin-bottom: 50px; }
        .header h1 { font-size: 2.5rem; color: #2c3e50; margin-bottom: 10px; font-weight: 700; }
        .header p { color: #7f8c8d; font-size: 1.1rem; }
        .modules-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(350px, 1fr)); gap: 30px; }
        .module-card { background: #fff; border-radius: 12px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.03); transition: all 0.3s ease; display: flex; flex-direction: column; justify-content: space-between; height: 100%; position: relative; }
        .module-card:hover { transform: translateY(-5px); box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        .card-top { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 20px; }
        .icon-box { width: 50px; height: 50px; background-color: #e8f9f7; border-radius: 10px; display: flex; align-items: center; justify-content: center; }
        .icon-box i { font-size: 24px; color: var(--teal); }
        .duration-badge { background-color: #fff; border: 1px solid #eee; padding: 5px 12px; border-radius: 20px; font-size: 0.85rem; font-weight: 600; color: #555; }
        .card-content h3 { font-size: 1.25rem; color: #2c3e50; margin-bottom: 10px; font-weight: 700; }
        .card-content p { color: #7f8c8d; font-size: 0.95rem; line-height: 1.5; margin-bottom: 25px; flex-grow: 1; }
        .start-btn { width: 100%; padding: 12px; background-color: var(--teal); color: white; border: none; border-radius: 8px; font-size: 0.95rem; font-weight: 600; cursor: pointer; text-decoration: none; text-align: center; display: block; transition: background-color 0.2s; }
        .start-btn:hover { background-color: var(--teal-dark); }
        .btn-ghost { background: transparent; border: 1px solid #ccc; color: #555; margin-bottom: 20px; display:inline-block; padding: 8px 16px; border-radius: 6px; text-decoration: none; font-size: 0.9rem;}

        /* Type Badge Styles */
        .type-badge {
            display: inline-block;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            padding: 4px 10px;
            border-radius: 6px;
            margin-bottom: 10px;
            letter-spacing: 0.5px;
        }
        .type-Article { background-color: #e0f2fe; color: #0284c7; }
        .type-Video { background-color: #fce7f3; color: #db2777; }
        .type-Interactive { background-color: #dcfce7; color: #16a34a; }
        .type-default { background-color: #f3f4f6; color: #4b5563; }

        /* Add these styles for the mini progress bar */
        .progress-mini-wrapper { margin-bottom: 15px; }
        .progress-header { display: flex; justify-content: space-between; font-size: 0.8rem; color: #95a5a6; margin-bottom: 5px; font-weight: 600; }
        .progress-track-mini { width: 100%; height: 6px; background-color: #f1f2f6; border-radius: 3px; overflow: hidden; }
        .progress-fill-mini { height: 100%; background-color: var(--teal); border-radius: 3px; transition: width 0.3s ease; }
    </style>
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/student/home" class="btn-ghost">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
        
        <div class="header">
            <h1>Learning Modules</h1>
            <p>Self-paced resources to support your mental well-being.</p>
        </div>

        <c:if test="${empty modules}">
            <div style="text-align:center; padding: 20px; color:#777;">
                <p>No learning modules are currently available.</p>
            </div>
        </c:if>

        <c:if test="${not empty modules}">
            <div class="modules-grid">
                <c:forEach var="module" items="${modules}">
                    <div class="module-card">
                        <div class="card-top">
                            <div class="icon-box">
                                <c:choose>
                                    <c:when test="${module.type == 'Article'}">
                                        <i class="fas fa-book-open"></i>
                                    </c:when>
                                    <c:when test="${module.type == 'Video'}">
                                        <i class="fas fa-video"></i>
                                    </c:when>
                                    <c:when test="${module.type == 'Interactive'}">
                                        <i class="fas fa-hand-pointer"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-shapes"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                            <div style="display: flex; gap: 8px; align-items: flex-start;">
                                <span class="duration-badge" style="background-color: #dcfce7; color: #166534; border-color: #bbf7d0;">
                                    <i class="fas fa-chart-line"></i> 
                                    <span>${progressMap[module.id] != null ? progressMap[module.id] : 0}%</span>
                                </span>

                                <c:if test="${module.type != 'Article' && module.type != 'Interactive'}">
                                    <span class="duration-badge">
                                        <i class="far fa-clock"></i> <span>${module.duration} min</span>
                                    </span>
                                </c:if>
                            </div>
                        </div>
                        
                        <div class="card-content">
                            <span class="type-badge type-${module.type}">${module.type}</span>
                            <h3>${module.title}</h3>
                            <p>${module.description}</p>
                        </div>
                        
                        <a href="${pageContext.request.contextPath}/content/view/${module.id}" class="start-btn">Start Module</a>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </div>
</body>
</html>