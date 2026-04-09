<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>General Wellbeing Assessment - MindWell</title>
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
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        * { box-sizing: border-box; }
        body { margin: 0; font-family: Inter, "Segoe UI", Roboto, Arial, sans-serif; background: var(--page-bg); color: #123; line-height: 1.5; }
        .page { max-width: 600px; margin: 0 auto; padding: 40px 20px; }
        .back-button { display: inline-flex; align-items: center; gap: 8px; color: var(--teal-dark); text-decoration: none; font-weight: 600; margin-bottom: 30px; }
        .header { margin-bottom: 30px; animation: fadeInDown 0.5s ease-out; }
        .header h1 { font-size: 28px; font-weight: 700; color: #123; margin: 0; }
        .header p { color: var(--muted); font-size: 14px; margin: 8px 0 0 0; }
        .card { background: var(--card-bg); border-radius: var(--radius); padding: 30px; box-shadow: var(--shadow); animation: fadeInUp 0.5s ease-out; }
        .progress-container { margin-bottom: 30px; display: flex; justify-content: space-between; align-items: center; gap: 10px; }
        .progress-bar { flex-grow: 1; height: 6px; background: #eef6f5; border-radius: 6px; overflow: hidden; }
        .progress-fill { height: 100%; background: linear-gradient(90deg, var(--teal), var(--teal-dark)); width: 20%; transition: width 0.3s ease; }
        .progress-text { color: var(--muted); font-size: 12px; font-weight: 600; }
        .question-container { margin-bottom: 30px; }
        .question-title { font-size: 16px; font-weight: 700; color: #123; margin-bottom: 16px; }
        .options { display: grid; gap: 10px; }
        .option { position: relative; }
        .option input[type="radio"] { position: absolute; opacity: 0; cursor: pointer; }
        .option-label { display: flex; align-items: center; padding: 14px 16px; background: #fbfffe; border: 2px solid #eef6f5; border-radius: 10px; cursor: pointer; transition: var(--transition); font-weight: 500; }
        .option input[type="radio"]:checked + .option-label { background: var(--teal-light); border-color: var(--teal-dark); color: var(--teal-dark); }
        .option-label::before { content: ''; width: 18px; height: 18px; border: 2px solid var(--muted); border-radius: 50%; margin-right: 12px; transition: var(--transition); }
        .option input[type="radio"]:checked + .option-label::before { background: var(--teal-dark); border-color: var(--teal-dark); box-shadow: inset 0 0 0 2px #fff; }
        .option-label:hover { background: var(--teal-light); border-color: var(--teal); }
        .buttons { display: flex; gap: 12px; margin-top: 30px; }
        .btn { flex: 1; padding: 12px 20px; border-radius: 8px; border: none; cursor: pointer; transition: var(--transition); font-weight: 600; font-size: 14px; }
        .btn-primary { background: linear-gradient(180deg, var(--teal), var(--teal-dark)); color: #fff; }
        .btn-secondary { background: #fff; border: 2px solid var(--teal); color: var(--teal-dark); }
        .privacy-notice { background: #f0f9f9; border-left: 4px solid var(--teal); padding: 14px; border-radius: 8px; font-size: 12px; color: var(--muted); margin-top: 20px; }
        @keyframes fadeInUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes fadeInDown { from { opacity: 0; transform: translateY(-20px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>
<div class="page">
    <a href="${pageContext.request.contextPath}/student/assessment/" class="back-button">← Back</a>
    <div class="header"><h1>✓ General Wellbeing</h1><p>Comprehensive assessment of your mental wellness</p></div>
    <div class="card">
        <div class="progress-container"><div class="progress-bar"><div class="progress-fill"></div></div><span class="progress-text" id="progressText">1/5</span></div>
        <form id="assessmentForm" action="${pageContext.request.contextPath}/student/assessment/submit" method="post">
            <input type="hidden" name="assessmentType" value="wellbeing">
            <div class="question-container" data-question="1">
                <div class="question-title">How is your physical health?</div>
                <div class="options">
                    <div class="option"><input type="radio" id="q1_1" name="q1" value="5" required><label for="q1_1" class="option-label">Excellent - No health concerns</label></div>
                    <div class="option"><input type="radio" id="q1_2" name="q1" value="4"><label for="q1_2" class="option-label">Good - Minor issues only</label></div>
                    <div class="option"><input type="radio" id="q1_3" name="q1" value="3"><label for="q1_3" class="option-label">Fair - Some health concerns</label></div>
                    <div class="option"><input type="radio" id="q1_4" name="q1" value="2"><label for="q1_4" class="option-label">Poor - Multiple health issues</label></div>
                    <div class="option"><input type="radio" id="q1_5" name="q1" value="1"><label for="q1_5" class="option-label">Very Poor - Serious health concerns</label></div>
                </div>
            </div>
            <div class="question-container" data-question="2" style="display:none;">
                <div class="question-title">How is your mental health?</div>
                <div class="options">
                    <div class="option"><input type="radio" id="q2_1" name="q2" value="5"><label for="q2_1" class="option-label">Excellent - Feeling great</label></div>
                    <div class="option"><input type="radio" id="q2_2" name="q2" value="4"><label for="q2_2" class="option-label">Good - Doing well</label></div>
                    <div class="option"><input type="radio" id="q2_3" name="q2" value="3"><label for="q2_3" class="option-label">Fair - Managing okay</label></div>
                    <div class="option"><input type="radio" id="q2_4" name="q2" value="2"><label for="q2_4" class="option-label">Poor - Struggling</label></div>
                    <div class="option"><input type="radio" id="q2_5" name="q2" value="1"><label for="q2_5" class="option-label">Very Poor - In crisis</label></div>
                </div>
            </div>
            <div class="question-container" data-question="3" style="display:none;">
                <div class="question-title">How satisfied are you with your life?</div>
                <div class="options">
                    <div class="option"><input type="radio" id="q3_1" name="q3" value="5"><label for="q3_1" class="option-label">Very satisfied</label></div>
                    <div class="option"><input type="radio" id="q3_2" name="q3" value="4"><label for="q3_2" class="option-label">Satisfied</label></div>
                    <div class="option"><input type="radio" id="q3_3" name="q3" value="3"><label for="q3_3" class="option-label">Neutral</label></div>
                    <div class="option"><input type="radio" id="q3_4" name="q3" value="2"><label for="q3_4" class="option-label">Dissatisfied</label></div>
                    <div class="option"><input type="radio" id="q3_5" name="q3" value="1"><label for="q3_5" class="option-label">Very dissatisfied</label></div>
                </div>
            </div>
            <div class="question-container" data-question="4" style="display:none;">
                <div class="question-title">Do you feel a sense of purpose?</div>
                <div class="options">
                    <div class="option"><input type="radio" id="q4_1" name="q4" value="5"><label for="q4_1" class="option-label">Strongly - Clear direction</label></div>
                    <div class="option"><input type="radio" id="q4_2" name="q4" value="4"><label for="q4_2" class="option-label">Mostly - Fairly clear</label></div>
                    <div class="option"><input type="radio" id="q4_3" name="q4" value="3"><label for="q4_3" class="option-label">Somewhat - Unclear</label></div>
                    <div class="option"><input type="radio" id="q4_4" name="q4" value="2"><label for="q4_4" class="option-label">Weak - Very unclear</label></div>
                    <div class="option"><input type="radio" id="q4_5" name="q4" value="1"><label for="q4_5" class="option-label">Not at all - Lost</label></div>
                </div>
            </div>
            <div class="question-container" data-question="5" style="display:none;">
                <div class="question-title">How are your relationships?</div>
                <div class="options">
                    <div class="option"><input type="radio" id="q5_1" name="q5" value="5"><label for="q5_1" class="option-label">Excellent - Strong connections</label></div>
                    <div class="option"><input type="radio" id="q5_2" name="q5" value="4"><label for="q5_2" class="option-label">Good - Healthy relationships</label></div>
                    <div class="option"><input type="radio" id="q5_3" name="q5" value="3"><label for="q5_3" class="option-label">Fair - Some tension</label></div>
                    <div class="option"><input type="radio" id="q5_4" name="q5" value="2"><label for="q5_4" class="option-label">Poor - Strained</label></div>
                    <div class="option"><input type="radio" id="q5_5" name="q5" value="1"><label for="q5_5" class="option-label">Very Poor - Broken relationships</label></div>
                </div>
            </div>
            <div class="buttons">
                <button type="button" class="btn btn-secondary" id="prevBtn" onclick="prevQuestion()" style="display:none;">← Previous</button>
                <button type="button" class="btn btn-primary" id="nextBtn" onclick="nextQuestion()">Next →</button>
            </div>
            <div class="privacy-notice">🔒 Your responses are completely private and secure.</div>
        </form>
    </div>
</div>
<script>
    let currentQuestion = 1;
    const totalQuestions = 5;
    const answersArray = new Array(totalQuestions).fill(null);

    function updateUI() {
        const progressPercent = (currentQuestion / totalQuestions) * 100;
        document.querySelector('.progress-fill').style.width = progressPercent + '%';
        document.getElementById('progressText').textContent = currentQuestion + '/' + totalQuestions;

        document.querySelectorAll('.question-container').forEach((q, index) => {
            if (index + 1 === currentQuestion) {
                q.style.display = 'block';
            } else {
                q.style.display = 'none';
            }
        });

        document.getElementById('prevBtn').style.display = currentQuestion > 1 ? 'block' : 'none';
        document.getElementById('nextBtn').textContent = currentQuestion === totalQuestions ? 'Submit' : 'Next →';
        document.getElementById('nextBtn').style.background = currentQuestion === totalQuestions 
            ? 'linear-gradient(180deg, #28a745, #1e8449)' 
            : 'linear-gradient(180deg, var(--teal), var(--teal-dark))';
    }

    function nextQuestion() {
        console.log('nextQuestion called, currentQuestion:', currentQuestion);
        
        const currentQuestionContainer = document.querySelector('.question-container[data-question="' + currentQuestion + '"]');
        console.log('currentQuestionContainer:', currentQuestionContainer);
        
        if (!currentQuestionContainer) {
            alert('Error: Could not find current question container');
            return;
        }
        
        const selected = currentQuestionContainer.querySelector('input[name="q' + currentQuestion + '"]:checked');
        console.log('selected:', selected);
        
        if (!selected) {
            alert('Please select an answer before proceeding.');
            return;
        }

        answersArray[currentQuestion - 1] = selected.value;

        if (currentQuestion === totalQuestions) {
            submitAssessment();
        } else {
            currentQuestion++;
            updateUI();
            window.scrollTo(0, 0);
        }
    }

    function submitAssessment() {
        const form = document.getElementById('assessmentForm');
        console.log('submitAssessment called');
        
        form.querySelectorAll('input[name="answer"]').forEach(el => el.remove());
        form.querySelectorAll('input[name="answers"]').forEach(el => el.remove());
        
        const collectedAnswers = [];
        for (let i = 1; i <= totalQuestions; i++) {
            const selected = document.querySelector('input[name="q' + i + '"]:checked');
            console.log('Question', i, 'selected:', selected);
            if (selected) {
                collectedAnswers.push(selected.value);
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'answers';
                input.value = selected.value;
                form.appendChild(input);
                console.log('Added answer:', selected.value);
            } else {
                console.log('No answer found for question', i);
            }
        }
        
        console.log('All collected answers:', collectedAnswers);
        console.log('Form data before submit:', new FormData(form));
        
        form.submit();
    }

    function prevQuestion() {
        if (currentQuestion > 1) {
            currentQuestion--;
            updateUI();
            window.scrollTo(0, 0);
        }
    }

    document.addEventListener('keydown', function(e) {
        if (e.key === 'Enter') {
            nextQuestion();
        } else if (e.key === 'ArrowRight') {
            nextQuestion();
        } else if (e.key === 'ArrowLeft') {
            prevQuestion();
        }
    });

    updateUI();

    console.log('Assessment page loaded. Total questions:', totalQuestions);
</script>
</body>
</html>
