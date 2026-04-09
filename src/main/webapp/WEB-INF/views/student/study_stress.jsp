<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Managing Study Stress - MindWell</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root { --teal: #6fd7cc; --teal-dark: #3fb9a8; --bg: #f8fafb; --text: #2c3e50; }
        body { font-family: 'Segoe UI', sans-serif; background: var(--bg); color: var(--text); margin: 0; padding: 20px; }
        .container { max-width: 900px; margin: 0 auto; background: white; padding: 30px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .btn-back { display: inline-flex; align-items: center; gap: 8px; text-decoration: none; color: #666; font-weight: 600; margin-bottom: 20px; }
        .btn-back:hover { color: var(--teal-dark); }
        
        .video-wrapper { position: relative; padding-bottom: 56.25%; height: 0; border-radius: 12px; overflow: hidden; background: #000; margin-bottom: 25px; }
        .video-wrapper iframe { position: absolute; top: 0; left: 0; width: 100%; height: 100%; border: 0; }
        .meta-tags { display: flex; gap: 15px; font-size: 0.9rem; color: #7f8c8d; margin-bottom: 15px; }
        .tag { background: #eef6f5; padding: 4px 10px; border-radius: 4px; color: var(--teal-dark); font-weight: 600; }
        .takeaways { background: #f9f9f9; padding: 20px; border-left: 4px solid var(--teal); border-radius: 0 8px 8px 0; margin-top: 20px; }
        .btn-complete { background: var(--teal); color: white; border: none; padding: 12px 24px; border-radius: 8px; font-size: 1rem; cursor: pointer; float: right; transition: 0.2s; }
        .btn-complete:hover { background: var(--teal-dark); }
    </style>
</head>
<body>
    <div class="container">
        <a href="javascript:history.back()" class="btn-back"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
        
        <div class="meta-tags">
            <span class="tag"><i class="fas fa-video"></i> Video Module</span>
            <span><i class="far fa-clock"></i> 15 min</span>
        </div>

        <h1>Managing Study Stress & Burnout</h1>
        <p class="subtitle">Learn practical techniques to maintain balance during exam season.</p>

        <div class="video-wrapper">
            <iframe src="https://www.youtube.com/embed/dQw4w9WgXcQ?autoplay=0" allowfullscreen></iframe>
        </div>

        <h3>Description</h3>
        <p>Academic pressure is one of the leading causes of anxiety among students. In this session, Dr. Mitchell explains the physiology of stress and introduces the "Pomodoro Plus" technique for breaking study sessions into manageable chunks.</p>

        <div class="takeaways">
            <h4>💡 Key Takeaways</h4>
            <ul>
                <li>Stress is a natural response, but chronic stress hinders memory retention.</li>
                <li>Take a 5-minute movement break every 25 minutes.</li>
                <li>Prioritize "Active Recall" over passive reading.</li>
            </ul>
        </div>

        <div style="margin-top: 30px; overflow: hidden;">
            <button class="btn-complete" onclick="alert('Module marked as complete!')">
                <i class="fas fa-check-circle"></i> Mark as Complete
            </button>
        </div>
    </div>
</body>
</html>