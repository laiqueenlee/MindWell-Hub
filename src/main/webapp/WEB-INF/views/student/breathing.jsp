<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Breathing Exercises - MindWell</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root { --teal: #6fd7cc; --teal-dark: #3fb9a8; --bg: #e0f7f4; --text: #2c3e50; }
        body { font-family: 'Segoe UI', sans-serif; background: var(--bg); color: var(--text); display: flex; flex-direction: column; align-items: center; justify-content: center; height: 100vh; margin: 0; }
        
        .app-container { text-align: center; width: 100%; max-width: 500px; padding: 20px; }
        .header { margin-bottom: 40px; }
        .header h1 { color: var(--teal-dark); margin-bottom: 5px; }
        
        .circle-container { position: relative; width: 250px; height: 250px; margin: 0 auto 40px; }
        .circle {
            background: linear-gradient(180deg, #6fd7cc 0%, #3fb9a8 100%);
            width: 100%; height: 100%;
            border-radius: 50%;
            position: absolute; left: 0; top: 0;
            z-index: 1;
            transform: scale(0.6);
            box-shadow: 0 0 40px rgba(111, 215, 204, 0.4);
        }
        
        .instruction-text {
            position: absolute;
            top: 50%; left: 50%;
            transform: translate(-50%, -50%);
            z-index: 2;
            color: white;
            font-size: 1.5rem;
            font-weight: bold;
            pointer-events: none;
        }

        .circle.inhale { animation: grow 4s ease-in-out forwards; }
        .circle.hold { animation: pulse 4s infinite; } 
        .circle.exhale { animation: shrink 8s ease-in-out forwards; }

        @keyframes grow { from { transform: scale(0.6); } to { transform: scale(1.1); } }
        @keyframes shrink { from { transform: scale(1.1); } to { transform: scale(0.6); } }
        @keyframes pulse { 0% { transform: scale(1.1); } 50% { transform: scale(1.08); } 100% { transform: scale(1.1); } }

        .btn-control {
            background: white; color: var(--text); border: none;
            padding: 15px 40px; border-radius: 30px;
            font-size: 1.1rem; font-weight: 600;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            cursor: pointer; transition: 0.2s;
        }
        .btn-control:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(0,0,0,0.15); }
        .btn-back { position: absolute; top: 20px; left: 20px; text-decoration: none; color: var(--teal-dark); font-weight: bold; }
    </style>
</head>
<body>
    <a href="javascript:history.back()" class="btn-back"><i class="fas fa-arrow-left"></i> Exit</a>

    <div class="app-container">
        <div class="header">
            <h1>4-7-8 Breathing</h1>
            <p>Relax your nervous system. Follow the circle.</p>
        </div>

        <div class="circle-container">
            <div class="circle" id="breathingCircle"></div>
            <div class="instruction-text" id="instruction">Ready?</div>
        </div>

        <button class="btn-control" id="startBtn" onclick="startBreathing()">Start Exercise</button>
    </div>

    <script>
        const circle = document.getElementById('breathingCircle');
        const text = document.getElementById('instruction');
        const btn = document.getElementById('startBtn');
        let isRunning = false;

        function startBreathing() {
            if(isRunning) return;
            isRunning = true;
            btn.style.opacity = '0.5';
            btn.innerText = "Focus...";
            
            runCycle();
            setInterval(runCycle, 19000); 
        }

        function runCycle() {
            text.innerText = "Inhale...";
            circle.className = 'circle inhale';

            setTimeout(() => {
                text.innerText = "Hold";
                circle.className = 'circle hold';

                setTimeout(() => {
                    text.innerText = "Exhale...";
                    circle.className = 'circle exhale';
                }, 7000);

            }, 4000);
        }
    </script>
</body>
</html>