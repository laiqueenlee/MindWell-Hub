package com.secj3303.model.Content;

import javax.persistence.*;
import com.secj3303.model.User;

@Entity
@Table(name = "CONTENT_PROGRESS", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"user_id", "content_id"})
})
public class ContentProgress {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "content_id", nullable = false)
    private Content content;

    @Column(name = "progress_percent")
    private int progressPercent; 

    @Column(name = "rating")
    private int rating;

    // Stores selected indices as comma-separated string (e.g., "1,0,2")
    @Column(name = "quiz_answers", length = 500) 
    private String quizAnswers;

    // NEW: Stores the exact index of the article section (0, 1, 2...)
    @Column(name = "last_visited_page")
    private int lastVisitedPage;

    public ContentProgress() {}

    public ContentProgress(User user, Content content) {
        this.user = user;
        this.content = content;
        this.progressPercent = 0;
        this.rating = 0;
        this.lastVisitedPage = 0; // Default to 0
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public Content getContent() { return content; }
    public void setContent(Content content) { this.content = content; }
    public int getProgressPercent() { return progressPercent; }
    public void setProgressPercent(int progressPercent) { this.progressPercent = progressPercent; }
    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }
    public String getQuizAnswers() { return quizAnswers; }
    public void setQuizAnswers(String quizAnswers) { this.quizAnswers = quizAnswers; }
    
    // NEW Getter/Setter
    public int getLastVisitedPage() { return lastVisitedPage; }
    public void setLastVisitedPage(int lastVisitedPage) { this.lastVisitedPage = lastVisitedPage; }
}