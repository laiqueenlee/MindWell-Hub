<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Edit Content - HealthHub MHP' : 'Create Content - HealthHub MHP'}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background-color: #ffffff; color: #333; }
        .main-layout { display: flex; gap: 40px; max-width: 1400px; margin: 0 auto; padding: 40px; }
        .content-column { flex: 3; }
        .sidebar-column { flex: 1; }

        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .page-header h1 { font-size: 1.8rem; color: #2c3e50; margin-bottom: 5px; }
        .page-header p { color: #95a5a6; font-size: 0.9rem; }

        .tabs { display: flex; gap: 10px; margin-bottom: 20px; border-bottom: 1px solid #eee; padding-bottom: 10px; }
        .tab-btn { background: none; border: none; padding: 8px 15px; font-weight: 600; color: #95a5a6; cursor: pointer; border-radius: 20px; }
        .tab-btn.active { background-color: #f1f2f6; color: #2c3e50; }
        .tab-btn:hover { color: #2c3e50; background-color: #f8f9fa; }

        .form-card { border: 1px solid #eee; border-radius: 12px; padding: 30px; background-color: #fff; box-shadow: 0 4px 15px rgba(0,0,0,0.02); }
        .form-title { font-size: 1.4rem; color: #2c3e50; margin-bottom: 10px; font-weight: 600; }
        .form-subtitle { color: #95a5a6; font-size: 0.9rem; margin-bottom: 30px; display: block; }
        .form-group { margin-bottom: 25px; }
        .form-row { display: flex; gap: 30px; margin-bottom: 25px; }
        .col-half { flex: 1; }
        .col-third { flex: 1; }
        label { display: block; font-weight: 600; color: #34495e; margin-bottom: 8px; font-size: 0.95rem; }
        input[type="text"], input[type="number"], select, textarea { width: 100%; padding: 12px 15px; border: 1px solid #e0e0e0; border-radius: 8px; font-size: 0.95rem; color: #555; background-color: #fff; transition: border-color 0.2s; outline: none; }
        input:focus, select:focus, textarea:focus { border-color: #00d2d3; }
        textarea.short { height: 80px; resize: none; }
        textarea.long { height: 300px; resize: vertical; }
        textarea.medium { height: 150px; resize: vertical; }
        .form-actions { display: flex; gap: 20px; margin-top: 40px; }
        .btn-submit { flex: 1; padding: 15px; border-radius: 8px; font-weight: 600; font-size: 1rem; cursor: pointer; border: none; text-align: center; }
        .btn-save-draft { background-color: #00d2d3; color: white; opacity: 0.9; }
        .btn-publish { background-color: #00d2d3; color: white; }
        .btn-publish:hover, .btn-save-draft:hover { opacity: 1; filter: brightness(1.05); }
        .ai-card { border: 1px solid #eee; border-radius: 12px; padding: 20px; background-color: #fff; height: fit-content; }
        .ai-header { display: flex; align-items: center; gap: 10px; margin-bottom: 15px; }
        .ai-header h3 { font-size: 1.2rem; color: #2c3e50; }
        .ai-input-box { position: relative; width: 100%; }
        .ai-input-box input { width: 100%; padding: 12px 40px 12px 15px; border: 1px solid #ddd; border-radius: 20px; outline: none; font-size: 0.9rem; }
        .ai-input-box i { position: absolute; right: 15px; top: 50%; transform: translateY(-50%); color: #95a5a6; cursor: pointer; }
        .dynamic-section { display: none; background: #f9f9f9; padding: 20px; border-radius: 8px; border: 1px dashed #ddd; margin-bottom: 20px; }
        .section-label { font-size: 0.85rem; text-transform: uppercase; letter-spacing: 1px; color: #00d2d3; margin-bottom: 10px; display: block; font-weight: 700; }
        .question-block { background: #fff; padding: 15px; border: 1px solid #eee; border-radius: 8px; margin-bottom: 15px; }
        .question-block h4 { margin-bottom: 10px; color: #2c3e50; font-size: 1rem; }
        .options-container { margin-top: 10px; padding-left: 10px; border-left: 2px solid #00d2d3; }
        .option-row { display: flex; align-items: center; gap: 10px; margin-bottom: 8px; }
        .option-row input[type="radio"] { width: auto; cursor: pointer; accent-color: #00d2d3; }
        .option-row input[type="text"] { flex: 1; padding: 8px; font-size: 0.9rem; }
        .btn-icon-action { background: none; border: none; color: #e74c3c; cursor: pointer; font-size: 1rem; }
        .btn-add-option { background: none; border: 1px dashed #00d2d3; color: #00d2d3; padding: 5px 10px; border-radius: 4px; cursor: pointer; font-size: 0.85rem; margin-top: 5px; }
        .btn-add-option:hover { background: #e0fbfb; }
        /* Add this inside your <style> tag */
.flag-alert {
    background-color: #fff5f5;
    border: 1px solid #feb2b2;
    border-left: 5px solid #e53e3e;
    border-radius: 6px;
    padding: 15px 20px;
    margin-bottom: 25px;
    display: flex;
    gap: 15px;
    align-items: flex-start;
}
.flag-icon {
    color: #e53e3e;
    font-size: 1.2rem;
    margin-top: 2px;
}
.flag-content h4 {
    color: #c53030;
    margin-bottom: 5px;
    font-size: 1rem;
}
.flag-content p {
    color: #2d3748;
    font-size: 0.95rem;
    margin-bottom: 5px;
}
.flag-content small {
    color: #718096;
    font-style: italic;
}



    </style>
</head>

<body>
    <jsp:include page="/WEB-INF/views/includes/mhp-navbar.jsp" />

    <div class="main-layout">
        <div class="content-column">

            <div class="page-header">
                <div>
                    <h1>Content Management</h1>
                    <p>Create and manage educational content</p>
                </div>
            </div>

            <div class="tabs">
                <button class="tab-btn" onclick="window.location.href='${pageContext.request.contextPath}/mhp/content'">My Content</button>
                <button class="tab-btn active">${isEdit ? 'Edit Content' : 'Create New'}</button>
                <button class="tab-btn">Analytics</button>
            </div>

            <div class="form-card">
                <div class="form-title">${isEdit ? 'Edit Content' : 'Create New Content'}</div>
                <span class="form-subtitle">${isEdit ? 'Update your existing content details below' : 'Share your expertise with students'}</span>

                <c:if test="${content.status == 'Flagged'}">
    <div class="flag-alert">
        <div class="flag-icon">
            <i class="fas fa-exclamation-triangle"></i>
        </div>
        <div class="flag-content">
            <h4><i class="fas fa-flag"></i> Content Flagged for Moderation</h4>
            <p><strong>Moderator Note : </strong>${not empty content.flagReason ? fn:escapeXml(content.flagReason) : 'No specific reason provided.'}</p>
            <small>Please edit the content to address these issues and click "Update & Publish" to resubmit for review.</small>
        </div>
    </div>
</c:if>



                <form action="${pageContext.request.contextPath}/mhp/save-content" method="post" id="createForm">
                    
                    <input type="hidden" name="id" value="${content.id}">
                    <input type="hidden" name="status" id="statusInput" value="${not empty content.status ? content.status : 'draft'}">

                    <div class="form-group">
                        <label>Title</label>
                        <input type="text" name="title" value="${fn:escapeXml(content.title)}" placeholder="Enter content title" required>
                    </div>

                    <div class="form-group">
                        <label>Content Description</label>
                        <textarea name="description" class="short" placeholder="Enter a brief overview of what students will learn..." required>${fn:escapeXml(content.description)}</textarea>
                    </div>

                    <div class="form-row">
                        <div class="col-half">
                            <label>Content Type</label>
                            <select name="contentType" id="contentTypeSelect" onchange="toggleContentType()" required>
                                <option disabled ${empty content.type ? 'selected' : ''} value="">Select type</option>
                                <option value="Video" ${content.type == 'Video' ? 'selected' : ''}>Video</option>
                                <option value="Article" ${content.type == 'Article' ? 'selected' : ''}>Article</option>
                                <option value="Interactive" ${content.type == 'Interactive' ? 'selected' : ''}>Interactive Quiz</option>
                            </select>
                        </div>
                        <div class="col-half">
                            <label>Category</label>
                            <select name="category" required>
                                <option disabled value="" ${empty content.category ? 'selected' : ''}>Select category</option>
                                <option value="Stress Management" ${content.category == 'Stress Management' ? 'selected' : ''}>Stress Management</option>
                                <option value="Mental Health" ${content.category == 'Mental Health' ? 'selected' : ''}>Mental Health</option>
                                <option value="Wellness" ${content.category == 'Wellness' ? 'selected' : ''}>Wellness</option>
                                <option value="Self-Care" ${content.category == 'Self-Care' ? 'selected' : ''}>Self-Care</option>
                            </select>
                        </div>
                    </div>

                    <div id="videoSection" class="dynamic-section">
                        <span class="section-label"><i class="fas fa-video"></i> Video Configuration</span>
                        
                        <c:set var="videoSec" value="${(not empty content.videoSections) ? content.videoSections[0] : null}" />
                        
                        <input type="hidden" id="videoIdInput" value="${not empty videoSec ? videoSec.id : 0}">

                        <div class="form-group">
                            <label>YouTube Embed URL</label>
                            <input type="text" id="videoUrlInput" placeholder="e.g., https://www.youtube.com/embed/VIDEO_ID" 
                                   value="${not empty videoSec ? videoSec.videoUrl : ''}">
                            <small style="color: #95a5a6; margin-top: 5px; display: block;">Paste the full Embed URL from YouTube</small>
                        </div>
                        <div class="form-group">
                            <label>Video Description</label>
                            <textarea id="mainVideoDescription" name="mainVideoDescription" class="short" 
                                      placeholder="Enter a brief description for this video...">${not empty videoSec ? videoSec.description : ''}</textarea>
                        </div>
                    </div>

                    <div id="articleSection" class="dynamic-section">
                        <span class="section-label"><i class="fas fa-book-open"></i> Text Content Sections</span>

                        <div class="form-group">
                            <label>Section 1.0 Content</label>
                            
                            <c:set var="firstArticle" value="${(not empty content.articleSections) ? content.articleSections[0] : null}" />

                            <input type="hidden" id="articlePage1-id" value="${not empty firstArticle ? firstArticle.id : 0}">

                            <input type="text" id="articlePage1-subtitle" placeholder="Section 1.0 Subtitle" 
                                   style="margin-bottom: 10px;"
                                   value="${not empty firstArticle ? firstArticle.subtitle : ''}">
                            <textarea id="articlePage1" class="medium" placeholder="<p>Enter section content here...</p>">${not empty firstArticle ? firstArticle.body : ''}</textarea>
                        </div>

                        <div id="dynamicArticleContainer">
                            <c:forEach var="section" items="${content.articleSections}" varStatus="stat">
                                <c:if test="${stat.index > 0}">
                                    <div class="form-group article-dynamic-block">
                                        <input type="hidden" class="article-id" value="${section.id}">
                                        
                                        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom: 8px;">
                                            <label>Section ${stat.index + 1}.0 Content</label>
                                            <button type="button" class="btn-icon-action" onclick="this.closest('.form-group').remove(); reindexArticleSections()" title="Remove Section">
                                                <i class="fas fa-times"></i>
                                            </button>
                                        </div>
                                        <input type="text" class="article-dynamic-subtitle" value="${section.subtitle}" 
                                               style="margin-bottom: 10px;" placeholder="Section ${stat.index + 1}.0 Subtitle">
                                        <textarea class="medium article-dynamic-area">${section.body}</textarea>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>

                        <button type="button" class="btn-add-option" onclick="addArticleSection()">+ Add Section</button>
                    </div>

                    <div id="interactiveSection" class="dynamic-section">
                        <span class="section-label"><i class="fas fa-mouse-pointer"></i> Quiz Configuration</span>
                        
                        <c:set var="firstQuestion" value="${(not empty content.quizQuestions) ? content.quizQuestions[0] : null}" />

                        <div class="form-group">
                            <label>Study Material / Introduction</label>
                            <textarea id="interactiveContent" class="medium" placeholder="<h3>Introduction</h3><p>Enter the study material for this quiz...</p>">${not empty firstQuestion ? firstQuestion.introduction : ''}</textarea>
                        </div>

                        <div class="question-block" id="q1-block">
                            <label>Question 1</label>
                            
                            <input type="hidden" id="q1-id" value="${not empty firstQuestion ? firstQuestion.id : 0}">
                            
                            <input type="text" id="q1-text" placeholder="Enter question text"
                                   value="${not empty firstQuestion ? firstQuestion.questionText : ''}">
                            
                            <div class="options-container" id="q1-options">
                                <c:choose>
                                    <c:when test="${not empty firstQuestion and not empty firstQuestion.options}">
                                        <c:forEach var="option" items="${firstQuestion.options}" varStatus="optStat">
                                            <div class="option-row">
                                                <input type="hidden" class="option-id" value="${option.id}">
                                                <input type="radio" name="correct_q1" value="${optStat.index}" 
                                                       ${option.correct ? 'checked' : ''} title="Mark as correct answer">
                                                <input type="text" value="${option.optionText}" placeholder="Option ${optStat.index + 1}">
                                                <button type="button" class="btn-icon-action" onclick="removeOption(this)">
                                                    <i class="fas fa-times"></i>
                                                </button>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="option-row">
                                            <input type="radio" name="correct_q1" value="0" title="Mark as correct answer">
                                            <input type="text" placeholder="Option 1">
                                            <button type="button" class="btn-icon-action" onclick="removeOption(this)"><i class="fas fa-times"></i></button>
                                        </div>
                                        <div class="option-row">
                                            <input type="radio" name="correct_q1" value="1" title="Mark as correct answer">
                                            <input type="text" placeholder="Option 2">
                                            <button type="button" class="btn-icon-action" onclick="removeOption(this)"><i class="fas fa-times"></i></button>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <button type="button" class="btn-add-option" onclick="addOption('q1')">+ Add Answer Option</button>
                        </div>

                        <div id="dynamicQuizContainer">
                            <c:forEach var="question" items="${content.quizQuestions}" varStatus="qStat">
                                <c:if test="${qStat.index > 0}">
                                    <div class="question-block dynamic-question-block">
                                        <input type="hidden" class="question-id" value="${question.id}">
                                        
                                        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:10px;">
                                            <label style="margin:0;">Question ${qStat.index + 1}</label>
                                            <button type="button" class="btn-icon-action" onclick="this.closest('.question-block').remove(); reindexQuestions();" title="Remove Question">
                                                <i class="fas fa-times"></i>
                                            </button>
                                        </div>
                                        <input type="text" value="${question.questionText}" id="q${qStat.index + 1}-text" placeholder="Enter question text">
                                        
                                        <div class="options-container" id="q${qStat.index + 1}-options">
                                            <c:forEach var="option" items="${question.options}" varStatus="optStat">
                                                <div class="option-row">
                                                    <input type="hidden" class="option-id" value="${option.id}">
                                                    <input type="radio" name="correct_q${qStat.index + 1}" 
                                                           value="${optStat.index}" ${option.correct ? 'checked' : ''}>
                                                    <input type="text" value="${option.optionText}" placeholder="Option ${optStat.index + 1}">
                                                    <button type="button" class="btn-icon-action" onclick="removeOption(this)">
                                                        <i class="fas fa-times"></i>
                                                    </button>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <button type="button" class="btn-add-option" onclick="addOption('q${qStat.index + 1}')">+ Add Answer Option</button>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>

                        <button type="button" class="btn-add-option" onclick="addQuestion()">+ Add Question</button>
                    </div>

                    <div class="form-row">
                        <div class="col-third">
                            <label>Difficulty Level</label>
                            <select name="difficulty">
                                <option disabled value="" ${empty content.difficulty ? 'selected' : ''}>Select level</option>
                                <option value="Beginner" ${content.difficulty == 'Beginner' ? 'selected' : ''}>Beginner</option>
                                <option value="Intermediate" ${content.difficulty == 'Intermediate' ? 'selected' : ''}>Intermediate</option>
                                <option value="Advanced" ${content.difficulty == 'Advanced' ? 'selected' : ''}>Advanced</option>
                            </select>
                        </div>

                        <div class="col-third" id="durationGroup">
                            <label>Duration (minutes)</label>
                            <input type="number" name="duration" value="${content.duration}">
                        </div>

                        <div class="col-third">
                            <label>Points</label>
                            <input type="number" name="points" value="${content.points}">
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="button" class="btn-submit btn-save-draft" onclick="submitContent('draft')">
                            ${isEdit ? 'Update as Draft' : 'Save as Draft'}
                        </button>
                        <button type="button" class="btn-submit btn-publish" onclick="submitContent('published')">
                            ${isEdit ? 'Update & Publish' : 'Publish'}
                        </button>
                    </div>

                </form>
            </div>
        </div>

        <div class="sidebar-column">
            <div class="ai-card">
                <div class="ai-header">
                    <h3>Ask AI <i class="fas fa-robot" style="color:#00d2d3;"></i></h3>
                </div>
                <div class="ai-input-box">
                    <input type="text" placeholder="Generate quiz questions...">
                    <i class="fas fa-paper-plane"></i>
                </div>
            </div>
        </div>
    </div>

    <script>
        window.onload = function() {
            var select = document.getElementById('contentTypeSelect');
            if (select.value) {
                toggleContentType();
            } else {
                for(var i=0; i<select.options.length; i++) {
                    if(select.options[i].selected) { // Changed for JSP: standard DOM property
                        select.value = select.options[i].value;
                        toggleContentType();
                        break;
                    }
                }
            }
        };

        function toggleContentType() {
            var type = document.getElementById('contentTypeSelect').value;
            var videoSec = document.getElementById('videoSection');
            var articleSec = document.getElementById('articleSection');
            var interactiveSec = document.getElementById('interactiveSection');
            var durationGroup = document.getElementById('durationGroup');

            videoSec.style.display = 'none';
            articleSec.style.display = 'none';
            interactiveSec.style.display = 'none';
            durationGroup.style.visibility = 'visible';

            if(type === 'Video') {
                videoSec.style.display = 'block';
            }
            else if(type === 'Article') {
                articleSec.style.display = 'block';
                durationGroup.style.visibility = 'hidden';
            }
            else if(type === 'Interactive') {
                interactiveSec.style.display = 'block';
                durationGroup.style.visibility = 'hidden';
            }
        }

        // ==========================================
        // ARTICLE LOGIC
        // ==========================================
        function addArticleSection() {
            var container = document.getElementById('dynamicArticleContainer');
            // Simplified logic for JSP: just count the total blocks
            var totalSections = container.querySelectorAll('.article-dynamic-block').length;
            var nextSectionNum = totalSections + 2; // +1 for 0-index, +1 because static is Sec 1

            var div = document.createElement('div');
            div.className = 'form-group article-dynamic-block';
            div.innerHTML = `
                <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom: 8px;">
                    <label>Section ` + nextSectionNum + `.0 Content</label>
                    <button type="button" class="btn-icon-action" onclick="this.closest('.form-group').remove(); reindexArticleSections()" title="Remove Section"><i class="fas fa-times"></i></button>
                </div>
                <input type="text" class="article-dynamic-subtitle" placeholder="Section ` + nextSectionNum + `.0 Subtitle" style="margin-bottom: 10px;">
                <textarea class="medium article-dynamic-area" placeholder="<p>Enter section content here...</p>"></textarea>
            `;
            container.appendChild(div);
        }

        function reindexArticleSections() {
            var container = document.getElementById('dynamicArticleContainer');
            var groups = container.querySelectorAll('.article-dynamic-block');
            groups.forEach((group, index) => {
                var num = index + 2; 
                var label = group.querySelector('label');
                var subtitle = group.querySelector('.article-dynamic-subtitle');

                if(label) label.innerText = `Section ` + num + `.0 Content`;
                if(subtitle) subtitle.placeholder = `Section ` + num + `.0 Subtitle`;
            });
        }

        // ==========================================
        // QUIZ LOGIC
        // ==========================================
        function addQuestion() {
            var container = document.getElementById('dynamicQuizContainer');
            // Simplified logic for JSP: count total blocks
            var currentDynamicCount = container.querySelectorAll('.dynamic-question-block').length;
            var qNum = currentDynamicCount + 2; // +1 for existing static q1, +1 for new one
            var uniqueId = 'dq_' + Date.now();

            var div = document.createElement('div');
            div.className = 'question-block dynamic-question-block';
            div.id = uniqueId + '-block';
            div.innerHTML = `
                <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:10px;">
                    <label style="margin:0;">Question ` + qNum + `</label>
                    <button type="button" class="btn-icon-action" onclick="this.closest('.question-block').remove(); reindexQuestions();" title="Remove Question"><i class="fas fa-times"></i></button>
                </div>
                <input type="text" id="` + uniqueId + `-text" placeholder="Enter question text">
                <div class="options-container" id="` + uniqueId + `-options">
                    <div class="option-row">
                        <input type="radio" name="correct_` + uniqueId + `" value="0">
                        <input type="text" placeholder="Option 1">
                        <button type="button" class="btn-icon-action" onclick="removeOption(this)"><i class="fas fa-times"></i></button>
                    </div>
                    <div class="option-row">
                        <input type="radio" name="correct_` + uniqueId + `" value="1">
                        <input type="text" placeholder="Option 2">
                        <button type="button" class="btn-icon-action" onclick="removeOption(this)"><i class="fas fa-times"></i></button>
                    </div>
                </div>
                <button type="button" class="btn-add-option" onclick="addOption('` + uniqueId + `')">+ Add Answer Option</button>
            `;
            container.appendChild(div);
        }

        function reindexQuestions() {
            var container = document.getElementById('dynamicQuizContainer');
            var blocks = container.querySelectorAll('.dynamic-question-block');
            blocks.forEach((block, index) => {
                var num = index + 2;
                var label = block.querySelector('label');
                if(label) label.innerText = "Question " + num;
            });
        }

        function addOption(qId) {
            var container = document.getElementById(qId + '-options');
            var count = container.querySelectorAll('.option-row').length;

            var div = document.createElement('div');
            div.className = 'option-row';
            div.innerHTML = `
                <input type="radio" name="correct_` + qId + `" value="` + count + `">
                <input type="text" placeholder="Option ` + (count + 1) + `">
                <button type="button" class="btn-icon-action" onclick="removeOption(this)"><i class="fas fa-times"></i></button>
            `;
            container.appendChild(div);

            reindexOptions(qId);
        }

        function removeOption(btn) {
            var row = btn.parentNode;
            var container = row.parentNode;
            var qId = container.id.split('-')[0];

            container.removeChild(row);
            reindexOptions(qId);
        }

        function reindexOptions(qId) {
            var container = document.getElementById(qId + '-options');
            var rows = container.querySelectorAll('.option-row');
            rows.forEach((row, index) => {
                var radio = row.querySelector('input[type="radio"]');
                radio.value = index;
                var text = row.querySelector('input[type="text"]');
                text.placeholder = "Option " + (index + 1);
            });
        }

        function submitContent(status) {
            document.getElementById('statusInput').value = status;

            var title = document.querySelector('input[name="title"]').value;
            if(!title.trim()) {
                alert("Please enter a title.");
                return;
            }

            var type = document.getElementById('contentTypeSelect').value;
            var form = document.getElementById('createForm');

            function createHiddenInput(name, value) {
                var input = document.createElement('input');
                input.type = 'hidden';
                input.name = name;
                input.value = value;
                input.className = 'generated-input';
                form.appendChild(input);
            }

            // Clean up old generated inputs
            var oldInputs = document.querySelectorAll('.generated-input');
            oldInputs.forEach(el => el.remove());

            // --- ARTICLE LOGIC ---
            if(type === 'Article') {
                var sectionIndex = 0;

                // Process Section 1 (Static)
                var id1 = document.getElementById('articlePage1-id').value;
                var sub1 = document.getElementById('articlePage1-subtitle').value;
                var body1 = document.getElementById('articlePage1').value;

                createHiddenInput('articleSections[' + sectionIndex + '].id', id1);
                createHiddenInput('articleSections[' + sectionIndex + '].subtitle', sub1);
                createHiddenInput('articleSections[' + sectionIndex + '].body', body1);
                sectionIndex++;

                // Process Dynamic Sections
                var dynamicBlocks = document.querySelectorAll('.article-dynamic-block');
                dynamicBlocks.forEach(function(block) {
                    var idInput = block.querySelector('.article-id');
                    var idVal = idInput ? idInput.value : 0;

                    var sub = block.querySelector('.article-dynamic-subtitle').value;
                    var body = block.querySelector('.article-dynamic-area').value;

                    createHiddenInput('articleSections[' + sectionIndex + '].id', idVal);
                    createHiddenInput('articleSections[' + sectionIndex + '].subtitle', sub);
                    createHiddenInput('articleSections[' + sectionIndex + '].body', body);
                    sectionIndex++;
                });
            }

            // --- VIDEO LOGIC ---
            else if(type === 'Video') {
                var vidId = document.getElementById('videoIdInput').value;
                var videoUrl = document.getElementById('videoUrlInput').value;
                var videoDesc = document.getElementById('mainVideoDescription').value;
                
                if (!videoUrl.trim()) {
                    alert("Please enter a video URL.");
                    return;
                }
                
                createHiddenInput('videoSections[0].id', vidId);
                createHiddenInput('videoSections[0].videoUrl', videoUrl);
                createHiddenInput('videoSections[0].description', videoDesc);
            }

            // --- INTERACTIVE QUIZ LOGIC ---
            else if(type === 'Interactive') {
                var introContent = document.getElementById('interactiveContent').value;
                var qIndex = 0;
                
                function processQuizBlock(block, qTextElementId, qId) {
                    var qText = qTextElementId ? 
                                document.getElementById(qTextElementId).value : 
                                block.querySelector('input[type="text"]').value;

                    createHiddenInput('quizQuestions[' + qIndex + '].id', qId);
                    createHiddenInput('quizQuestions[' + qIndex + '].questionText', qText);

                    if (qIndex === 0) {
                        createHiddenInput('quizQuestions[' + qIndex + '].introduction', introContent);
                    }

                    var container = block.querySelector('.options-container');
                    var optionRows = container.querySelectorAll('.option-row');
                    
                    optionRows.forEach((row, oIndex) => {
                        var optIdInput = row.querySelector('.option-id');
                        var optId = optIdInput ? optIdInput.value : 0;

                        var optText = row.querySelector('input[type="text"]').value;
                        var isRadioChecked = row.querySelector('input[type="radio"]').checked;

                        createHiddenInput('quizQuestions[' + qIndex + '].options[' + oIndex + '].id', optId);
                        createHiddenInput('quizQuestions[' + qIndex + '].options[' + oIndex + '].optionText', optText);
                        createHiddenInput('quizQuestions[' + qIndex + '].options[' + oIndex + '].correct', isRadioChecked);
                    });

                    qIndex++;
                }

                // Process first question (Static)
                var q1Block = document.getElementById('q1-block');
                var q1Id = document.getElementById('q1-id').value;
                if(q1Block) processQuizBlock(q1Block, 'q1-text', q1Id);

                // Process dynamic questions
                var dynamicBlocks = document.querySelectorAll('.dynamic-question-block');
                dynamicBlocks.forEach(function(block) {
                    var idInput = block.querySelector('.question-id');
                    var qId = idInput ? idInput.value : 0;
                    processQuizBlock(block, null, qId);
                });
            }

            form.submit();
        }
    </script>
    
</body>
</html>