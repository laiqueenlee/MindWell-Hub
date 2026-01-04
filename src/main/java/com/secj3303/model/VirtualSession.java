package com.secj3303.model;

import java.time.LocalDate;
import javax.persistence.*;

@Entity
@Table(name = "VIRTUAL_SESSION")
public class VirtualSession {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "session_id", nullable = false, columnDefinition = "INT AUTO_INCREMENT")
    private Integer id;
    
    @ManyToOne
    @JoinColumn(name = "student_id", nullable = false)
    private User student;

    @ManyToOne
    @JoinColumn(name = "mhp_id", nullable = false)
    private User mhp;

    @Column(name = "session_date", nullable = false)
    private LocalDate sessionDate;

    @Column(name = "session_time", nullable = false) 
    private String time;  

    @Column(name = "confirmed", nullable = false)
    private boolean confirmed;

    @Column(name = "pre_focus", length = 255)
    private String preFocus; // Stores the "Preliminary Focus" dropdown/input

    @Column(name = "notes", length = 2000)
    private String notes;

    public VirtualSession() {}

    public VirtualSession(User student, User mhp, LocalDate sessionDate, String time, boolean confirmed) {
        this.student = student;
        this.mhp = mhp;
        this.sessionDate = sessionDate;
        this.time = time;
        this.confirmed = confirmed;
    }

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public User getStudent() { return student; }
    public void setStudent(User student) { this.student = student; }
    public User getMhp() { return mhp; }
    public void setMhp(User mhp) { this.mhp = mhp; }
    public LocalDate getSessionDate() { return sessionDate; }
    public void setSessionDate(LocalDate sessionDate) { this.sessionDate = sessionDate; }
    public String getTime() { return time; }
    public void setTime(String time) { this.time = time; }
    public boolean isConfirmed() { return confirmed; }
    public void setConfirmed(boolean confirmed) { this.confirmed = confirmed; }
    public String getPreFocus() {
        return preFocus;
    }

    public void setPreFocus(String preFocus) {
        this.preFocus = preFocus;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}