<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Session Detail</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        body {
            font-family: system-ui, sans-serif;
            background-color: #ffffff;
            color: #111827;
            margin: 40px;
            display: flex;
            justify-content: center;
        }

        .container {
            width: 70%;
            max-width: 900px;
        }

        h1 {
            font-size: 30px;
            font-weight: 600;
            margin-bottom: 6px;
        }

        p {
            color: #6b7280;
            font-size: 15px;
            margin-bottom: 22px;
        }

        .outer-block {
            border: 1px solid #e5e7eb;
            border-radius: 14px;
            padding: 26px;
            margin-top: 10px;
        }

        .detail-title {
            font-weight: 600;
            font-size: 15px;
            margin-bottom: 6px;
        }

        .inner-box {
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            padding: 12px 14px;
            background-color: #fafafa;
            font-size: 15px;
            color: #374151;
            margin-bottom: 20px;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 9999px;  /* pill shape */
            border: none;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.2s ease-in-out;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        .btn-approve {
            background-color: #34d399;
            color: white;
        }
        .btn-approve:hover {
            background-color: #2ebf8f;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .btn-reject {
            background-color: #f87171;
            color: white;
        }
        .btn-reject:hover {
            background-color: #f65a5a;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .btn-back {
            background-color: #d1d5db;
            color: #111827;
        }
        .btn-back:hover {
            background-color: #b8bbbf;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
    </style>
</head>
<body>

<c:if test="${role == 'STUDENT'}">
    <jsp:include page="/WEB-INF/views/includes/navbar.jsp" />
</c:if>

<div class="container">

    <h1>Session Details</h1>
    <p>Details of the scheduled session</p>

    <div class="outer-block">

        <div>
            <div class="detail-title">Student Name</div>
            <div class="inner-box">John Smith</div>
        </div>

        <div>
            <div class="detail-title">Mental Health Professional</div>
            <div class="inner-box">Dr. Alice Wong</div>
        </div>

        <div>
            <div class="detail-title">Session Type</div>
            <div class="inner-box">Initial Consultation</div>
        </div>

        <div>
            <div class="detail-title">Date & Time</div>
            <div class="inner-box">12 Dec 2025, 10:00 AM</div>
        </div>

        <div>
            <div class="detail-title">Duration</div>
            <div class="inner-box">60 minutes</div>
        </div>

        <div>
            <div class="detail-title">Status</div>
            <div class="inner-box">Pending</div>
        </div>

        <div>
            <div class="detail-title">Notes</div>
            <div class="inner-box">
                Student has reported anxiety issues. Plan to cover coping strategies and initial assessment.
            </div>
        </div>

        <!-- MHP side with buttons -->
        <!-- <div style="margin-top:20px; display:flex; justify-content:space-between;">
            <c:if test="${roles == 'COUNSELOR'}">
            <a href="${pageContext.request.contextPath}/sessions/confirm" class="btn btn-back">
                <i class="fas fa-arrow-left"></i> Back to Sessions
            </a>

            <div>
                <button class="btn btn-approve"><i class="fas fa-check"></i> Approve</button>
                <button class="btn btn-reject"><i class="fas fa-times"></i> Reject</button>
            </div>
            </c:if>

        </div> -->

        <!--Student side with back to home button-->
        <div style="margin-top:20px; display:flex; justify-content:space-between;">
            <a href="${pageContext.request.contextPath}/student/home" class="btn btn-back">
                <i class="fas fa-arrow-left"></i> Back to Home
            </a>

        </div>

    </div>

</div>

</body>
</html>
