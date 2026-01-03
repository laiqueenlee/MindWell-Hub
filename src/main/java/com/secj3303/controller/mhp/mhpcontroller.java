package com.secj3303.controller.mhp;

import java.util.List;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.secj3303.dao.ContentDao;
import com.secj3303.model.Role;
import com.secj3303.model.User;
import com.secj3303.model.Content.Content;

@Controller
@RequestMapping("/mhp")
public class mhpcontroller {

    private final ContentDao contentDao;

    @Autowired
    public mhpcontroller(ContentDao contentDao) {
        this.contentDao = contentDao;
    }

    // --- MHP DASHBOARD ---
    @GetMapping({"/home", "/content"})
    public String showMhpDashboard(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || loggedInUser.getRole() != Role.MENTAL_HEALTH_PROFESSIONAL) {
            return "redirect:/auth/login";
        }

        // FETCH REAL DATA FROM REPOSITORY
        List<Content> contentList = contentDao.findAll();

        model.addAttribute("user", loggedInUser);
        model.addAttribute("contentList", contentList);
        
        return "/mhp/home"; 
    }


    @GetMapping("/chatbot")
    public String showChatbotPage(Model model, HttpSession session) {
        // 1. Security Check
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || loggedInUser.getRole() != Role.MENTAL_HEALTH_PROFESSIONAL) {
            return "redirect:/auth/login";
        }

        // 2. Add user to model (for the Navbar "Hello, Dr. Name")
        model.addAttribute("user", loggedInUser);

        // 3. Return the JSP view
        // This assumes your file is located at: /WEB-INF/views/mhp/chatbot.jsp
        return "mhp/chatbot"; 
    }

    @GetMapping("/logout")
    public String mhpLogout(HttpSession session) {
        session.invalidate();  // Invalidate the session to log out
        return "redirect:/auth/login";  // Redirect to the login page
    }
}