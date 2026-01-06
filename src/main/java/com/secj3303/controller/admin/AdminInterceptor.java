package com.secj3303.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.secj3303.dao.ContentDao;
import com.secj3303.dao.UserDao;
import com.secj3303.dao.ForumPostDao;

// This annotation tells Spring to apply this logic to ALL controllers in this package
@ControllerAdvice(basePackages = "com.secj3303.controller.admin")
public class AdminInterceptor {

    @Autowired
    private UserDao userDao;
    
    @Autowired
    private ContentDao contentDao;
    
    @Autowired
    private ForumPostDao forumPostDao;

    @ModelAttribute
    public void addAdminHeaderStats(Model model) {
        // Now these 4 lines run for EVERY admin page automatically
        model.addAttribute("totalUsers", userDao.countAllUsers());
        model.addAttribute("activeContentCount", contentDao.countActiveContent());
        model.addAttribute("totalForumPosts", forumPostDao.countAllPosts());
        model.addAttribute("dailyActiveCount", 0); 
    }
}
