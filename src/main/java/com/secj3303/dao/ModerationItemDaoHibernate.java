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
    // OLD QUERY: "from ModerationItem where status = :status"
    
    // NEW QUERY: Fetch both 'PENDING' and 'Flagged' items
    Query<ModerationItem> query = sessionFactory.getCurrentSession()
        .createQuery("from ModerationItem where status IN (:s1, :s2)", ModerationItem.class);
    
    query.setParameter("s1", "PENDING");
    query.setParameter("s2", "Flagged"); // Keeps flagged items visible
    
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