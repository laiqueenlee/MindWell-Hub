package com.secj3303.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.secj3303.model.ForumPost;

@Repository
public class ForumPostDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Transactional(readOnly = true)
    public List<ForumPost> findAllDesc() {
        Session session = sessionFactory.getCurrentSession();
        // Simple HQL keeps ordering explicit and avoids any Criteria quirks
        return session.createQuery(
                "from ForumPost fp order by fp.createdAt desc",
                ForumPost.class)
            .getResultList();
    }

    @Transactional(readOnly = true)
    public ForumPost findById(Long id) {
        if (id == null) return null;
        return sessionFactory.getCurrentSession().get(ForumPost.class, id);
    }

    @Transactional
    public void save(ForumPost post) {
        sessionFactory.getCurrentSession().saveOrUpdate(post);
    }

    @Transactional
    public void delete(Long id) {
        ForumPost p = findById(id);
        if (p != null) sessionFactory.getCurrentSession().delete(p);
    }
}
