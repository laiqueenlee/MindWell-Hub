package com.secj3303.controller.admin;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.secj3303.model.ModerationItemRepository;
import com.secj3303.model.User;

// import com.secj3303.model.User;

@Controller
@RequestMapping("/admin")
public class admincontroller {

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

        model.addAttribute("user", loggedInUser);
        
        return "/admin/content-quality";  
    }

    
    @GetMapping("/moderation-queue")
    public String showModerationQueue(Model model, HttpSession session) {
        
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }

        // Fetch pending items from the static Repository we created
        model.addAttribute("moderationItems", ModerationItemRepository.getPendingItems());
        model.addAttribute("user", loggedInUser);
        
        return "/admin/moderation-queue";  
    }

    @GetMapping("/moderation/approve/{id}")
    public String approveModerationItem(@PathVariable("id") int id, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/auth/login";

        // Call repository to approve
        ModerationItemRepository.approveItem(id);
        
        return "redirect:/admin/moderation-queue";
    }

    @GetMapping("/moderation/remove/{id}")
    public String removeModerationItem(@PathVariable("id") int id, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/auth/login";

        // Call repository to remove
        ModerationItemRepository.removeItem(id);
        
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
