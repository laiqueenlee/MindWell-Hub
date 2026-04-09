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
import com.secj3303.dao.VirtualSessionDao;
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
    @Autowired
    private VirtualSessionDao virtualSessionDao;


    @GetMapping("/home")
    public String showStudentHomePage(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }

        model.addAttribute("user", loggedInUser);
        model.addAttribute("sessions", virtualSessionDao.findByStudentId(loggedInUser.getId()));


        Double rawAvg = contentProgressDao.getUserAverageProgress(loggedInUser.getId());
        int progressVal = (int) Math.round(rawAvg);

        model.addAttribute("overallProgress", progressVal);

        long completedCount = contentProgressDao.countCompletedContent(loggedInUser.getId());
        long totalContentCount = contentDao.countByStatus("Published");
        String modulesString = completedCount + "/" + totalContentCount;

        model.addAttribute("learningModulesCompleted", modulesString);

        long userForumPostsCount = forumPostDao.countByAuthorId(Long.valueOf(loggedInUser.getId()));
        model.addAttribute("forumPosts", userForumPostsCount);

        List<Assessment> allAssessments = assessmentDao.findByUsername(loggedInUser.getUsername());
        int completedAssessmentsCount = allAssessments.size();
        model.addAttribute("completedAssessments", completedAssessmentsCount);

        int wellnessScore = 0; // Default
        if (!allAssessments.isEmpty()) {
            int totalScore = 0;
            for (Assessment assessment : allAssessments) {
                totalScore += assessment.getScore();
            }
            double averageScore = (double) totalScore / allAssessments.size();
            wellnessScore = (int) Math.round((averageScore / 25.0) * 100);
        }
        model.addAttribute("wellnessScore", wellnessScore);

        LocalDateTime oneWeekAgo = LocalDateTime.now().minus(7, ChronoUnit.DAYS);
        List<RecentActivity> recentActivities = new ArrayList<>();

        List<Assessment> recentAssessments = assessmentDao.findRecentByUsername(loggedInUser.getUsername(), oneWeekAgo);
        for (Assessment assessment : recentAssessments) {
            String desc = "Completed " + capitalizeFirst(assessment.getAssessmentType()) + " Assessment";
            recentActivities.add(new RecentActivity(desc, assessment.getCompletedAt(), "assessment"));
        }

        List<ForumPost> recentPosts = forumPostDao.findRecentByAuthorId(Long.valueOf(loggedInUser.getId()), oneWeekAgo);
        for (ForumPost post : recentPosts) {
            String desc = "Posted in Support Forum: \"" + truncate(post.getTitle(), 30) + "\"";
            recentActivities.add(new RecentActivity(desc, post.getCreatedAt(), "post"));
        }

        List<ForumReply> recentReplies = forumReplyDao.findRecentByAuthorId(Long.valueOf(loggedInUser.getId()), oneWeekAgo);
        for (ForumReply reply : recentReplies) {
            String desc = "Replied in Forum Discussion";
            recentActivities.add(new RecentActivity(desc, reply.getCreatedAt(), "reply"));
        }

        recentActivities.sort(Comparator.comparing(RecentActivity::getTimestamp).reversed());
        if (recentActivities.size() > 5) {
            recentActivities = recentActivities.subList(0, 5);
        }

        model.addAttribute("recentActivities", recentActivities);

        return "/student/home";  
    }

    private String capitalizeFirst(String str) {
        if (str == null || str.isEmpty()) return str;
        return str.substring(0, 1).toUpperCase() + str.substring(1);
    }

    private String truncate(String str, int length) {
        if (str == null) return "";
        return str.length() > length ? str.substring(0, length) + "..." : str;
    }

    @GetMapping("/logout")
    public String studentLogout(HttpSession session) {
        session.invalidate();  
        return "redirect:/auth/login";  
    }

    
    @GetMapping("/chatbot")
    public String showChatbotPage(Model model) {
        return "/student/chatbot"; 
    }


    @GetMapping("/content/study-stress")
    public String showStudyStressPage(Model model, HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/auth/login";
        }

        return "student/study_stress"; 
    }
    @GetMapping("/content/sleep-hygiene")
    public String showSleepHygienePage(Model model, HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/auth/login";
        }
        return "student/sleep_hygiene"; 
    }

    @GetMapping("/content/breathing")
    public String showBreathingPage(Model model, HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/auth/login";
        }
        return "student/breathing"; 
    }
}

