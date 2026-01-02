package com.secj3303.dao;

import com.secj3303.model.Content.ContentProgress;

public interface ContentProgressDao {
    ContentProgress findByUserAndContent(int userId, int contentId);
    void saveOrUpdate(ContentProgress progress);

    public Double getAverageRating(int contentId);
}