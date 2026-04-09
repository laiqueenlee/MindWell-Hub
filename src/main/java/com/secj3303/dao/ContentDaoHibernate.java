package com.secj3303.dao;

import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.secj3303.model.Content.Content;
import com.secj3303.model.Content.QuizQuestion;

@Repository
@Transactional
public class ContentDaoHibernate implements ContentDao {

    private final SessionFactory sessionFactory;

    @Autowired
    public ContentDaoHibernate(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public List<Content> findAll() {
        Query<Content> query = sessionFactory.getCurrentSession().createQuery("from Content", Content.class);
        List<Content> list = query.getResultList();
        for (Content c : list) {
            initializeContent(c);
        }

        return list;
    }

    @Override
    public Content findById(int id) {
        return sessionFactory.getCurrentSession().get(Content.class, id);
    }

    @Override
    public Content findByIdWithAssociations(int id) {
        String hql = "SELECT DISTINCT c FROM Content c LEFT JOIN FETCH c.articleSections WHERE c.id = :id";
        Query<Content> query = sessionFactory.getCurrentSession().createQuery(hql, Content.class);
        query.setParameter("id", id);

        Content content = query.uniqueResult();

        if (content != null) {

            org.hibernate.Hibernate.initialize(content.getVideoSections());
            org.hibernate.Hibernate.initialize(content.getQuizQuestions());

            for (QuizQuestion q : content.getQuizQuestions()) {
                org.hibernate.Hibernate.initialize(q.getOptions());
            }
        }

        return content;
    }

    @Override
    public void save(Content content) {
        sessionFactory.getCurrentSession().saveOrUpdate(content);
    }

    @Override
    public void delete(int id) {
        Content content = findById(id);
        if (content != null) {
            sessionFactory.getCurrentSession().delete(content);
        }
    }

    @Override
    public long countActiveContent() {
        Query<Long> query = sessionFactory.getCurrentSession()
                .createQuery("select count(c) from Content c where c.status = 'Published'", Long.class);
        return query.uniqueResult();
    }

    @Override

    public long countByStatus(String status) {
        String hql = "SELECT COUNT(c) FROM Content c WHERE c.status = :status";
        Query<Long> query = sessionFactory.getCurrentSession().createQuery(hql, Long.class);
        query.setParameter("status", status);

        Long count = query.uniqueResult();
        return (count != null) ? count : 0;
    }

    @Override
    public List<Content> findByStatus(String status) {
        String hql = "FROM Content c WHERE c.status = :status";
        Query<Content> query = sessionFactory.getCurrentSession().createQuery(hql, Content.class);
        query.setParameter("status", status);
        List<Content> list = query.getResultList();

        for (Content c : list) {
            initializeContent(c);
        }

        return list;
    }

    private void initializeContent(Content c) {
        if (c == null)
            return;
        Hibernate.initialize(c.getArticleSections());
        Hibernate.initialize(c.getVideoSections());
        Hibernate.initialize(c.getQuizQuestions());

        if (c.getQuizQuestions() != null) {
            for (QuizQuestion q : c.getQuizQuestions()) {
                Hibernate.initialize(q.getOptions());
            }
        }
    }
}
