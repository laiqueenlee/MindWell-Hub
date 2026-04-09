package com.secj3303.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.secj3303.dao.MhpAvailabilityDao;
import com.secj3303.dao.UserDao;
import com.secj3303.dao.VirtualSessionDao;
import com.secj3303.model.MhpAvailability;
import com.secj3303.model.Role;
import com.secj3303.model.User;
import com.secj3303.model.VirtualSession;


@Controller
@RequestMapping("/sessions")
public class VirtualSesController {

    @Autowired
    private VirtualSessionDao sessionDao;

    @Autowired
    private UserDao userDao;

    @Autowired
    private MhpAvailabilityDao mhpAvailabilityDao;


    @GetMapping("/book")
    public String studBookSes(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || user.getRole() != Role.STUDENT) {
            return "redirect:/auth/login";
        }

        List<User> mhps = userDao.findByRole(Role.MENTAL_HEALTH_PROFESSIONAL);
        
        Map<String, List<String>> availableSlotsMap = new HashMap<>();
        for (User mhp : mhps) {
            List<MhpAvailability> slots = mhpAvailabilityDao.findByMhpId(mhp.getId());
            List<String> formatted = new ArrayList<>();
            for (MhpAvailability s : slots) {
                formatted.add(s.getDayOfWeek() + ": " + s.getTimeSlot());
            }
            availableSlotsMap.put(mhp.getUsername(), formatted);
        }

        model.addAttribute("mhps", mhps);
        model.addAttribute("availableSlotsMap", availableSlotsMap);
        return "virtualSes/book-session-page"; 
    } 

    @PostMapping("/book")
    public String processStudentBooking(@RequestParam("mhpId") Integer mhpId, 
                                        @RequestParam(value="selectedDate", required=false) String dateStr,
                                        HttpSession session, Model model) {
        User mhp = userDao.findById(mhpId);
        model.addAttribute("mhp", mhp);
        
        LocalDate today = LocalDate.now();
        model.addAttribute("minDate", today);
        model.addAttribute("maxDate", today.plusMonths(2));

        if (dateStr != null && !dateStr.isEmpty()) {
            LocalDate chosenDate = LocalDate.parse(dateStr);
            String dayOfWeek = chosenDate.getDayOfWeek().name();
            
            List<MhpAvailability> routine = mhpAvailabilityDao.findByMhpId(mhpId);
            
            List<VirtualSession> bookedSessions = sessionDao.findByMhpAndDate(mhpId, chosenDate);
            List<String> takenTimes = bookedSessions.stream()
                                        .map(VirtualSession::getTime)
                                        .collect(java.util.stream.Collectors.toList());

            List<String> availableTimes = new ArrayList<>();
            for (MhpAvailability slot : routine) {
                if (slot.getDayOfWeek().equalsIgnoreCase(dayOfWeek)) {
                    if (!takenTimes.contains(slot.getTimeSlot())) {
                        availableTimes.add(slot.getTimeSlot());
                    }
                }
            }
            model.addAttribute("availableSlots", availableTimes);
            model.addAttribute("selectedDate", chosenDate);
        }

        return "virtualSes/book-session-form"; 
    }

    @PostMapping("/book/save")
    public String saveFinalBooking(@RequestParam("mhpId") Integer mhpId, 
                                @RequestParam("time") String time,
                                @RequestParam("selectedDate") String dateStr,
                                @RequestParam("notes") String notes,     
                                @RequestParam("preFocus") String preFocus, 
                                HttpSession session) {
        
        User student = (User) session.getAttribute("loggedInUser");
        User mhp = userDao.findById(mhpId);

        if (student != null && mhp != null) {
            VirtualSession sessionObj = new VirtualSession();
            sessionObj.setStudent(userDao.findById(student.getId()));
            sessionObj.setMhp(mhp);
            sessionObj.setTime(time);
            
            sessionObj.setNotes(notes);
            sessionObj.setPreFocus(preFocus);
            
            if (dateStr != null && !dateStr.isEmpty()) {
                sessionObj.setSessionDate(java.time.LocalDate.parse(dateStr));
            }
            
            sessionObj.setConfirmed(false);
            sessionDao.save(sessionObj);
        }

        return "redirect:/sessions/book?success=true";
    }

    @GetMapping("/confirm")
    public String mhpConfirmPage(HttpSession session, Model model) {
        User mhp = (User) session.getAttribute("loggedInUser");
        if (mhp == null || mhp.getRole() != Role.MENTAL_HEALTH_PROFESSIONAL) {
            return "redirect:/auth/login";
        }

        List<VirtualSession> sessions = sessionDao.findByMhpUsername(mhp.getUsername());
        model.addAttribute("sessions", sessions);
        
        return "virtualSes/confirm-session-page"; 
    }

    @PostMapping("/confirm")
    public String processMhpConfirmation(@RequestParam("sessionId") Integer sessionId) {
        VirtualSession sessionObj = sessionDao.findById(sessionId);
        if (sessionObj != null) {
            sessionObj.setConfirmed(true);
            sessionDao.save(sessionObj); 
        }
        return "redirect:/sessions/confirm";
    }


    @GetMapping("/detail")
    public String sessionDetail(@RequestParam("id") Integer sessionId, Model model, HttpSession session) {
        VirtualSession sessionObj = sessionDao.findById(sessionId);
        
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }

        if (sessionObj == null) {
            return loggedInUser.getRole() == Role.STUDENT ? "redirect:/student/home" : "redirect:/sessions/confirm";
        }

        model.addAttribute("sessionObj", sessionObj);
        model.addAttribute("userRole", loggedInUser.getRole().name()); // Passes "STUDENT" or "MENTAL_HEALTH_PROFESSIONAL"

        return "virtualSes/session-detail"; 
}

    @GetMapping("/meeting")
    public String virtualMeetingPage(@RequestParam("sessionId") Integer sessionId,
                                    HttpSession session,
                                    Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/auth/login";

        VirtualSession sessionObj = sessionDao.findById(sessionId);
        if (sessionObj == null) {
            model.addAttribute("error", "Session not found");
            return "error";
        }

        if (!user.getId().equals(sessionObj.getStudent().getId()) && 
            !user.getId().equals(sessionObj.getMhp().getId())) {
            return "redirect:/access-denied"; // Prevent strangers from joining the link
        }

        model.addAttribute("sessionObj", sessionObj);
        
        model.addAttribute("userRole", user.getRole().toString()); 

        return "virtualSes/virtual-session-meeting"; 
    }
}