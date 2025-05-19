/*
2. Transaction Frequency Analysis

Scenario: The finance team wants to analyze how often customers transact to segment them (e.g., frequent vs. occasional users).
Task: Calculate the average number of transactions per customer per month and categorize them:
"High Frequency" (≥10 transactions/month)
"Medium Frequency" (3-9 transactions/month)
"Low Frequency" (≤2 transactions/month)   */

select frequency_category,
	   count(*) as customer_count, 
       round(avg(transactions_per_month),1) as avg_transactions_per_month
from(
select s.owner_id,

 -- calculate transactions per month
        count(*) / count(distinct date_format(s.created_on, '%Y-%m')) as transactions_per_month,
        
-- categorize the frequency category
        case 
            when count(distinct date_format(s.created_on, '%Y-%m')) >= 10 then "High Frequency"
			when count(distinct date_format(s.created_on, '%Y-%m')) between 3 and 9 then "Medium Frequency"
            else "Low Frequency" 
            end as frequency_category
            from savings_savingsaccount s
            group by s.owner_id) as freq_table
group by frequency_category
order by customer_count desc;