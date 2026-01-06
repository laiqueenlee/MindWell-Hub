<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MHP Resource Hub | Digital Mental Health Literacy Hub</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background-color: #f8fafb;
            height: 100vh;
            display: flex;
            flex-direction: column;
            color: #1a1a1a;
        }

        /* --- Header Styling --- */
        .page-header-strip {
            background-color: #fff;
            border-bottom: 1px solid #e5e7eb;
            width: 100%;
        }

        .header-inner-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 16px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .header-title h1 {
            font-size: 24px;
            font-weight: 700;
            color: #1a1a1a;
        }

        .header-title p {
            font-size: 14px;
            color: #666;
            margin-top: 2px;
        }

        /* --- Button Styling --- */
        .btn-back {
            display: inline-flex;
            align-items: center;
            padding: 8px 16px;
            background-color: white;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            color: #666;
            font-weight: 600;
            font-size: 14px;
            text-decoration: none;
            transition: all 0.2s;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }

        .btn-back:hover {
            border-color: #5dd5c3; 
            color: #5dd5c3;
            transform: translateY(-1px);
        }

        /* --- Chat Layout --- */
        .chat-container {
            flex: 1;
            display: flex;
            flex-direction: column;
            max-width: 900px;
            width: 100%;
            margin: 0 auto;
            padding: 24px 20px 0 20px;
            min-height: 0;
        }

        .assistant-header {
            background-color: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
            flex-shrink: 0;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }

        .assistant-icon {
            font-size: 24px;
            background: #e0f7f4;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
        }

        .assistant-info h2 {
            font-size: 16px;
            font-weight: 700;
            color: #1a1a1a;
        }

        .assistant-info p {
            font-size: 13px;
            color: #666;
        }

        .chat-box {
            flex: 1;
            display: flex;
            flex-direction: column;
            min-height: 0;
            overflow-y: auto;
            padding-bottom: 20px;
        }

        .chat-box::-webkit-scrollbar { width: 6px; }
        .chat-box::-webkit-scrollbar-track { background: transparent; }
        .chat-box::-webkit-scrollbar-thumb { background: #d1d5db; border-radius: 3px; }

        /* Empty State */
        .empty-state {
            text-align: center;
            margin: auto;
            padding: 40px;
        }

        .empty-icon { font-size: 48px; margin-bottom: 16px; opacity: 0.5; }
        
        .empty-text {
            font-size: 15px;
            color: #666;
            margin-bottom: 24px;
        }

        .suggestion {
            background-color: white;
            border: 1px solid #e5e7eb;
            border-radius: 24px;
            padding: 10px 20px;
            font-size: 14px;
            color: #1a1a1a;
            cursor: pointer;
            transition: all 0.2s;
            display: inline-block;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
            margin-bottom: 8px;
        }

        .suggestion:hover {
            border-color: #5dd5c3;
            color: #5dd5c3;
        }

        /* Messages */
        .chat-message {
            padding: 12px 16px;
            margin-bottom: 12px;
            border-radius: 12px;
            max-width: 80%;
            font-size: 15px;
            line-height: 1.5;
        }

        .bot-message {
            background-color: #fff;
            border: 1px solid #e5e7eb;
            align-self: flex-start;
            color: #1f2937;
            border-bottom-left-radius: 2px;
        }

        .user-message {
            background-color: #5dd5c3; 
            color: white;
            align-self: flex-end;
            border-bottom-right-radius: 2px;
            box-shadow: 0 1px 2px rgba(93, 213, 195, 0.3);
        }

        /* Input Area */
        .input-container {
            background-color: #fff;
            border-top: 1px solid #e5e7eb;
            padding: 20px 0;
            flex-shrink: 0;
        }

        .input-wrapper {
            max-width: 900px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .input-box {
            flex: 1;
            padding: 14px 20px;
            border-radius: 24px;
            border: 1px solid #e5e7eb;
            font-size: 15px;
            outline: none;
            background-color: #f9fafb;
            transition: all 0.2s;
        }

        .input-box:focus {
            border-color: #5dd5c3;
            background-color: white;
            box-shadow: 0 0 0 3px rgba(93, 213, 195, 0.1);
        }

        .send-button {
            background-color: #5dd5c3;
            color: white;
            border: none;
            border-radius: 50%;
            width: 44px;
            height: 44px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background-color 0.2s;
            box-shadow: 0 2px 4px rgba(93, 213, 195, 0.3);
        }

        .send-button:hover {
            background-color: #4cc4b3;
            transform: translateY(-1px);
        }

        .messages-area {
            display: none;
            flex-direction: column;
            width: 100%;
        }

        .messages-area.active { display: flex; }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/includes/mhp-navbar.jsp" />

    <div class="page-header-strip">
        <div class="header-inner-container">
            <div class="header-title">
                <h1>Welcome, Dr. <c:out value="${displayName}" default="Professional"/></h1>
                <p>MHP Clinical Decision Support</p>
            </div>
            
            <a href="#" class="btn-back" onclick="if(history.length>1){ history.back(); } else { window.location.href='${pageContext.request.contextPath}/dashboard-mhp'; } return false;">
                ← Exit Workspace
            </a>
        </div>
    </div>

    <div class="chat-container">
        <div class="assistant-header">
            <div class="assistant-icon">⚕️</div>
            <div class="assistant-info">
                <h2>AI MHP Case Assistant</h2>
                <p>Support tools for case management, session scheduling, and resource curation.</p>
            </div>
        </div>
        
        <div class="chat-box" id="chatBox">
            <div class="empty-state" id="emptyState">
                <div class="empty-icon">📂</div>
                <p class="empty-text">Select a professional task to begin</p>
                <div class="suggestion" onclick="fillPrompt('Identify resources for a student struggling with academic anxiety')">
                    Identify student resources
                </div>
                <br>
                <div class="suggestion" onclick="fillPrompt('Show AI-driven care suggestions for high-risk pattern students')">
                    View AI care suggestions
                </div>
            </div>

            <div class="messages-area" id="messagesArea">
            </div>
        </div>
    </div>

    <div class="input-container">
        <div class="input-wrapper">
            <input type="text" class="input-box" id="userMessage" placeholder="Search resources, summarize case notes, or manage sessions...">
            <button class="send-button" id="sendButton" onclick="sendMessage()">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <line x1="22" y1="2" x2="11" y2="13"></line>
                    <polygon points="22 2 15 22 11 13 2 9 22 2"></polygon>
                </svg>
            </button>
        </div>
    </div>

    <script>
        function fillPrompt(text) {
            document.getElementById("userMessage").value = text;
            document.getElementById("userMessage").focus();
        }

        function sendMessage() {
            var userMessage = document.getElementById("userMessage").value;
            if (userMessage.trim() === "") return;

            var emptyState = document.getElementById("emptyState");
            var messagesArea = document.getElementById("messagesArea");
            var chatBox = document.getElementById("chatBox");

            if (emptyState.style.display !== "none") {
                emptyState.style.display = "none";
                messagesArea.classList.add("active");
            }

            var userDiv = document.createElement("div");
            userDiv.classList.add("chat-message", "user-message");
            userDiv.textContent = userMessage;
            messagesArea.appendChild(userDiv);

            chatBox.scrollTop = chatBox.scrollHeight;
            document.getElementById("userMessage").value = "";

            var typingDiv = document.createElement("div");
            typingDiv.classList.add("chat-message", "bot-message");
            typingDiv.id = "typingIndicator";
            typingDiv.style.fontStyle = "italic";
            typingDiv.style.color = "#999";
            typingDiv.textContent = "Processing professional request...";
            messagesArea.appendChild(typingDiv);
            chatBox.scrollTop = chatBox.scrollHeight;

            setTimeout(function() {
                var indicator = document.getElementById("typingIndicator");
                if (indicator) indicator.remove();

                var botResponse = getBotResponse(userMessage);
                var botDiv = document.createElement("div");
                botDiv.classList.add("chat-message", "bot-message");
                botDiv.innerHTML = botResponse.replace(/\n/g, "<br>"); 
                messagesArea.appendChild(botDiv);

                chatBox.scrollTop = chatBox.scrollHeight;
            }, 1500);
        }

        // UPDATED MHP RESPONSES based on project requirements [cite: 51, 54, 56]
        function getBotResponse(message) {
            message = message.toLowerCase();
            
    
if (message.includes("article") || message.includes("research") || message.includes("read")) {
        return "<strong>MHP Clinical Article Database:</strong>\n\n" +
               "I found the following clinical resources for your review:\n\n" +
               "1. <strong>Strengthening Mental Health Response</strong>\n" +
               "   <em>Citation:</em> World Health Organization (WHO), 2022. \n" +
               "   <em>Origin:</em> <a href='https://www.who.int/news-room/fact-sheets/detail/mental-health-strengthening-our-response' target='_blank'>who.int</a>\n" +
               "   <em>Description:</em> A comprehensive overview of global mental health strategies, focusing on literacy as a tool to reduce the treatment gap and improve pathways to intervention. \n\n" +
               "2. <strong>Anxiety Disorders in Higher Education</strong>\n" +
               "   <em>Citation:</em> National Institute of Mental Health (NIMH), 2023. \n" +
               "   <em>Origin:</em> <a href='https://www.nimh.nih.gov/health/topics/anxiety-disorders' target='_blank'>nimh.nih.gov</a>\n" +
               "   <em>Description:</em> Research highlighting how academic pressures and social adjustments contribute to stress and anxiety among university students, emphasizing the need for targeted literacy programs. \n\n" +
               "Would you like to securely share these digital resources with your students? ";
    }

    // INTERACTIVE QUIZ WITH MULTIPLE QUESTIONS AND ANSWERS
    else if (message.includes("quiz") || message.includes("test") || message.includes("knowledge")) {
        return "<strong>Interactive Literacy Quiz Preview:</strong>\n\n" +
               "These modules ensure students grasp foundational concepts to reduce stigma:\n\n" +
               "<strong>Q1:</strong> Which feature allows students to share coping experiences anonymously? \n" +
               "   <em>Answer:</em> <strong>Peer Support Forums.</strong> \n\n" +
               "<strong>Q2:</strong> What is the primary purpose of self-assessment tools in the Hub? \n" +
               "   <em>Answer:</em> <strong>To help students recognize early symptoms of stress or anxiety.</strong> \n\n" +
               "<strong>Q3:</strong> How does the AI recommendation engine personalize the student experience? \n" +
               "   <em>Answer:</em> <strong>By suggesting content and tools based on individual needs and interactions.</strong> \n\n" +
               "Shall I assign these knowledge checks to your current student groups? ";
    }

    // VIDEO CONTENT WITH LINKS AND DESCRIPTIONS
    else if (message.includes("video") || message.includes("watch") || message.includes("simulation")) {
        return "<strong>Mental Health Educational Videos:</strong>\n\n" +
               "The following modules are designed for high engagement through simulations and infographics:\n\n" +
               "1. <strong>Recognizing Mental Health Symptoms</strong> \n" +
               "   <em>Link:</em> <a href='https://www.youtube.com/watch?v=DxIDKZHW3-E' target='_blank'>Watch Simulation</a>\n" +
               "   <em>Focus:</em> Identifying distress signals and early signs of depression. \n\n" +
               "2. <strong>Stress Management & Coping Strategies</strong> \n" +
               "   <em>Link:</em> <a href='https://www.youtube.com/watch?v=rkZl2gxZooM' target='_blank'>Watch Module</a>\n" +
               "   <em>Focus:</em> Practical techniques for handling academic and financial pressures. \n\n" +
               "These videos support a mobile-responsive design for accessible, on-demand learning.";
    }

    // DEFAULT MHP ASSISTANCE
    else {
        return "Welcome to the MHP Resource Workspace. I am here to assist with:\n" +
               "- <strong>Articles:</strong> Finding clinical literacy content with proper citations. \n" +
               "- <strong>Quizzes:</strong> Previewing interactive modules and knowledge checks. \n" +
               "- <strong>Videos:</strong> Curating simulation-based content for student engagement. \n\n" +
               "How would you like to assist your students today? ";
    }
}
        

        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById("userMessage").addEventListener("keypress", function(event) {
                if (event.key === "Enter") {
                    event.preventDefault();
                    sendMessage();
                }
            });
        });
    </script>
</body>
</html>