/*
3. Account Inactivity Alert
Scenario: The ops team wants to flag accounts with no inflow transactions for over one year.
Task: Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days) .
   */
SELECT p.id AS plan_id
	,p.owner_id
	,CASE 
		WHEN p.is_regular_savings = 1
			THEN "Savings"
		WHEN p.is_a_fund = 1
			THEN "Investment"
		ELSE "Other"
		END AS type
	,max(s.created_on) AS last_transaction_date
	,datediff(curdate(), max(s.created_on)) AS inactivity_days
FROM plans_plan p
LEFT JOIN savings_savingsaccount s ON s.owner_id = p.owner_id
	AND s.created_on IS NOT NULL
WHERE p.is_deleted = 0
	AND p.is_archived = 0
	AND (
		p.is_regular_savings = 1
		OR p.is_a_fund = 1
		)
GROUP BY p.id
	,p.owner_id
	,p.is_regular_savings
	,p.is_a_fund
HAVING last_transaction_date IS NULL
	OR inactivity_days > 365
ORDER BY inactivity_days DESC;