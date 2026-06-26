# Foodie-Fi Customer Churn Analysis

SQL case study analyzing customer subscription behavior for Foodie-Fi, a fictional video streaming subscription service. This project answers 11 business questions about customer churn, plan upgrades/downgrades, and the customer journey using PostgreSQL.

This is my solution to **Case Study #3 (Foodie-Fi)** from Danny Ma's [8 Week SQL Challenge](https://8weeksqlchallenge.com/case-study-3/).

## Business Context

Foodie-Fi offers 5 subscription tiers: a 7-day free trial, basic monthly, pro monthly, pro annual, and churn (cancelled). The goal of this analysis is to understand the customer lifecycle — how customers move between plans, when and why they churn, and how long it takes them to upgrade to higher-value plans.

## Tools Used

- PostgreSQL
- Window functions (`LEAD`, `ROW_NUMBER`)
- CTEs (Common Table Expressions)
- Date arithmetic and bucketing
- Conditional aggregation

## Dataset

Two tables:
- **plans** — the 5 subscription plan types and their pricing
- **subscriptions** — 1,000 customers and their plan change history over time

Full schema and dataset (`schema.sql`) are included in this repo and are also available on the original challenge: [db-fiddle link](https://www.db-fiddle.com/f/jbahqhW5AQwqV1RZ2xExEz/0) | [8 Week SQL Challenge Case Study #3](https://8weeksqlchallenge.com/case-study-3/)

## Questions Answered

| # | Question | Key SQL Technique |
|---|---|---|
| 1 | How many customers has Foodie-Fi ever had? | `COUNT(DISTINCT)` |
| 2 | Monthly distribution of trial signups | `DATE_TRUNC` |
| 3 | Plan breakdown for events after 2020 | `JOIN` + `GROUP BY` |
| 4 | Customer count & % who have churned | Conditional aggregation |
| 5 | % who churned immediately after trial | `LEAD()` window function |
| 6 | Breakdown of plans customers land on right after trial | `LEAD()` + `JOIN` |
| 7 | Plan breakdown snapshot as of 2020-12-31 | `ROW_NUMBER()` |
| 8 | Customers who upgraded to annual in 2020 | Date range filtering |
| 9 | Average days to upgrade to an annual plan | CTEs + date subtraction |
| 10 | Days-to-upgrade broken into 30-day buckets | `FLOOR()` bucketing |
| 11 | Pro monthly → basic monthly downgrades in 2020 | `LEAD()` with date-of-event handling |

See [`insights.md`](insights.md) for a summary of findings, and [`queries.sql`](queries.sql) for all 11 solutions.

## Key Findings (Summary)

- **30.7%** of all customers have churned at some point
- **9%** of customers cancel immediately after their free trial ends
- It takes an average of **~105 days** for a customer to upgrade to an annual plan
- No customers downgraded directly from pro monthly to basic monthly in 2020 — a result that highlights the importance of using the correct event date in time-based SQL logic

Full breakdown in [`insights.md`](insights.md).

## How to Run

1. Run `schema.sql` in PostgreSQL (locally, or via [DB Fiddle](https://www.db-fiddle.com/f/jbahqhW5AQwqV1RZ2xExEz/0)) to create and populate the tables
2. Run any query from [`queries.sql`](queries.sql)

---
*Project by Vinayak — MBA Marketing student building a Data Analyst portfolio.*
