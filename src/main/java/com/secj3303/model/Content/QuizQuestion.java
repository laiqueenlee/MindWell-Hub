package com.secj3303.model.Content;

import javax.persistence.*;

import java.util.List;

@Entity
@Table(name = "QUIZ_QUESTION")
public class QuizQuestion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String questionText;

    @Column(columnDefinition = "TEXT") // Use TEXT if the intro is long
    private String introduction;

    @ManyToOne
    @JoinColumn(name = "content_id")
    private Content content;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "question_id") // Unidirectional is simpler for options
    private List<QuizOption> options;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getQuestionText() {
        return questionText;
    }

    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }

    public String getIntroduction() { 
        return introduction; 
    
    }
    public void setIntroduction(String introduction) { 
        this.introduction = introduction; 
    }

    public Content getContent() {
        return content;
    }

    public void setContent(Content content) {
        this.content = content;
    }

    public List<QuizOption> getOptions() {
        return options;
    }

    public void setOptions(List<QuizOption> options) {
        this.options = options;
    }

   
}