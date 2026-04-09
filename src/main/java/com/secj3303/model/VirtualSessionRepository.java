package com.secj3303.model;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class VirtualSessionRepository {

    private static List<VirtualSession> sessions = new ArrayList<>();
    private static Integer nextId = 1;

    public static void save(VirtualSession session) {
        if (session.getId() == null) {
            session.setId(nextId++);
            sessions.add(session);
        } else {
            for (int i = 0; i < sessions.size(); i++) {
                if (sessions.get(i).getId().equals(session.getId())) {
                    sessions.set(i, session);
                    break;
                }
            }
        }
    }

    public static VirtualSession findById(String id) {
        for (VirtualSession vs : sessions) {
            if (vs.getId().equals(id)) {
                return vs;
            }
        }
        return null;
    }

    public static List<VirtualSession> findByStudentUsername(String studentUsername) {
        return sessions.stream()
                .filter(s -> s.getStudent() != null && s.getStudent().getUsername().equals(studentUsername))
                .collect(Collectors.toList());
    }

    public static List<VirtualSession> findByMhpUsername(String mhpUsername) {
        return sessions.stream()
                .filter(s -> s.getMhp() != null && s.getMhp().getUsername().equals(mhpUsername))
                .collect(Collectors.toList());
    }

    public static List<VirtualSession> findPendingByMhpUsername(String mhpUsername) {
        return sessions.stream()
                .filter(s -> s.getMhp() != null
                        && s.getMhp().getUsername().equals(mhpUsername)
                        && !s.isConfirmed())
                .collect(Collectors.toList());
    }

    public static List<VirtualSession> getAllSessions() {
        return new ArrayList<>(sessions);
    }
}
