package com.secj3303.dao;

import java.time.LocalDateTime;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.secj3303.model.Assessment;

@Repository
@Transactional
public class AssessmentDaoHibernate implements AssessmentDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(Assessment assessment) {
        Session session = sessionFactory.getCurrentSession();
        session.save(assessment);
    }

    @Override
    public Assessment findById(String assessmentId) {
        Session session = sessionFactory.getCurrentSession();
        return session.get(Assessment.class, assessmentId);
    }

    @Override
    public List<Assessment> findByUsername(String username) {
        Session session = sessionFactory.getCurrentSession();
        Query<Assessment> query = session.createQuery(
            "FROM Assessment WHERE username = :username ORDER BY completedAt DESC", 
            Assessment.class
        );
        query.setParameter("username", username);
        return query.list();
    }

    @Override
    public List<Assessment> findByUsernameAndType(String username, String assessmentType) {
        Session session = sessionFactory.getCurrentSession();
        Query<Assessment> query = session.createQuery(
            "FROM Assessment WHERE username = :username AND assessmentType = :type ORDER BY completedAt DESC", 
            Assessment.class
        );
        query.setParameter("username", username);
        query.setParameter("type", assessmentType);
        return query.list();
    }

    @Override
    public List<Assessment> findAll() {
        Session session = sessionFactory.getCurrentSession();
        Query<Assessment> query = session.createQuery("FROM Assessment ORDER BY completedAt DESC", Assessment.class);
        return query.list();
    }

    @Override
    public void update(Assessment assessment) {
        Session session = sessionFactory.getCurrentSession();
        session.update(assessment);
    }

    @Override
    public void delete(String assessmentId) {
        Session session = sessionFactory.getCurrentSession();
        Assessment assessment = session.get(Assessment.class, assessmentId);
        if (assessment != null) {
            session.delete(assessment);
        }
    }

    @Override
    public Assessment findLatestByUsernameAndType(String username, String assessmentType) {
        Session session = sessionFactory.getCurrentSession();
        Query<Assessment> query = session.createQuery(
            "FROM Assessment WHERE username = :username AND assessmentType = :type ORDER BY completedAt DESC", 
            Assessment.class
        );
        query.setParameter("username", username);
        query.setParameter("type", assessmentType);
        query.setMaxResults(1);
        List<Assessment> results = query.list();
        return results.isEmpty() ? null : results.get(0);
    }

    @Override
    public List<Assessment> findRecentByUsername(String username, int limit) {
        Session session = sessionFactory.getCurrentSession();
        Query<Assessment> query = session.createQuery(
            "FROM Assessment WHERE username = :username ORDER BY completedAt DESC", 
            Assessment.class
        );
        query.setParameter("username", username);
        query.setMaxResults(limit);
        return query.list();
    }

    @Override
    public List<Assessment> findRecentByUsername(String username, LocalDateTime since) {
        Session session = sessionFactory.getCurrentSession();
        Query<Assessment> query = session.createQuery(
            "FROM Assessment WHERE username = :username AND completedAt >= :since ORDER BY completedAt DESC", 
            Assessment.class
        );
        query.setParameter("username", username);
        query.setParameter("since", since);
        return query.list();
    }
}
