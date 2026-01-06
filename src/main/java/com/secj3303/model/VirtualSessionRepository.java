package com.secj3303.model;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class VirtualSessionRepository {

    private static List<VirtualSession> sessions = new ArrayList<>();
    private static Integer nextId = 1;

    // Save a new session or update existing one
    public static void save(VirtualSession session) {
        if (session.getId() == null) {
            // Assign a simple string ID
            session.setId(nextId++);
            sessions.add(session);
        } else {
            // Update existing session
            for (int i = 0; i < sessions.size(); i++) {
                if (sessions.get(i).getId().equals(session.getId())) {
                    sessions.set(i, session);
                    break;
                }
            }
        }
    }

    // Find a session by its ID
    public static VirtualSession findById(String id) {
        for (VirtualSession vs : sessions) {
            if (vs.getId().equals(id)) {
                return vs;
            }
        }
        return null;
    }

    // Find all sessions for a student by username
    public static List<VirtualSession> findByStudentUsername(String studentUsername) {
        return sessions.stream()
                .filter(s -> s.getStudent() != null && s.getStudent().getUsername().equals(studentUsername))
                .collect(Collectors.toList());
    }

    // Find all sessions for an MHP by username
    public static List<VirtualSession> findByMhpUsername(String mhpUsername) {
        return sessions.stream()
                .filter(s -> s.getMhp() != null && s.getMhp().getUsername().equals(mhpUsername))
                .collect(Collectors.toList());
    }

    // Find pending sessions for an MHP (not yet confirmed)
    public static List<VirtualSession> findPendingByMhpUsername(String mhpUsername) {
        return sessions.stream()
                .filter(s -> s.getMhp() != null
                        && s.getMhp().getUsername().equals(mhpUsername)
                        && !s.isConfirmed())
                .collect(Collectors.toList());
    }

    // Optional: get all sessions
    public static List<VirtualSession> getAllSessions() {
        return new ArrayList<>(sessions);
    }
}
