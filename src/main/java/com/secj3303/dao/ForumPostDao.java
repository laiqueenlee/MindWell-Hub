package com.secj3303.dao;

import java.time.LocalDateTime;
import java.util.List;

import com.secj3303.model.ForumPost;

public interface ForumPostDao {

    List<ForumPost> findAllDesc();

    ForumPost findById(Long id);

    void save(ForumPost post);

    void delete(Long id);

    long countByAuthorId(Long authorId);

    List<ForumPost> findRecentByAuthorId(Long authorId, LocalDateTime since);


    long countAllPosts();

}
