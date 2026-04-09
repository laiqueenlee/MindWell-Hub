package com.secj3303.model;

import java.time.LocalDateTime;

public class RecentActivity {
    private String description;
    private LocalDateTime timestamp;
    private String type; 

    public RecentActivity() {
    }

    public RecentActivity(String description, LocalDateTime timestamp, String type) {
        this.description = description;
        this.timestamp = timestamp;
        this.type = type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
