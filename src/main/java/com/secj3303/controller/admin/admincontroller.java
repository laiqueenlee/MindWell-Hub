package com.secj3303.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.secj3303.dao.ContentDao;
import com.secj3303.dao.UserDao;
import com.secj3303.model.User;
import com.secj3303.dao.ContentProgressDao; 
import com.secj3303.model.Content.Content;  

// import com.secj3303.model.User;

@Controller
@RequestMapping("/admin")
public class admincontroller {
  
    private final ContentDao contentDao;
    private final UserDao userDao; 
    private final ContentProgressDao contentProgressDao; 

 
    @Autowired
    public admincontroller(ContentDao contentDao, UserDao userDao, ContentProgressDao contentProgressDao) {
        this.contentDao = contentDao;
        this.userDao = userDao;
        this.contentProgressDao = contentProgressDao;
    }

    
    @ModelAttribute
    public void addGlobalAttributes(Model model) {
        // These will now be available in admin-header.html automatically
        model.addAttribute("totalUsers", userDao.countAllUsers());
        model.addAttribute("activeContentCount", contentDao.countActiveContent());

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

    // In admincontroller.java

    @GetMapping("/content-quality")
    public String showContentQuality(Model model, HttpSession session) {

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }

        // 1. Fetch the list (existing code)
        List<Content> contentList = contentDao.findAll();

        // 2. NEW: Fetch the published count
        long publishedCount = contentDao.countByStatus("Published");
        long pendingCount   = contentDao.countByStatus("Pending"); 
        long flaggedCount   = contentDao.countByStatus("Flagged");  

        // 3. Calculate ratings (from previous step)
        Map<Integer, Double> ratingMap = new HashMap<>();
        for (Content content : contentList) {
            Double avgRating = contentProgressDao.getAverageRating(content.getId());
            ratingMap.put(content.getId(), avgRating);
        }

        // 4. Add data to model
        model.addAttribute("contentList", contentList);
        model.addAttribute("ratingMap", ratingMap);
        model.addAttribute("publishedCount", publishedCount); 
        model.addAttribute("pendingCount", pendingCount); 
        model.addAttribute("flaggedCount", flaggedCount);

        return "admin/content-quality";
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
