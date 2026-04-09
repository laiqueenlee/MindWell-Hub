package com.secj3303.dao;

import java.util.List;

import com.secj3303.model.Content.ModerationItem;

public interface ModerationItemDao {
    List<ModerationItem> findPendingItems();
    
    ModerationItem findById(int id);
    void save(ModerationItem item);
    void delete(int id);
}