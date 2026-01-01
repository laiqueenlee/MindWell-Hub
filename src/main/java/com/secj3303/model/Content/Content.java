package com.secj3303.model.Content;

import javax.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "CONTENT")
public class Content {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "content_id")
    private int id;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "category")
    private String category;

    @Column(name = "created_date")
    private String date;

    @Column(name = "status")
    private String status;      

    @Column(name = "content_type")
    private String type; // Values: "Video", "Article", "Interactive"

   
  
    @OneToMany(mappedBy = "content", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<VideoSection> videoSections = new ArrayList<>();

    @OneToMany(mappedBy = "content", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<ArticleSection> articleSections = new ArrayList<>();

    @OneToMany(mappedBy = "content", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<QuizQuestion> quizQuestions = new ArrayList<>();

    @Column(name = "difficulty")
    private String difficulty;

    @Column(name = "duration")
    private int duration;

    @Column(name = "points")
    private int points;

    // --- Constructors ---
    public Content() {}

    
    public void addVideoSection(VideoSection video) {
        videoSections.add(video);
        video.setContent(this);
    }
    
    public void removeVideoSection(VideoSection video) {
        videoSections.remove(video);
        video.setContent(null);
    }
    
    public void addArticleSection(ArticleSection section) {
        articleSections.add(section);
        section.setContent(this);
    }
    
    public void addQuizQuestion(QuizQuestion question) {
        quizQuestions.add(question);
        question.setContent(this);
    }

    // --- Getters and Setters ---

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public List<VideoSection> getVideoSections() { return videoSections; }
    public void setVideoSections(List<VideoSection> videoSections) { this.videoSections = videoSections; }

    public List<ArticleSection> getArticleSections() { return articleSections; }
    public void setArticleSections(List<ArticleSection> articleSections) { this.articleSections = articleSections; }

    public List<QuizQuestion> getQuizQuestions() { return quizQuestions; }
    public void setQuizQuestions(List<QuizQuestion> quizQuestions) { this.quizQuestions = quizQuestions; }

    public String getDifficulty() { return difficulty; }
    public void setDifficulty(String difficulty) { this.difficulty = difficulty; }

    public int getDuration() { return duration; }
    public void setDuration(int duration) { this.duration = duration; }

    public int getPoints() { return points; }
    public void setPoints(int points) { this.points = points; }
}