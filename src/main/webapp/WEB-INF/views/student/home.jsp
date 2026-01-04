<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>Home - MindWell</title>
    <meta name="viewport" content="width=device-width,initial-scale=1"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        :root{
            --teal:#6fd7cc;
            --teal-dark:#3fb9a8;
            --teal-light:#e8f9f7;
            --muted:#7b8794;
            --card-bg:#ffffff;
            --page-bg:#f6fbfa;
            --radius:12px;
            --shadow:0 10px 30px rgba(18,24,33,0.06);
            --shadow-hover:0 15px 40px rgba(18,24,33,0.1);
            --transition:all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        *{box-sizing:border-box}
        body{margin:0;font-family:Inter, "Segoe UI", Roboto, Arial, sans-serif;background:var(--page-bg);color:#123;line-height:1.5}
        .page{max-width:1100px;margin:28px auto;padding:20px}
        
        /* Header with animation */
        .header{display:flex;align-items:center;justify-content:space-between;gap:18px;margin-bottom:20px;animation:fadeInDown 0.5s ease-out}
        .title{font-size:22px;font-weight:700;color:#123}
        .subtitle{color:var(--muted);font-size:13px;margin-top:6px}
        
        /* Grid layout */
        .grid{display:grid;grid-template-columns:1fr 320px;gap:20px;align-items:start}
        .main{display:flex;flex-direction:column;gap:18px}
        
        /* Enhanced cards with hover effects */
        .card{
            background:var(--card-bg);
            border-radius:var(--radius);
            box-shadow:var(--shadow);
            padding:16px;
            transition:var(--transition);
            animation:fadeInUp 0.5s ease-out backwards;
        }
        .card:hover{box-shadow:var(--shadow-hover);transform:translateY(-2px)}
        .card:nth-child(1){animation-delay:0.1s}
        .card:nth-child(2){animation-delay:0.2s}
        .card:nth-child(3){animation-delay:0.3s}
        .card:nth-child(4){animation-delay:0.4s}
        
        /* Stats with improved styling */
        .stats{display:flex;gap:12px;padding:18px}
        .stat{
            flex:1;
            border-radius:10px;
            padding:14px;
            background:#fbfffe;
            border:1px solid rgba(18,24,33,0.04);
            text-align:center;
            transition:var(--transition);
            cursor:pointer;
        }
        .stat:hover{
            background:var(--teal-light);
            border-color:var(--teal);
            transform:translateY(-3px);
        }
        .stat h3{margin:0;font-size:20px;color:var(--teal-dark);font-weight:700}
        .stat p{margin:6px 0 0;color:var(--muted);font-size:13px}

        /* Interactive quick actions */
        .quick-actions{display:grid;grid-template-columns:repeat(3,1fr);gap:10px}
        .quick-item{
            background:#fff;
            border-radius:10px;
            padding:14px;
            text-align:center;
            border:1px dashed rgba(18,24,33,0.08);
            cursor:pointer;
            transition:var(--transition);
            position:relative;
            overflow:hidden;
        }
        .quick-item::before{
            content:'';
            position:absolute;
            top:0;
            left:-100%;
            width:100%;
            height:100%;
            background:linear-gradient(90deg, transparent, rgba(111,215,204,0.1), transparent);
            transition:var(--transition);
        }
        .quick-item:hover{
            border-color:var(--teal);
            border-style:solid;
            background:var(--teal-light);
            transform:translateY(-2px);
        }
        .quick-item:hover::before{left:100%}
        .quick-item strong{display:block;color:#123;font-size:14px}
        .quick-item small{display:block;color:var(--muted);font-size:12px;margin-top:6px}

        /* Enhanced recommendations */
        .recommendations .rec-item{
            display:flex;
            justify-content:space-between;
            align-items:center;
            padding:12px;
            border-bottom:1px solid #f2f6f5;
            transition:var(--transition);
        }
        .rec-item:last-child{border-bottom:none}
        .rec-item:hover{background:var(--teal-light);border-radius:8px}
        .rec-meta{color:var(--muted);font-size:12px;margin-top:4px}

        /* Animated wellness score */
        .wellness{padding:18px;text-align:center}
        .score{
            font-size:36px;
            color:var(--teal-dark);
            font-weight:800;
            animation:countUp 1s ease-out;
        }
        .progress{
            height:8px;
            background:#eef6f5;
            border-radius:8px;
            margin-top:12px;
            overflow:hidden;
            position:relative;
        }
        .progress > i{
            display:block;
            height:100%;
            background:linear-gradient(90deg,var(--teal),var(--teal-dark));
            width:0;
            transition:width 1s ease-out 0.3s;
            border-radius:8px;
        }
        .wellness-details{margin-top:10px;color:var(--muted);font-size:13px;text-align:left}
        .wellness-details > div{
            padding:6px 0;
            transition:var(--transition);
            border-radius:4px;
            padding-left:4px;
        }
        .wellness-details > div:hover{background:var(--teal-light);padding-left:8px}

        /* Enhanced achievements */
        .achievements .badge{
            background:#fbfffc;
            border-radius:8px;
            padding:10px;
            margin-bottom:8px;
            border:1px solid rgba(18,24,33,0.03);
            transition:var(--transition);
            cursor:pointer;
        }
        .badge:hover{
            background:var(--teal-light);
            border-color:var(--teal);
            transform:translateX(4px);
        }

        /* Recent activity improvements */
        .recent-activity ul{list-style:none;padding:0;margin:0}
        .recent-activity li{
            padding:10px;
            border-bottom:1px solid #f3f6f5;
            color:var(--muted);
            font-size:13px;
            transition:var(--transition);
            border-radius:6px;
        }
        .recent-activity li:hover{background:var(--teal-light)}
        .time-ago{float:right;color:var(--muted);font-size:12px}

        /* Enhanced buttons */
        .btn{
            padding:10px 14px;
            border-radius:8px;
            border:none;
            cursor:pointer;
            transition:var(--transition);
            font-weight:600;
            font-size:13px;
        }
        .btn-primary{
            background:linear-gradient(180deg,var(--teal),var(--teal-dark));
            color:#fff;
            box-shadow:0 4px 12px rgba(63,185,168,0.3);
        }
        .btn-primary-grey{
            background:rgb(232, 229, 229);
            color:black;
            box-shadow:0 4px 12px rgba(63,185,168,0.3);
        }
        .btn-primary:hover{
            transform:translateY(-2px);
            box-shadow:0 6px 20px rgba(63,185,168,0.4);
        }
        .btn-ghost{
            background:#fff;
            border:1px solid rgba(18,24,33,0.06);
            color:#27433f;
        }
        .btn-ghost:hover{
            background:var(--teal-light);
            border-color:var(--teal);
        }

        /* Card headers */
        .card h4{
            margin:0 0 10px 0;
            font-size:16px;
            font-weight:700;
            color:#123;
        }

        /* --- NEW AI CARD STYLING --- */
        .ai-link-wrapper {
            text-decoration: none;
            display: block;
            margin-top: 14px;
        }

        .ai-card {
            background: var(--card-bg);
            border-radius: var(--radius);
            padding: 24px;
            box-shadow: var(--shadow);
            transition: var(--transition);
            display: flex;
            justify-content: space-between;
            align-items: center;
            border: 1px solid transparent; /* invisible border for hover state */
            position: relative;
            overflow: hidden;
            animation: fadeInUp 0.5s ease-out backwards;
            animation-delay: 0.5s;
        }

        .ai-card:hover {
            box-shadow: var(--shadow-hover);
            transform: translateY(-5px);
            border-color: var(--teal);
        }

        .ai-content {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .ai-title {
            font-size: 18px; 
            color: #123;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .ai-subtitle {
            font-size: 13px;
            color: var(--muted);
        }

        .ai-action-icon {
            font-size: 18px;
            color: #e0e0e0;
            transition: var(--transition);
        }

        /* Hover Effect: Arrow turns teal and moves right */
        .ai-card:hover .ai-action-icon {
            color: var(--teal);
            transform: translateX(5px);
        }

        /* Animations */
        @keyframes fadeInUp{
            from{opacity:0;transform:translateY(20px)}
            to{opacity:1;transform:translateY(0)}
        }
        @keyframes fadeInDown{
            from{opacity:0;transform:translateY(-20px)}
            to{opacity:1;transform:translateY(0)}
        }
        @keyframes countUp{
            from{opacity:0;transform:scale(0.5)}
            to{opacity:1;transform:scale(1)}
        }

        /* Responsive design */
        @media (max-width:960px){
            .grid{grid-template-columns:1fr;padding-bottom:40px}
            .quick-actions{grid-template-columns:repeat(2,1fr)}
            .stats{flex-wrap:wrap}
            .stat{min-width:calc(50% - 6px)}
        }
        @media (max-width:640px){
            .page{padding:12px;margin:12px auto}
            .header{flex-direction:column;align-items:flex-start}
            .title{font-size:20px}
            .quick-actions{grid-template-columns:1fr}
            .stats{flex-direction:column}
            .stat{width:100%}
        }

        /* Accessibility improvements */
        .btn:focus, .quick-item:focus, .stat:focus, .ai-link-wrapper:focus .ai-card{
            outline:2px solid var(--teal);
            outline-offset:2px;
        }
        @media (prefers-reduced-motion: reduce){
            *{animation:none !important;transition:none !important}
        }
    </style>
</head>
<body>
<c:choose>
    <c:when test="${not empty loggedInUser}">
        <c:choose>
            <c:when test="${not empty loggedInUser.fullName}">
                <c:set var="displayName" value="${loggedInUser.fullName}"/>
            </c:when>
            <c:otherwise>
                <c:set var="displayName" value="${loggedInUser.username}"/>
            </c:otherwise>
        </c:choose>

        <c:set var="ws" value="${wellnessScore}"/>
        <c:if test="${empty ws}"><c:set var="ws" value="78"/></c:if>

        <c:set var="completedAssessmentsVal" value="${completedAssessments}"/>
        <c:if test="${empty completedAssessmentsVal}"><c:set var="completedAssessmentsVal" value="12"/></c:if>

        <c:set var="learningModulesVal" value="${learningModulesCompleted}"/>
        <c:if test="${empty learningModulesVal}"><c:set var="learningModulesVal" value='8/15'/></c:if>

        <c:set var="forumPostsVal" value="${forumPosts}"/>
        <c:if test="${empty forumPostsVal}"><c:set var="forumPostsVal" value="23"/></c:if>

        <c:set var="badgesEarnedVal" value="${badgesEarned}"/>
        <c:if test="${empty badgesEarnedVal}"><c:set var="badgesEarnedVal" value="5"/></c:if>

        <div class="page">
            <div class="header">
                <div>
                    <div class="title">Welcome back, <c:out value="${displayName}"/> &#128075; </div>
                    <div class="subtitle">Here's your wellness journey at a glance</div>
                </div>
                <div style="text-align:right">
                    <div style="font-size:13px;color:var(--muted)">Role: <strong><c:out value="${loggedInUser.role}"/></strong></div>
                    <div style="margin-top:8px"><a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-ghost">Log out</a></div>
                </div>
            </div>

            <div class="grid">
                <div class="main">
                    <div class="card stats">
                        <div class="stat" tabindex="0" role="button" aria-label="View completed assessments">
                            <h3><c:out value="${completedAssessmentsVal}"/></h3>
                            <p>Completed Assessments</p>
                        </div>
                        <div class="stat" tabindex="0" role="button" aria-label="View learning modules">
                            <h3><c:out value="${learningModulesVal}"/></h3>
                            <p>Learning Modules</p>
                        </div>
                        <div class="stat" tabindex="0" role="button" aria-label="View forum posts">
                            <h3><c:out value="${forumPostsVal}"/></h3>
                            <p>Forum Posts</p>
                        </div>
                        <div class="stat" tabindex="0" role="button" aria-label="View badges earned">
                            <h3><c:out value="${badgesEarnedVal}"/></h3>
                            <p>Badges Earned</p>
                        </div>
                    </div>

                    <div class="card">
                        <h4>Quick Actions</h4>
                        <div class="quick-actions">
                            <div class="quick-item" tabindex="0" role="button" onclick="handleQuickAction('assessment')">
                                <strong>Take Assessment</strong>
                                <small>Check your mood today</small>
                            </div>
                            <div class="quick-item" tabindex="0" role="button" onclick="handleQuickAction('content')">
                                <strong>Browse Content</strong>
                                <small>Learn something new</small>
                            </div>
                            <div class="quick-item" tabindex="0" role="button" onclick="handleQuickAction('forum')">
                                <strong>Join Forum</strong>
                                <small>Connect with peers</small>
                            </div>
                            <div class="quick-item" tabindex="0" role="button" onclick="handleQuickAction('progress')">
                                <strong>View Progress</strong>
                                <small>Track your journey</small>
                            </div>
                            <div class="quick-item" tabindex="0" role="button" onclick="handleQuickAction('session')">
                                <strong>Book Session</strong>
                                <small>Schedule counselling</small>
                            </div>
                        </div>
                    </div>

                    <div class="card recommendations">
                        <h4>🤖 AI Recommendations for You</h4>
                        <div class="rec-item">
                            <div>
                                <div style="font-weight:700">Managing Study Stress</div>
                                <div class="rec-meta">Video · 15 min · 95% match</div>
                            </div>
                            <div><a href="${pageContext.request.contextPath}/student/content/study-stress" class="btn btn-ghost">View</a></div>
                        </div>
                        <div class="rec-item">
                            <div>
                                <div style="font-weight:700">Sleep Hygiene Basics</div>
                                <div class="rec-meta">Article · 5 min · 88% match</div>
                            </div>
                            <div><a href="${pageContext.request.contextPath}/student/content/sleep-hygiene" class="btn btn-ghost">View</a></div>
                        </div>
                        <div class="rec-item">
                            <div>
                                <div style="font-weight:700">Breathing Exercises</div>
                                <div class="rec-meta">Interactive · 10 min · 92% match</div>
                            </div>
                            <div><a href="${pageContext.request.contextPath}/student/content/breathing" class="btn btn-ghost">View</a></div>
                        </div>
                    </div>

                    <div class="card recent-activity">
                        <h4>Recent Activity</h4>
                        <ul>
                            <li>Completed Stress Assessment <span class="time-ago">2 hours ago</span></li>
                            <li>Earned 'Mindful Learner' Badge <span class="time-ago">1 day ago</span></li>
                            <li>Viewed 'Coping with Anxiety' Module <span class="time-ago">2 days ago</span></li>
                            <li>Posted in Support Forum <span class="time-ago">3 days ago</span></li>
                        </ul>
                    </div>
                </div>

                <aside class="right">
                    <div class="card wellness">
                        <h4>Wellness Score</h4>
                        <div class="score"><c:out value="${ws}"/> <small style="font-size:12px;color:var(--muted)">/100</small></div>
                        <div class="progress">
                            <i id="progressBar" data-ws="${ws}"></i>
                        </div>
                        <div class="wellness-details">
                            <div>Engagement <span style="float:right;font-weight:700">85%</span></div>
                            <div>Consistency <span style="float:right;font-weight:700">72%</span></div>
                            <div>Progress <span style="float:right;font-weight:700">80%</span></div>
                        </div>
                    </div>

                    <div class="card achievements" style="margin-top:14px">
                        <h4>🏆 Latest Achievements</h4>
                        <div class="badge" tabindex="0">Mindful Learner — Completed 5 modules</div>
                        <div class="badge" tabindex="0">Consistent Tracker — 7 day streak</div>
                        <div class="badge" tabindex="0">Community Helper — 10+ helpful posts</div>
                    </div>

                    <div class="card" style="margin-top:14px">
                        <h4>📅 Upcoming</h4>
                        <div style="font-size:13px;color:var(--muted)"><b>Counseling Session with Dr Mitchell</b></div>
                        <br>
                        <div style="margin-top:8px">
                            <a href="${pageContext.request.contextPath}/sessions/detail" class="btn btn-primary-grey">
                                View Details
                            </a>
                        </div>

                        &nbsp;
                        
                        <div style="margin-top:8px">
                            <a href="${pageContext.request.contextPath}/sessions/meeting" class="btn btn-primary">
                                Start Session
                            </a>
                        </div>
                    </div>

                    <a href="${pageContext.request.contextPath}/student/chatbot" class="ai-link-wrapper">
                        <div class="ai-card">
                            <div class="ai-content">
                                <div class="ai-title">
                                    Ask AI <i class="fas fa-robot" style="color:var(--teal);"></i>
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

                </aside>
            </div>
        </div>
    </c:when>

    <c:otherwise>
        <div style="padding:40px;text-align:center;animation:fadeInUp 0.5s ease-out">
            <h2>Please log in to view your dashboard</h2>
            <p><a href="${pageContext.request.contextPath}/auth/login" class="btn btn-primary">Go to Login</a></p>
        </div>
    </c:otherwise>
</c:choose>

<script>
    // Animate progress bar
    (function(){
        var el = document.getElementById('progressBar');
        if(!el) return;
        var v = parseFloat(el.getAttribute('data-ws'));
        if(isNaN(v)) v = 78;
        v = Math.max(0, Math.min(100, v));
        
        // Trigger animation after page load
        setTimeout(function(){
            el.style.width = v + '%';
        }, 300);
    })();

    // Handle quick action clicks
    function handleQuickAction(action){
    var routes = {
            'assessment': '/student/assessment/',
            'content': '/content/browse',
            'forum': '/student/forum',
            'progress': '/student/dashboard',
            'session': '/sessions/book'
        };
        
        var contextPath = '${pageContext.request.contextPath}';
        if(routes[action]){
            window.location.href = contextPath + routes[action];
        }
    }

    // Add keyboard accessibility to stat cards
    document.querySelectorAll('.stat, .quick-item, .badge').forEach(function(el){
        el.addEventListener('keypress', function(e){
            if(e.key === 'Enter' || e.key === ' '){
                e.preventDefault();
                el.click();
            }
        });
    });
</script>
</body>
</html>