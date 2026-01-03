package com.secj3303.controller.admin;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.secj3303.dao.ContentDao;
import com.secj3303.dao.UserDao;
import com.secj3303.model.User;
import com.secj3303.model.Content.Content; 
@Controller
@RequestMapping("/admin")
public class ModerationController {

    private final ContentDao contentDao; 
    private final UserDao userDao;

    @Autowired
    public ModerationController(ContentDao contentDao, UserDao userDao) {
        this.contentDao = contentDao;
        this.userDao = userDao;
    }

    // --- Header Stats ---
    @ModelAttribute
    public void addGlobalAttributes(Model model) {
        model.addAttribute("totalUsers", userDao.countAllUsers());
        model.addAttribute("activeContentCount", contentDao.countActiveContent());
        model.addAttribute("forumPostsCount", 892); 
        model.addAttribute("dailyActiveCount", 432); 
    }

    // 1. Show Queue (Fixed to fetch Content)
    @GetMapping("/moderation-queue") 
    public String showModerationQueue(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/auth/login";

        // RESTORED: Fetch from ContentDao like your old controller
        // Note: If you want to see FLAGGED items too, ensure this method returns them
        // or creates a custom list combining "published" and "Flagged"
        model.addAttribute("moderationItems", contentDao.findByStatus("Pending"));
        model.addAttribute("user", loggedInUser);
        
        return "/admin/moderation-queue"; 
    }

    // 2. Flag Content
    @PostMapping("/moderation/flag") 
    public String flagContent(@RequestParam("contentId") int contentId, 
                              @RequestParam("reason") String reason,
                              RedirectAttributes redirectAttributes) {
        
        // Update the CONTENT entity
        Content content = contentDao.findById(contentId);
        if (content != null) {
            content.setStatus("Flagged");
            content.setFlagReason(reason);
            contentDao.save(content);
            redirectAttributes.addFlashAttribute("message", "Content flagged successfully.");
        }
        
        return "redirect:/admin/moderation-queue";
    }

    // 3. Approve
    @GetMapping("/moderation/approve/{id}") 
    public String approveContent(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
        Content content = contentDao.findById(id);
        if (content != null) {
            content.setStatus("Published");
            contentDao.save(content);
            redirectAttributes.addFlashAttribute("message", "Content approved.");
        }
        return "redirect:/admin/moderation-queue";
    }

    // 4. Remove
    @GetMapping("/moderation/remove/{id}") 
    public String removeContent(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
        contentDao.delete(id);
        redirectAttributes.addFlashAttribute("error", "Content removed.");
        return "redirect:/admin/moderation-queue";
    }
}