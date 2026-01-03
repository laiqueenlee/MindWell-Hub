package com.secj3303.controller.mhp;

import java.time.LocalDate;
import java.util.List;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.secj3303.dao.ContentDao;
import com.secj3303.model.User;
import com.secj3303.model.Content.ArticleSection;
import com.secj3303.model.Content.Content;
import com.secj3303.model.Content.QuizOption;
import com.secj3303.model.Content.QuizQuestion;
import com.secj3303.model.Content.VideoSection;

@Controller
@RequestMapping("/mhp")
public class ContentController {

    private final ContentDao contentDao;

    @Autowired
    public ContentController(ContentDao contentDao) {
        this.contentDao = contentDao;
    }

    // --- CREATE CONTENT PAGE (GET) ---
    @GetMapping("/create-content")
    public String showCreateContentPage(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) { return "redirect:/auth/login"; }
        
        model.addAttribute("content", new Content());
        model.addAttribute("isEdit", false);
        model.addAttribute("user", loggedInUser);
        
        return "mhp/create_content"; 
    }

    // --- EDIT CONTENT PAGE (GET) ---
    @GetMapping("/edit-content")
    @Transactional(readOnly = true)
    public String showEditContentPage(@RequestParam("id") int id, Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) { return "redirect:/auth/login"; }

        Content existing = contentDao.findByIdWithAssociations(id);
        if (existing == null) {
            return "redirect:/mhp/home";
        }

        model.addAttribute("content", existing);
        model.addAttribute("isEdit", true);
        model.addAttribute("user", loggedInUser);

        return "mhp/create_content";
    }

    // --- SAVE CONTENT PROCESS (POST) ---
    @PostMapping("/save-content")
    public String processSaveContent(
            @ModelAttribute Content content, 
            @RequestParam("contentType") String type, 
            HttpSession session) {
        
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) { return "redirect:/auth/login"; }

        if (content.getId() > 0) {
            // --- UPDATE EXISTING RECORD (Smart Merge) ---
            Content existing = contentDao.findByIdWithAssociations(content.getId());
            if (existing == null) return "redirect:/mhp/home";

            existing.setTitle(content.getTitle());
            existing.setCategory(content.getCategory());
            existing.setType(type);
            existing.setDuration(content.getDuration());
            existing.setPoints(content.getPoints());
            existing.setDifficulty(content.getDifficulty());
            existing.setStatus(content.getStatus());

            if ("Article".equals(type)) {
                existing.getVideoSections().clear();
                existing.getQuizQuestions().clear();
                mergeArticleSections(existing, content.getArticleSections());
            } 
            else if ("Video".equals(type)) {
                existing.getArticleSections().clear();
                existing.getQuizQuestions().clear();
                mergeVideoSections(existing, content.getVideoSections());
            } 
            else if ("Interactive".equals(type)) {
                existing.getArticleSections().clear();
                existing.getVideoSections().clear();
                mergeQuizQuestions(existing, content.getQuizQuestions());
            }

            contentDao.save(existing);
        } else {

            // 2. SET THE AUTHOR HERE
            content.setAuthor(loggedInUser.getUsername());
            // --- CREATE NEW RECORD ---
            content.setType(type);
            if (content.getDate() == null || content.getDate().isEmpty()) {
                content.setDate(LocalDate.now().toString());
            }

            if ("Article".equals(type) && content.getArticleSections() != null) {
                for (ArticleSection s : content.getArticleSections()) s.setContent(content);
                content.setVideoSections(null);
                content.setQuizQuestions(null);
            } 
            else if ("Video".equals(type) && content.getVideoSections() != null) {
                for (VideoSection v : content.getVideoSections()) v.setContent(content);
                content.setArticleSections(null);
                content.setQuizQuestions(null);
            } 
            else if ("Interactive".equals(type) && content.getQuizQuestions() != null) {
                for (QuizQuestion q : content.getQuizQuestions()) q.setContent(content);
                content.setArticleSections(null);
                content.setVideoSections(null);
            }

            contentDao.save(content);
        }

        return "redirect:/mhp/home";
    }

    // --- DELETE CONTENT (GET) ---
    @GetMapping("/delete-content")
    public String deleteContent(@RequestParam("id") int id, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) { return "redirect:/auth/login"; }

        contentDao.delete(id);
        return "redirect:/mhp/home";
    }

    // ==========================================
    // PRIVATE MERGE HELPERS
    // ==========================================

    private void mergeArticleSections(Content existing, List<ArticleSection> newSections) {
        if (newSections == null) { existing.getArticleSections().clear(); return; }

        for (ArticleSection newSec : newSections) {
            if (newSec.getId() > 0) {
                existing.getArticleSections().stream()
                    .filter(old -> old.getId() == newSec.getId())
                    .findFirst()
                    .ifPresent(old -> {
                        old.setSubtitle(newSec.getSubtitle());
                        old.setBody(newSec.getBody());
                    });
            } else {
                newSec.setContent(existing);
                existing.getArticleSections().add(newSec);
            }
        }
        existing.getArticleSections().removeIf(old -> 
            old.getId() > 0 && newSections.stream().noneMatch(n -> n.getId() == old.getId())
        );
    }

    private void mergeVideoSections(Content existing, List<VideoSection> newSections) {
        if (newSections == null) { existing.getVideoSections().clear(); return; }

        for (VideoSection newSec : newSections) {
            if (newSec.getId() > 0) {
                existing.getVideoSections().stream()
                    .filter(old -> old.getId() == newSec.getId())
                    .findFirst()
                    .ifPresent(old -> {
                        old.setVideoUrl(newSec.getVideoUrl());
                        old.setDescription(newSec.getDescription());
                    });
            } else {
                newSec.setContent(existing);
                existing.getVideoSections().add(newSec);
            }
        }
        existing.getVideoSections().removeIf(old -> 
            old.getId() > 0 && newSections.stream().noneMatch(n -> n.getId() == old.getId())
        );
    }

    private void mergeQuizQuestions(Content existing, List<QuizQuestion> newQuestions) {
        if (newQuestions == null) { existing.getQuizQuestions().clear(); return; }

        for (QuizQuestion newQ : newQuestions) {
            if (newQ.getId() > 0) {
                existing.getQuizQuestions().stream()
                    .filter(old -> old.getId() == newQ.getId())
                    .findFirst()
                    .ifPresent(old -> {
                        old.setQuestionText(newQ.getQuestionText());
                        old.setIntroduction(newQ.getIntroduction());
                        mergeQuizOptions(old, newQ.getOptions());
                    });
            } else {
                newQ.setContent(existing);
                existing.getQuizQuestions().add(newQ);
            }
        }
        existing.getQuizQuestions().removeIf(old -> 
            old.getId() > 0 && newQuestions.stream().noneMatch(n -> n.getId() == old.getId())
        );
    }

    private void mergeQuizOptions(QuizQuestion existingQ, List<QuizOption> newOptions) {
        if (newOptions == null) { existingQ.getOptions().clear(); return; }

        for (QuizOption newOpt : newOptions) {
            if (newOpt.getId() > 0) {
                existingQ.getOptions().stream()
                    .filter(old -> old.getId() == newOpt.getId())
                    .findFirst()
                    .ifPresent(old -> {
                        old.setOptionText(newOpt.getOptionText());
                        old.setCorrect(newOpt.isCorrect());
                    });
            } else {
                existingQ.getOptions().add(newOpt);
            }
        }
        existingQ.getOptions().removeIf(old -> 
            old.getId() > 0 && newOptions.stream().noneMatch(n -> n.getId() == old.getId())
        );
    }
}