package com.secj3303.model;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

public class ModerationItemRepository {

    private static final List<ModerationItem> moderationStore = new ArrayList<>();
    private static final AtomicInteger idCounter = new AtomicInteger(1);

    // Initialize with dummy data matching the image
    static {
        // Item 1: High Priority
        ModerationItem m1 = new ModerationItem(
            idCounter.getAndIncrement(),
            "Forum Post",
            "high",
            "Struggling with exam anxiety",
            "Anonymous",
            "Potential crisis"
        );
        moderationStore.add(m1);

        // Item 2: Medium Priority
        ModerationItem m2 = new ModerationItem(
            idCounter.getAndIncrement(),
            "Comment",
            "medium",
            "Re: Coping strategies",
            "Student123",
            "Inappropriate language"
        );
        moderationStore.add(m2);

        // Item 3: Low Priority
        ModerationItem m3 = new ModerationItem(
            idCounter.getAndIncrement(),
            "Article",
            "low",
            "Managing Depression",
            "Dr. Smith",
            "Pending review"
        );
        moderationStore.add(m3);
    }

    // Get all items that are still PENDING (simulating a queue)
    public static List<ModerationItem> getPendingItems() {
        return moderationStore.stream()
                .filter(item -> "PENDING".equalsIgnoreCase(item.getStatus()))
                .collect(Collectors.toList());
    }

    public static ModerationItem getItemById(int id) {
        for (ModerationItem item : moderationStore) {
            if (item.getId() == id) {
                return item;
            }
        }
        return null;
    }

    // "Approve" removes it from the queue by changing status
    public static void approveItem(int id) {
        ModerationItem item = getItemById(id);
        if (item != null) {
            item.setStatus("APPROVED");
            // In a real app, you might trigger an email here or update the original content
        }
    }

    // "Remove" removes it from the queue by changing status or deleting
    public static void removeItem(int id) {
        // We remove it entirely from the list for the 'Remove' action
        moderationStore.removeIf(item -> item.getId() == id);
    }
}