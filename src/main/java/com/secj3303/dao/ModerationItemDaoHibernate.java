package com.secj3303.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.secj3303.model.Content.ModerationItem;

@Repository
@Transactional
public class ModerationItemDaoHibernate implements ModerationItemDao {

    private final SessionFactory sessionFactory;

    @Autowired
    public ModerationItemDaoHibernate(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public List<ModerationItem> findPendingItems() {
        // HQL query to find only items where status is 'PENDING'
        Query<ModerationItem> query = sessionFactory.getCurrentSession()
            .createQuery("from ModerationItem where status = :status", ModerationItem.class);
        query.setParameter("status", "PENDING");
        return query.getResultList();
    }

    @Override
    public ModerationItem findById(int id) {
        return sessionFactory.getCurrentSession().get(ModerationItem.class, id);
    }

    @Override
    public void save(ModerationItem item) {
        sessionFactory.getCurrentSession().saveOrUpdate(item);
    }

    @Override
    public void delete(int id) {
        ModerationItem item = findById(id);
        if (item != null) {
            sessionFactory.getCurrentSession().delete(item);
        }
    }
}