package com.secj3303.model;

import javax.persistence.*;

@Entity
@Table(name = "mhp_availability")
public class MhpAvailability {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "mhp_id", nullable = false)
    private User mhp;

    @Column(name = "day_of_week", nullable = false)
    private String dayOfWeek; // e.g., "Monday", "Tuesday"

    @Column(name = "time_slot", nullable = false)
    private String timeSlot;  // e.g., "10:00 AM", "02:00 PM"

    public MhpAvailability() {}

    public MhpAvailability(User mhp, String dayOfWeek, String timeSlot) {
        this.mhp = mhp;
        this.dayOfWeek = dayOfWeek;
        this.timeSlot = timeSlot;
    }

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public User getMhp() { return mhp; }
    public void setMhp(User mhp) { this.mhp = mhp; }
    public String getDayOfWeek() { return dayOfWeek; }
    public void setDayOfWeek(String dayOfWeek) { this.dayOfWeek = dayOfWeek; }
    public String getTimeSlot() { return timeSlot; }
    public void setTimeSlot(String timeSlot) { this.timeSlot = timeSlot; }
    
    // Helper to show as a single string (Mon 10:00 AM)
    public String getFormattedSlot() {
        return dayOfWeek.substring(0, 3) + " " + timeSlot;
    }
}