package com.secj3303.controller.mhp;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.secj3303.dao.ContentDao;
import com.secj3303.dao.MhpAvailabilityDao;
import com.secj3303.dao.VirtualSessionDao;
import com.secj3303.model.Content.Content;
import com.secj3303.model.MhpAvailability;
import com.secj3303.model.Role;
import com.secj3303.model.User;

@Controller
@RequestMapping("/mhp")
public class mhpcontroller {

    @Autowired
    private ContentDao contentDao;

    @Autowired
    private MhpAvailabilityDao mhpAvailabilityDao; 

    @Autowired
    private VirtualSessionDao virtualSessionDao;
    

    @GetMapping({"/home", "/content"})
    public String showMhpDashboard(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || loggedInUser.getRole() != Role.MENTAL_HEALTH_PROFESSIONAL) {
            return "redirect:/auth/login";
        }

        LocalDate today = LocalDate.now();
        LocalDate startOfWeek = today.with(java.time.DayOfWeek.MONDAY);
        LocalDate endOfWeek = today.with(java.time.DayOfWeek.SUNDAY);

        Long todaysSessions = virtualSessionDao.countSessionsByDate(today);
        Long weeksSessions = virtualSessionDao.countSessionsThisWeek(startOfWeek, endOfWeek);
        Long totalStudents = virtualSessionDao.countTotalStudents();

        model.addAttribute("todaysSessions", todaysSessions);
        model.addAttribute("weeksSessions", weeksSessions);
        model.addAttribute("totalStudents", totalStudents);


        List<Content> contentList = contentDao.findAll();

        model.addAttribute("user", loggedInUser);
        model.addAttribute("contentList", contentList);
        
        return "/mhp/home"; 
    }


    @GetMapping("/chatbot")
    public String showChatbotPage(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || loggedInUser.getRole() != Role.MENTAL_HEALTH_PROFESSIONAL) {
            return "redirect:/auth/login";
        }

        model.addAttribute("user", loggedInUser);

        return "mhp/chatbot"; 
    }

    @GetMapping("/availability")
    public String showManageAvailability(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || loggedInUser.getRole() != Role.MENTAL_HEALTH_PROFESSIONAL) {
            return "redirect:/auth/login";
        }

        List<MhpAvailability> slots = mhpAvailabilityDao.findByMhpId(loggedInUser.getId());
        model.addAttribute("user", loggedInUser);
        model.addAttribute("slots", slots);

        return "mhp/manage_availability";
    }

    @PostMapping("/availability/add")
    public String addSlot(
            @RequestParam String day, 
            @RequestParam String startTime, 
            @RequestParam String endTime, 
            HttpSession session) {
            
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        if (loggedInUser != null && loggedInUser.getRole() == Role.MENTAL_HEALTH_PROFESSIONAL) {
            if (startTime.compareTo(endTime) < 0) {
                String combinedTime = startTime + " - " + endTime; // e.g. "09:00 - 10:00"
                MhpAvailability newSlot = new MhpAvailability(loggedInUser, day, combinedTime);
                mhpAvailabilityDao.save(newSlot);
            }
        }
        return "redirect:/mhp/availability";
    }

    @PostMapping("/availability/delete")
    public String deleteSlot(@RequestParam Integer slotId, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null && loggedInUser.getRole() == Role.MENTAL_HEALTH_PROFESSIONAL) {
            mhpAvailabilityDao.delete(slotId);
        }
        return "redirect:/mhp/availability";
    }

    @GetMapping("/logout")
    public String mhpLogout(HttpSession session) {
        session.invalidate();  
        return "redirect:/auth/login";  
    }
}