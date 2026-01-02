package com.secj3303.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.secj3303.model.ForumPostLike;

@Repository
public class ForumPostLikeDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Transactional(readOnly = true)
    public ForumPostLike findByPostAndUser(Long postId, Long userId) {
        List<ForumPostLike> list = sessionFactory.getCurrentSession()
            .createQuery("from ForumPostLike f where f.postId = :postId and f.userId = :userId", ForumPostLike.class)
            .setParameter("postId", postId)
            .setParameter("userId", userId)
            .getResultList();
        return list.isEmpty() ? null : list.get(0);
    }

    @Transactional
    public void save(ForumPostLike like) {
        sessionFactory.getCurrentSession().saveOrUpdate(like);
    }

    @Transactional
    public void delete(ForumPostLike like) {
        sessionFactory.getCurrentSession().delete(like);
    }
}
