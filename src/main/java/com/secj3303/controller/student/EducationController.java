package com.secj3303.controller.student;

import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpSession;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.secj3303.dao.ContentDao;
import com.secj3303.dao.ContentProgressDao; // 1. Import This
import com.secj3303.model.User;
import com.secj3303.model.Content.ArticleSection;
import com.secj3303.model.Content.Content;
import com.secj3303.model.Content.ContentProgress; // 2. Import This

import java.util.stream.Collectors;

@Controller
@RequestMapping("/content") 
public class EducationController {

    private final ContentDao contentDao;
    private final ContentProgressDao progressDao; // 3. Add this field

    @Autowired
    // 4. Update Constructor to include ProgressDao
    public EducationController(ContentDao contentDao, ContentProgressDao progressDao) {
        this.contentDao = contentDao;
        this.progressDao = progressDao;
    }

    @GetMapping("/browse")
    public String showLegacyEducationPage(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }

        // 1. Fetch ALL content from DAO
        List<Content> allContent = contentDao.findAll();

        // 2. FILTER the list: Keep only content where status is "Published"
        List<Content> modules = allContent.stream()
                .filter(c -> "Published".equalsIgnoreCase(c.getStatus()))
                .collect(Collectors.toList());

        // --- CREATE THE MAP (Only for published modules) ---
        Map<Integer, Integer> progressMap = new HashMap<>();

        for (Content module : modules) {
            ContentProgress cp = progressDao.findByUserAndContent(loggedInUser.getId(), module.getId());
            int percent = (cp != null) ? cp.getProgressPercent() : 0;
            progressMap.put(module.getId(), percent);
        }

        // --- SEND THE MAP & FILTERED MODULES ---
        model.addAttribute("progressMap", progressMap);
        model.addAttribute("user", loggedInUser);
        model.addAttribute("modules", modules); // This now contains only published items

        return "/student/education"; 
    }

    @GetMapping("/view/{id}")
    public String viewContent(@PathVariable("id") int id,
            @RequestParam(defaultValue = "1") int page,
            Model model,
            HttpSession session) {

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null)
            return "redirect:/auth/login";

        Content content = contentDao.findByIdWithAssociations(id);
        if (content == null)
            return "redirect:/content/browse";

        // ============================================================
        // 5. NEW CODE: FETCH SAVED PROGRESS FROM DATABASE
        // ============================================================
        ContentProgress savedProgress = progressDao.findByUserAndContent(loggedInUser.getId(), id);

        int percent = (savedProgress != null) ? savedProgress.getProgressPercent() : 0;
        int rating = (savedProgress != null) ? savedProgress.getRating() : 0;
        int lastPage = (savedProgress != null) ? savedProgress.getLastVisitedPage() : 0;
        String quizAnswers = (savedProgress != null) ? savedProgress.getQuizAnswers() : "";

        // Pass these to the view so JavaScript can use them
        model.addAttribute("progressPercent", percent); // Overwrites the manual calculation below
        model.addAttribute("userRating", rating);
        model.addAttribute("lastPage", lastPage); // THIS IS THE KEY FIX
        model.addAttribute("savedQuizAnswers", quizAnswers);
        // ============================================================

        model.addAttribute("module", content);
        model.addAttribute("currentPage", page);

        // Keep existing logic for "Article" type to ensure backward compatibility
        if ("Article".equals(content.getType())) {
            int totalSections = content.getArticleSections().size();

            if (page < 1 || page > totalSections) {
                // If we have a saved page, maybe we want to redirect there?
                // For now, let's just let the view handle it via 'lastPage' variable.
            }

            // Fallback for non-JS rendering
            if (totalSections > 0 && page <= totalSections) {
                ArticleSection currentSection = content.getArticleSections().get(page - 1);
                model.addAttribute("currentSection", currentSection);
                model.addAttribute("totalPages", totalSections);
                model.addAttribute("hasNextPage", page < totalSections);
                model.addAttribute("nextPage", page + 1);
            }
        }

        return "/student/module-view";
    }
}