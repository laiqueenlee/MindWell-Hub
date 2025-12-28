package com.secj3303.controller.admin;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.secj3303.dao.ContentDao;
import com.secj3303.dao.ModerationItemDao;
import com.secj3303.dao.UserDao;
import com.secj3303.model.User;
import com.secj3303.model.Content.ModerationItem;

// import com.secj3303.model.User;

@Controller
@RequestMapping("/admin")
public class admincontroller {
    // 1. Declare the DAO fields
    private final ContentDao contentDao;
    private final ModerationItemDao moderationItemDao;
    private final UserDao userDao; // Add UserDao

    // 2. Inject them via Constructor
    @Autowired
    public admincontroller(ContentDao contentDao, ModerationItemDao moderationItemDao, UserDao userDao) {
        this.contentDao = contentDao;
        this.moderationItemDao = moderationItemDao;
        this.userDao = userDao;
    }

    // --- NEW METHOD: Load Header Stats Automatically ---
    @ModelAttribute
    public void addGlobalAttributes(Model model) {
        // These will now be available in admin-header.html automatically
        model.addAttribute("totalUsers", userDao.countAllUsers());
        model.addAttribute("activeContentCount", contentDao.countActiveContent());
        
        // If you don't have DAOs for these yet, you can keep hardcoded values or add 0
        model.addAttribute("forumPostsCount", 892); 
        model.addAttribute("dailyActiveCount", 432); 
    }

    @GetMapping("/home")
    public String showAdminHomePage(Model model, HttpSession session) {
        
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }

        model.addAttribute("user", loggedInUser);
        
        return "/admin/home";  
    }

    @GetMapping("/content-quality")
    public String showContentQuality(Model model, HttpSession session) {
        
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }

        model.addAttribute("contentList", contentDao.findAll());
       // model.addAttribute("user", loggedInUser);
        
        
        return "/admin/content-quality";  
    }

    
    @GetMapping("/moderation-queue")
    public String showModerationQueue(Model model, HttpSession session) {
        
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }

        // Fetch pending items from the static Repository we created
        model.addAttribute("moderationItems", moderationItemDao.findPendingItems());
        model.addAttribute("user", loggedInUser);
        
        return "/admin/moderation-queue";  
    }

    @GetMapping("/moderation/approve/{id}")
    public String approveModerationItem(@PathVariable("id") int id, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/auth/login";

        // Call repository to approve
        ModerationItem item = moderationItemDao.findById(id);
        if (item != null) {
            item.setStatus("APPROVED");
            moderationItemDao.save(item);
        }
        
        return "redirect:/admin/moderation-queue";
    }

    @GetMapping("/moderation/remove/{id}")
    public String removeModerationItem(@PathVariable("id") int id, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/auth/login";

       
       moderationItemDao.delete(id);
        
        return "redirect:/admin/moderation-queue";
    }

    @GetMapping("/moderation/review/{id}")
    public String reviewModerationItem(@PathVariable("id") int id, HttpSession session) {
        // You can redirect to a specific detail page here later. 
        // For now, we just redirect back to the queue.
        return "redirect:/admin/moderation-queue";
    }

    @GetMapping("/platform-analytics")
    public String showPlatformAnalytics(Model model, HttpSession session) {
        
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }

        model.addAttribute("user", loggedInUser);
        
        return "/admin/platform-analytics";  
    }

    @GetMapping("/logout")
        public String logout(HttpSession session) {
            session.invalidate();
            return "redirect:/auth/login";
    }

}
