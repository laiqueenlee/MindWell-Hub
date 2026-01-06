# Assessment Module - Database Persistence & History Feature

## Overview
Updated the Assessment module to meet project rubric requirements by adding database persistence and reporting/history functionality.

## Changes Made

### 1. Model Layer - Assessment.java
**File:** `src/main/java/com/secj3303/model/Assessment.java`

**Changes:**
- Added JPA/Hibernate annotations:
  - `@Entity` - Marks as a database entity
  - `@Table(name = "assessments")` - Maps to assessments table
  - `@Id` and `@GeneratedValue` - Auto-increment primary key
  - `@Column` annotations for all fields
- Changed `assessmentId` from String to Long (database primary key)
- Changed `recommendations` storage from String[] to TEXT field (stored as pipe-separated values `||`)
- Added helper methods to convert between String[] and database TEXT format

**Key Fields:**
- assessment_id (BIGINT, Primary Key, Auto-increment)
- username (VARCHAR, indexed)
- assessment_type (VARCHAR - mood/stress/anxiety/wellbeing)
- score (INT)
- category (VARCHAR - Good/Fair/Poor etc.)
- feedback (TEXT)
- completed_at (DATETIME)
- recommendations_text (TEXT - stored as pipe-separated)

---

### 2. DAO Layer - AssessmentDao.java (NEW)
**File:** `src/main/java/com/secj3303/dao/AssessmentDao.java`

**Purpose:** Data Access Object interface defining CRUD operations

**Methods:**
1. `save(Assessment assessment)` - Save new assessment
2. `findById(Long id)` - Find by ID
3. `findByUsername(String username)` - Get all assessments for a user
4. `findByUsernameAndType(String username, String type)` - Filter by type
5. `findAll()` - Get all assessments
6. `update(Assessment assessment)` - Update existing
7. `delete(Long id)` - Delete assessment
8. `findLatestByUsernameAndType(String username, String type)` - Get most recent for comparison
9. `findRecentByUsername(String username, int limit)` - Get N most recent

---

### 3. DAO Implementation - AssessmentDaoHibernate.java (NEW)
**File:** `src/main/java/com/secj3303/dao/AssessmentDaoHibernate.java`

**Features:**
- `@Repository` - Spring component scan
- `@Transactional` - Automatic transaction management
- Uses `SessionFactory` from Spring configuration
- HQL queries for filtering and sorting
- Proper ordering by `completedAt DESC` for chronological history

**Example Query:**
```java
String hql = "FROM Assessment a WHERE a.username = :username AND a.assessmentType = :type ORDER BY a.completedAt DESC";
```

---

### 4. Controller - AssessmentController.java
**File:** `src/main/java/com/secj3303/controller/student/AssessmentController.java`

**Changes:**
1. Added `@Autowired AssessmentDao assessmentDao` dependency injection
2. Updated `submitAssessment()` method:
   - Now creates Assessment object from result
   - Calls `assessmentDao.save()` to persist to database
   - Logs the saved assessment ID
3. Added NEW endpoint `/student/assessment/history`:
   - Displays assessment history
   - Supports filtering by type (`?type=mood`)
   - Shows all assessments sorted by date (newest first)

**New Endpoint:**
```java
@GetMapping("/history")
public String viewAssessmentHistory(
    @RequestParam(value = "type", required = false) String assessmentType,
    Model model, HttpSession session)
```

---

### 5. View - assessment-history.jsp (NEW)
**File:** `src/main/webapp/WEB-INF/views/student/assessment-history.jsp`

**Features:**
- Filter buttons for All/Mood/Stress/Anxiety/Wellbeing
- Timeline display of all past assessments
- Color-coded categories (Green=Good, Yellow=Fair, Red=Poor)
- Collapsible recommendations section
- Summary statistics:
  - Total assessments taken
  - Average score
  - Latest category
- Responsive Bootstrap 5 design
- Date/time formatting using JSTL fmt tags

**Screenshot:**
```
┌─────────────────────────────────────────────┐
│ Assessment History                          │
│                                             │
│ [All] [Mood] [Stress] [Anxiety] [Wellbeing]│
│                                             │
│ ┌─────────────────────────────────────────┐ │
│ │ 📊 Mood    75 Good   Dec 31, 2024 2:30pm│ │
│ │ "You're doing well..."                  │ │
│ │ [View Recommendations]                  │ │
│ └─────────────────────────────────────────┘ │
│                                             │
│ ┌─────────────────────────────────────────┐ │
│ │ 🧠 Stress  60 Fair   Dec 30, 2024 1:15pm│ │
│ │ "Moderate stress level..."              │ │
│ └─────────────────────────────────────────┘ │
└─────────────────────────────────────────────┘
```

---

### 6. View Update - assessment-list.jsp
**File:** `src/main/webapp/WEB-INF/views/student/assessment-list.jsp`

**Changes:**
- Added "View Assessment History" button in the header
- Links to `/student/assessment/history`

---

### 7. Database Table - create_assessments_table.sql (NEW)
**File:** `src/main/resources/database/create_assessments_table.sql`

