<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <title>Virtual Session | MindWell</title>
    <style>
        body { margin: 0; padding: 0; font-family: "Inter", Arial, sans-serif; background: #f7f9fc; color: #333; }
        .header { display: flex; align-items: center; padding: 15px 25px; background: #ffffff; font-size: 18px; font-weight: 500; border-bottom: 1px solid #e5e7eb; }
        .container { display: flex; padding: 25px; gap: 25px; }
        .video-area { flex: 1; background: white; border-radius: 12px; padding: 25px; box-shadow: 0 1px 3px rgba(0,0,0,0.08); position: relative; display: flex; justify-content: center; align-items: center; min-height: 450px; }
        .session-timer { position: absolute; top: 15px; left: 15px; background: #ffffff; padding: 5px 12px; border-radius: 6px; font-size: 12px; border: 1px solid #e5e7eb; }
        .counselor-box { text-align: center; color: #777; }
        .counselor-icon { width: 70px; height: 70px; background: #3bb8c8; border-radius: 50%; display: flex; justify-content: center; align-items: center; margin: auto; color: white; font-size: 24px; }
        .counselor-name { margin-top: 12px; font-size: 15px; color: #333; font-weight: 500; }
        .user-box { position: absolute; bottom: 20px; right: 20px; background: #ffffff; border: 1px solid #e5e7eb; border-radius: 10px; padding: 10px 18px; font-size: 13px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        .controls { margin-top: 20px; display: flex; justify-content: center; gap: 18px; padding-bottom: 30px; }
        .control-btn { width: 45px; height: 45px; background: #e5e7eb; border-radius: 50%; display: flex; justify-content: center; align-items: center; cursor: pointer; transition: 0.2s; }
        .control-btn:hover { background: #d1d5db; }
        .control-btn.end { background: #e74c3c; color: white; }
        .control-btn.end:hover { background: #c0392b; }
        .session-details { width: 280px; background: white; border-radius: 12px; padding: 20px; box-shadow: 0 1px 3px rgba(0,0,0,0.08); height: fit-content; }
        .session-details-title { font-size: 17px; font-weight: 600; margin-bottom: 15px; color: #111; }
        .details-label { font-size: 12px; color: #888; margin-top: 12px; text-transform: uppercase; letter-spacing: 0.5px; }
        .details-value { font-size: 14px; color: #333; margin-bottom: 5px; font-weight: 500; }
    </style>
</head>
<body>

<div class="header">
    <i class="fa-solid fa-video" style="color: #3bb8c8;"></i>&nbsp;&nbsp;Virtual Session
</div>

<div class="container">

    <div class="video-area">
        <div class="session-timer">
            <i class="fa-regular fa-clock"></i> Session: 00:12:34
        </div>
        
        <c:choose>
            <%-- IF LOGGED IN USER IS STUDENT: Show MHP in big screen --%>
            <c:when test="${userRole == 'STUDENT'}">
                <div class="counselor-box">
                    <div class="counselor-icon"><i class="fa-solid fa-user-doctor"></i></div>
                    <div class="counselor-name">Dr. ${sessionObj.mhp.fullName}</div>
                    <div style="font-size: 12px; color: #999; margin-top: 5px;">Waiting for Counselor...</div>
                </div>

                <div class="user-box">
                    <div style="font-weight: 600;">You</div>
                    <div style="font-size: 12px; color: #999;">(Student)</div>
                </div>
            </c:when>

            <%-- IF LOGGED IN USER IS MHP: Show Student in big screen --%>
            <c:otherwise>
                <div class="counselor-box">
                    <div class="counselor-icon" style="background: #f39c12;"><i class="fa-solid fa-user-graduate"></i></div>
                    <div class="counselor-name">${sessionObj.student.fullName}</div>
                    <div style="font-size: 12px; color: #999; margin-top: 5px;">Waiting for Student...</div>
                </div>

                <div class="user-box">
                    <div style="font-weight: 600;">You</div>
                    <div style="font-size: 12px; color: #999;">(Counselor)</div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <%-- Side Panel with dynamic data --%>
    <div class="session-details">
        <div class="session-details-title">Session Info</div>
        
        <div class="details-label">Student</div>
        <div class="details-value">${sessionObj.student.fullName}</div>
        
        <div class="details-label">Counselor</div>
        <div class="details-value">Dr. ${sessionObj.mhp.fullName}</div>
        
        <div class="details-label">Focus Area</div>
        <div class="details-value">${not empty sessionObj.preFocus ? sessionObj.preFocus : 'General Wellness'}</div>
        
        <div class="details-label">Time Slot</div>
        <div class="details-value">${sessionObj.sessionDate} <br> ${sessionObj.time}</div>
    </div>
</div>

<div class="controls">
    <div class="control-btn"><i class="fa-solid fa-microphone"></i></div>
    <div class="control-btn"><i class="fa-solid fa-video"></i></div>
    
    <%-- Redirect back home based on role when clicking X --%>
    <c:url var="exitUrl" value="${userRole == 'STUDENT' ? '/student/home' : '/sessions/confirm'}" />
    <div class="control-btn end" onclick="window.history.back();">
        <i class="fa-solid fa-phone-slash"></i>
    </div>
    
    <div class="control-btn"><i class="fa-solid fa-comment"></i></div>
    <div class="control-btn"><i class="fa-solid fa-ellipsis-vertical"></i></div>
</div>

</body>
</html>