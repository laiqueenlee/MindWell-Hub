package com.secj3303.dao;

import com.secj3303.model.MhpAvailability;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Repository
@Transactional
public class MhpAvailabilityDaoHibernate implements MhpAvailabilityDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(MhpAvailability availability) {
        sessionFactory.getCurrentSession().saveOrUpdate(availability);
    }

    @Override
    public void delete(Integer id) {
        MhpAvailability slot = sessionFactory.getCurrentSession().get(MhpAvailability.class, id);
        if (slot != null) {
            sessionFactory.getCurrentSession().delete(slot);
        }
    }

    @Override
    public List<MhpAvailability> findByMhpId(Integer mhpId) {
        String hql = "FROM MhpAvailability a WHERE a.mhp.id = :mhpId";
        return sessionFactory.getCurrentSession()
                .createQuery(hql, MhpAvailability.class)
                .setParameter("mhpId", mhpId)
                .getResultList();
    }

    @Override
    public List<MhpAvailability> findAll() {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM MhpAvailability", MhpAvailability.class)
                .getResultList();
    }
}
