package com.secj3303.dao;

import java.util.List;
import java.util.ArrayList; // Added import

import org.hibernate.Hibernate; // Import needed for initialization
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.secj3303.model.Content.Content;
import com.secj3303.model.Content.QuizQuestion;
import com.secj3303.model.Content.VideoSection;

@Repository
@Transactional
public class ContentDaoHibernate implements ContentDao {

    private final SessionFactory sessionFactory;

    @Autowired
    public ContentDaoHibernate(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public List<Content> findAll() {
        // HQL query to get all content
        Query<Content> query = sessionFactory.getCurrentSession().createQuery("from Content", Content.class);
        //return query.getResultList();
        List<Content> list = query.getResultList();
        // FIX: Initialize collections for all items
        for (Content c : list) {
            initializeContent(c);
        }
        
        return list;
    }

    @Override
    public Content findById(int id) {
        return sessionFactory.getCurrentSession().get(Content.class, id);
    }

    @Override
    public Content findByIdWithAssociations(int id) {
        // 1. Fetch Content and ArticleSections in one query
        // "DISTINCT" prevents duplicate Content objects in the result
        String hql = "SELECT DISTINCT c FROM Content c LEFT JOIN FETCH c.articleSections WHERE c.id = :id";
        Query<Content> query = sessionFactory.getCurrentSession().createQuery(hql, Content.class);
        query.setParameter("id", id);
        
        Content content = query.uniqueResult();
        
        if (content != null) {
            // 2. Safely initialize the other collections
            // This forces Hibernate to run the SELECT queries for these lists
            // without replacing the collection objects themselves.
            org.hibernate.Hibernate.initialize(content.getVideoSections());
            org.hibernate.Hibernate.initialize(content.getQuizQuestions());
            
            // 3. Initialize Quiz Options (Deep loading)
            for (QuizQuestion q : content.getQuizQuestions()) {
                org.hibernate.Hibernate.initialize(q.getOptions());
            }
        }
        
        return content;
    }

    @Override
    public void save(Content content) {
        // saveOrUpdate handles both adding new content and editing existing content
        sessionFactory.getCurrentSession().saveOrUpdate(content);
    }

    @Override
    public void delete(int id) {
        Content content = findById(id);
        if (content != null) {
            sessionFactory.getCurrentSession().delete(content);
        }
    }

    @Override
    public long countActiveContent() {
        Query<Long> query = sessionFactory.getCurrentSession().createQuery("select count(c) from Content c where c.status = 'published'", Long.class);
        return query.uniqueResult();
    }
    @Override

public long countByStatus(String status) {
    String hql = "SELECT COUNT(c) FROM Content c WHERE c.status = :status";
    Query<Long> query = sessionFactory.getCurrentSession().createQuery(hql, Long.class);
    query.setParameter("status", status);
    
    Long count = query.uniqueResult();
    return (count != null) ? count : 0;
}

@Override
public List<Content> findByStatus(String status) {
    String hql = "FROM Content c WHERE c.status = :status";
    Query<Content> query = sessionFactory.getCurrentSession().createQuery(hql, Content.class);
    query.setParameter("status", status);
    //return query.getResultList();
    List<Content> list = query.getResultList();
    
    // --- ADD THIS LOOP TO FIX THE ERROR ---
    for (Content c : list) {
        initializeContent(c);
    }
    // --------------------------------------
    
    return list;
}

// --- HELPER METHOD TO AVOID REPEATING CODE ---
    private void initializeContent(Content c) {
        if (c == null) return;
        Hibernate.initialize(c.getArticleSections());
        Hibernate.initialize(c.getVideoSections());
        Hibernate.initialize(c.getQuizQuestions());
        
        // Initialize nested Quiz Options
        if (c.getQuizQuestions() != null) {
            for (QuizQuestion q : c.getQuizQuestions()) {
                Hibernate.initialize(q.getOptions());
            }
        }
    }
}
