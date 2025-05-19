# DataAnalytics-Assessment

Welcome to my submission for the **SQL Proficiency Assessment**. This evaluation demonstrates my ability to query relational databases and solve real-world business problems using SQL. The assessment tested knowledge of data retrieval, aggregation, joins, subqueries, and data manipulation across multiple tables.

## Assessment Overview
A database containing the following tables. Alternatively, you can download the database file using this [link](https://drive.google.com/file/d/1__51EvatOK1ubG4oi0Im_VW2UWUChMHu/view?usp=drive_link):

- **users_customuser:** customer demographic and contact information
- **savings_savingsaccount:** records of deposit transactions
- **plans_plan:** records of plans created by customers
- **withdrawals_withdrawal:**  records of withdrawal transactions

## Evaluation Criteria
My solutions were designed with these in mind:

- Accuracy — Correct results
- Efficiency — Well-structured and optimized queries
- Completeness — All requirements of each task addressed
- Readability — I used poorsql.com to achieve correct indentation of the codes. Comments were added where necessary.

## QUESTIONS

**1. High-Value Customers with Multiple Products**

**Scenario:** The business wants to identify customers who have both a savings and an investment plan (cross-selling opportunity).

**Task:** Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.

**My Approach:** 
- I looked for customers who have both a savings plan and an investment plan.
- Left-joined the "plans_plan" and "savings_savingsaccount" tables, counted how many of each plan type they have, and added up the total deposits they’ve made.
- I also used COALESCE to replace any missing values with zero so the totals work correctly.
- Then, filtered the results to only show customers who own both plans and sorted them by their total deposits from highest to lowest.


**2. Transaction Frequency Analysis**

**Scenario:** The finance team wants to analyze how often customers transact to segment them (e.g., frequent vs. occasional users).

**Task:** Calculate the average number of transactions per customer per month and categorize them:

"High Frequency" (≥10 transactions/month)

"Medium Frequency" (3-9 transactions/month)

"Low Frequency" (≤2 transactions/month)

**My Approach:** 
- I calculated how often customers make transactions by dividing their total transactions by the number of months since they signed up.
- Based on their average number of transactions per month, I grouped them into three categories: High Frequency, Medium Frequency, and Low Frequency. I used a CASE statement for this
- Counted how many customers fell into each group.



**3. Account Inactivity Alert**

**Scenario:** The ops team wants to flag accounts with no inflow transactions for over one year.

**Task:** Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days).

**My Approach**
- Found all active savings and investment plans where no deposit transactions have happened in the last 365 days.
- I left joined the "plans_plan" table with the "savings_savingsaccount" table
- Checked the last transaction date for each account
- I Calculated how many days have passed since then. If no transaction was found or it’s been over a year, the account was flagged as inactive.


				
**4. Customer Lifetime Value (CLV) Estimation**

**Scenario:** Marketing wants to estimate CLV based on account tenure and transaction volume (simplified model).

**Task:** For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:

Account tenure (months since signup)

Total transactions

Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)

Order by estimated CLV from highest to lowest

**My Approach**
- I estimated each customer’s lifetime value by first calculating how long they’ve had an account (in months)
- The total number of transactions they’ve made.
- Since each transaction makes a profit of 0.1% of its value, I worked out the average profit per transaction and plugged it into the given CLV formula:
CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction
- Sorted the customers by their estimated CLV from highest to lowest.


## Challenges I Faced
- **Handling Null Values:** In some queries, transactions or product counts could be missing for a customer. I used COALESCE to ensure those cases showed as zero instead of null, so calculations worked smoothly. I Added NULLIF in the tenure-based calculation to avoid divide-by-zero errors when tenure is zero.

- **Complex Joins:** Some tasks required joining different tables based on owner IDs, while carefully handling cases where no transactions existed. I used LEFT JOIN to avoid losing important records.

- **Managing Query Performance:**
Some queries, especially those using multiple joins and aggregations with date calculations, slowed down while testing. I made sure to use indexed columns in WHERE clauses and avoided unnecessary nested subqueries to improve performance.

- **Identifying Active Accounts with No Transactions:**
Some accounts were active (not deleted/archived), but had no deposit history. Detecting these required LEFT JOINs and checking for null created_on values while still excluding inactive accounts.

- **Working with Multiple Product Types:**
Since a customer could have both a savings and an investment plan, and sometimes the same owner_id would appear twice, it was tricky to correctly group and filter them without double-counting. I carefully structured the CASE statements and used grouping logic to segment them accurately.

- **Ambiguous Plan Types:**
Initially, it was unclear how to differentiate savings and investment plans. Resolved by leveraging hints: is_regular_savings = 1 for savings, is_a_fund = 1 for investments.


**Hints:**
- owner_id is a foreign key to the ID primary key in the users table
- plan_id is a foreign key to the ID primary key in the plans table
- savings_plan : is_regular_savings = 1
- investment_plan: is_a_fund = 1
- confirmed_amount is the field for value of inflow
- amount_withdrawn is the field for value of withdrawal
- all amount fields are in kobo

## Final Note
This assessment wasn’t just about writing SQL queries — it was about using data to solve real business problems. Each task challenged me to think critically about what the business actually needed, beyond just numbers. From identifying valuable cross-selling opportunities to flagging dormant accounts and estimating customer lifetime value, I approached each problem with the mindset of a business partner, not just a developer.

I’m passionate about transforming raw data into insights that drive operational decisions, improve customer engagement and optimize processes. This project reinforced my ability to navigate messy, incomplete or complex data environments while delivering clear & actionable outcomes.

I look forward to bringing this same problem-solving energy and business-first thinking to your team.
