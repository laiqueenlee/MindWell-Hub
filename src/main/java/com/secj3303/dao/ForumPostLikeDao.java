package com.secj3303.dao;

import com.secj3303.model.ForumPostLike;

public interface ForumPostLikeDao {

    ForumPostLike findByPostAndUser(Long postId, Long userId);

    void save(ForumPostLike like);

    void delete(ForumPostLike like);
}
