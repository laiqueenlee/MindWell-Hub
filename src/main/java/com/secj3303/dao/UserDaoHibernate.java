package com.secj3303.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.secj3303.model.Role;
import com.secj3303.model.User;

@Repository
@Transactional
public class UserDaoHibernate implements UserDao {

    private final SessionFactory sessionFactory;

    @Autowired
    public UserDaoHibernate(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    private Session currentSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public User findById(int id) {
        return currentSession().get(User.class, id);
    }

    @Override
    public List<User> findAll() {
        Query<User> q = currentSession().createQuery("from User", User.class);
        return q.getResultList();
    }

    @Override
    public void save(User user) {
        currentSession().saveOrUpdate(user);
    }

    @Override
    public void delete(User user) {
        currentSession().delete(user);
    }

    @Override
    public User findByEmail(String email) {
        Query<User> q = currentSession().createQuery(
            "from User u where u.email = :email", User.class);
        q.setParameter("email", email);
        return q.uniqueResult();
    }

    @Override
    public long countAllUsers() {
        Query<Long> query = sessionFactory.getCurrentSession().createQuery("select count(u) from User u", Long.class);
        return query.uniqueResult();
    }


    //added this for mhp-virtual ses part
    @Override
    public List<User> findByRole(Role role) {
    return sessionFactory.getCurrentSession()
            .createQuery("FROM User u WHERE u.role = :role", User.class)
            .setParameter("role", role)
            .getResultList();
    }

    @Override
    public long countByRole(Role role) {
        String hql = "SELECT count(u) FROM User u WHERE u.role = :role";
        return sessionFactory.getCurrentSession()
                    .createQuery(hql, Long.class)
                    .setParameter("role", role)
                    .uniqueResult();
    }

    @Override
    public List<User> findRecentUsers(int limit) {
    return sessionFactory.getCurrentSession()
            .createQuery("from User order by id desc", User.class) // "id desc" puts newest at top
            .setMaxResults(limit)
            .list();
    }
}