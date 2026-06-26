# Key Insights — Foodie-Fi Customer Churn Analysis

## 1. Total Customer Base
Foodie-Fi has served **1,000 customers** in total across all plans.

---

## 2. Trial Plan Signups by Month
Trial signups were spread across all 12 months of 2020, showing consistent
customer acquisition throughout the year. This tells us Foodie-Fi had a
steady inflow of new users, not just seasonal spikes.

---

## 3. Plan Activity After 2020
After 2020, the breakdown of plan events was:
- **Churn: 71** — the highest post-2020 activity, meaning many customers
  who were still active at end of 2020 eventually cancelled
- **Pro annual: 63** — a healthy number of long-term upgrades
- **Pro monthly: 60** — ongoing monthly subscribers
- **Basic monthly: 8** — very few customers stayed on the entry-level plan
  post-2020, suggesting they either upgraded or churned

---

## 4. Overall Churn Rate
**307 customers (30.7%)** have churned. Nearly 1 in 3 customers eventually
cancelled their subscription — a significant number that signals a real
retention challenge for the business.

---

## 5. Trial-to-Churn (Immediate Cancellations)
**92 customers (9%)** cancelled immediately after their free trial ended
without ever paying for a plan. This means 9% of Foodie-Fi's entire
customer base never saw value worth paying for — pointing to a
**trial conversion problem** that could be addressed through better
onboarding or trial-period engagement.

---

## 6. Where Customers Go After Trial
After their free trial, customers split as follows:
- **Basic monthly: 546 (54.6%)** — majority start cautiously with the cheaper plan
- **Pro monthly: 325 (32.5%)** — a large group upgrades directly to pro
- **Churn: 92 (9.2%)** — cancel without converting (see Q5)
- **Pro annual: 37 (3.7%)** — very few commit to annual immediately

The fact that 54.6% go to basic monthly (rather than pro) suggests most
customers prefer to test the paid product at a lower price point before
committing to a higher tier.

---

## 7. Plan Snapshot as of 31 December 2020
At end of 2020, the active customer base looked like this:
- **Pro monthly: 326 (32.6%)** — largest active segment
- **Churn: 236 (23.6%)** — over 1 in 5 customers already gone by year-end
- **Basic monthly: 224 (22.4%)**
- **Pro annual: 195 (19.5%)**
- **Still on trial: 19 (1.9%)** — small group in mid-trial at year-end

Pro monthly being the largest segment suggests Foodie-Fi's revenue is
heavily dependent on monthly recurring subscribers, making churn from
this group especially costly.

---

## 8. Annual Plan Upgrades in 2020
**195 customers** upgraded to the pro annual plan during 2020 — almost
exactly 20% of the total customer base committed to the highest-value tier
within the year.

---

## 9. Average Time to Annual Upgrade
On average, customers take **~105 days (about 3.5 months)** from joining
to upgrading to an annual plan. This means the "decision window" for
annual upgrades is roughly 3–4 months after signup — useful for timing
upsell campaigns and lifecycle emails.

---

## 10. 30-Day Upgrade Buckets
Breaking the 105-day average into 30-day windows:
- **0–29 days: 48 customers** — the largest single group upgrades very
  quickly, suggesting some customers come in already intending to go annual
- **30–59 days: 25 customers**
- **60–89 days: 33 customers**
- **90–119 days: 35 customers**
- *(distribution continues up to ~360 days)*

Upgrade activity does not drop off quickly — it's spread across many
months. This means lifecycle campaigns should not stop after 30–60 days;
there is still meaningful upgrade potential well beyond the first billing cycle.

---

## 11. Pro Monthly → Basic Monthly Downgrades in 2020
**0 customers** downgraded from pro monthly to basic monthly in 2020.

This is an important finding — and a reminder that SQL date logic matters.
A common mistake is filtering on the wrong date field, which can produce
a misleading non-zero count. Using `LEAD(start_date)` to capture the
actual date of the downgrade event (not the prior plan's date) is what
gives the correct answer of zero. In real-world subscription data,
getting this right is critical for accurate churn and downgrade reporting.

---

## Summary

Foodie-Fi has a strong top-of-funnel (1,000 customers, steady monthly
trial signups) but faces real retention challenges — 30.7% overall churn,
and 9% of customers never converting past the free trial. The biggest
opportunity for the business is improving trial-period engagement and
timing annual-plan upsell campaigns in the 60–120 day window where
upgrade activity naturally clusters.
