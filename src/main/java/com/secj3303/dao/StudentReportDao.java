package com.secj3303.dao;

import java.util.List;

import com.secj3303.model.Report.StudentReport;

public interface StudentReportDao {

    void save(StudentReport r);

    StudentReport findById(int id);

    List<StudentReport> findPendingReports();

    List<StudentReport> findAll();

    void delete(int id);

}
