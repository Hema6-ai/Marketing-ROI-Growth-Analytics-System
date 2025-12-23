SQL Analysis — Marketing ROI & Growth Analytics System
1. Base Table Assumption

Assume the data is stored in a table called:

marketing_campaigns


Columns used:

Campaign_ID

Channel_Used

Acquisition_Cost

ROI

Conversion_Rate

Engagement_Score

Date

2. Channel-Level Performance Summary
Purpose

Understand where marketing money is working vs underperforming.

SELECT
    Channel_Used,
    COUNT(*) AS total_campaigns,
    SUM(Acquisition_Cost) AS total_spend,
    AVG(ROI) AS avg_roi,
    AVG(Conversion_Rate) AS avg_conversion_rate,
    AVG(Engagement_Score) AS avg_engagement
FROM marketing_campaigns
GROUP BY Channel_Used
ORDER BY avg_roi DESC;


Output

Channel-wise spend

Average ROI

Growth effectiveness indicators

3. Identify Budget Wastage
Purpose

Find campaigns with high cost but weak returns.

WITH medians AS (
    SELECT
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Acquisition_Cost) AS median_cost,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY ROI) AS median_roi
    FROM marketing_campaigns
)
SELECT
    m.Channel_Used,
    COUNT(*) AS wasteful_campaigns,
    SUM(m.Acquisition_Cost) AS wasted_spend
FROM marketing_campaigns m, medians
WHERE
    m.Acquisition_Cost > medians.median_cost
    AND m.ROI < medians.median_roi
GROUP BY m.Channel_Used
ORDER BY wasted_spend DESC;


Output

Channels causing budget leakage

Cost of inefficiency

4. ROI Risk & Stability Analysis
Purpose

Identify channels with unpredictable performance.

SELECT
    Channel_Used,
    AVG(ROI) AS avg_roi,
    STDDEV(ROI) AS roi_volatility
FROM marketing_campaigns
GROUP BY Channel_Used
ORDER BY roi_volatility DESC;


Output

Stable vs risky channels

Scalability assessment

5. Growth Effectiveness Analysis
Purpose

Check whether engagement and conversion translate into returns.

SELECT
    Channel_Used,
    AVG(Engagement_Score) AS avg_engagement,
    AVG(Conversion_Rate) AS avg_conversion,
    AVG(ROI) AS avg_roi
FROM marketing_campaigns
GROUP BY Channel_Used
ORDER BY avg_engagement DESC;


Output

Channels with engagement-profit mismatch

Optimization opportunities

6. Performance-Based Channel Classification
Purpose

Create decision labels directly in SQL.

WITH channel_metrics AS (
    SELECT
        Channel_Used,
        AVG(ROI) AS avg_roi,
        STDDEV(ROI) AS roi_volatility
    FROM marketing_campaigns
    GROUP BY Channel_Used
)
SELECT
    Channel_Used,
    avg_roi,
    roi_volatility,
    CASE
        WHEN avg_roi >= 6 AND roi_volatility < 1 THEN 'Scale Aggressively'
        WHEN avg_roi >= 4 THEN 'Optimize & Monitor'
        ELSE 'Reduce / Pause'
    END AS recommended_action
FROM channel_metrics
ORDER BY avg_roi DESC;


Output

Direct action guidance for leadership

7. Time-Based ROI Trend
Purpose

Track ROI performance over time.

SELECT
    DATE_TRUNC('month', Date) AS month,
    Channel_Used,
    AVG(ROI) AS monthly_avg_roi
FROM marketing_campaigns
GROUP BY month, Channel_Used
ORDER BY month;


Output

Trend analysis

Growth sustainability check

8. Final Business Insight from SQL

This SQL layer answers:

Where marketing money is working

Where it is being wasted

Which channels are risky

What actions should be taken

It mirrors and validates the Python notebook results.