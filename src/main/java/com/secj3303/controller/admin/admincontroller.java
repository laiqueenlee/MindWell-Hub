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
import com.secj3303.dao.ContentProgressDao;
import com.secj3303.dao.ForumPostDao;
import com.secj3303.dao.UserDao;
import com.secj3303.model.Content.Content;
import com.secj3303.model.Role;
import com.secj3303.model.User;


@Controller
@RequestMapping("/admin")
public class admincontroller {
  
    private final ContentDao contentDao;
    private final UserDao userDao; 
    private final ContentProgressDao contentProgressDao; 
    private final ForumPostDao forumPostDao;

 
    @Autowired
    public admincontroller(ContentDao contentDao, 
                        UserDao userDao, 
                        ContentProgressDao contentProgressDao, 
                        ForumPostDao forumPostDao) { 
        this.contentDao = contentDao;
        this.userDao = userDao;
        this.contentProgressDao = contentProgressDao;
        this.forumPostDao = forumPostDao; 
    }

    
    @ModelAttribute
    public void addGlobalAttributes(Model model) {
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

        long total = userDao.countAllUsers();
        if (total > 0) {
            long studentCount = userDao.countByRole(Role.STUDENT);
            long mhpCount = userDao.countByRole(Role.MENTAL_HEALTH_PROFESSIONAL);
            long adminCount = userDao.countByRole(Role.ADMIN);

            model.addAttribute("studentPercent", (studentCount * 100) / total);
            model.addAttribute("mhpPercent", (mhpCount * 100) / total);
            model.addAttribute("adminPercent", (adminCount * 100) / total);
        }

        model.addAttribute("recentUsers", userDao.findRecentUsers(5));

        return "admin/home";

    }

    @GetMapping("/content-quality")
    public String showContentQuality(Model model, HttpSession session) {

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }

        List<Content> contentList = contentDao.findAll();

        long publishedCount = contentDao.countByStatus("Published");
        long pendingCount   = contentDao.countByStatus("Pending"); 
        long flaggedCount   = contentDao.countByStatus("Flagged");  

        Map<Integer, Double> ratingMap = new HashMap<>();
        for (Content content : contentList) {
            Double avgRating = contentProgressDao.getAverageRating(content.getId());
            ratingMap.put(content.getId(), avgRating);
        }

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
