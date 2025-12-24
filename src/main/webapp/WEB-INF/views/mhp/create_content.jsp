<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Edit Content' : 'Create Content'} - HealthHub MHP</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background-color: #ffffff; color: #333; }
        .main-layout { display: flex; gap: 40px; max-width: 1400px; margin: 0 auto; padding: 40px 60px; }
        .content-column { flex: 3; }
        .sidebar-column { flex: 1; }
        .page-header { margin-bottom: 25px; }
        .page-header h1 { font-size: 1.8rem; color: #2c3e50; margin-bottom: 5px; }
        .page-header p { color: #95a5a6; font-size: 0.9rem; }
        .btn-header-action { background-color: #00d2d3; color: white; padding: 10px 20px; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; float: right; font-size: 0.9rem; text-decoration: none; }
        .tabs { display: flex; gap: 10px; margin-bottom: 30px; }
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

        /* --- NEW STYLES FOR DYNAMIC SECTIONS --- */
        .dynamic-section { display: none; background: #f9f9f9; padding: 20px; border-radius: 8px; border: 1px dashed #ddd; margin-bottom: 20px; }
        .section-label { font-size: 0.85rem; text-transform: uppercase; letter-spacing: 1px; color: #00d2d3; margin-bottom: 10px; display: block; font-weight: 700; }
        
        /* Quiz Specific Styles */
        .question-block { background: #fff; padding: 15px; border: 1px solid #eee; border-radius: 8px; margin-bottom: 15px; }
        .question-block h4 { margin-bottom: 10px; color: #2c3e50; font-size: 1rem; }
        .options-container { margin-top: 10px; padding-left: 10px; border-left: 2px solid #00d2d3; }
        .option-row { display: flex; align-items: center; gap: 10px; margin-bottom: 8px; }
        .option-row input[type="radio"] { width: auto; cursor: pointer; accent-color: #00d2d3; }
        .option-row input[type="text"] { flex: 1; padding: 8px; font-size: 0.9rem; }
        .btn-icon-action { background: none; border: none; color: #e74c3c; cursor: pointer; font-size: 1rem; }
        .btn-add-option { background: none; border: 1px dashed #00d2d3; color: #00d2d3; padding: 5px 10px; border-radius: 4px; cursor: pointer; font-size: 0.85rem; margin-top: 5px; }
        .btn-add-option:hover { background: #e0fbfb; }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/includes/mhp-navbar.jsp" />
    <div class="main-layout">
        <div class="content-column">
            
            <div class="page-header">
                <a href="${pageContext.request.contextPath}/mhp/content" class="btn-header-action">
                     <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
                <h1>Content Management</h1>
                <p>Create and manage educational content</p>
            </div>

            <div class="tabs">
                <button class="tab-btn" onclick="window.location.href='${pageContext.request.contextPath}/mhp/content'">My Content</button>
                <button class="tab-btn active">${isEdit ? 'Edit Content' : 'Create New'}</button>
                <button class="tab-btn">Analytics</button>
            </div>

            <div class="form-card">
                <div class="form-title">${isEdit ? 'Edit Content' : 'Create New Content'}</div>
                <span class="form-subtitle">${isEdit ? 'Update your existing content details below' : 'Share your expertise with students'}</span>

                <!-- FORM START -->
                <form action="${pageContext.request.contextPath}/mhp/save-content" method="post" id="createForm">
                    
                    <!-- HIDDEN FIELDS -->
                    <input type="hidden" name="id" value="${content.id}">
                    <input type="hidden" name="status" id="statusInput" value="${content.status != null ? content.status : 'draft'}">
                    
                    <!-- This hidden field will collect data from the dynamic fields before submit -->
                    <textarea name="contentBody" id="realContentBody" style="display:none;">${content.contentBody}</textarea>

                    <!-- Title -->
                    <div class="form-group">
                        <label>Title</label>
                        <input type="text" name="title" placeholder="Enter content title" required value="${content.title}">
                    </div>

                    <!-- Type & Category Row -->
                    <div class="form-row">
                        <div class="col-half">
                            <label>Content Type</label>
                            <select name="contentType" id="contentTypeSelect" onchange="toggleContentType()" required>
                                <option disabled ${content.type == null ? 'selected' : ''} value="">Select type</option>
                                <option value="Video" ${content.type == 'Video' ? 'selected' : ''}>Video</option>
                                <option value="Article" ${content.type == 'Article' ? 'selected' : ''}>Article</option>
                                <option value="Interactive" ${content.type == 'Interactive' ? 'selected' : ''}>Interactive Quiz</option>
                            </select>
                        </div>
                        <div class="col-half">
                            <label>Category</label>
                            <select name="category" required>
                                <option disabled ${content.category == null ? 'selected' : ''} value="">Select category</option>
                                <option value="Stress Management" ${content.category == 'Stress Management' ? 'selected' : ''}>Stress Management</option>
                                <option value="Mental Health" ${content.category == 'Mental Health' ? 'selected' : ''}>Mental Health</option>
                                <option value="Wellness" ${content.category == 'Wellness' ? 'selected' : ''}>Wellness</option>
                                <option value="Self-Care" ${content.category == 'Self-Care' ? 'selected' : ''}>Self-Care</option>
                            </select>
                        </div>
                    </div>

                    <!-- Description -->
                    <div class="form-group">
                        <label>Description (Subtitle)</label>
                        <textarea name="description" class="short" placeholder="Brief description of the content">${content.description}</textarea>
                    </div>

                    <!-- === DYNAMIC CONTENT SECTIONS === -->

                    <!-- 1. VIDEO SECTION -->
                    <div id="videoSection" class="dynamic-section">
                        <span class="section-label"><i class="fas fa-video"></i> Video Configuration</span>
                        <div class="form-group">
                            <label>YouTube Embed URL</label>
                            <input type="text" id="videoUrlInput" placeholder="e.g., https://www.youtube.com/embed/VIDEO_ID" value="">
                            <small style="color: #95a5a6; margin-top: 5px; display: block;">Paste the full Embed URL from YouTube</small>
                        </div>
                    </div>

                    <!-- 2. ARTICLE SECTION (1.0, 2.0, 3.0) -->
                    <div id="articleSection" class="dynamic-section">
                        <span class="section-label"><i class="fas fa-book-open"></i> Text Content Sections</span>
                        <div class="form-group">
                            <label>Section 1.0 Content</label>
                            <textarea id="articlePage1" class="medium" placeholder="<h3>1.1 Intro</h3><p>Text here...</p>"></textarea>
                        </div>
                        <div class="form-group">
                            <label>Section 2.0 Content</label>
                            <textarea id="articlePage2" class="medium" placeholder="<h3>2.1 Details</h3><p>Text here...</p>"></textarea>
                        </div>
                        <div class="form-group">
                            <label>Section 3.0 (Conclusion)</label>
                            <textarea id="articlePage3" class="short" placeholder="<h3>Conclusion</h3><p>Wrap up...</p>"></textarea>
                        </div>
                    </div>

                    <!-- 3. INTERACTIVE SECTION -->
                    <div id="interactiveSection" class="dynamic-section">
                        <span class="section-label"><i class="fas fa-mouse-pointer"></i> Quiz Configuration</span>
                        
                        <!-- Single Content Area for Interactive Type -->
                        <div class="form-group">
                            <label>Study Material / Introduction</label>
                            <textarea id="interactiveContent" class="medium" placeholder="<h3>Introduction</h3><p>Enter the study material for this quiz...</p>"></textarea>
                        </div>

                        <!-- Question 1 -->
                        <div class="question-block" id="q1-block">
                            <label>Question 1</label>
                            <input type="text" id="q1-text" placeholder="Enter question text">
                            <div class="options-container" id="q1-options">
                                <!-- Default Options -->
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
                            </div>
                            <button type="button" class="btn-add-option" onclick="addOption('q1')">+ Add Answer Option</button>
                        </div>

                        <!-- Question 2 -->
                        <div class="question-block" id="q2-block">
                            <label>Question 2</label>
                            <input type="text" id="q2-text" placeholder="Enter question text">
                            <div class="options-container" id="q2-options">
                                <div class="option-row">
                                    <input type="radio" name="correct_q2" value="0">
                                    <input type="text" placeholder="Option 1">
                                    <button type="button" class="btn-icon-action" onclick="removeOption(this)"><i class="fas fa-times"></i></button>
                                </div>
                                <div class="option-row">
                                    <input type="radio" name="correct_q2" value="1">
                                    <input type="text" placeholder="Option 2">
                                    <button type="button" class="btn-icon-action" onclick="removeOption(this)"><i class="fas fa-times"></i></button>
                                </div>
                            </div>
                            <button type="button" class="btn-add-option" onclick="addOption('q2')">+ Add Answer Option</button>
                        </div>

                        <!-- Question 3 -->
                        <div class="question-block" id="q3-block">
                            <label>Question 3</label>
                            <input type="text" id="q3-text" placeholder="Enter question text">
                            <div class="options-container" id="q3-options">
                                <div class="option-row">
                                    <input type="radio" name="correct_q3" value="0">
                                    <input type="text" placeholder="Option 1">
                                    <button type="button" class="btn-icon-action" onclick="removeOption(this)"><i class="fas fa-times"></i></button>
                                </div>
                                <div class="option-row">
                                    <input type="radio" name="correct_q3" value="1">
                                    <input type="text" placeholder="Option 2">
                                    <button type="button" class="btn-icon-action" onclick="removeOption(this)"><i class="fas fa-times"></i></button>
                                </div>
                            </div>
                            <button type="button" class="btn-add-option" onclick="addOption('q3')">+ Add Answer Option</button>
                        </div>

                    </div>

                    <!-- Bottom Row (Settings) -->
                    <div class="form-row">
                        <div class="col-third">
                            <label>Difficulty Level</label>
                            <select name="difficulty">
                                <option disabled ${content.difficulty == null ? 'selected' : ''}>Select level</option>
                                <option value="Beginner" ${content.difficulty == 'Beginner' ? 'selected' : ''}>Beginner</option>
                                <option value="Intermediate" ${content.difficulty == 'Intermediate' ? 'selected' : ''}>Intermediate</option>
                                <option value="Advanced" ${content.difficulty == 'Advanced' ? 'selected' : ''}>Advanced</option>
                            </select>
                        </div>
                        
                        <!-- Duration (Hidden if Article OR Interactive) -->
                        <div class="col-third" id="durationGroup">
                            <label>Duration (minutes)</label>
                            <input type="number" name="duration" value="${content.duration != 0 ? content.duration : 15}">
                        </div>
                        
                        <div class="col-third">
                            <label>Points</label>
                            <input type="number" name="points" value="${content.points != 0 ? content.points : 10}">
                        </div>
                    </div>

                    <!-- Actions -->
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
            toggleContentType();
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

        // --- NEW: Dynamic Option Logic ---
        function addOption(qId) {
            var container = document.getElementById(qId + '-options');
            var count = container.querySelectorAll('.option-row').length;
            
            var div = document.createElement('div');
            div.className = 'option-row';
            div.innerHTML = `
                <input type="radio" name="correct_${qId}" value="${count}">
                <input type="text" placeholder="Option ${count + 1}">
                <button type="button" class="btn-icon-action" onclick="removeOption(this)"><i class="fas fa-times"></i></button>
            `;
            container.appendChild(div);
            
            // Re-index radio values to ensure they match array index
            reindexOptions(qId);
        }

        function removeOption(btn) {
            var row = btn.parentNode;
            var container = row.parentNode;
            var qId = container.id.split('-')[0]; // Extract 'q1' from 'q1-options'
            
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

            // === DATA PREPARATION BEFORE SUBMIT ===
            var type = document.getElementById('contentTypeSelect').value;
            var finalBody = "";

            if(type === 'Video') {
                finalBody = document.getElementById('videoUrlInput').value;
            } 
            else if(type === 'Article') {
                var p1 = document.getElementById('articlePage1').value;
                var p2 = document.getElementById('articlePage2').value;
                var p3 = document.getElementById('articlePage3').value;
                finalBody = "<!--PAGE_1-->" + p1 + "<!--PAGE_2-->" + p2 + "<!--PAGE_3-->" + p3;
            } 
            else if(type === 'Interactive') {
                // Collect Single Content Page
                var content = document.getElementById('interactiveContent').value;
                
                // Collect Dynamic Quiz Data
                var quizData = [];
                
                // Loop through Questions 1, 2, 3
                ['q1', 'q2', 'q3'].forEach((qId, index) => {
                    var qText = document.getElementById(qId + '-text').value;
                    if(qText.trim()) {
                        var container = document.getElementById(qId + '-options');
                        var optionRows = container.querySelectorAll('.option-row');
                        var optionsArr = [];
                        var correctIdx = -1;

                        optionRows.forEach((row, i) => {
                            var textVal = row.querySelector('input[type="text"]').value;
                            var isChecked = row.querySelector('input[type="radio"]').checked;
                            
                            if(textVal.trim()) {
                                optionsArr.push(textVal);
                                if(isChecked) correctIdx = i;
                            }
                        });

                        quizData.push({
                            id: index + 1,
                            question: qText,
                            options: optionsArr,
                            correctIndex: correctIdx
                        });
                    }
                });
                
                var quizJson = JSON.stringify(quizData);
                
                // Combine Text + Quiz Data
                finalBody = "<!--PAGE_1-->" + content + "<!--QUIZ_DATA-->" + quizJson;
            } else {
                finalBody = document.getElementById('realContentBody').value; 
            }

            document.getElementById('realContentBody').value = finalBody;
            document.getElementById('createForm').submit();
        }
    </script>
</body>
</html>