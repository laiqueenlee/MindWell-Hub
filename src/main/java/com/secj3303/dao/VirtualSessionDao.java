package com.secj3303.dao;

import java.time.LocalDate;
import java.util.List;
import com.secj3303.model.VirtualSession;

public interface VirtualSessionDao {
    void save(VirtualSession session);
    VirtualSession findById(Integer id);
    List<VirtualSession> findByStudentUsername(String username);
    List<VirtualSession> findByMhpUsername(String username);
    List<VirtualSession> findPendingByMhpUsername(String username);
    List<VirtualSession> findAll();
    List<VirtualSession> findByMhpAndDate(Integer mhpId, LocalDate date);
    List<VirtualSession> findByStudentId(Integer studentId);
}