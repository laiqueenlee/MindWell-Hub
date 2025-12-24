package com.secj3303.model;

public class ModerationItem {
    
    private int id;
    private String type;        // "Forum Post", "Comment", "Article"
    private String priority;    // "high", "medium", "low"
    private String title;
    private String author;
    private String flagReason;
    private String status;      // "PENDING", "APPROVED", "REMOVED"
    
    public ModerationItem() {}

    public ModerationItem(int id, String type, String priority, String title, String author, String flagReason) {
        this.id = id;
        this.type = type;
        this.priority = priority;
        this.title = title;
        this.author = author;
        this.flagReason = flagReason;
        this.status = "PENDING";
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getPriority() { return priority; }
    public void setPriority(String priority) { this.priority = priority; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }

    public String getFlagReason() { return flagReason; }
    public void setFlagReason(String flagReason) { this.flagReason = flagReason; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}