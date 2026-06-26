-- =====================================================
-- Foodie-Fi Customer Churn Analysis
-- All 11 SQL Queries — Written by Vinayak
-- Database: PostgreSQL
-- Source: Danny Ma's 8 Week SQL Challenge - Case Study #3
-- =====================================================


-- =====================================================
-- Q1: How many customers has Foodie-Fi ever had?
-- =====================================================
SELECT COUNT(DISTINCT customer_id)
FROM subscriptions;
-- Answer: 1000


-- =====================================================
-- Q2: What is the monthly distribution of trial plan
-- start_date values? (grouped by start of month)
-- =====================================================
SELECT DATE_TRUNC('month', start_date) AS month_start,
COUNT(*) AS Trial_plan
FROM subscriptions
WHERE plan_id = 0
GROUP BY DATE_TRUNC('month', start_date)
ORDER BY month_start;


-- =====================================================
-- Q3: What plan start_date values occur after the year
-- 2020? Breakdown by count of events per plan_name.
-- =====================================================
SELECT p.plan_name,
COUNT(*) AS event_count
FROM subscriptions s
JOIN plans p ON s.plan_id = p.plan_id
WHERE s.start_date > '2020-12-31'
GROUP BY p.plan_name
ORDER BY event_count DESC;
-- Answer: churn 71, pro annual 63, pro monthly 60, basic monthly 8


-- =====================================================
-- Q4: Customer count and percentage of customers who
-- have churned, rounded to 1 decimal place.
-- =====================================================
SELECT
    COUNT(DISTINCT customer_id) AS churned_customer,
    ROUND(
        100.0 * COUNT(DISTINCT customer_id)
        / (SELECT COUNT(DISTINCT customer_id) FROM subscriptions),
    1) AS churn_percentage
FROM subscriptions
WHERE plan_id = 4;
-- Answer: 307 customers, 30.7%


-- =====================================================
-- Q5: How many customers churned straight after their
-- initial free trial? What % is this (nearest whole number)?
-- =====================================================
WITH customer_plans AS (
    SELECT
        customer_id,
        plan_id,
        LEAD(plan_id) OVER (PARTITION BY customer_id ORDER BY start_date) AS next_plan_id
    FROM subscriptions
)
SELECT
    COUNT(*) AS trial_to_churn_count,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(DISTINCT customer_id) FROM subscriptions), 0) AS percentage
FROM customer_plans
WHERE plan_id = 0
  AND next_plan_id = 4;
-- Answer: 92 customers, 9%


-- =====================================================
-- Q6: Number and percentage breakdown of all plans
-- customers land on immediately after their trial.
-- =====================================================
SELECT
    p.plan_name AS next_plan,
    COUNT(*) AS customer_count,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(DISTINCT customer_id) FROM subscriptions), 1) AS percentage
FROM (
    SELECT
        customer_id,
        plan_id,
        LEAD(plan_id) OVER (PARTITION BY customer_id ORDER BY start_date) AS next_plan_id
    FROM subscriptions
) AS customer_plans
JOIN plans p ON customer_plans.next_plan_id = p.plan_id
WHERE customer_plans.plan_id = 0
GROUP BY p.plan_name
ORDER BY customer_count DESC;
-- Answer: basic monthly 546 (54.6%), pro monthly 325 (32.5%),
--         churn 92 (9.2%), pro annual 37 (3.7%)


-- =====================================================
-- Q7: Customer count and percentage breakdown of all 5
-- plan_name values as of 2020-12-31 (snapshot).
-- =====================================================
WITH ranked_plans AS (
    SELECT
        customer_id,
        plan_id,
        start_date,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY start_date DESC) AS rn
    FROM subscriptions
    WHERE start_date <= '2020-12-31'
)
SELECT
    p.plan_name,
    COUNT(*) AS customer_count,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(DISTINCT customer_id) FROM subscriptions), 1) AS percentage
FROM ranked_plans rp
JOIN plans p ON rp.plan_id = p.plan_id
WHERE rp.rn = 1
GROUP BY p.plan_name
ORDER BY customer_count DESC;
-- Answer: pro monthly 326 (32.6%), churn 236 (23.6%),
--         basic monthly 224 (22.4%), pro annual 195 (19.5%), trial 19 (1.9%)


-- =====================================================
-- Q8: How many customers upgraded to an annual plan in 2020?
-- =====================================================
SELECT COUNT(DISTINCT customer_id)
FROM subscriptions
WHERE plan_id = 3
  AND start_date BETWEEN '2020-01-01' AND '2020-12-31';
-- Answer: 195


-- =====================================================
-- Q9: Average number of days to upgrade to an annual
-- plan from the day a customer joins Foodie-Fi.
-- =====================================================
WITH trial_dates AS (
    SELECT customer_id, start_date AS trial_date
    FROM subscriptions
    WHERE plan_id = 0
),
annual_dates AS (
    SELECT customer_id, start_date AS annual_date
    FROM subscriptions
    WHERE plan_id = 3
),
days_to_upgrade AS (
    SELECT
        t.customer_id,
        a.annual_date - t.trial_date AS days_diff
    FROM trial_dates t
    JOIN annual_dates a ON t.customer_id = a.customer_id
)
SELECT ROUND(AVG(days_diff), 0) AS avg_days_to_upgrade
FROM days_to_upgrade;
-- Answer: 105 days


-- =====================================================
-- Q10: Breakdown of days-to-upgrade into 30-day periods
-- (uses same CTEs as Q9 above)
-- =====================================================
WITH trial_dates AS (
    SELECT customer_id, start_date AS trial_date
    FROM subscriptions
    WHERE plan_id = 0
),
annual_dates AS (
    SELECT customer_id, start_date AS annual_date
    FROM subscriptions
    WHERE plan_id = 3
),
days_to_upgrade AS (
    SELECT
        t.customer_id,
        a.annual_date - t.trial_date AS days_diff
    FROM trial_dates t
    JOIN annual_dates a ON t.customer_id = a.customer_id
)
SELECT
    FLOOR(days_diff / 30) * 30 AS period_start,
    COUNT(*) AS customer_count
FROM days_to_upgrade
GROUP BY FLOOR(days_diff / 30)
ORDER BY period_start;
-- Answer (partial): 0-29 days: 48, 30-59 days: 25,
--                   60-89 days: 33, 90-119 days: 35 ...


-- =====================================================
-- Q11: How many customers downgraded from pro monthly
-- to basic monthly in 2020?
-- =====================================================
SELECT COUNT(*) AS pro_to_basic_count
FROM (
    SELECT
        customer_id,
        plan_id,
        start_date,
        LEAD(plan_id) OVER (PARTITION BY customer_id ORDER BY start_date) AS next_plan_id,
        LEAD(start_date) OVER (PARTITION BY customer_id ORDER BY start_date) AS next_start_date
    FROM subscriptions
) AS customer_plans
WHERE plan_id = 2
  AND next_plan_id = 1
  AND next_start_date BETWEEN '2020-01-01' AND '2020-12-31';
-- Answer: 0
-- Note: Using LEAD(start_date) to get the actual downgrade event date
-- is critical here. Filtering on the current row's start_date gives
-- incorrect results — a common SQL trap in event-sequence analysis.
