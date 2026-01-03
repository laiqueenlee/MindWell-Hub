package com.secj3303.dao;

import java.util.List;
import com.secj3303.model.VirtualSession;

public interface VirtualSessionDao {
    void save(VirtualSession session);
    VirtualSession findById(int id);
    List<VirtualSession> findByStudentUsername(String username);
    List<VirtualSession> findByMhpUsername(String username);
    List<VirtualSession> findPendingByMhpUsername(String username);
    List<VirtualSession> findAll();
}