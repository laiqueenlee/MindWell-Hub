<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book Counselling Session | MindWell</title>

    <style>
        body {
            font-family: "Inter", Arial, sans-serif;
            background-color: #f6fdfb;
            color: #1a1a1a;
            margin: 0; 
        }

        .navbar-placeholder {
            height: 70px; 
        }

        .container {
            margin: 40px auto;
            width: 60%; 
            max-width: 800px;
        }

        h1 {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 10px;
            text-align: center;
        }

        .subtitle {
            color: #6b7280;
            text-align: center;
            margin-bottom: 30px;
        }

        .card {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0px 10px 25px rgba(0,0,0,0.05);
        }

        label {
            display: block;
            font-weight: 600;
            font-size: 14px;
            margin-bottom: 8px;
            color: #374151;
        }

        input, select, textarea {
            width: 100%;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            padding: 12px;
            font-size: 14px;
            box-sizing: border-box; 
            margin-bottom: 20px;
            font-family: inherit;
        }

        input[readonly] {
            background-color: #f3f4f6;
            color: #6b7280;
            cursor: not-allowed;
            border: 1px solid #e5e7eb;
        }

        textarea {
            resize: vertical;
        }

        .button-group {
            display: flex;
            justify-content: flex-start;
            gap: 15px;
            margin-top: 10px;
        }

        .submit-btn {
            background-color: #2dd4bf;
            color: white;
            padding: 14px 28px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            font-size: 15px;
            transition: background 0.2s;
        }

        .submit-btn:hover:not(:disabled) {
            background-color: #1fb3a3;
        }

        .submit-btn:disabled {
            background-color: #9ca3af;
            cursor: not-allowed;
        }

        .back-btn {
            background-color: #f3f4f6;
            color: #4b5563;
            padding: 14px 28px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            font-size: 15px;
            text-decoration: none;
            display: inline-block;
            transition: background 0.2s;
        }

        .back-btn:hover {
            background-color: #e5e7eb;
        }

        .flex-row {
            display: flex;
            gap: 20px;
        }

        .flex-item {
            flex: 1;
        }

        h2 {
            margin-top: 0;
            font-size: 24px;
            color: #111827;
        }
        
        .info-msg {
            font-size: 12px;
            color: #0d9488;
            margin-top: -15px;
            margin-bottom: 15px;
            display: block;
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/includes/navbar.jsp" />

<div class="navbar-placeholder"></div>

<div class="container">

    <c:if test="${param.success == 'true'}">
        <div style="background-color: #d1fae5; color: #065f46; padding: 15px; border-radius: 8px; margin-bottom: 20px; text-align: center; border: 1px solid #6ee7b7;">
            <strong>Success!</strong> Your session has been booked and is awaiting counselor confirmation.
        </div>
    </c:if>
    
    <h1>Book Counselling Session</h1>
    <p class="subtitle">Select your preferred date and time to secure your session with the counselor.</p>

    <div class="card">
        <h2>Session Details</h2>
        <p style="margin-bottom: 25px;">You are requesting a session with Dr. ${mhp.fullName}.</p>

        <form id="bookingForm" method="post" action="${pageContext.request.contextPath}/sessions/book/save">
            
            <input type="hidden" name="mhpId" value="${mhp.id}">

            <label>Counselor</label>
            <input type="text" value="Dr. ${mhp.fullName}" readonly>

            <div class="flex-row">
                <div class="flex-item">
                    <label>Step 1: Choose Date</label>
                    <input type="date" name="selectedDate" id="selectedDate" 
                           value="${selectedDate}" 
                           min="${minDate}" 
                           max="${maxDate}" 
                           onchange="refreshTimeSlots()" required>
                    <span class="info-msg">Available up to 2 months in advance.</span>
                </div>

                <div class="flex-item">
                    <label>Step 2: Available Time Slot</label>
                    <select name="time" id="timeSlot" required ${empty availableSlots ? 'disabled' : ''}>
                        <c:choose>
                            <c:when test="${empty selectedDate}">
                                <option value="" disabled selected>Select a date first...</option>
                            </c:when>
                            <c:when test="${empty availableSlots}">
                                <option value="" disabled selected>No slots available for this day</option>
                            </c:when>
                            <c:otherwise>
                                <option value="" disabled selected>Choose a time...</option>
                                <c:forEach var="slot" items="${availableSlots}">
                                    <option value="${slot}">${slot}</option>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </select>
                </div>
            </div>

            <label>Notes to Counselor</label>
            <textarea name="notes" rows="3" placeholder="Enter anything you wish for your counselor to know..."></textarea>

            <label>Preliminary Focus</label>
            <textarea name="preFocus" rows="5" placeholder="Briefly explain the primary issue..." required></textarea>

            <div class="button-group">
                <a href="${pageContext.request.contextPath}/sessions/book" class="back-btn">Cancel</a>
                <button class="submit-btn" type="submit" id="confirmBtn" ${empty availableSlots ? 'disabled' : ''}>
                    Confirm Booking Now
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    function refreshTimeSlots() {
        const form = document.getElementById('bookingForm');
        // Temporarily change action to return to the booking page to filter slots
        form.action = '${pageContext.request.contextPath}/sessions/book';
        form.submit();
    }
</script>

</body>
</html>