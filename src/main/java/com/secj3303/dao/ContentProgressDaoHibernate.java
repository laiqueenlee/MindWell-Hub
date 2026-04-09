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


    @Override
    public Double getAverageRating(int contentId) {
        String hql = "SELECT AVG(cp.rating) FROM ContentProgress cp WHERE cp.content.id = :cid AND cp.rating > 0";

        Query<Double> query = sessionFactory.getCurrentSession().createQuery(hql, Double.class);
        query.setParameter("cid", contentId);

        Double avg = query.uniqueResult();

        return (avg != null) ? avg : 0.0;
    }

    @Override
    public Double getUserAverageProgress(int userId) {

        String sumHql = "SELECT COALESCE(SUM(cp.progressPercent), 0) " +
                "FROM ContentProgress cp " +
                "WHERE cp.user.id = :uid " +
                "AND cp.content.status = 'Published'";

        Query<Long> sumQuery = sessionFactory.getCurrentSession().createQuery(sumHql, Long.class);
        sumQuery.setParameter("uid", userId);
        Long totalUserProgress = sumQuery.uniqueResult();

        String countHql = "SELECT COUNT(c) FROM Content c WHERE c.status = 'Published'";
        Query<Long> countQuery = sessionFactory.getCurrentSession().createQuery(countHql, Long.class);
        Long totalPublishedContent = countQuery.uniqueResult();

        if (totalPublishedContent == null || totalPublishedContent == 0) {
            return 0.0;
        }
        return (double) totalUserProgress / totalPublishedContent;
    }

    @Override
    public long countCompletedContent(int userId) {

        String hql = "SELECT COUNT(cp) FROM ContentProgress cp " +
                "WHERE cp.user.id = :uid " +
                "AND cp.progressPercent = 100 " +
                "AND cp.content.status = 'Published'";

        Query<Long> query = sessionFactory.getCurrentSession().createQuery(hql, Long.class);
        query.setParameter("uid", userId);

        Long count = query.uniqueResult();
        return (count != null) ? count : 0;
    }
}