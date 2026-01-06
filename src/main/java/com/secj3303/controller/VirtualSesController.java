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
import org.springframework.web.bind.annotation.*;

import com.secj3303.dao.MhpAvailabilityDao;
import com.secj3303.dao.UserDao;
import com.secj3303.dao.VirtualSessionDao;
import com.secj3303.model.Role;
import com.secj3303.model.User;
import com.secj3303.model.VirtualSession;
import com.secj3303.model.MhpAvailability;
import com.secj3303.dao.MhpAvailabilityDao;
// Import your User DAO if you have one, or use a general method to fetch MHPs
// import com.secj3303.dao.UserDao; 

@Controller
@RequestMapping("/sessions")
public class VirtualSesController {

    @Autowired
    private VirtualSessionDao sessionDao;

    @Autowired
    private UserDao userDao;

    @Autowired
    private MhpAvailabilityDao mhpAvailabilityDao;

    // --- STUDENT BOOKING SECTION ---

    @GetMapping("/book")
    public String studBookSes(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || user.getRole() != Role.STUDENT) {
            return "redirect:/auth/login";
        }

        List<User> mhps = userDao.findByRole(Role.MENTAL_HEALTH_PROFESSIONAL);
        
        // Populate the Map for the preview pills on the card
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
        
        // Set date constraints for HTML5 date picker
        LocalDate today = LocalDate.now();
        model.addAttribute("minDate", today);
        model.addAttribute("maxDate", today.plusMonths(2));

        if (dateStr != null && !dateStr.isEmpty()) {
            LocalDate chosenDate = LocalDate.parse(dateStr);
            String dayOfWeek = chosenDate.getDayOfWeek().name(); // e.g., "MONDAY"
            
            // 1. Get MHP's regular routine for that day of the week
            List<MhpAvailability> routine = mhpAvailabilityDao.findByMhpId(mhpId);
            
            // 2. Get existing bookings for that specific date
            List<VirtualSession> bookedSessions = sessionDao.findByMhpAndDate(mhpId, chosenDate);
            List<String> takenTimes = bookedSessions.stream()
                                        .map(VirtualSession::getTime)
                                        .collect(java.util.stream.Collectors.toList());

            // 3. Filter: Only keep slots that match the day of week AND aren't taken
            List<String> availableTimes = new ArrayList<>();
            for (MhpAvailability slot : routine) {
                // Match "Monday" from DB with "MONDAY" from Calendar
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
                                @RequestParam("notes") String notes,     // Field: notes
                                @RequestParam("preFocus") String preFocus, // Field: preFocus
                                HttpSession session) {
        
        User student = (User) session.getAttribute("loggedInUser");
        User mhp = userDao.findById(mhpId);

        if (student != null && mhp != null) {
            VirtualSession sessionObj = new VirtualSession();
            sessionObj.setStudent(userDao.findById(student.getId()));
            sessionObj.setMhp(mhp);
            sessionObj.setTime(time);
            
            // Using your specific field names
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
        // --- MHP CONFIRMATION SECTION ---

    @GetMapping("/confirm")
    public String mhpConfirmPage(HttpSession session, Model model) {
        User mhp = (User) session.getAttribute("loggedInUser");
        if (mhp == null || mhp.getRole() != Role.MENTAL_HEALTH_PROFESSIONAL) {
            return "redirect:/auth/login";
        }

        // Dynamic fetch using your DAO
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

    // --- DETAILS & MEETING SECTION ---

    @GetMapping("/detail")
    public String sessionDetail(@RequestParam("id") Integer sessionId, Model model, HttpSession session) {
        // 1. Fetch the specific session
        VirtualSession sessionObj = sessionDao.findById(sessionId);
        
        // 2. Security Check: Ensure a user is logged in
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }

        if (sessionObj == null) {
            // Redirect based on role if session doesn't exist
            return loggedInUser.getRole() == Role.STUDENT ? "redirect:/student/home" : "redirect:/sessions/confirm";
        }

        // 3. Add data to the model
        // Note: I use "sessionObj" to avoid conflict with the reserved JSP "session" keyword
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

        // 1. Rename attribute to 'sessionObj' to avoid conflict with the built-in 'session' object
        model.addAttribute("sessionObj", sessionObj);
        
        // 2. Add 'userRole' so the JSP knows whether to show the Student or MHP view
        model.addAttribute("userRole", user.getRole().toString()); 

        return "virtualSes/virtual-session-meeting"; 
    }
}