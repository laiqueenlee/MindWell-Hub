package com.secj3303.controller.student;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.secj3303.dao.ContentDao;
import com.secj3303.dao.ContentProgressDao;
import com.secj3303.model.Content.ArticleSection;
import com.secj3303.model.Content.Content;
import com.secj3303.model.Content.ContentProgress; 
import com.secj3303.model.User;

@Controller
@RequestMapping("/content") 
public class EducationController {

    private final ContentDao contentDao;
    private final ContentProgressDao progressDao; 

    @Autowired
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

        List<Content> allContent = contentDao.findAll();

        List<Content> modules = allContent.stream()
                .filter(c -> "Published".equalsIgnoreCase(c.getStatus()))
                .collect(Collectors.toList());

        Map<Integer, Integer> progressMap = new HashMap<>();

        for (Content module : modules) {
            ContentProgress cp = progressDao.findByUserAndContent(loggedInUser.getId(), module.getId());
            int percent = (cp != null) ? cp.getProgressPercent() : 0;
            progressMap.put(module.getId(), percent);
        }

        model.addAttribute("progressMap", progressMap);
        model.addAttribute("user", loggedInUser);
        model.addAttribute("modules", modules);

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

        ContentProgress savedProgress = progressDao.findByUserAndContent(loggedInUser.getId(), id);

        int percent = (savedProgress != null) ? savedProgress.getProgressPercent() : 0;
        int rating = (savedProgress != null) ? savedProgress.getRating() : 0;
        int lastPage = (savedProgress != null) ? savedProgress.getLastVisitedPage() : 0;
        String quizAnswers = (savedProgress != null) ? savedProgress.getQuizAnswers() : "";

        model.addAttribute("progressPercent", percent); 
        model.addAttribute("userRating", rating);
        model.addAttribute("lastPage", lastPage); 
        model.addAttribute("savedQuizAnswers", quizAnswers);

        model.addAttribute("module", content);
        model.addAttribute("currentPage", page);

        if ("Article".equals(content.getType())) {
            int totalSections = content.getArticleSections().size();

            if (page < 1 || page > totalSections) {
                // 
            }

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