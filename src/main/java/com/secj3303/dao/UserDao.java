package com.secj3303.dao;

import java.util.List;

import com.secj3303.model.User;

public interface UserDao {
    User findById(int id);
    List<User> findAll();
    void save(User user);
    void delete(User user);

    User findByEmail(String email);

    long countAllUsers();
}
