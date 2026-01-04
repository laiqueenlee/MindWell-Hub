<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assessment History - HealthHub UTM</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: #f8fafb;
            color: #1a1a1a;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        
        .filter-section {
            margin-bottom: 30px;
        }
        
        .filter-section h5 {
            margin-bottom: 15px;
            font-weight: 600;
        }
        
        .page-header {
            margin-bottom: 30px;
        }
        
        .page-header h2 {
            font-size: 28px;
            font-weight: 700;
        }
        
        .btn {
            padding: 10px 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            text-decoration: none;
            background: white;
            color: #333;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-block;
        }
        
        .btn:hover {
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        
        .btn-primary {
            background: #007bff;
            color: white;
            border-color: #007bff;
        }
        
        .btn-outline-primary {
            background: white;
            color: #007bff;
            border-color: #007bff;
        }
        
        .btn-info, .btn-outline-info {
            color: #17a2b8;
            border-color: #17a2b8;
        }
        
        .btn-info {
            background: #17a2b8;
            color: white;
        }
        
        .btn-warning, .btn-outline-warning {
            color: #ffc107;
            border-color: #ffc107;
        }
        
        .btn-warning {
            background: #ffc107;
            color: #333;
        }
        
        .btn-danger, .btn-outline-danger {
            color: #dc3545;
            border-color: #dc3545;
        }
        
        .btn-danger {
            background: #dc3545;
            color: white;
        }
        
        .btn-success, .btn-outline-success {
            color: #28a745;
            border-color: #28a745;
        }
        
        .btn-success {
            background: #28a745;
            color: white;
        }
        
        .btn-sm {
            padding: 6px 12px;
            font-size: 14px;
        }
        
        .btn-outline-secondary {
            color: #6c757d;
            border-color: #6c757d;
        }
        
        .alert {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        
        .alert-info {
            background: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }
        
        .card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        
        .card-header {
            padding: 15px 20px;
            border-bottom: 1px solid #e5e7eb;
            border-radius: 8px 8px 0 0;
        }
        
        .card-body {
            padding: 20px;
        }
        
        .bg-primary {
            background: #007bff !important;
        }
        
        .text-white {
            color: white !important;
        }
        
        .text-muted {
            color: #6c757d;
        }
        
        .text-center {
            text-align: center;
        }
        
        .text-end {
            text-align: right;
        }
        
        .row {
            display: flex;
            flex-wrap: wrap;
            margin: 0 -10px;
        }
        
        [class*="col-"] {
            padding: 0 10px;
        }
        
        .col-md-2 { width: 16.66%; }
        .col-md-3 { width: 25%; }
        .col-md-5 { width: 41.66%; }
        
        .align-items-center {
            align-items: center;
        }
        
        .mb-0 { margin-bottom: 0; }
        .mb-1 { margin-bottom: 8px; }
        .mt-2 { margin-top: 16px; }
        .mt-3 { margin-top: 24px; }
        .mt-4 { margin-top: 32px; }
        
        .badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
        }
        
        .bg-info { background: #17a2b8; color: white; }
        .bg-warning { background: #ffc107; }
        .bg-danger { background: #dc3545; color: white; }
        .bg-success { background: #28a745; color: white; }
        .text-dark { color: #333; }
        
        .collapse {
            display: none;
        }
        
        ul {
            margin: 10px 0;
            padding-left: 20px;
        }
        
        li {
            margin: 5px 0;
        }
        
        small {
            font-size: 14px;
        }
        
        @media (max-width: 768px) {
            [class*="col-md-"] {
                width: 100%;
                margin-bottom: 15px;
            }
        }
        
        .assessment-card {
            margin-bottom: 20px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .assessment-card:hover {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transform: translateY(-2px);
        }
        .assessment-type-badge {
            font-size: 0.9rem;
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
        }
        .score-display {
            font-size: 2rem;
            font-weight: bold;
        }
        .category-good { color: #28a745; }
        .category-fair { color: #ffc107; }
        .category-poor { color: #dc3545; }
        .filter-btn {
            margin: 5px;
        }
        .timeline-line {
            border-left: 3px solid #007bff;
            padding-left: 20px;
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/includes/navbar.jsp" %>
    
    <% 
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("MMM dd, yyyy");
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("hh:mm a");
        pageContext.setAttribute("dateFormatter", dateFormatter);
        pageContext.setAttribute("timeFormatter", timeFormatter);
    %>
    
    <div class="container">
        <div class="page-header">
            <h2>
                <i class="fas fa-history"></i> Assessment History
            </h2>
        </div>
                
        <!-- Filter Buttons -->
        <div class="filter-section">
            <h5>Filter by Type:</h5>
            <a href="${pageContext.request.contextPath}/student/assessment/history" 
               class="btn ${selectedType == 'all' ? 'btn-primary' : 'btn-outline-primary'} filter-btn">
                <i class="fas fa-list"></i> All Assessments
            </a>
            <a href="${pageContext.request.contextPath}/student/assessment/history?type=mood" 
               class="btn ${selectedType == 'mood' ? 'btn-info' : 'btn-outline-info'} filter-btn">
                <i class="fas fa-smile"></i> Mood
            </a>
            <a href="${pageContext.request.contextPath}/student/assessment/history?type=stress" 
               class="btn ${selectedType == 'stress' ? 'btn-warning' : 'btn-outline-warning'} filter-btn">
                <i class="fas fa-brain"></i> Stress
            </a>
            <a href="${pageContext.request.contextPath}/student/assessment/history?type=anxiety" 
               class="btn ${selectedType == 'anxiety' ? 'btn-danger' : 'btn-outline-danger'} filter-btn">
                <i class="fas fa-heartbeat"></i> Anxiety
            </a>
            <a href="${pageContext.request.contextPath}/student/assessment/history?type=wellbeing" 
               class="btn ${selectedType == 'wellbeing' ? 'btn-success' : 'btn-outline-success'} filter-btn">
                <i class="fas fa-spa"></i> Wellbeing
            </a>
        </div>
                
        <!-- Assessment List -->
                <c:choose>
                    <c:when test="${empty assessments}">
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle"></i> 
                            No assessment history found. Take your first assessment to see results here!
                        </div>
                        <a href="${pageContext.request.contextPath}/student/assessment/" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Take an Assessment
                        </a>
                    </c:when>
                    <c:otherwise>
                        <div class="timeline-line">
                            <c:forEach var="assessment" items="${assessments}">
                                <div class="assessment-card card">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col-md-2 text-center">
                                                <c:choose>
                                                    <c:when test="${assessment.assessmentType == 'mood'}">
                                                        <span class="assessment-type-badge badge bg-info">
                                                            <i class="fas fa-smile"></i> Mood
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${assessment.assessmentType == 'stress'}">
                                                        <span class="assessment-type-badge badge bg-warning text-dark">
                                                            <i class="fas fa-brain"></i> Stress
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${assessment.assessmentType == 'anxiety'}">
                                                        <span class="assessment-type-badge badge bg-danger">
                                                            <i class="fas fa-heartbeat"></i> Anxiety
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${assessment.assessmentType == 'wellbeing'}">
                                                        <span class="assessment-type-badge badge bg-success">
                                                            <i class="fas fa-spa"></i> Wellbeing
                                                        </span>
                                                    </c:when>
                                                </c:choose>
                                            </div>
                                            
                                            <div class="col-md-2 text-center">
                                                <div class="score-display
                                                    <c:choose>
                                                        <c:when test="${assessment.category == 'Good' || assessment.category == 'Excellent' || assessment.category == 'Very Good'}">
                                                            category-good
                                                        </c:when>
                                                        <c:when test="${assessment.category == 'Fair' || assessment.category == 'Moderate' || assessment.category == 'Average'}">
                                                            category-fair
                                                        </c:when>
                                                        <c:otherwise>
                                                            category-poor
                                                        </c:otherwise>
                                                    </c:choose>
                                                ">
                                                    ${assessment.score}
                                                </div>
                                                <small class="text-muted">${assessment.category}</small>
                                            </div>
                                            
                                            <div class="col-md-5">
                                                <p class="mb-1"><strong>Feedback:</strong></p>
                                                <p class="text-muted">${assessment.feedback}</p>
                                            </div>
                                            
                                            <div class="col-md-3 text-end">
                                                <small class="text-muted">
                                                    <i class="fas fa-calendar"></i>
                                                    ${assessment.completedAt.format(dateFormatter)}
                                                    <br>
                                                    <i class="fas fa-clock"></i>
                                                    ${assessment.completedAt.format(timeFormatter)}
                                                </small>
                                            </div>
                                        </div>
                                        
                                        <!-- Recommendations (collapsible) -->
                                        <c:if test="${not empty assessment.recommendations}">
                                            <div class="mt-3">
                                                <a class="btn btn-sm btn-outline-secondary" data-bs-toggle="collapse" 
                                                   href="#recommendations-${assessment.assessmentId}" role="button">
                                                    <i class="fas fa-lightbulb"></i> View Recommendations
                                                </a>
                                                <div class="collapse mt-2" id="recommendations-${assessment.assessmentId}">
                                                    <div class="card card-body">
                                                        <ul class="mb-0">
                                                            <c:forEach var="recommendation" items="${assessment.recommendations}">
                                                                <li>${recommendation}</li>
                                                            </c:forEach>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        
                        <!-- Statistics Summary -->
                        <div class="card mt-4">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0"><i class="fas fa-chart-bar"></i> Summary Statistics</h5>
                            </div>
                            <div class="card-body">
                                <div class="row text-center">
                                    <div class="col-md-3">
                                        <h4>${assessments.size()}</h4>
                                        <small class="text-muted">Total Assessments</small>
                                    </div>
                                    <div class="col-md-3">
                                        <h4>
                                            <c:set var="totalScore" value="0" />
                                            <c:forEach var="a" items="${assessments}">
                                                <c:set var="totalScore" value="${totalScore + a.score}" />
                                            </c:forEach>
                                            <fmt:formatNumber value="${totalScore / assessments.size()}" maxFractionDigits="1" />
                                        </h4>
                                        <small class="text-muted">Average Score</small>
                                    </div>
                                    <div class="col-md-3">
                                        <h4>${assessments.get(0).category}</h4>
                                        <small class="text-muted">Latest Category</small>
                                    </div>
                                    <div class="col-md-3">
                                        <a href="${pageContext.request.contextPath}/student/assessment/" 
                                           class="btn btn-primary">
                                            <i class="fas fa-plus"></i> Take New Assessment
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
    </div>
    
    <script>
        // Simple collapse toggle
        document.addEventListener('DOMContentLoaded', function() {
            const toggles = document.querySelectorAll('[data-bs-toggle="collapse"]');
            toggles.forEach(toggle => {
                toggle.addEventListener('click', function(e) {
                    e.preventDefault();
                    const target = document.querySelector(this.getAttribute('href'));
                    if (target) {
                        target.style.display = target.style.display === 'none' ? 'block' : 'none';
                    }
                });
            });
            
            // Initialize all collapse elements as hidden
            document.querySelectorAll('.collapse').forEach(el => {
                el.style.display = 'none';
            });
        });
    </script>
</body>
</html>
