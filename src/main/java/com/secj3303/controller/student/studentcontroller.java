package com.secj3303.controller.student;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.beans.factory.annotation.Autowired; 

import com.secj3303.dao.ContentDao;
import com.secj3303.dao.ContentProgressDao;
import com.secj3303.model.ChatbotModel;
import com.secj3303.model.User;

@Controller
@RequestMapping("/student")
public class studentcontroller {
    @Autowired
    private ContentProgressDao contentProgressDao;
    @Autowired
    private ContentDao contentDao;

    // --- STUDENT HOME PAGE (GET) ---
    @GetMapping("/home")
    public String showStudentHomePage(Model model, HttpSession session) {
        // Retrieve the logged-in user from the session
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            // If no user is logged in, redirect to the login page
            return "redirect:/auth/login";
        }

        // Add the logged-in user to the model
        model.addAttribute("user", loggedInUser);

        // In StudentController.java inside showStudentHomePage()

        //Calculate average of APPROVED content from DAO
        Double rawAvg = contentProgressDao.getUserAverageProgress(loggedInUser.getId());
        int progressVal = (int) Math.round(rawAvg);

        model.addAttribute("overallProgress", progressVal);

        long completedCount = contentProgressDao.countCompletedContent(loggedInUser.getId());
        long totalContentCount = contentDao.countByStatus("Published");
        String modulesString = completedCount + "/" + totalContentCount;

        model.addAttribute("learningModulesCompleted", modulesString);

        // Render the student homepage
        return "/student/home";  // => /WEB-INF/views/student/home.jsp
    }

    // --- STUDENT PROFILE PAGE (GET) ---
    @GetMapping("/profile")
    public String showStudentProfilePage(Model model, HttpSession session) {

        // Retrieve the logged-in user from the session
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            // If no user is logged in, redirect to the login page
            return "redirect:/auth/login";
        }

        // Add the logged-in user details to the model
        model.addAttribute("user", loggedInUser);

        // Render the student profile page
        return "/student/profile";  // => /WEB-INF/views/student/profile.jsp
    }

    // --- STUDENT DASHBOARD PAGE (GET) ---
    @GetMapping("/dashboard")
    public String showStudentDashboardPage(Model model, HttpSession session) {

        // Retrieve the logged-in user from the session
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            // If no user is logged in, redirect to the login page
            return "redirect:/auth/login";
        }

        // Add the logged-in user and other necessary data to the model
        model.addAttribute("user", loggedInUser);

        // Render the student dashboard page
        return "/student/dashboard"; // => /WEB-INF/views/student/dashboard.jsp
    }

    // --- STUDENT LOGOUT (GET) ---
    @GetMapping("/logout")
    public String studentLogout(HttpSession session) {
        session.invalidate();  // Invalidate the session to log out
        return "redirect:/auth/login";  // Redirect to the login page
    }

    // --- NEW POST PAGE (GET) ---
    // @GetMapping("/new-post")
    // public String showNewPostPage(Model model) {
    // Add model attributes if needed
    // return "/student/new-post"; // Resolves to
    // /WEB-INF/views/student/new-post.jsp
    // }

    // Redirect student-scoped forum route to the central ForumController
    // @GetMapping("/forum")
    // public String showForumPage(Model model) {
    // return "redirect:/forum";
    // }

    private ChatbotModel chatbotModel = new ChatbotModel();

    @GetMapping("/chatbot")
    public String showChatbotPage(Model model) {
        // Static data for chatbot responses
        model.addAttribute("chatbotResponses", chatbotModel.getResponse("default"));
        return "/student/chatbot"; 
    }

    // Method to handle sending messages (in the case of dynamic user input)
    @PostMapping("/chatbot")
    public String handleUserMessage(@RequestParam("userMessage") String userMessage, Model model) {
        // Get the chatbot response based on user message
        String botResponse = chatbotModel.getResponse(userMessage);

        model.addAttribute("chatbotResponses", botResponse);
        return "/student/chatbot";
    }

    // ... inside StudentController class ...

    // Mapping for Study Stress Page
    @GetMapping("/content/study-stress")
    public String showStudyStressPage(Model model, HttpSession session) {
        // Security check (optional but recommended)
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/auth/login";
        }

        // Return the path to the JSP (without .jsp extension)
        // This assumes your JSP is at /WEB-INF/views/student/study_stress.jsp
        return "student/study_stress"; 
    }
    // Mapping for Sleep Hygiene Page
    @GetMapping("/content/sleep-hygiene")
    public String showSleepHygienePage(Model model, HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/auth/login";
        }
        return "student/sleep_hygiene"; 
    }

    // Mapping for Breathing Exercise Page
    @GetMapping("/content/breathing")
    public String showBreathingPage(Model model, HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/auth/login";
        }
        return "student/breathing"; 
    }
}

