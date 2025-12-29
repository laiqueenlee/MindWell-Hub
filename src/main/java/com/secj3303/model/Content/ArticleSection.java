package com.secj3303.model.Content;

import javax.persistence.*;

@Entity
@Table(name = "ARTICLE_SECTION")
public class ArticleSection {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String subtitle;

    @Lob
    private String body; // The HTML content

    @ManyToOne
    @JoinColumn(name = "content_id")
    private Content content;

    // Getters and Setters
    public void setContent(Content content) { this.content = content; }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSubtitle() {
        return subtitle;
    }

    public void setSubtitle(String subtitle) {
        this.subtitle = subtitle;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public Content getContent() {
        return content;
    }
    
    
}