<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Session Detail - MindWell</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        :root { 
            --teal: #6fd7cc; 
            --teal-dark: #3fb9a8; 
            --teal-light: #e8f9f7; 
            --muted: #7b8794; 
            --card-bg: #ffffff; 
            --page-bg: #f6fbfa; 
            --radius: 12px; 
            --shadow: 0 10px 30px rgba(18,24,33,0.06); 
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); 
        }

        body { 
            font-family: Inter, "Segoe UI", Roboto, sans-serif; 
            background-color: var(--page-bg); 
            color: #123; 
            margin: 0; 
            display: flex; 
            justify-content: center; 
            align-items: center;
            min-height: 100vh;
        }

        .container { 
            width: 90%; 
            max-width: 600px; 
            background: var(--card-bg);
            padding: 32px;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            animation: fadeInUp 0.5s ease-out;
        }

        h1 { font-size: 24px; font-weight: 700; color: #123; margin: 0 0 8px 0; }
        .subtitle { color: var(--muted); font-size: 14px; margin-bottom: 30px; }

        .detail-group { margin-bottom: 20px; }
        .detail-title { font-weight: 700; font-size: 13px; color: var(--muted); text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 8px; }
        
        /* Matching the "inner-box" to the "stat" or "badge" feel */
        .inner-box { 
            background: #fbfffe; 
            border: 1px solid rgba(18,24,33,0.05); 
            border-radius: 10px; 
            padding: 14px; 
            font-size: 15px; 
            color: #123; 
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .inner-box i { color: var(--teal-dark); width: 20px; text-align: center; }

        .btn { 
            padding: 12px 24px; 
            border-radius: 8px; 
            border: none; 
            cursor: pointer; 
            font-size: 14px; 
            font-weight: 600; 
            transition: var(--transition); 
            text-decoration: none; 
            display: inline-flex; 
            align-items: center; 
            justify-content: center;
            gap: 8px;
        }

        .btn-primary { 
            background: linear-gradient(180deg, var(--teal), var(--teal-dark)); 
            color: #fff; 
            box-shadow: 0 4px 12px rgba(63,185,168,0.3); 
        }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(63,185,168,0.4); }

        .btn-ghost { 
            background: #fff; 
            border: 1px solid rgba(18,24,33,0.06); 
            color: #27433f; 
        }
        .btn-ghost:hover { background: var(--teal-light); border-color: var(--teal); }

        .status-pill {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
        }
        .status-confirmed { background: var(--teal-light); color: var(--teal-dark); }
        .status-pending { background: #fff3cd; color: #856404; }

        @keyframes fadeInUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>

<div class="container">
    <h1>Session Details</h1>
    <div class="subtitle">Information for your upcoming wellness appointment</div>

    <div class="detail-group">
        <div class="detail-title">Student</div>
        <div class="inner-box">
            <i class="fas fa-user-graduate"></i>
            <span>${not empty sessionObj.student.fullName ? sessionObj.student.fullName : sessionObj.student.username}</span>
        </div>
    </div>

    <div class="detail-group">
        <div class="detail-title">Counselor</div>
        <div class="inner-box">
            <i class="fas fa-user-md"></i>
            <span>${sessionObj.mhp.fullName}</span>
        </div>
    </div>

    <div class="detail-group">
        <div class="detail-title">Date & Time</div>
        <div class="inner-box">
            <i class="fas fa-calendar-check"></i>
            <span>${sessionObj.sessionDate} at ${sessionObj.time}</span>
        </div>
    </div>

    <div class="detail-group">
        <div class="detail-title">Status</div>
        <div class="inner-box">
            <c:choose>
                <c:when test="${sessionObj.confirmed}">
                    <span class="status-pill status-confirmed"><i class="fas fa-check-circle"></i> Confirmed</span>
                </c:when>
                <c:otherwise>
                    <span class="status-pill status-pending"><i class="fas fa-hourglass-half"></i> Pending Review</span>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <c:if test="${userRole == 'MENTAL_HEALTH_PROFESSIONAL'}">
        <hr style="border: 0; border-top: 1px solid rgba(18,24,33,0.06); margin: 25px 0;">
        
        <div class="detail-group">
            <div class="detail-title">Preliminary Focus</div>
            <div class="inner-box">
                <i class="fas fa-bullseye"></i>
                <span>${not empty sessionObj.preFocus ? sessionObj.preFocus : 'Not specified'}</span>
            </div>
        </div>

        <div class="detail-group">
            <div class="detail-title">Notes to Counselor</div>
            <div class="inner-box">
                <i class="fas fa-comment-medical"></i>
                <span>${not empty sessionObj.notes ? sessionObj.notes : 'No additional notes provided.'}</span>
            </div>
        </div>
    </c:if>

    <div style="margin-top: 32px; display: flex; gap: 12px; justify-content: flex-end;">
        
        <c:choose>
            <c:when test="${userRole == 'MENTAL_HEALTH_PROFESSIONAL'}">
                <a href="${pageContext.request.contextPath}/sessions/confirm" class="btn btn-ghost">Back</a>
                <c:if test="${!sessionObj.confirmed}">
                    <form action="${pageContext.request.contextPath}/sessions/confirm" method="POST" style="margin:0;">
                        <input type="hidden" name="sessionId" value="${sessionObj.id}">
                        <button type="submit" class="btn btn-primary">Approve Session</button>
                    </form>
                </c:if>
            </c:when>

            <c:otherwise>
                <a href="${pageContext.request.contextPath}/student/home" class="btn btn-ghost">Back to Home</a>
                <c:if test="${sessionObj.confirmed}">
                    <a href="${pageContext.request.contextPath}/sessions/meeting?sessionId=${sessionObj.id}" class="btn btn-primary">
                        <i class="fas fa-video"></i> Join Now
                    </a>
                </c:if>
            </c:otherwise>
        </c:choose>
    </div>
</div>

</body>
</html>