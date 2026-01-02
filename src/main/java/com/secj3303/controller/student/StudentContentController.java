package com.secj3303.controller.student;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.secj3303.dao.ContentDao;
import com.secj3303.dao.ContentProgressDao;
import com.secj3303.model.User;
import com.secj3303.model.Content.Content;
import com.secj3303.model.Content.ContentProgress;

@Controller
@RequestMapping("/student/module")
public class StudentContentController {

    @Autowired private ContentDao contentDao;
    @Autowired private ContentProgressDao progressDao;

    @GetMapping("/view")
    public String viewModule(@RequestParam("id") int contentId, Model model, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/auth/login";

        Content content = contentDao.findByIdWithAssociations(contentId);
        ContentProgress progress = progressDao.findByUserAndContent(user.getId(), contentId);
        
        int percent = (progress != null) ? progress.getProgressPercent() : 0;
        int rating = (progress != null) ? progress.getRating() : 0;
        int lastPage = (progress != null) ? progress.getLastVisitedPage() : 0;
        String quizAnswers = (progress != null) ? progress.getQuizAnswers() : "";

        model.addAttribute("module", content);
        model.addAttribute("progressPercent", percent);
        model.addAttribute("userRating", rating);
        model.addAttribute("savedQuizAnswers", quizAnswers);
        model.addAttribute("lastPage", lastPage); // Pass to View

        return "/student/module-view";
    }

    @PostMapping("/save-progress")
    public String saveProgress(@RequestParam("contentId") int contentId, 
                               @RequestParam("percent") int percent,
                               @RequestParam(value = "pageIndex", defaultValue = "0") int pageIndex, // NEW param
                               HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/auth/login";

        ContentProgress cp = getOrCreateProgress(user, contentId);
        cp.setProgressPercent(percent);
        cp.setLastVisitedPage(pageIndex); // Save the exact page index
        progressDao.saveOrUpdate(cp);

        return "redirect:/content/browse";
    }

    // ... (Keep submit-quiz, reset-quiz, submit-rating, and helper methods exactly as they were) ...
    
    @PostMapping("/submit-quiz")
    public String submitQuiz(@RequestParam("contentId") int contentId, 
                             @RequestParam("answers") String answers,
                             HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/auth/login";

        ContentProgress cp = getOrCreateProgress(user, contentId);
        cp.setProgressPercent(100); 
        cp.setQuizAnswers(answers); 
        progressDao.saveOrUpdate(cp);
        return "redirect:/student/module/view?id=" + contentId;
    }

    @PostMapping("/reset-quiz")
    public String resetQuiz(@RequestParam("contentId") int contentId, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/auth/login";

        ContentProgress cp = progressDao.findByUserAndContent(user.getId(), contentId);
        if (cp != null) {
            cp.setProgressPercent(80);
            cp.setQuizAnswers(null); 
            progressDao.saveOrUpdate(cp);
        }
        return "redirect:/student/module/view?id=" + contentId;
    }

    @PostMapping("/submit-rating")
    public String submitRating(@RequestParam("contentId") int contentId, 
                               @RequestParam("rating") int rating, 
                               HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/auth/login";

        ContentProgress cp = getOrCreateProgress(user, contentId);
        cp.setRating(rating);
        cp.setProgressPercent(100); 
        progressDao.saveOrUpdate(cp);

        return "redirect:/content/browse";
    }

    private ContentProgress getOrCreateProgress(User user, int contentId) {
        ContentProgress cp = progressDao.findByUserAndContent(user.getId(), contentId);
        if (cp == null) {
            Content c = contentDao.findById(contentId);
            cp = new ContentProgress(user, c);
        }
        return cp;
    }
}