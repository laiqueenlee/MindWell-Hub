package com.secj3303.model;

import java.util.ArrayList;
import java.util.List;

public class UserRepository {

    private static final List<User> users = new ArrayList<>();

    public static User findByUsernameAndPasswordAndRole(String username, String password, Role role) {
        for (User u : users) {
            if (u.getUsername().equals(username)
                    && u.getPassword().equals(password)
                    && u.getRole() == role) {
                return u;
            }
        }
        return null;
    }

    public static User findByUsername(String username) {
        for (User u : users) {
            if (u.getUsername().equals(username)) {
                return u;
            }
        }
        return null;
    }

    public static User findByUsernameOrEmail(String identifier) {
        if (identifier == null) return null;
        for (User u : users) {
            if (identifier.equalsIgnoreCase(u.getUsername()) ||
                identifier.equalsIgnoreCase(u.getEmail())) {
                return u;
            }
        }
        return null;
    }

    public static void addUser(User user) {
        users.add(user);
    }

    public static List<User> getAllUsers() {
        return users;
    }
}
