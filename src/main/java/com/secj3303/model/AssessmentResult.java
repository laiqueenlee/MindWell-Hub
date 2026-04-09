package com.secj3303.model;

public class AssessmentResult {
    private int overallScore;
    private String category;
    private String feedback;
    private String[] recommendedActions;
    private AssessmentMetrics metrics;

    public AssessmentResult() {}

    public AssessmentResult(int overallScore, String category, String feedback, String[] recommendedActions) {
        this.overallScore = overallScore;
        this.category = category;
        this.feedback = feedback;
        this.recommendedActions = recommendedActions;
    }

    public int getOverallScore() {
        return overallScore;
    }

    public void setOverallScore(int overallScore) {
        this.overallScore = overallScore;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public String[] getRecommendedActions() {
        return recommendedActions;
    }

    public void setRecommendedActions(String[] recommendedActions) {
        this.recommendedActions = recommendedActions;
    }

    public AssessmentMetrics getMetrics() {
        return metrics;
    }

    public void setMetrics(AssessmentMetrics metrics) {
        this.metrics = metrics;
    }

    public static class AssessmentMetrics {
        public int engagement;
        public int consistency;
        public int progress;

        public AssessmentMetrics(int engagement, int consistency, int progress) {
            this.engagement = engagement;
            this.consistency = consistency;
            this.progress = progress;
        }

        public int getEngagement() {
            return engagement;
        }

        public int getConsistency() {
            return consistency;
        }

        public int getProgress() {
            return progress;
        }
    }
}
