package com.secj3303.controller.student;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.secj3303.dao.AssessmentDao;
import com.secj3303.model.Assessment;
import com.secj3303.model.AssessmentResult;
import com.secj3303.model.AssessmentService;
import com.secj3303.model.User;

import java.util.List;

@Controller
@RequestMapping("/student/assessment")
public class AssessmentController {

    @Autowired
    private AssessmentDao assessmentDao;

    // --- ASSESSMENT LISTING PAGE (GET) ---
    @GetMapping("/")
    public String showAssessmentPage(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }

        model.addAttribute("user", loggedInUser);
        return "student/assessment-list"; // => /WEB-INF/views/student/assessment-list.jsp
    }

    // --- TAKE DAILY MOOD CHECK (GET) ---
    @GetMapping("/mood")
    public String showMoodAssessment(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }

        model.addAttribute("user", loggedInUser);
        model.addAttribute("assessmentType", "mood");
        model.addAttribute("duration", "2 min");
        return "student/mood-assessment";
    }

    // --- TAKE STRESS ASSESSMENT (GET) ---
    @GetMapping("/stress")
    public String showStressAssessment(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }

        model.addAttribute("user", loggedInUser);
        model.addAttribute("assessmentType", "stress");
        model.addAttribute("duration", "5 min");
        return "student/stress-assessment";
    }

    // --- TAKE ANXIETY SCREENING (GET) ---
    @GetMapping("/anxiety")
    public String showAnxietyAssessment(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }

        model.addAttribute("user", loggedInUser);
        model.addAttribute("assessmentType", "anxiety");
        model.addAttribute("duration", "7 min");
        return "student/anxiety-assessment";
    }

    // --- TAKE GENERAL WELLBEING ASSESSMENT (GET) ---
    @GetMapping("/wellbeing")
    public String showWellbeingAssessment(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }

        model.addAttribute("user", loggedInUser);
        model.addAttribute("assessmentType", "wellbeing");
        model.addAttribute("duration", "10 min");
        return "student/wellbeing-assessment";
    }

    // --- SUBMIT ASSESSMENT (POST) ---
    @PostMapping("/submit")
    public String submitAssessment(
            @RequestParam("assessmentType") String assessmentType,
            @RequestParam(value = "answers", required = false) String[] answersStr,
            Model model,
            HttpSession session) {
        
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }

        // DEBUG: Print what we received
        System.out.println("=== ASSESSMENT SUBMISSION DEBUG ===");
        System.out.println("Assessment Type: " + assessmentType);
        System.out.println("Answers received: " + (answersStr == null ? "NULL" : "Array of length " + answersStr.length));
        if (answersStr != null) {
            System.out.println("Answers array: " + java.util.Arrays.toString(answersStr));
        }
        System.out.println("===================================");
        
        // Convert string answers to int array
        int[] answers = new int[0];
        if (answersStr != null && answersStr.length > 0) {
            answers = new int[answersStr.length];
            for (int i = 0; i < answersStr.length; i++) {
                try {
                    answers[i] = Integer.parseInt(answersStr[i]);
                    System.out.println("Parsed answer[" + i + "] = " + answers[i]);
                } catch (NumberFormatException e) {
                    System.err.println("Failed to parse answer[" + i + "]: " + answersStr[i]);
                    answers[i] = 0;
                }
            }
        } else {
            System.err.println("WARNING: No answers received!");
        }

        try {
            // Calculate result
            System.out.println("[AssessmentController] Received submit for type=" + assessmentType + " answersCount=" + (answers == null ? 0 : answers.length));
            if (answers != null) {
                System.out.println("[AssessmentController] Answers:" + java.util.Arrays.toString(answers));
            }

            AssessmentResult result = AssessmentService.calculateResult(assessmentType, answers);

            // Create Assessment object and save to database
            Assessment assessment = new Assessment(
                loggedInUser.getUsername(),
                assessmentType,
                result.getOverallScore(),
                result.getCategory(),
                result.getFeedback()
            );
            assessment.setRecommendations(result.getRecommendedActions());
            
            // Save to database
            assessmentDao.save(assessment);
            System.out.println("[AssessmentController] Saved assessment to database: ID=" + assessment.getAssessmentId());

            // Add to model
            model.addAttribute("user", loggedInUser);
            model.addAttribute("assessmentType", assessmentType);
            model.addAttribute("result", result);
            model.addAttribute("score", result.getOverallScore());
            model.addAttribute("category", result.getCategory());
            model.addAttribute("feedback", result.getFeedback());
            model.addAttribute("recommendations", result.getRecommendedActions());
            model.addAttribute("metrics", result.getMetrics());

            // Store in session for reference
            session.setAttribute("lastAssessmentResult", result);
            session.setAttribute("lastAssessmentType", assessmentType);

            return "student/assessment-result"; // => /WEB-INF/views/student/assessment-result.jsp
        } catch (Exception ex) {
            // Log and forward to the same JSP with an error message so page can render diagnostic info
            ex.printStackTrace();
            model.addAttribute("errorMessage", "An error occurred while processing the assessment: " + ex.getMessage());
            return "student/assessment-result";
        }
    }

    // --- VIEW ASSESSMENT RESULTS (GET) ---
    @GetMapping("/results")
    public String viewAssessmentResults(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }

        AssessmentResult result = (AssessmentResult) session.getAttribute("lastAssessmentResult");
        String assessmentType = (String) session.getAttribute("lastAssessmentType");

        if (result == null) {
            return "redirect:/student/assessment/";
        }

        model.addAttribute("user", loggedInUser);
        model.addAttribute("assessmentType", assessmentType);
        model.addAttribute("result", result);
        model.addAttribute("score", result.getOverallScore());
        model.addAttribute("category", result.getCategory());
        model.addAttribute("feedback", result.getFeedback());
        model.addAttribute("recommendations", result.getRecommendedActions());
        model.addAttribute("metrics", result.getMetrics());

        return "student/assessment-result";
    }
    
    // --- VIEW ASSESSMENT HISTORY (GET) ---
    @GetMapping("/history")
    public String viewAssessmentHistory(
            @RequestParam(value = "type", required = false) String assessmentType,
            Model model, 
            HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }

        List<Assessment> assessments;
        
        if (assessmentType != null && !assessmentType.isEmpty()) {
            // Filter by type
            assessments = assessmentDao.findByUsernameAndType(loggedInUser.getUsername(), assessmentType);
            model.addAttribute("selectedType", assessmentType);
        } else {
            // All assessments
            assessments = assessmentDao.findByUsername(loggedInUser.getUsername());
            model.addAttribute("selectedType", "all");
        }

        model.addAttribute("user", loggedInUser);
        model.addAttribute("assessments", assessments);
        
        return "student/assessment-history"; // => /WEB-INF/views/student/assessment-history.jsp
    }
}
