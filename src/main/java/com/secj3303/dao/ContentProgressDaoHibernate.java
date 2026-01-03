package com.secj3303.dao;

import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.secj3303.model.Content.ContentProgress;

@Repository
@Transactional
public class ContentProgressDaoHibernate implements ContentProgressDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public ContentProgress findByUserAndContent(int userId, int contentId) {
        String hql = "FROM ContentProgress cp WHERE cp.user.id = :uid AND cp.content.id = :cid";
        Query<ContentProgress> query = sessionFactory.getCurrentSession().createQuery(hql, ContentProgress.class);
        query.setParameter("uid", userId);
        query.setParameter("cid", contentId);
        return query.uniqueResult();
    }

    @Override
    public void saveOrUpdate(ContentProgress progress) {
        sessionFactory.getCurrentSession().saveOrUpdate(progress);
    }

    // In ContentProgressDaoHibernate.java

@Override
public Double getAverageRating(int contentId) {
    // HQL to calculate Average
    String hql = "SELECT AVG(cp.rating) FROM ContentProgress cp WHERE cp.content.id = :cid AND cp.rating > 0";
    
    Query<Double> query = sessionFactory.getCurrentSession().createQuery(hql, Double.class);
    query.setParameter("cid", contentId);
    
    Double avg = query.uniqueResult();
    
    // If no ratings exist, avg will be null. Return 0.0 in that case.
    return (avg != null) ? avg : 0.0;
}
}