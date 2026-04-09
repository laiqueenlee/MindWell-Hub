package com.secj3303.model;

import java.util.HashMap;
import java.util.Map;

public class AssessmentService {


    public static AssessmentResult calculateResult(String assessmentType, int[] answers) {
        int totalScore = 0;
        if (answers == null || answers.length == 0) {
            int overallScore = 0;
            String category = categorizeScore(overallScore);
            String feedback = getFeedback(assessmentType, category, overallScore);
            String[] recommendations = getRecommendations(assessmentType, category);

            AssessmentResult result = new AssessmentResult(overallScore, category, feedback, recommendations);
            result.setMetrics(new AssessmentResult.AssessmentMetrics(
                    generateEngagementScore(),
                    generateConsistencyScore(),
                    generateProgressScore()
            ));

            return result;
        }

        for (int answer : answers) {
            totalScore += answer;
        }

        int maxPossibleScore = answers.length * 5; 
        int overallScore = (totalScore * 25) / maxPossibleScore;  
        overallScore = Math.min(25, Math.max(0, overallScore));

        String category = categorizeScore(overallScore);
        String feedback = getFeedback(assessmentType, category, overallScore);
        String[] recommendations = getRecommendations(assessmentType, category);

        AssessmentResult result = new AssessmentResult(overallScore, category, feedback, recommendations);

        result.setMetrics(new AssessmentResult.AssessmentMetrics(
                generateEngagementScore(),
                generateConsistencyScore(),
                generateProgressScore()
        ));

        return result;
    }


    private static String categorizeScore(int score) {
        if (score >= 18) {  
            return "Excellent";
        } else if (score >= 13) {  
            return "Good";
        } else if (score >= 8) {  
            return "Fair";
        } else {  
            return "Poor";
        }
    }


    private static String getFeedback(String assessmentType, String category, int score) {
        Map<String, String> excellentFeedback = new HashMap<>();
        excellentFeedback.put("mood", "You're in an excellent emotional state. Keep up the positive momentum and continue your wellness practices.");
        excellentFeedback.put("stress", "Your stress levels are very well managed. You're doing an excellent job maintaining balance.");
        excellentFeedback.put("anxiety", "Your anxiety levels are very well controlled. Continue with the coping strategies that work for you.");
        excellentFeedback.put("wellbeing", "Your overall wellbeing is excellent. You're thriving physically, mentally, and emotionally.");

        Map<String, String> goodFeedback = new HashMap<>();
        goodFeedback.put("mood", "Your mood is generally positive. Keep nurturing your emotional wellbeing.");
        goodFeedback.put("stress", "Your stress levels are manageable. Consider exploring additional relaxation techniques.");
        goodFeedback.put("anxiety", "Your anxiety is at a manageable level. You're doing well with your coping strategies.");
        goodFeedback.put("wellbeing", "Your wellbeing is good overall. Small improvements in certain areas could enhance your experience.");

        Map<String, String> fairFeedback = new HashMap<>();
        fairFeedback.put("mood", "Your mood could use some attention. Consider engaging in uplifting activities and connecting with others.");
        fairFeedback.put("stress", "Your stress levels need some attention. Try implementing stress-relief techniques and take regular breaks.");
        fairFeedback.put("anxiety", "You're experiencing moderate anxiety. Exploring more coping strategies could be beneficial.");
        fairFeedback.put("wellbeing", "Your wellbeing needs some focus. Consider prioritizing self-care and seeking support where needed.");

        Map<String, String> poorFeedback = new HashMap<>();
        poorFeedback.put("mood", "Your mood needs immediate attention. Please reach out to a counselor or trusted person for support.");
        poorFeedback.put("stress", "Your stress levels are concerning. Please seek professional support and consider counseling sessions.");
        poorFeedback.put("anxiety", "Your anxiety levels are high. Professional support could be very beneficial for you.");
        poorFeedback.put("wellbeing", "Your wellbeing requires attention. Please reach out to a counselor for personalized guidance.");

        Map<String, String> feedbackMap;
        if ("Excellent".equals(category)) {
            feedbackMap = excellentFeedback;
        } else if ("Good".equals(category)) {
            feedbackMap = goodFeedback;
        } else if ("Fair".equals(category)) {
            feedbackMap = fairFeedback;
        } else {
            feedbackMap = poorFeedback;
        }

        return feedbackMap.getOrDefault(assessmentType, "Keep working on your wellness journey.");
    }


    private static String[] getRecommendations(String assessmentType, String category) {
        if ("mood".equals(assessmentType)) {
            if ("Excellent".equals(category) || "Good".equals(category)) {
                return new String[]{
                        "Continue your current wellness practices",
                        "Explore advanced coping techniques",
                        "Share your strategies in the forum"
                };
            } else {
                return new String[]{
                        "Practice daily mood tracking",
                        "Try guided meditation or journaling",
                        "Connect with the support community"
                };
            }
        } else if ("stress".equals(assessmentType)) {
            if ("Excellent".equals(category) || "Good".equals(category)) {
                return new String[]{
                        "Maintain your stress management routine",
                        "Learn advanced relaxation techniques",
                        "Help peers manage their stress"
                };
            } else {
                return new String[]{
                        "Practice breathing exercises daily",
                        "Take regular breaks throughout the day",
                        "Consider professional counseling support"
                };
            }
        } else if ("anxiety".equals(assessmentType)) {
            if ("Excellent".equals(category) || "Good".equals(category)) {
                return new String[]{
                        "Continue your anxiety management strategies",
                        "Explore mindfulness practices",
                        "Share helpful techniques with others"
                };
            } else {
                return new String[]{
                        "Practice grounding techniques",
                        "Engage in regular physical activity",
                        "Schedule a session with a counselor"
                };
            }
        } else { 
            if ("Excellent".equals(category) || "Good".equals(category)) {
                return new String[]{
                        "Continue your current wellness practices",
                        "Explore advanced coping techniques",
                        "Share your strategies in the forum"
                };
            } else {
                return new String[]{
                        "Prioritize sleep and exercise",
                        "Maintain a healthy diet",
                        "Seek professional support"
                };
            }
        }
    }


    private static int generateEngagementScore() {
        return 60 + (int) (Math.random() * 30); 
    }

    private static int generateConsistencyScore() {
        return 50 + (int) (Math.random() * 40); 
    }


    private static int generateProgressScore() {
        return 55 + (int) (Math.random() * 35); 
    }
}
