package com.secj3303.dao;

import com.secj3303.model.VirtualSession;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional // Automatically handles opening/closing database transactions
public class VirtualSessionDaoHibernate {

    @Autowired
    private SessionFactory sessionFactory;

    // Save or Update session in MySQL
    public void save(VirtualSession session) {
        sessionFactory.getCurrentSession().saveOrUpdate(session);
    }

    // Find a session by its Integer ID (changed from String to match your Model)
    public VirtualSession findById(Integer id) {
        return sessionFactory.getCurrentSession().get(VirtualSession.class, id);
    }

    // Find sessions for a student using HQL (Hibernate Query Language)
    public List<VirtualSession> findByStudentUsername(String username) {
        String hql = "FROM VirtualSession vs WHERE vs.student.username = :uname";
        return sessionFactory.getCurrentSession()
                .createQuery(hql, VirtualSession.class)
                .setParameter("uname", username)
                .getResultList();
    }

    // Find sessions for an MHP
    public List<VirtualSession> findByMhpUsername(String username) {
        String hql = "FROM VirtualSession vs WHERE vs.mhp.username = :uname";
        return sessionFactory.getCurrentSession()
                .createQuery(hql, VirtualSession.class)
                .setParameter("uname", username)
                .getResultList();
    }

    // Find pending sessions for an MHP
    public List<VirtualSession> findPendingByMhpUsername(String username) {
        String hql = "FROM VirtualSession vs WHERE vs.mhp.username = :uname AND vs.confirmed = false";
        return sessionFactory.getCurrentSession()
                .createQuery(hql, VirtualSession.class)
                .setParameter("uname", username)
                .getResultList();
    }

    // Get all sessions from the database
    public List<VirtualSession> getAllSessions() {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM VirtualSession", VirtualSession.class)
                .getResultList();
    }
}