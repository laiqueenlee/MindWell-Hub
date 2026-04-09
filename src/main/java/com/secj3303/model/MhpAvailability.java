package com.secj3303.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

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
    private String dayOfWeek; 

    @Column(name = "time_slot", nullable = false)
    private String timeSlot;  

    public MhpAvailability() {}

    public MhpAvailability(User mhp, String dayOfWeek, String timeSlot) {
        this.mhp = mhp;
        this.dayOfWeek = dayOfWeek;
        this.timeSlot = timeSlot;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public User getMhp() { return mhp; }
    public void setMhp(User mhp) { this.mhp = mhp; }
    public String getDayOfWeek() { return dayOfWeek; }
    public void setDayOfWeek(String dayOfWeek) { this.dayOfWeek = dayOfWeek; }
    public String getTimeSlot() { return timeSlot; }
    public void setTimeSlot(String timeSlot) { this.timeSlot = timeSlot; }
    
    public String getFormattedSlot() {
        return dayOfWeek.substring(0, 3) + " " + timeSlot;
    }
}