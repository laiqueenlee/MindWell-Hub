package com.secj3303.dao;

import com.secj3303.model.VirtualSession;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

@Repository
@Transactional 
public class VirtualSessionDaoHibernate implements VirtualSessionDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(VirtualSession session) {
        sessionFactory.getCurrentSession().saveOrUpdate(session);
    }

    @Override
    public VirtualSession findById(Integer id) {
        return sessionFactory.getCurrentSession().get(VirtualSession.class, id);
    }

    @Override
    public List<VirtualSession> findByStudentUsername(String username) {
        String hql = "FROM VirtualSession vs WHERE vs.student.username = :uname";
        return sessionFactory.getCurrentSession()
                .createQuery(hql, VirtualSession.class)
                .setParameter("uname", username)
                .getResultList();
    }

    @Override
    public List<VirtualSession> findByMhpUsername(String username) {
        String hql = "FROM VirtualSession vs WHERE vs.mhp.username = :uname";
        return sessionFactory.getCurrentSession()
                .createQuery(hql, VirtualSession.class)
                .setParameter("uname", username)
                .getResultList();
    }

    @Override
    public List<VirtualSession> findPendingByMhpUsername(String username) {
        String hql = "FROM VirtualSession vs WHERE vs.mhp.username = :uname AND vs.confirmed = false";
        return sessionFactory.getCurrentSession()
                .createQuery(hql, VirtualSession.class)
                .setParameter("uname", username)
                .getResultList();
    }

    // Renamed from getAllSessions to findAll to match the Interface
    @Override
    public List<VirtualSession> findAll() {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM VirtualSession", VirtualSession.class)
                .getResultList();
    }

    @Override
    public List<VirtualSession> findByMhpAndDate(Integer mhpId, LocalDate date) {
        String hql = "FROM VirtualSession vs WHERE vs.mhp.id = :mId AND vs.sessionDate = :sDate";
        return sessionFactory.getCurrentSession()
                .createQuery(hql, VirtualSession.class)
                .setParameter("mId", mhpId)
                .setParameter("sDate", date)
                .getResultList();
    }

    @Override
    public List<VirtualSession> findByStudentId(Integer studentId) {
    return sessionFactory.getCurrentSession()
        .createQuery("FROM VirtualSession WHERE student.id = :sid ORDER BY sessionDate ASC", VirtualSession.class)
        .setParameter("sid", studentId)
        .list();
    }

    @Override
    public Long countSessionsByDate(LocalDate date) {
        String hql = "SELECT COUNT(vs) FROM VirtualSession vs WHERE vs.sessionDate = :sDate";
        return sessionFactory.getCurrentSession()
                .createQuery(hql, Long.class)
                .setParameter("sDate", date)
                .uniqueResult();
    }

    @Override
    public Long countSessionsThisWeek(LocalDate startOfWeek, LocalDate endOfWeek) {
        String hql = "SELECT COUNT(vs) FROM VirtualSession vs WHERE vs.sessionDate BETWEEN :start AND :end";
        return sessionFactory.getCurrentSession()
                .createQuery(hql, Long.class)
                .setParameter("start", startOfWeek)
                .setParameter("end", endOfWeek)
                .uniqueResult();
    }

    @Override
    public Long countTotalStudents() {
        String hql = "SELECT COUNT(DISTINCT vs.student.id) FROM VirtualSession vs";
        return sessionFactory.getCurrentSession()
                .createQuery(hql, Long.class)
                .uniqueResult();
    }
}