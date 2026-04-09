package com.secj3303.model.Content;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "VIDEO_SECTION")
public class VideoSection {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "video_id")
    private int id;

    @Column(name = "video_url", nullable = false)
    private String videoUrl;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "content_id", nullable = false)
    private Content content;

    public VideoSection() {}

    public VideoSection(String videoUrl, String description) {
        this.videoUrl = videoUrl;
        this.description = description;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getVideoUrl() { return videoUrl; }
    public void setVideoUrl(String videoUrl) { this.videoUrl = videoUrl; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Content getContent() { return content; }
    public void setContent(Content content) { this.content = content; }
}