package com.secj3303.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.secj3303.dao.ContentDao;
import com.secj3303.dao.ForumPostDao;
import com.secj3303.dao.UserDao;

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
        model.addAttribute("totalUsers", userDao.countAllUsers());
        model.addAttribute("activeContentCount", contentDao.countActiveContent());
        model.addAttribute("totalForumPosts", forumPostDao.countAllPosts());
        model.addAttribute("dailyActiveCount", 0); 
    }
}
