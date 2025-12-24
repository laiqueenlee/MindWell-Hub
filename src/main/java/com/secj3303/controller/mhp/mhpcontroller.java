package com.secj3303.controller.mhp;

import java.util.List;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.secj3303.model.Content;
import com.secj3303.model.ContentRepository;
import com.secj3303.model.Role;
import com.secj3303.model.User;

@Controller
@RequestMapping("/mhp")
public class mhpcontroller {

    // --- MHP DASHBOARD ---
    @GetMapping({"/home", "/content"})
    public String showMhpDashboard(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || loggedInUser.getRole() != Role.MENTAL_HEALTH_PROFESSIONAL) {
            return "redirect:/auth/login";
        }

        // FETCH REAL DATA FROM REPOSITORY
        List<Content> contentList = ContentRepository.getAllContent();

        model.addAttribute("user", loggedInUser);
        model.addAttribute("contentList", contentList);
        
        return "/mhp/home"; 
    }

    // --- CREATE CONTENT PAGE (GET) ---
    @GetMapping("/create-content")
    public String showCreateContentPage(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) { return "redirect:/auth/login"; }
        
        // Pass empty content object to JSP
        model.addAttribute("content", new Content());
        model.addAttribute("isEdit", false);
        
        return "/mhp/create_content"; 
    }

    // --- EDIT CONTENT PAGE (GET) ---
    // This method handles the "Edit" pencil button click
    @GetMapping("/edit-content")
    public String showEditContentPage(@RequestParam("id") int id, Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) { return "redirect:/auth/login"; }

        // Find the existing content
        Content existing = ContentRepository.getContentById(id);
        
        if (existing == null) {
            return "redirect:/mhp/home"; // Safety fallback
        }

        model.addAttribute("content", existing);
        model.addAttribute("isEdit", true);

        return "/mhp/create_content";
    }

    // --- SAVE CONTENT PROCESS (POST) ---
    @PostMapping("/save-content")
    public String processSaveContent(
            @ModelAttribute Content content, // Automatically binds title, category, description, etc.
            @RequestParam("contentType") String type, // Manual bind: JSP "contentType" -> Java "type"
            HttpSession session) {
        
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) { return "redirect:/auth/login"; }
        
        // 1. Manually set the type (fixing the name mismatch)
        content.setType(type);

        // 2. Logic: If ID is 0, it's NEW. If ID > 0, it's an UPDATE.
        if (content.getId() == 0) {
            ContentRepository.addContent(content);
        } else {
            ContentRepository.updateContent(content);
        }

        return "redirect:/mhp/home";
    }

    // --- DELETE CONTENT (GET) ---
    @GetMapping("/delete-content")
    public String deleteContent(@RequestParam("id") int id, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) { return "redirect:/auth/login"; }

        ContentRepository.deleteContent(id);

        return "redirect:/mhp/home";
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