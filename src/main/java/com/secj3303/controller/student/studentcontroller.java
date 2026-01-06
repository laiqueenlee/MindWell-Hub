package com.secj3303.controller.student;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.secj3303.dao.AssessmentDao;
import com.secj3303.dao.ContentDao;
import com.secj3303.dao.ContentProgressDao;
import com.secj3303.dao.ForumPostDao;
import com.secj3303.dao.ForumReplyDao;
import com.secj3303.model.Assessment;
import com.secj3303.model.ForumPost;
import com.secj3303.model.ForumReply;
import com.secj3303.model.RecentActivity;
import com.secj3303.model.User;

@Controller
@RequestMapping("/student")
public class studentcontroller {
    @Autowired
    private ContentProgressDao contentProgressDao;
    @Autowired
    private ContentDao contentDao;
    @Autowired
    private ForumPostDao forumPostDao;
    @Autowired
    private ForumReplyDao forumReplyDao;
    @Autowired
    private AssessmentDao assessmentDao;

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

        // Fetch forum posts count for the logged-in user
        long userForumPostsCount = forumPostDao.countByAuthorId(Long.valueOf(loggedInUser.getId()));
        model.addAttribute("forumPosts", userForumPostsCount);

        // Fetch recent activities within the last week
        LocalDateTime oneWeekAgo = LocalDateTime.now().minus(7, ChronoUnit.DAYS);
        List<RecentActivity> recentActivities = new ArrayList<>();

        // Get recent assessments
        List<Assessment> recentAssessments = assessmentDao.findRecentByUsername(loggedInUser.getUsername(), oneWeekAgo);
        for (Assessment assessment : recentAssessments) {
            String desc = "Completed " + capitalizeFirst(assessment.getAssessmentType()) + " Assessment";
            recentActivities.add(new RecentActivity(desc, assessment.getCompletedAt(), "assessment"));
        }

        // Get recent forum posts
        List<ForumPost> recentPosts = forumPostDao.findRecentByAuthorId(Long.valueOf(loggedInUser.getId()), oneWeekAgo);
        for (ForumPost post : recentPosts) {
            String desc = "Posted in Support Forum: \"" + truncate(post.getTitle(), 30) + "\"";
            recentActivities.add(new RecentActivity(desc, post.getCreatedAt(), "post"));
        }

        // Get recent forum replies
        List<ForumReply> recentReplies = forumReplyDao.findRecentByAuthorId(Long.valueOf(loggedInUser.getId()), oneWeekAgo);
        for (ForumReply reply : recentReplies) {
            String desc = "Replied in Forum Discussion";
            recentActivities.add(new RecentActivity(desc, reply.getCreatedAt(), "reply"));
        }

        // Sort by timestamp descending and limit to 5 most recent
        recentActivities.sort(Comparator.comparing(RecentActivity::getTimestamp).reversed());
        if (recentActivities.size() > 5) {
            recentActivities = recentActivities.subList(0, 5);
        }

        model.addAttribute("recentActivities", recentActivities);

        // Render the student homepage
        return "/student/home";  // => /WEB-INF/views/student/home.jsp
    }

    private String capitalizeFirst(String str) {
        if (str == null || str.isEmpty()) return str;
        return str.substring(0, 1).toUpperCase() + str.substring(1);
    }

    private String truncate(String str, int length) {
        if (str == null) return "";
        return str.length() > length ? str.substring(0, length) + "..." : str;
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

    @GetMapping("/chatbot")
    public String showChatbotPage(Model model) {
        // Serve the static chatbot JSP; remove server-side AI invocation.
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

