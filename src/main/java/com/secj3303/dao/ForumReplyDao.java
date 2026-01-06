package com.secj3303.dao;

import java.util.List;

import com.secj3303.model.ForumReply;

public interface ForumReplyDao {

    List<ForumReply> findByPostId(Long postId);

    ForumReply findById(Long id);

    void delete(Long id);

    void save(ForumReply reply);
}
