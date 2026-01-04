package com.secj3303.dao;

import java.util.List;

import com.secj3303.model.Role;
import com.secj3303.model.User;

public interface UserDao {
    User findById(int id);
    List<User> findAll();
    void save(User user);
    void delete(User user);

    User findByEmail(String email);

    long countAllUsers();

    //added this for mhp-virtual ses part
    List<User> findByRole(Role role);

    //admin analytics
    long countByRole(Role role);

    // For findRecentUsers, you might need a custom query or a Pageable request:
    List<User> findRecentUsers(int limit);
}
