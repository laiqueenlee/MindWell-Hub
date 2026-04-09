<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sleep Hygiene Basics - MindWell</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root { --teal: #6fd7cc; --teal-dark: #3fb9a8; --bg: #f8fafb; --text: #2c3e50; }
        body { font-family: 'Georgia', serif;  background: var(--bg); color: #333; line-height: 1.8; padding: 20px; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 40px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        h1 { font-family: 'Segoe UI', sans-serif; color: #1a1a1a; font-size: 2.2rem; margin-bottom: 10px; }
        h2 { font-family: 'Segoe UI', sans-serif; color: var(--teal-dark); margin-top: 30px; }
        
        .header-meta { display: flex; justify-content: space-between; border-bottom: 1px solid #eee; padding-bottom: 20px; margin-bottom: 30px; font-family: 'Segoe UI', sans-serif; color: #7f8c8d; font-size: 0.9rem; }
        
        .checklist-card { background: #e8f9f7; border: 1px solid var(--teal); border-radius: 10px; padding: 25px; margin: 30px 0; }
        .checklist-item { display: flex; align-items: start; gap: 12px; margin-bottom: 10px; }
        .checklist-item i { color: var(--teal-dark); margin-top: 5px; }
        
        .highlight { background: linear-gradient(120deg, #e8f9f7 0%, #e8f9f7 100%); background-repeat: no-repeat; background-size: 100% 40%; background-position: 0 88%; }
        .btn-back { display: inline-flex; align-items: center; gap: 8px; text-decoration: none; color: #666; font-family: 'Segoe UI', sans-serif; font-weight: 600; margin-bottom: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <a href="javascript:history.back()" class="btn-back"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>

        <h1>Sleep Hygiene Basics: The Art of Rest</h1>
        <div class="header-meta">
            <span>By Clinical Team</span>
            <span><i class="far fa-clock"></i> 5 min read</span>
        </div>

        <p>We often treat sleep as a luxury rather than a necessity. However, quality sleep is the foundation of mental resilience. <span class="highlight">Sleep hygiene refers to the behavioral and environmental practice</span> developed in the late 1970s as a method to help people with mild to moderate insomnia.</p>

        <h2>Why Your Brain Needs Downtime</h2>
        <p>During sleep, your brain processes emotions, consolidates memories, and clears out toxins. Without it, our ability to regulate emotions plummets, leading to increased anxiety and irritability.</p>

        <div class="checklist-card">
            <h3 style="margin-top:0; font-family:'Segoe UI', sans-serif;">✅ The Golden Rules of Sleep</h3>
            <div class="checklist-item">
                <i class="fas fa-check"></i>
                <div><strong>Stick to a schedule:</strong> Go to bed and wake up at the same time every day, even on weekends.</div>
            </div>
            <div class="checklist-item">
                <i class="fas fa-check"></i>
                <div><strong>Digital Detox:</strong> Avoid screens (phones, laptops) for at least 60 minutes before bed. Blue light suppresses melatonin.</div>
            </div>
            <div class="checklist-item">
                <i class="fas fa-check"></i>
                <div><strong>Control the Environment:</strong> Keep your room cool, dark, and quiet.</div>
            </div>
        </div>

        <h2>The "20-Minute Rule"</h2>
        <p>If you haven’t fallen asleep after 20 minutes, don’t stay in bed tossing and turning. Get up and do something relaxing in low light—like reading a physical book or stretching—until you feel sleepy again.</p>
    </div>
</body>
</html>