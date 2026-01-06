package com.secj3303.dao;

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

    @Transactional
    public void delete(Long id) {
        ForumPost p = findById(id);
        if (p != null) sessionFactory.getCurrentSession().delete(p);
    }

    // added for admin analytics
    @Transactional(readOnly = true)
    public long countAllPosts() {
        return (long) sessionFactory.getCurrentSession()
                .createQuery("select count(fp) from ForumPost fp")
                .uniqueResult();
    }
}
