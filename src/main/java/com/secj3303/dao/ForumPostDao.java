package com.secj3303.dao;

import java.time.LocalDateTime;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
 
import com.secj3303.model.ForumPost;

public interface ForumPostDao {

    List<ForumPost> findAllDesc();

    ForumPost findById(Long id);

    void save(ForumPost post);

    void delete(Long id);

    long countByAuthorId(Long authorId);

    List<ForumPost> findRecentByAuthorId(Long authorId, LocalDateTime since);

    // added for admin analytics
    @Transactional(readOnly = true)
    public long countAllPosts() {
        return (long) sessionFactory.getCurrentSession()
                .createQuery("select count(fp) from ForumPost fp")
                .uniqueResult();
    }

}
