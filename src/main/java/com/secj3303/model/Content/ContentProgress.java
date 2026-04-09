package com.secj3303.model.Content;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import com.secj3303.model.User;

@Entity
@Table(name = "CONTENT_PROGRESS", uniqueConstraints = {
        @UniqueConstraint(columnNames = { "user_id", "content_id" })
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

    @Column(name = "quiz_answers", length = 500)
    private String quizAnswers;

    @Column(name = "last_visited_page")
    private int lastVisitedPage;

    public ContentProgress() {
    }

    public ContentProgress(User user, Content content) {
        this.user = user;
        this.content = content;
        this.progressPercent = 0;
        this.rating = 0;
        this.lastVisitedPage = 0; 
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Content getContent() {
        return content;
    }

    public void setContent(Content content) {
        this.content = content;
    }

    public int getProgressPercent() {
        return progressPercent;
    }

    public void setProgressPercent(int progressPercent) {
        this.progressPercent = progressPercent;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getQuizAnswers() {
        return quizAnswers;
    }

    public void setQuizAnswers(String quizAnswers) {
        this.quizAnswers = quizAnswers;
    }

    // NEW Getter/Setter
    public int getLastVisitedPage() {
        return lastVisitedPage;
    }

    public void setLastVisitedPage(int lastVisitedPage) {
        this.lastVisitedPage = lastVisitedPage;
    }
}