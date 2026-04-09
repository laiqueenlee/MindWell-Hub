<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>Self-Assessment Tools - MindWell</title>
    <meta name="viewport" content="width=device-width,initial-scale=1"/>
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
            --shadow-hover: 0 15px 40px rgba(18,24,33,0.1);
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        * { box-sizing: border-box; }
        body {
            margin: 0;
            font-family: Inter, "Segoe UI", Roboto, Arial, sans-serif;
            background: var(--page-bg);
            color: #123;
            line-height: 1.5;
        }
        .page {
            max-width: 1100px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        .back-button {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: var(--teal-dark);
            text-decoration: none;
            font-weight: 600;
            margin-bottom: 30px;
            transition: var(--transition);
        }
        .back-button:hover {
            gap: 12px;
            color: var(--teal);
        }
        .header {
            text-align: center;
            margin-bottom: 40px;
            animation: fadeInDown 0.5s ease-out;
        }
        .header h1 {
            font-size: 32px;
            font-weight: 700;
            color: #123;
            margin: 0;
        }
        .header p {
            color: var(--muted);
            font-size: 16px;
            margin: 12px 0 0 0;
        }
        .assessments-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 24px;
            margin-bottom: 40px;
        }
        .assessment-card {
            background: var(--card-bg);
            border-radius: var(--radius);
            padding: 28px;
            box-shadow: var(--shadow);
            transition: var(--transition);
            animation: fadeInUp 0.5s ease-out backwards;
            display: flex;
            flex-direction: column;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }
        .assessment-card:hover {
            box-shadow: var(--shadow-hover);
            transform: translateY(-8px);
        }
        .assessment-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(111,215,204,0.1), transparent);
            transition: var(--transition);
        }
        .assessment-card:hover::before {
            left: 100%;
        }
        .assessment-card:nth-child(1) { animation-delay: 0.1s; }
        .assessment-card:nth-child(2) { animation-delay: 0.2s; }
        .assessment-card:nth-child(3) { animation-delay: 0.3s; }
        .assessment-card:nth-child(4) { animation-delay: 0.4s; }
        
        .assessment-icon {
            font-size: 48px;
            margin-bottom: 16px;
            display: inline-block;
            width: 64px;
            height: 64px;
            border-radius: 12px;
            background: var(--teal-light);
            display: flex;
            align-items: center;
            justify-content: center;
            transition: var(--transition);
        }
        .assessment-card:hover .assessment-icon {
            transform: scale(1.1);
        }
        .assessment-title {
            font-size: 18px;
            font-weight: 700;
            color: #123;
            margin: 0 0 8px 0;
            transition: var(--transition);
        }
        .assessment-card:hover .assessment-title {
            color: var(--teal-dark);
        }
        .assessment-description {
            color: var(--muted);
            font-size: 13px;
            margin: 0 0 16px 0;
            flex-grow: 1;
        }
        .assessment-duration {
            display: flex;
            align-items: center;
            gap: 8px;
            color: var(--muted);
            font-size: 13px;
            margin-bottom: 16px;
            padding: 10px;
            background: var(--teal-light);
            border-radius: 8px;
            width: fit-content;
        }
        .clock-icon {
            display: inline-block;
            width: 16px;
            height: 16px;
            background: var(--teal);
            border-radius: 50%;
        }
        .btn {
            padding: 12px 20px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            transition: var(--transition);
            font-weight: 600;
            font-size: 14px;
            text-align: center;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
        }
        .btn-primary {
            background: linear-gradient(180deg, var(--teal), var(--teal-dark));
            color: #fff;
            box-shadow: 0 4px 12px rgba(63,185,168,0.3);
            width: 100%;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(63,185,168,0.4);
        }
        .btn-secondary {
            background: var(--teal-light);
            color: var(--teal-dark);
            width: 100%;
        }
        .btn-secondary:hover {
            background: var(--teal);
            color: #fff;
        }
        .completed-badge {
            display: inline-block;
            background: #d4f4d4;
            color: #2d5f2d;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            margin-top: 8px;
        }
        
        .info-card {
            background: var(--teal-light);
            border-left: 4px solid var(--teal-dark);
            border-radius: var(--radius);
            padding: 20px;
            margin-bottom: 30px;
            animation: fadeInUp 0.5s ease-out;
        }
        .info-card h3 {
            margin: 0 0 8px 0;
            color: var(--teal-dark);
            font-size: 15px;
            font-weight: 700;
        }
        .info-card p {
            margin: 0;
            color: #123;
            font-size: 13px;
            line-height: 1.6;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            .page { padding: 20px 16px; }
            .assessments-grid { grid-template-columns: 1fr; }
            .header h1 { font-size: 24px; }
        }
    </style>
</head>
<body>
<div class="page">
    <a href="${pageContext.request.contextPath}/student/home" class="back-button">
        ← Back to Home
    </a>

    <div class="header">
        <h1>Self-Assessment Tools</h1>
        <p>Choose an assessment to check in with your mental health and get personalized feedback</p>
        <div style="margin-top: 20px;">
            <a href="${pageContext.request.contextPath}/student/assessment/history" class="btn btn-primary">
                <i class="fas fa-history"></i> View Assessment History
            </a>
        </div>
    </div>

    <div class="info-card">
        <h3>💡 How It Works</h3>
        <p>Each assessment takes only a few minutes and provides you with personalized feedback and recommendations. Your responses are private and help us tailor support to your needs.</p>
    </div>

    <div class="assessments-grid">
        <div class="assessment-card">
            <div class="assessment-icon">📊</div>
            <h3 class="assessment-title">Daily Mood Check</h3>
            <p class="assessment-description">Track your emotional state and identify patterns</p>
            <div class="assessment-duration">
                <span class="clock-icon"></span>
                2 min
            </div>
            <form action="${pageContext.request.contextPath}/student/assessment/mood" method="get">
                <button type="submit" class="btn btn-primary">Start Assessment</button>
            </form>
        </div>

        <div class="assessment-card">
            <div class="assessment-icon">📈</div>
            <h3 class="assessment-title">Stress Assessment</h3>
            <p class="assessment-description">Evaluate your current stress levels and triggers</p>
            <div class="assessment-duration">
                <span class="clock-icon"></span>
                5 min
            </div>
            <form action="${pageContext.request.contextPath}/student/assessment/stress" method="get">
                <button type="submit" class="btn btn-primary">Start Assessment</button>
            </form>
        </div>

        <div class="assessment-card">
            <div class="assessment-icon">💫</div>
            <h3 class="assessment-title">Anxiety Screening</h3>
            <p class="assessment-description">Understand your anxiety symptoms and severity</p>
            <div class="assessment-duration">
                <span class="clock-icon"></span>
                7 min
            </div>
            <form action="${pageContext.request.contextPath}/student/assessment/anxiety" method="get">
                <button type="submit" class="btn btn-primary">Start Assessment</button>
            </form>
        </div>

        <div class="assessment-card">
            <div class="assessment-icon">✓</div>
            <h3 class="assessment-title">General Wellbeing</h3>
            <p class="assessment-description">Comprehensive assessment of your mental wellness</p>
            <div class="assessment-duration">
                <span class="clock-icon"></span>
                10 min
            </div>
            <form action="${pageContext.request.contextPath}/student/assessment/wellbeing" method="get">
                <button type="submit" class="btn btn-primary">Start Assessment</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
