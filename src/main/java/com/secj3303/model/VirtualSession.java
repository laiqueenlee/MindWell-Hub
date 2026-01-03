package com.secj3303.model;

import javax.persistence.*;

@Entity
@Table(name = "VIRTUAL_SESSION")
public class VirtualSession {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @ManyToOne
    @JoinColumn(name = "student_id", nullable = false)
    private User student;

    @ManyToOne
    @JoinColumn(name = "mhp_id", nullable = false)
    private User mhp;

    @Column(name = "session_time", nullable = false) // 'time' is a reserved keyword 
    private String time;  

    @Column(name = "confirmed", nullable = false)
    private boolean confirmed;

    public VirtualSession() {}

    public VirtualSession(User student, User mhp, String time, boolean confirmed) {
        this.student = student;
        this.mhp = mhp;
        this.time = time;
        this.confirmed = confirmed;
    }

    // Getters & Setters
    public Integer getId() {
        return id;
    }   
    public void setId(Integer id) {
        this.id = id;
    }
    public User getStudent() {
        return student;
    }
    public void setStudent(User student) {
        this.student = student;
    }
    public User getMhp() {
        return mhp;
    }
    public void setMhp(User mhp) {
        this.mhp = mhp;
    }
    public String getTime() {
        return time;
    }
    public void setTime(String time) {
        this.time = time;
    }
    public boolean isConfirmed() {
        return confirmed;
    }
    public void setConfirmed(boolean confirmed) {
        this.confirmed = confirmed;
    }
}

