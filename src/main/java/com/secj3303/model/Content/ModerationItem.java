package com.secj3303.model.Content;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "MODERATION_ITEM")
public class ModerationItem {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "moderation_id")
    private int id;

    // "type" is often a reserved SQL keyword, so we map it to "item_type"
    @Column(name = "item_type")
    private String type;        // "Forum Post", "Comment", "Article"

    @Column(name = "priority")
    private String priority;    // "high", "medium", "low"

    @Column(name = "title")
    private String title;

    @Column(name = "author")
    private String author;

    @Column(name = "flag_reason")
    private String flagReason;

    @Column(name = "status")
    private String status = "PENDING"; // Default value initialized here

    public ModerationItem() {}

    // Constructor updated to match your logic
    public ModerationItem(String type, String priority, String title, String author, String flagReason) {
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