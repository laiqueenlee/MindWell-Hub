package com.secj3303.model;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "assessments")
public class Assessment {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "assessment_id")
    private Long assessmentId;
    
    @Column(name = "username", nullable = false)
    private String username;
    
    @Column(name = "assessment_type", nullable = false)
    private String assessmentType; // "mood", "stress", "anxiety", "wellbeing"
    
    @Column(name = "score")
    private int score;
    
    @Column(name = "category")
    private String category; // e.g., "Good", "Fair", "Poor"
    
    @Column(name = "feedback", columnDefinition = "TEXT")
    private String feedback;
    
    @Column(name = "completed_at")
    private LocalDateTime completedAt;
    
    @Column(name = "recommendations", columnDefinition = "TEXT")
    private String recommendationsText; // Store as comma-separated values

    public Assessment() {}

    public Assessment(String assessmentType) {
        this.assessmentType = assessmentType;
        this.completedAt = LocalDateTime.now();
    }

    public Assessment(String username, String assessmentType, 
                      int score, String category, String feedback) {
        this.username = username;
        this.assessmentType = assessmentType;
        this.score = score;
        this.category = category;
        this.feedback = feedback;
        this.completedAt = LocalDateTime.now();
    }

    // Getters & Setters
    public Long getAssessmentId() {
        return assessmentId;
    }

    public void setAssessmentId(Long assessmentId) {
        this.assessmentId = assessmentId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getAssessmentType() {
        return assessmentType;
    }

    public void setAssessmentType(String assessmentType) {
        this.assessmentType = assessmentType;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public LocalDateTime getCompletedAt() {
        return completedAt;
    }

    public void setCompletedAt(LocalDateTime completedAt) {
        this.completedAt = completedAt;
    }

    public String[] getRecommendations() {
        if (recommendationsText == null || recommendationsText.isEmpty()) {
            return new String[0];
        }
        return recommendationsText.split("\\|\\|");
    }

    public void setRecommendations(String[] recommendations) {
        if (recommendations == null || recommendations.length == 0) {
            this.recommendationsText = "";
        } else {
            this.recommendationsText = String.join("||", recommendations);
        }
    }
    
    public String getRecommendationsText() {
        return recommendationsText;
    }
    
    public void setRecommendationsText(String recommendationsText) {
        this.recommendationsText = recommendationsText;
    }
}
