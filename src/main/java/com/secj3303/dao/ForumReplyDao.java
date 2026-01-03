package com.secj3303.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.secj3303.model.ForumReply;

@Repository
public class ForumReplyDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Transactional(readOnly = true)
    public List<ForumReply> findByPostId(Long postId) {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("from ForumReply r where r.postId = :pid order by r.createdAt asc", ForumReply.class)
                .setParameter("pid", postId)
                .getResultList();
    }

    @Transactional(readOnly = true)
    public ForumReply findById(Long id) {
        if (id == null) return null;
        Session session = sessionFactory.getCurrentSession();
        return session.get(ForumReply.class, id);
    }

    @Transactional
    public void delete(Long id) {
        if (id == null) return;
        Session session = sessionFactory.getCurrentSession();
        ForumReply r = session.get(ForumReply.class, id);
        if (r != null) session.delete(r);
    }

    @Transactional
    public void save(ForumReply reply) {
        sessionFactory.getCurrentSession().saveOrUpdate(reply);
    }
}
