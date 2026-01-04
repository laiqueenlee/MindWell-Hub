package com.secj3303.dao;

import com.secj3303.model.Assessment;
import java.util.List;

public interface AssessmentDao {
    // Create
    void save(Assessment assessment);
    
    // Read
    Assessment findById(String assessmentId);
    List<Assessment> findByUsername(String username);
    List<Assessment> findByUsernameAndType(String username, String assessmentType);
    List<Assessment> findAll();
    
    // Update
    void update(Assessment assessment);
    
    // Delete
    void delete(String assessmentId);
    
    // Reporting - Get latest assessment by type
    Assessment findLatestByUsernameAndType(String username, String assessmentType);
    
    // Reporting - Get assessment history (last N assessments)
    List<Assessment> findRecentByUsername(String username, int limit);
}
