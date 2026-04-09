<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${module.title} - HealthHub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background-color: #ffffff; color: #333; padding: 40px; }
        .container { max-width: 1000px; margin: 0 auto; }
        
        .hidden { display: none; }

        .module-header { margin-bottom: 30px; }
        .module-header h1 { font-size: 2rem; color: #2c3e50; font-weight: 700; margin-bottom: 10px; }
        .module-header p { color: #95a5a6; font-size: 0.95rem; }

        .progress-section { margin-bottom: 25px; }
        .progress-labels { display: flex; justify-content: space-between; margin-bottom: 8px; font-size: 0.9rem; color: #7f8c8d; font-weight: 600; }
        .progress-track { width: 100%; background-color: #ecf0f1; border-radius: 10px; height: 10px; overflow: hidden; }
        .progress-fill { height: 100%; background-color: #1abc9c; border-radius: 10px; transition: width 0.5s ease; }

        .tabs-container { display: flex; gap: 10px; margin-bottom: 20px; }
        .tab { padding: 8px 30px; border-radius: 6px; font-weight: 600; font-size: 0.9rem; cursor: default; background-color: #f8f9fa; color: #95a5a6; }
        .tab.active { background-color: #ffffff; color: #333; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        a.tab { text-decoration: none; } 

        .content-card { background: #ffffff; border: 1px solid #e0e0e0; border-radius: 12px; padding: 40px; box-shadow: 0 4px 20px rgba(0,0,0,0.04); margin-bottom: 30px; }
        .content-card h3 { font-size: 1.25rem; color: #2c3e50; margin-top: 25px; margin-bottom: 15px; font-weight: 700; }
        .content-card h3:first-child { margin-top: 0; }
        .content-card p { color: #7f8c8d; line-height: 1.6; margin-bottom: 15px; font-size: 1rem; }
        
        .video-wrapper { position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; border-radius: 12px; background-color: #000; margin-bottom: 25px; }
        .video-wrapper iframe { position: absolute; top: 0; left: 0; width: 100%; height: 100%; border: 0; }

        .question-block { margin-bottom: 30px; padding-bottom: 20px; border-bottom: 1px solid #f0f0f0; }
        .question-block:last-child { border-bottom: none; }
        .question-text { font-size: 1.1rem; font-weight: 600; color: #2c3e50; margin-bottom: 15px; }
        .options-list { list-style: none; }
        .option-item { margin-bottom: 10px; }
        .option-label { display: flex; align-items: center; cursor: pointer; padding: 10px 15px; border-radius: 8px; border: 1px solid #e0e0e0; transition: background-color 0.2s; }
        .option-label:hover { background-color: #f9f9f9; }
        .option-label input[type="radio"] { margin-right: 15px; accent-color: #00d2d3; transform: scale(1.2); }
        
        #resultContainer { display: none; margin-top: 20px; padding: 20px; border-radius: 8px; text-align: center; font-weight: bold; }
        .success-score { background-color: #d1fae5; color: #065f46; border: 1px solid #a7f3d0; }
        .fail-score { background-color: #fee2e2; color: #991b1b; border: 1px solid #fecaca; }

        .action-buttons { display: flex; justify-content: space-between; gap: 20px; }
        .btn { flex: 1; padding: 15px; border-radius: 8px; font-size: 0.9rem; font-weight: 600; text-align: center; cursor: pointer; text-decoration: none; transition: opacity 0.2s; border: none; }
        .btn:hover { opacity: 0.9; }
        .btn-save { background-color: #1abc9c; color: white; }
        .btn-continue { background-color: #00d2d3; color: white; }
        
        .modal-overlay { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); z-index: 1000; justify-content: center; align-items: center; }
        .modal-box { background: white; padding: 30px; border-radius: 12px; text-align: center; box-shadow: 0 4px 20px rgba(0,0,0,0.2); max-width: 400px; width: 90%; animation: fadeIn 0.3s ease; }
        .modal-icon { font-size: 3rem; color: #1abc9c; margin-bottom: 15px; }
        .modal-title { font-size: 1.25rem; font-weight: 700; color: #2c3e50; margin-bottom: 10px; }
        .modal-btn { background-color: #1abc9c; color: white; border: none; padding: 10px 24px; border-radius: 6px; font-weight: 600; cursor: pointer; margin-top: 15px; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }

        .rating-container { display: flex; justify-content: center; gap: 10px; margin: 20px 0; }
        .star { font-size: 2rem; color: #dcdde1; cursor: pointer; transition: color 0.2s; }
        .star:hover, .star.selected { color: #f1c40f; } /* Gold */
        .btn-skip { background: transparent; color: #95a5a6; border: none; font-size: 0.9rem; cursor: pointer; margin-top: 10px; text-decoration: underline; }
    </style>
</head>
<body>

    <div class="container">
        
        <div class="module-header">
            <h1>${module.title}</h1>
            <p>${module.description}</p>
        </div>

        <div class="progress-section">
            <div class="progress-labels">
                <span>Course Progress</span>
                <span id="progress-text">${progressPercent}%</span>
            </div>
            <div class="progress-track">
                <div class="progress-fill" id="progress-bar" style="width: 0%;"></div>
            </div>
        </div>

        <c:if test="${module.type == 'Article'}">
    
            <div class="tabs-container">
                <c:forEach var="section" items="${module.articleSections}" varStatus="stat">
                    <div id="tab-header-${stat.index}"
                         class="tab ${stat.first ? 'active' : ''}"
                         data-index="${stat.index}"
                         onclick="openArticleSection(this.dataset.index)"
                         style="cursor: pointer;">
                        ${stat.count}.0
                    </div>
                </c:forEach>
            </div>

            <c:forEach var="section" items="${module.articleSections}" varStatus="stat">
                <div id="article-content-${stat.index}"
                     class="content-card article-section-view ${stat.first ? '' : 'hidden'}">
                
                    <h3>${section.subtitle}</h3>
                    <div>${section.body}</div>
                </div>
            </c:forEach>

            <div class="action-buttons">
                <a href="#" onclick="saveArticleProgress(event)" class="btn btn-save">Save Progress & Leave</a>
                
                <button type="button" 
                        id="btn-article-continue"
                        class="btn btn-continue" 
                        onclick="nextArticleSection()">
                    Continue On
                </button>
            </div>
        </c:if>

        <c:if test="${module.type == 'Video'}">
            <div class="tabs-container">
                <div class="tab active">Video Lesson</div>
            </div>

            <c:choose>
                <c:when test="${not empty module.videoSections}">
                    <div class="content-card">
                        <div class="video-wrapper">
                           <iframe 
       id="videoFrame"
       src="${module.videoSections[0].videoUrl}" 
       title="YouTube video player" 
       frameborder="0" 
       allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
       referrerpolicy="strict-origin-when-cross-origin" 
       allowfullscreen>
    </iframe>
                        </div>
                        
                        <div class="video-info">
                            <h3>About this Video</h3>
                            <p>${module.videoSections[0].description}</p>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="content-card">
                        <p>No video content available.</p>
                    </div>
                </c:otherwise>
            </c:choose>

            <div class="action-buttons">
                <a href="#" onclick="saveFixedProgress(event, 50)" class="btn btn-save">Save Progress & Leave</a>
                <button type="button" class="btn btn-continue" onclick="openRatingModal()">Mark as Complete</button>
            </div>
        </c:if>

        <c:if test="${module.type == 'Interactive'}">
            <div class="tabs-container">
                <div class="tab active" id="tab-content" onclick="switchQuizTab('content')">Content</div>
                <div class="tab" id="tab-assessment" onclick="startQuiz()">Quiz Assessment</div>
            </div>

            <div id="view-content">
                <div class="content-card">
                    <h3>Introduction</h3>
                    
                    <c:choose>
                        <c:when test="${not empty module.quizQuestions}">
                            <div>${module.quizQuestions[0].introduction}</div>
                        </c:when>
                        <c:otherwise>
                            <p style="color:#95a5a6; font-style:italic;">
                                No introduction content available for this module.
                            </p>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="action-buttons">
                    <a href="#" onclick="saveFixedProgress(event, 50)" class="btn btn-save">Save Progress & Leave</a>
                    <button type="button" class="btn btn-continue" onclick="startQuiz()">Start Quiz Assessment</button>
                </div>
            </div>

            <form id="quizForm" action="${pageContext.request.contextPath}/student/module/submit-quiz" method="post" style="display:none;">
                <input type="hidden" name="contentId" value="${module.id}">
                <input type="hidden" name="answers" id="hidden-answers">

                <div class="content-card">
                    
                    <c:forEach var="q" items="${module.quizQuestions}" varStatus="qStat">
                        <div class="question-block" id="qblock-${qStat.index}">
                            <div class="question-text">${qStat.count}. ${q.questionText}</div>
                            
                            <ul class="options-list">
                                <c:forEach var="opt" items="${q.options}" varStatus="optStat">
                                    <li class="option-item">
                                        <label class="option-label">
                                            <input type="radio" 
                                                   name="question_${q.id}" 
                                                   value="${optStat.index}" 
                                                   data-is-correct="${opt.correct}"
                                                   class="quiz-radio">
                                            <span>${opt.optionText}</span>
                                        </label>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:forEach>
                    <div id="resultContainer"></div>
                </div>

                <div class="action-buttons" id="quiz-action-buttons">
                    <a href="#" onclick="saveFixedProgress(event, 80)" class="btn btn-save">Save Progress & Leave</a>
                    <button type="button" class="btn btn-continue" onclick="validateAndSubmitQuiz()">Submit Answers</button>
                </div>
            </form>
        </c:if>

    </div>

    <form id="progressForm" action="${pageContext.request.contextPath}/student/module/save-progress" method="post" style="display:none;">
        <input type="hidden" name="contentId" value="${module.id}">
        <input type="hidden" id="form-percent" name="percent" value="${progressPercent}">
        <input type="hidden" id="form-pageIndex" name="pageIndex" value="0">
    </form>

    <form id="ratingForm" action="${pageContext.request.contextPath}/student/module/submit-rating" method="post" style="display:none;">
        <input type="hidden" name="contentId" value="${module.id}">
        <input type="hidden" id="form-rating" name="rating" value="0">
        <input type="hidden" id="rating-pageIndex" name="pageIndex" value="0">
    </form>

    <div id="saveModal" class="modal-overlay">
        <div class="modal-box">
            <div class="modal-icon"><i class="fas fa-check-circle"></i></div>
            <div class="modal-title">Progress Saved!</div>
            <p style="color:#7f8c8d;">Your learning progress has been securely saved.</p>
            <button class="modal-btn" onclick="submitProgressForm()">Return to Modules</button>
        </div>
    </div>

    <div id="ratingModal" class="modal-overlay">
        <div class="modal-box">
            <div class="modal-icon" style="color: #f1c40f;"><i class="fas fa-star"></i></div>
            <div class="modal-title">Module Complete!</div>
            <p style="color:#7f8c8d;">How helpful was this content?</p>
            
            <div class="rating-container">
                <i class="fas fa-star star" onclick="selectStar(1)" id="star-1"></i>
                <i class="fas fa-star star" onclick="selectStar(2)" id="star-2"></i>
                <i class="fas fa-star star" onclick="selectStar(3)" id="star-3"></i>
                <i class="fas fa-star star" onclick="selectStar(4)" id="star-4"></i>
                <i class="fas fa-star star" onclick="selectStar(5)" id="star-5"></i>
            </div>
            
            <input type="hidden" id="selectedRating" value="0">
            
            <button class="modal-btn" onclick="submitRatingForm()">Submit Rating</button>
        </div>
    </div>

    <script>
    const dbPercent = Number("${not empty progressPercent ? progressPercent : 0}");
    const savedPageIndex = Number("${not empty lastPage ? lastPage : 0}");
    const totalSections = Number("${fn:length(module.articleSections)}");
    
    const contentType = "${module.type}"; 
    const savedAnswers = "${not empty savedQuizAnswers ? savedQuizAnswers : ''}"; 
    const contentId = Number("${module.id}");

    let currentCalculatedPercent = dbPercent;
    let currentSectionIndex = 0;

    window.onload = function() {
        updateProgressUI(dbPercent); 
var iframe = document.getElementById('videoFrame');
        if (iframe) {
            var rawUrl = iframe.getAttribute('src');
            
            var regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
            var match = rawUrl.match(regExp);

            if (match && match[2].length === 11) {
                var videoId = match[2];
                var embedUrl = "https://www.youtube.com/embed/" + videoId;
                
                if (rawUrl !== embedUrl) {
                    iframe.setAttribute('src', embedUrl);
                }
            }
        }
        if(contentType === 'Article' && totalSections > 0) {
            if (dbPercent === 100) {
                openArticleSection(totalSections - 1);
            } else {
                let indexToOpen = (typeof savedPageIndex === 'number') ? savedPageIndex : 0;
                openArticleSection(indexToOpen);
            }
        }

        if(contentType === 'Interactive') {
            if (dbPercent >= 100) {
                switchQuizTab('assessment');
                populateAndGradeQuiz();
            } else if (dbPercent >= 80) {
                switchQuizTab('assessment');
                updateProgressUI(80);
            } else {
                switchQuizTab('content');
            }
        }
    };

    function submitProgressForm() {
        document.getElementById('form-percent').value = currentCalculatedPercent;
        document.getElementById('form-pageIndex').value = currentSectionIndex; 
        document.getElementById('progressForm').submit();
    }

    function submitRatingForm() {
        const rating = document.getElementById('selectedRating').value;
        if(rating == 0) {
            alert("Please select a star rating to proceed.");
            return;
        }
        document.getElementById('form-rating').value = rating;
        document.getElementById('rating-pageIndex').value = currentSectionIndex;
        document.getElementById('ratingForm').submit();
    }

    function openRatingModal() {
        document.getElementById('ratingModal').style.display = 'flex';
    }

    function showSaveModal(e) {
        if(e) e.preventDefault();
        document.getElementById('saveModal').style.display = 'flex';
    }

    function selectStar(rating) {
        document.getElementById('selectedRating').value = rating;
        for (let i = 1; i <= 5; i++) {
            const star = document.getElementById('star-' + i);
            if (i <= rating) star.classList.add('selected');
            else star.classList.remove('selected');
        }
    }

    function updateProgressUI(percent) {
        currentCalculatedPercent = percent;
        let fill = document.getElementById('progress-bar');
        let label = document.getElementById('progress-text');
        
        if(fill) fill.style.width = percent + '%';
        if(label) label.innerText = percent + '%';
    }

    function saveFixedProgress(e, percent) {
        e.preventDefault();
        currentCalculatedPercent = percent;
        showSaveModal(null);
    }

    function saveArticleProgress(e) {
        e.preventDefault();
        let percent = Math.round(((currentSectionIndex + 1) / totalSections) * 100);
        currentCalculatedPercent = percent;
        showSaveModal(null);
    }

    function openArticleSection(indexStr) {
        const index = Number(indexStr); 
        currentSectionIndex = index;

        document.querySelectorAll('.article-section-view').forEach(el => el.classList.add('hidden'));
        document.querySelectorAll('.tabs-container .tab').forEach(el => el.classList.remove('active'));

        const contentEl = document.getElementById('article-content-' + index);
        const tabEl = document.getElementById('tab-header-' + index);
        
        if(contentEl) contentEl.classList.remove('hidden');
        if(tabEl) tabEl.classList.add('active');

        updateContinueButtonState();
        
        let percent = Math.round(((currentSectionIndex + 1) / totalSections) * 100);
        updateProgressUI(percent);
    }

    function nextArticleSection() {
        if (currentSectionIndex < totalSections - 1) {
            openArticleSection(currentSectionIndex + 1);
        } else {
            currentCalculatedPercent = 100;
            openRatingModal(); 
        }
    }

    function updateContinueButtonState() {
        const btn = document.getElementById('btn-article-continue');
        if (!btn) return;

        if (currentSectionIndex < totalSections - 1) {
            btn.innerText = "Continue On";
            btn.setAttribute('onclick', 'nextArticleSection()');
        } else {
            btn.innerText = "Finish Module"; 
        }
    }

    function startQuiz() {
        switchQuizTab('assessment');
        updateProgressUI(80);
    }

    function switchQuizTab(tabName) {
        const tabContent = document.getElementById('tab-content');
        const tabAssessment = document.getElementById('tab-assessment');
        const viewContent = document.getElementById('view-content');
        const quizForm = document.getElementById('quizForm');

        tabContent.classList.remove('active');
        tabAssessment.classList.remove('active');
        
        if (tabName === 'content') {
            tabContent.classList.add('active');
            viewContent.style.display = 'block';
            quizForm.style.display = 'none';
            currentSectionIndex = 0;
        } else {
            tabAssessment.classList.add('active');
            viewContent.style.display = 'none';
            quizForm.style.display = 'block';
            currentSectionIndex = 1;
        }
    }

    function validateAndSubmitQuiz() {
        let questions = document.querySelectorAll('.question-block');
        if(questions.length === 0) return; 

        let collectedAnswers = [];
        let allAnswered = true;

        for (let i = 0; i < questions.length; i++) {
            let block = document.getElementById('qblock-' + i);
            let selectedOption = block.querySelector('input[type="radio"]:checked');
            
            if (!selectedOption) {
                allAnswered = false;
                collectedAnswers.push("-1"); 
            } else {
                collectedAnswers.push(selectedOption.value);
            }
        }

        if (!allAnswered) {
            alert("Please answer all questions before submitting.");
            return;
        }

        document.getElementById('hidden-answers').value = collectedAnswers.join(",");
        document.getElementById('quizForm').submit();
    }

   function populateAndGradeQuiz() {
        if (!savedAnswers) return;

        let answersArr = savedAnswers.split(",");
        let questions = document.querySelectorAll('.question-block');
        let correctCount = 0;
        let totalQuestions = questions.length;

        for (let i = 0; i < totalQuestions; i++) {
            let block = document.getElementById('qblock-' + i);
            let userAnsIndex = parseInt(answersArr[i]);
            let radios = block.querySelectorAll('input[type="radio"]');
            let selectedRadio = radios[userAnsIndex];

            radios.forEach(r => r.disabled = true);

            if (selectedRadio) {
                selectedRadio.checked = true;
                let isCorrect = selectedRadio.getAttribute('data-is-correct') === 'true';

                if (isCorrect) {
                    correctCount++;
                    selectedRadio.parentElement.style.backgroundColor = '#d1fae5'; 
                    selectedRadio.parentElement.style.borderColor = '#34d399';
                } else {
                    selectedRadio.parentElement.style.backgroundColor = '#fee2e2'; 
                    selectedRadio.parentElement.style.borderColor = '#f87171';
                }
            }
        }

        let resultDiv = document.getElementById("resultContainer");
        resultDiv.style.display = "block";
        let percentage = (correctCount / totalQuestions) * 100;
        
        if (percentage >= 50) {
            resultDiv.className = "success-score";
            resultDiv.innerHTML = "Great job! You scored " + correctCount + "/" + totalQuestions + " (" + percentage.toFixed(0) + "%).";
        } else {
            resultDiv.className = "fail-score";
            resultDiv.innerHTML = "You scored " + correctCount + "/" + totalQuestions + ".";
        }

        let btnContainer = document.getElementById('quiz-action-buttons');
        const contextPath = '${pageContext.request.contextPath}';

        btnContainer.innerHTML = `
            <form action="` + contextPath + `/student/module/reset-quiz" method="post" style="flex: 1;">
                <input type="hidden" name="contentId" value="${module.id}">
                <button type="submit" class="btn" style="background-color: #95a5a6; color: white; width: 100%;">
                    <i class="fas fa-redo"></i> Retake Quiz
                </button>
            </form>
            
            <button type="button" class="btn btn-continue" style="flex: 1;" onclick="openRatingModal()">
                Mark as Complete <i class="fas fa-check"></i>
            </button>
        `;
    }
    </script>

</body>
</html>