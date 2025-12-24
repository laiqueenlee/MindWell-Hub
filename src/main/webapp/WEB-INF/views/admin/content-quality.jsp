<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 1. Include the Layout Header -->
<jsp:include page="/WEB-INF/views/includes/admin-header.jsp" />

<!-- 2. Page-Specific Assets -->
<!-- We ONLY include Bootstrap Icons. We removed Bootstrap CSS to prevent it from messing up your Header layout. -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">

<style>
    /* --- Scoped Styles for Content Quality Dashboard --- */
    /* Defined locally to ensure it looks like the image without needing external libraries that break the header */

    .cq-dashboard-container {
        /* Matches the padding flow from your admin-header.jsp */
        margin-top: 30px;
        font-family: 'Inter', sans-serif; 
        color: #111827;
        width: 100%;
    }

    /* The Main Outer Box */
    .cq-main-card {
        background-color: #ffffff;
        border: 1px solid #e5e7eb; /* Matches header border color */
        border-radius: 12px;
        padding: 32px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        box-sizing: border-box;
    }

    /* Header inside the card */
    .cq-header-section {
        margin-bottom: 30px;
    }

    .cq-page-title {
        font-size: 20px;
        font-weight: 700;
        margin: 0 0 4px 0;
        color: #111827;
    }

    .cq-page-subtitle {
        color: #6b7280;
        font-size: 14px;
        margin: 0;
    }

    /* Metrics Grid (Custom Grid, replacing Bootstrap .row) */
    .cq-metrics-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        margin-bottom: 40px;
    }

    .cq-metric-card {
        border: 1px solid #e9ecef;
        border-radius: 12px;
        background: white;
        padding: 20px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }
    
    .cq-metric-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    }

    .cq-metric-header {
        display: flex;
        align-items: center;
        gap: 8px;
        margin-bottom: 12px;
        font-size: 15px;
        font-weight: 600;
    }

    /* Status Colors */
    .status-published { color: #10b981; } /* Green */
    .status-review { color: #3b82f6; }    /* Blue */
    .status-flagged { color: #ef4444; }   /* Red */

    .cq-metric-value {
        font-size: 32px;
        font-weight: 700;
        color: #111827;
        margin-bottom: 4px;
        line-height: 1.2;
    }

    .cq-metric-sub {
        color: #6b7280;
        font-size: 14px;
    }

    /* Content List */
    .cq-list-header {
        font-size: 18px;
        font-weight: 600;
        margin-bottom: 15px;
        color: #111827;
    }

    .cq-content-item {
        background-color: #f9fafb;
        border: 1px solid #f3f4f6;
        border-radius: 8px;
        padding: 16px 20px;
        margin-bottom: 12px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .cq-content-info {
        display: flex;
        flex-direction: column;
    }

    .cq-content-title {
        font-weight: 600;
        color: #111827;
        font-size: 16px;
        margin-bottom: 4px;
    }

    .cq-content-stats {
        color: #6b7280;
        font-size: 13px;
    }

    .cq-rating-box {
        font-weight: 700;
        font-size: 16px;
        color: #111827;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .star-icon {
        color: #ffc107;
        font-size: 16px;
    }
</style>

<!-- 3. Dashboard Content -->
<div class="cq-dashboard-container">
    <div class="cq-main-card">
        
        <!-- Section Header -->
        <div class="cq-header-section">
            <h2 class="cq-page-title">Content Performance Overview</h2>
            <p class="cq-page-subtitle">Quality metrics and engagement</p>
        </div>

        <!-- Metrics Grid -->
        <div class="cq-metrics-grid">
            <!-- Published -->
            <div class="cq-metric-card">
                <div class="cq-metric-header status-published">
                    <i class="bi bi-check-circle"></i>
                    <span>Published</span>
                </div>
                <div class="cq-metric-value">156</div>
                <div class="cq-metric-sub">All content types</div>
            </div>

            <!-- In Review -->
            <div class="cq-metric-card">
                <div class="cq-metric-header status-review">
                    <i class="bi bi-activity"></i>
                    <span>In Review</span>
                </div>
                <div class="cq-metric-value">23</div>
                <div class="cq-metric-sub">Pending approval</div>
            </div>

            <!-- Flagged -->
            <div class="cq-metric-card">
                <div class="cq-metric-header status-flagged">
                    <i class="bi bi-x-circle"></i>
                    <span>Flagged</span>
                </div>
                <div class="cq-metric-value">7</div>
                <div class="cq-metric-sub">Needs attention</div>
            </div>
        </div>

        <!-- List Section -->
        <div class="cq-list-section">
            <h4 class="cq-list-header">Top Rated Content</h4>

            <!-- Item 1 -->
            <div class="cq-content-item">
                <div class="cq-content-info">
                    <span class="cq-content-title">Understanding Stress</span>
                    <span class="cq-content-stats">1250 views</span>
                </div>
                <div class="cq-rating-box">
                    <i class="bi bi-star-fill star-icon"></i>
                    <span>4.8</span>
                </div>
            </div>

            <!-- Item 2 -->
            <div class="cq-content-item">
                <div class="cq-content-info">
                    <span class="cq-content-title">Mindfulness Guide</span>
                    <span class="cq-content-stats">980 views</span>
                </div>
                <div class="cq-rating-box">
                    <i class="bi bi-star-fill star-icon"></i>
                    <span>4.7</span>
                </div>
            </div>

            <!-- Item 3 -->
            <div class="cq-content-item">
                <div class="cq-content-info">
                    <span class="cq-content-title">Sleep Hygiene Tips</span>
                    <span class="cq-content-stats">845 views</span>
                </div>
                <div class="cq-rating-box">
                    <i class="bi bi-star-fill star-icon"></i>
                    <span>4.6</span>
                </div>
            </div>
        </div>
    </div>
</div>