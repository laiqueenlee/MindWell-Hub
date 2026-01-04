package com.secj3303.dao;

import java.util.List;

import com.secj3303.model.Content.Content;

public interface ContentDao {
    List<Content> findAll();
    Content findById(int id);
    Content findByIdWithAssociations(int id);
    void save(Content content);
    void delete(int id);

    long countActiveContent(); // or countAllContent()

    public long countByStatus(String status);

    public List<Content> findByStatus(String status);
}