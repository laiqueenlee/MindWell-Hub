<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Manage My Time Slots</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
        body { margin:0; font-family: "Segoe UI", Roboto, Arial, sans-serif; color:#222; background-color: #f7fbfc; }
        
        /* Matching the Homepage Hero */
        .mhp-header {
            display:flex;
            align-items:center;
            justify-content:center;
            flex-direction:column;
            height:30vh;
            background: linear-gradient(135deg, #79e5c6 0%, #9fe8d9 50%, #d6f7ee 100%);
            text-align:center;
            padding:20px;
            color: #fff;
        }
        .mhp-header h1 { margin:0; font-size:36px; font-weight:700; }
        .mhp-header p { margin:10px 0 0; opacity: 0.9; font-size:18px; }

        .container { max-width: 900px; margin: -40px auto 40px; padding: 0 20px; }

        /* Content Card */
        .card {
            background: #fff;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
        }

        .form-section {
            display: flex;
            gap: 15px;
            background: #f0faf7;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 30px;
            align-items: center;
            flex-wrap: wrap;
        }

        .form-section h3 { width: 100%; margin: 0 0 10px 0; color: #17a88b; font-size: 18px; }

        select, input {
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #d6e8e3;
            flex: 1;
            min-width: 150px;
            font-size: 15px;
        }

        .btn-add {
            background: #17a88b;
            color: #fff;
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s;
        }
        .btn-add:hover { background: #138d74; }

        /* Table Styling */
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th { text-align: left; padding: 15px; color: #666; font-weight: 600; border-bottom: 2px solid #eee; }
        td { padding: 15px; border-bottom: 1px solid #eee; }

        .day-badge {
            background: #e6f7f3;
            color: #17a88b;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
        }

        .btn-delete {
            background: transparent;
            color: #ff5c5c;
            border: 1px solid #ff5c5c;
            padding: 6px 15px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.2s;
        }
        .btn-delete:hover { background: #ff5c5c; color: #fff; }

        .empty-msg { text-align: center; color: #999; padding: 40px; }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/includes/mhp-navbar.jsp" %>

    <header class="mhp-header">
        <h1>Work Routine</h1>
        <p>Manage the time slots available for student bookings</p>
    </header>

    <div class="container">
        <div class="card">
            
            <form class="form-section" action="${pageContext.request.contextPath}/mhp/availability/add" method="post">
                <h3>Set New Availability</h3>
                <select name="day" required>
                    <option value="" disabled selected>Select Day</option>
                    <option value="Monday">Monday</option>
                    <option value="Tuesday">Tuesday</option>
                    <option value="Wednesday">Wednesday</option>
                    <option value="Thursday">Thursday</option>
                    <option value="Friday">Friday</option>
                    <option value="Saturday">Saturday</option>
                    <option value="Sunday">Sunday</option>
                </select>
                
                <div style="display: flex; gap: 10px; flex: 2;">
                    <select name="startTime" required>
                        <option value="" disabled selected>Start Time</option>
                        <c:forEach var="hour" items="${['08:00', '09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00']}">
                            <option value="${hour}">${hour}</option>
                        </c:forEach>
                    </select>
                    
                    <span style="align-self: center;">to</span>

                    <select name="endTime" required>
                        <option value="" disabled selected>End Time</option>
                        <c:forEach var="hour" items="${['09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00']}">
                            <option value="${hour}">${hour}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <button type="submit" class="btn-add">Add to Routine</button>
            </form>

            <table>
                <thead>
                    <tr>
                        <th>Available Day</th>
                        <th>Time Window</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="slot" items="${slots}">
                        <tr>
                            <td><span class="day-badge">${slot.dayOfWeek}</span></td>
                            <td>${slot.timeSlot}</td>
                            <td>
                                <form action="${pageContext.request.contextPath}/mhp/availability/delete" method="post" style="display:inline;">
                                    <input type="hidden" name="slotId" value="${slot.id}">
                                    <button type="submit" class="btn-delete" onclick="return confirm('Remove this slot?')">Remove</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <c:if test="${empty slots}">
                <div class="empty-msg">
                    <p>No routine slots found. Add your first availability above to start receiving bookings.</p>
                </div>
            </c:if>

        </div>
    </div>
</body>
</html>