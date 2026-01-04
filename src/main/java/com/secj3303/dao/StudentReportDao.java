package com.secj3303.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.secj3303.model.Report.StudentReport;

@Repository
@Transactional
public class StudentReportDao {

    private final SessionFactory sessionFactory;

    @Autowired
    public StudentReportDao(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public void save(StudentReport r) {
        sessionFactory.getCurrentSession().saveOrUpdate(r);
    }

    public StudentReport findById(int id) {
        return sessionFactory.getCurrentSession().get(StudentReport.class, id);
    }

    public List<StudentReport> findPendingReports() {
        Query<StudentReport> q = sessionFactory.getCurrentSession()
            .createQuery("from StudentReport where status = :s order by createdAt desc", StudentReport.class);
        q.setParameter("s", "PENDING");
        return q.getResultList();
    }

    public List<StudentReport> findAll() {
        return sessionFactory.getCurrentSession().createQuery("from StudentReport order by createdAt desc", StudentReport.class).getResultList();
    }

    public void delete(int id) {
        StudentReport r = findById(id);
        if (r != null) sessionFactory.getCurrentSession().delete(r);
    }
}
