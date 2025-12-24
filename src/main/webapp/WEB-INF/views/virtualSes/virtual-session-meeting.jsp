<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <title>Virtual Session</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Inter", Arial, sans-serif;
            background: #f7f9fc;
            color: #333;
        }

        .header {
            display: flex;
            align-items: center;
            padding: 15px 25px;
            background: #ffffff;
            font-size: 18px;
            font-weight: 500;
            border-bottom: 1px solid #e5e7eb;
        }

        .header img {
            width: 22px;
            height: 22px;
            margin-right: 10px;
        }

        .container {
            display: flex;
            padding: 25px;
            gap: 25px;
        }

        .video-area {
            flex: 1;
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 450px;
        }

        .session-timer {
            position: absolute;
            top: 15px;
            left: 15px;
            background: #ffffff;
            padding: 5px 12px;
            border-radius: 6px;
            font-size: 12px;
            border: 1px solid #e5e7eb;
        }

        .counselor-box {
            text-align: center;
            color: #777;
        }

        .counselor-icon {
            width: 70px;
            height: 70px;
            background: #3bb8c8;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: auto;
        }

        .counselor-name {
            margin-top: 12px;
            font-size: 15px;
            color: #333;
        }

        .user-box {
            position: absolute;
            bottom: 20px;
            right: 20px;
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 10px;
            padding: 10px 18px;
            font-size: 13px;
            text-align: center;
        }

        .controls {
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 18px;
        }

        .control-btn {
            width: 45px;
            height: 45px;
            background: #e5e7eb;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
        }

        .control-btn.end {
            background: #e74c3c;
            color: white;
        }

        .session-details {
            width: 260px;
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
            height: fit-content;
        }

        .session-details-title {
            font-size: 17px;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .details-label {
            font-size: 13px;
            color: #888;
            margin-top: 10px;
        }

        .details-value {
            font-size: 14px;
            color: #333;
            margin-bottom: 5px;
        }

    </style>
</head>
<body>

<div class="header">
    <i class="fa-solid fa-video"></i>&nbsp; Virtual Session
</div>

<div class="container">

    <!-- <c:if test="${roles == 'STUDENT'}"> -->
    <div class="video-area">
        <div class="session-timer">Session: 00:12:34</div>
            <div class="counselor-box">
            <div class="counselor-icon"><i class="fa-solid fa-video"></i></div>
            <div class="counselor-name">Dr. Michael Tan</div>
            <br>
            <div style="font-size: 12px; color: #999;">Waiting to connect...</div>
        </div>

        <div class="user-box">
            <div style="font-weight: 600;">You</div>
            <div style="font-size: 12px; color: #999;">Student</div>
        </div>
    </div>
    <!-- </c:if> -->
     
    <!-- <c:if test="${roles == 'COUNSELOR'}"> -->
    <!-- <div class="video-area">
        <div class="session-timer">Session: 00:12:34</div>
            <div class="counselor-box">
            <div class="counselor-icon"><i class="fa-solid fa-video"></i></div>
            <div class="counselor-name">John Doe</div>
            <br>
            <div style="font-size: 12px; color: #999;">Waiting to connect...</div>
        </div>

        <div class="user-box">
            <div style="font-weight: 600;">You</div>
            <div style="font-size: 12px; color: #999;">Counselor</div>
        </div>
    </div> -->
    <!--</c:if> -->

    <div class="session-details">
        <div class="session-details-title">Session Details</div>
        <div class="details-label">Counselor</div>
        <div class="details-value">Dr. Michael Tan</div>
        <div class="details-label">Appointment</div>
        <div class="details-value">2:00 PM - 3:00 PM</div>
    </div>
</div>

<div class="controls">
    <div class="control-btn"><i class="fa-solid fa-microphone"></i></div>
    <div class="control-btn"><i class="fa-solid fa-video"></i></div>
    <div class="control-btn end"><i class="fa-solid fa-circle-xmark"></i></div>
    <div class="control-btn"><i class="fa-solid fa-comment"></i></div>
    <div class="control-btn"><i class="fa-solid fa-ellipsis-vertical"></i></div>
</div>

</body>
</html>
