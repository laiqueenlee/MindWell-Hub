package com.secj3303.dao;

import java.time.LocalDateTime;
import java.util.List;

import com.secj3303.model.Assessment;

public interface AssessmentDao {

    void save(Assessment assessment);
    

    Assessment findById(String assessmentId);
    List<Assessment> findByUsername(String username);
    List<Assessment> findByUsernameAndType(String username, String assessmentType);
    List<Assessment> findAll();
    
    void update(Assessment assessment);
    
    void delete(String assessmentId);
    
    Assessment findLatestByUsernameAndType(String username, String assessmentType);
    
    List<Assessment> findRecentByUsername(String username, int limit);

    List<Assessment> findRecentByUsername(String username, LocalDateTime since);
}
