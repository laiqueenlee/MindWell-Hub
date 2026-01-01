package com.secj3303.model;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

public class ContentRepository {
    
    // Changed List type to 'Content' to match your model class
    private static final List<Content> contentStore = new ArrayList<>();
    
    // Added AtomicInteger to handle 'int' IDs automatically
    private static final AtomicInteger idCounter = new AtomicInteger(1);

    // Initialize with dummy data matching Content.java fields
    static {
        // Item 1
        Content c1 = new Content();
        c1.setId(idCounter.getAndIncrement());
        c1.setTitle("Managing Study Stress");
        c1.setCategory("Stress Management");
        c1.setType("Video");
        c1.setStatus("published");
        c1.setStatusClass("badge-published");
        c1.setDate("2024-01-15");
        c1.setDescription("Learn to manage stress");
        c1.setContentBody("Detailed content about stress...");
        c1.setDifficulty("Beginner");
        c1.setDuration(15);
        c1.setPoints(10);
        contentStore.add(c1);

        // Item 2
        Content c2 = new Content();
        c2.setId(idCounter.getAndIncrement());
        c2.setTitle("Understanding Anxiety");
        c2.setCategory("Mental Health");
        c2.setType("Article");
        c2.setStatus("draft");
        c2.setStatusClass("badge-draft");
        c2.setDate("2024-01-20");
        c2.setDescription("Anxiety basics");
        c2.setContentBody("Detailed content about anxiety...");
        c2.setDifficulty("Intermediate");
        c2.setDuration(10);
        c2.setPoints(5);
        contentStore.add(c2);

        // Item 3
        Content c3 = new Content();
        c3.setId(idCounter.getAndIncrement());
        c3.setTitle("Mindfulness Exercises");
        c3.setCategory("Wellness");
        c3.setType("Interactive");
        c3.setStatus("published");
        c3.setStatusClass("badge-published");
        c3.setDate("2024-01-10");
        c3.setDescription("Practice mindfulness");
        c3.setContentBody("Detailed content about mindfulness...");
        c3.setDifficulty("Beginner");
        c3.setDuration(5);
        c3.setPoints(10);
        contentStore.add(c3);
    }

    public static List<Content> getAllContent() {
        return contentStore;
    }

    public static void addContent(Content content) {
        // Auto-generate ID
        content.setId(idCounter.getAndIncrement());
        
        // Helper to set the CSS class for the badge based on status
        determineStatusClass(content);
        
        // Set a default date if not provided (optional)
        if (content.getDate() == null || content.getDate().isEmpty()) {
            content.setDate(java.time.LocalDate.now().toString());
        }

        contentStore.add(0, content); // Add to top of list
    }

    // Changed parameter to 'int' to match Content.java
    public static Content getContentById(int id) {
        for (Content c : contentStore) {
            if (c.getId() == id) {
                return c;
            }
        }
        return null;
    }

    public static void updateContent(Content updatedContent) {
        for (int i = 0; i < contentStore.size(); i++) {
            Content existing = contentStore.get(i);
            
            // Changed comparison to '==' for int
            if (existing.getId() == updatedContent.getId()) {
                
                // Preserve the original creation date
                updatedContent.setDate(existing.getDate());
                
                // Update status class in case status changed from draft to published
                determineStatusClass(updatedContent);
                
                contentStore.set(i, updatedContent);
                return;
            }
        }
    }

    // Changed parameter to 'int'
    public static void deleteContent(int id) {
        contentStore.removeIf(c -> c.getId() == id);
    }

    // Helper method to set the correct badge CSS class
    private static void determineStatusClass(Content content) {
        if ("published".equalsIgnoreCase(content.getStatus())) {
            content.setStatusClass("badge-published");
        } else {
            content.setStatusClass("badge-draft");
        }
    }
}