**SQL Script:**
```sql
CREATE TABLE IF NOT EXISTS assessments (
    assessment_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL,
    assessment_type VARCHAR(50) NOT NULL,
    score INT NOT NULL,
    category VARCHAR(50),
    feedback TEXT,
    completed_at DATETIME NOT NULL,
    recommendations_text TEXT,
    INDEX idx_username (username),
    INDEX idx_username_type (username, assessment_type),
    INDEX idx_completed_at (completed_at)
);
```

**To Execute:**
1. Open MySQL Workbench or command line
2. Connect to database: `mindwell`
3. Run the SQL script from the file above

---

## Spring Configuration
**File:** `src/main/webapp/WEB-INF/dispatcher-servlet.xml`

**Already Configured (No changes needed):**
- Component scan includes `com.secj3303.dao` ✅
- Hibernate SessionFactory configured ✅
- Transaction management enabled ✅
- Database connection to `mindwell` schema ✅

---

## How It Works

### User Flow:
1. Student takes an assessment (mood/stress/anxiety/wellbeing)
2. Submits answers via POST `/student/assessment/submit`
3. AssessmentService calculates score and feedback
4. **NEW:** Controller creates Assessment object and saves to database
5. Result displayed on result page
6. **NEW:** Student can view history at `/student/assessment/history`

### Database Persistence:
```
submitAssessment() 
  → AssessmentService.calculateResult() 
  → new Assessment(...) 
  → assessmentDao.save(assessment) 
  → Hibernate saves to MySQL
```

### History Retrieval:
```
viewAssessmentHistory() 
  → assessmentDao.findByUsername(username) 
  → Hibernate queries: SELECT * FROM assessments WHERE username=? ORDER BY completed_at DESC
  → Returns List<Assessment>
  → JSP renders timeline view
```

---

## Rubric Compliance

### ✅ Model (DAO, Database)
- Assessment model with JPA annotations
- AssessmentDao interface
- AssessmentDaoHibernate implementation
- MySQL assessments table

### ✅ View (JSP, CSS, Bootstrap)
- All views are JSP files
- Bootstrap 5 styling
- Custom CSS for timeline display
- Responsive design

### ✅ Controller (CRUD)
- Create: `submitAssessment()` saves to database
- Read: `viewAssessmentHistory()` retrieves records
- Update: Available via DAO (not exposed in UI yet)
- Delete: Available via DAO (not exposed in UI yet)

### ✅ Personalization & Authorization
- Session-based authentication
- User-specific data (filtered by username)
- Filter required for all assessment pages

### ✅ Reporting (Transaction, History)
- Transaction tracking: Each assessment saved with timestamp
- History: Complete timeline of all past assessments
- Performance comparison: Can view scores over time
- Statistics: Average score, total assessments

---

## Testing Instructions

### 1. Create Database Table
```sql
-- Run in MySQL Workbench
USE mindwell;
SOURCE src/main/resources/database/create_assessments_table.sql;
```

### 2. Build Project
```bash
mvn clean package
```

### 3. Deploy to Tomcat
1. Copy `target/healthhubutm.war` to Tomcat webapps/
2. Start Tomcat
3. Access: http://localhost:8080/healthhubutm/

### 4. Test Flow
1. Login as student
2. Navigate to "Assessment" menu
3. Take any assessment (e.g., Mood Check)
4. Submit answers
5. View result page
6. Click "View Assessment History" button
7. Verify assessment appears in history
8. Take another assessment
9. Refresh history - should see both assessments
10. Test filter buttons (All, Mood, Stress, etc.)

### 5. Verify Database
```sql
SELECT * FROM assessments ORDER BY completed_at DESC;
```

---

## Future Enhancements

### Performance Comparison Chart
- Add Chart.js to display score trends over time
- Line graph showing improvement/decline

### Export Feature
- Export assessment history to PDF
- Generate monthly reports

### Goal Setting
- Allow students to set improvement goals
- Track progress toward goals

### Reminder System
- Notify students to take regular assessments
- Email/notification when score drops

---

## Files Modified/Created

### Modified:
1. `src/main/java/com/secj3303/model/Assessment.java`
2. `src/main/java/com/secj3303/controller/student/AssessmentController.java`
3. `src/main/webapp/WEB-INF/views/student/assessment-list.jsp`

### Created:
1. `src/main/java/com/secj3303/dao/AssessmentDao.java`
2. `src/main/java/com/secj3303/dao/AssessmentDaoHibernate.java`
3. `src/main/webapp/WEB-INF/views/student/assessment-history.jsp`
4. `src/main/resources/database/create_assessments_table.sql`

---

## Summary

The Assessment module now has complete database persistence and history/reporting features. Students can:
- Take assessments (existing functionality)
- Have results automatically saved to database (NEW)
- View complete assessment history (NEW)
- Filter history by assessment type (NEW)
- See performance over time (NEW)
- Track improvement trends (NEW)

This meets all rubric requirements:
- ✅ Model (DAO, Database)
- ✅ View (JSP, CSS, Bootstrap)
- ✅ Controller (CRUD)
- ✅ Personalization & Authorization
- ✅ Reporting (Transaction, History)
