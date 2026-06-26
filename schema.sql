-- =====================================================
-- Foodie-Fi Customer Churn Analysis
-- Schema (table structure + plans reference table)
-- Source: Danny Ma's 8 Week SQL Challenge - Case Study #3 (Foodie-Fi)
-- https://8weeksqlchallenge.com/case-study-3/
-- =====================================================
--
-- NOTE ON DATA: The `subscriptions` table contains 1,000 customers
-- and ~2,200 rows of transaction history. To keep this repo
-- lightweight and avoid manual-copy transcription errors on a
-- large dataset, the full subscriptions INSERT statements are not
-- duplicated here. Run this schema together with the official
-- dataset from the original challenge:
--
--   https://www.db-fiddle.com/f/jbahqhW5AQwqV1RZ2xExEz/0
--
-- (Click "Schema SQL" on that page for the full, copy-pasteable
-- CREATE TABLE + INSERT statements for both `plans` and
-- `subscriptions`.)
-- =====================================================

CREATE SCHEMA dbo;
SET search_path = dbo;

-- =====================================================
-- Table: plans
-- Describes the 5 subscription plans available
-- =====================================================
CREATE TABLE plans (
  plan_id INTEGER,
  plan_name VARCHAR(13),
  price DECIMAL(5,2)
);

INSERT INTO plans
  (plan_id, plan_name, price)
VALUES
  ('0', 'trial', '0'),
  ('1', 'basic monthly', '9.90'),
  ('2', 'pro monthly', '19.90'),
  ('3', 'pro annual', '199'),
  ('4', 'churn', null);

-- =====================================================
-- Table: subscriptions
-- Records each customer's plan changes over time
-- Structure shown below — see note above for full data.
-- =====================================================
CREATE TABLE subscriptions (
  customer_id INTEGER,
  plan_id INTEGER,
  start_date DATE
);

-- Example rows (first 10 of ~2,200 total) — see note above for full INSERT:
INSERT INTO subscriptions
  (customer_id, plan_id, start_date)
VALUES
  ('1', '0', '2020-08-01'),
  ('1', '1', '2020-08-08'),
  ('2', '0', '2020-09-20'),
  ('2', '3', '2020-09-27'),
  ('3', '0', '2020-01-13'),
  ('3', '1', '2020-01-20'),
  ('4', '0', '2020-01-17'),
  ('4', '1', '2020-01-24'),
  ('4', '4', '2020-04-21'),
  ('5', '0', '2020-08-03'),
  ('5', '1', '2020-08-10');
  -- ... full dataset continues — see DB Fiddle link above
