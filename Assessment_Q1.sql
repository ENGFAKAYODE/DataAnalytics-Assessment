/*1. High-Value Customers with Multiple Products

Scenario: The business wants to identify customers who have both a savings and an investment plan (cross-selling opportunity).
Task: Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.*/
SELECT u.id AS owner_id
	,u.name
	,
	-- count the saving plans
	COALESCE(savings_plans.savings_count, 0) AS savings_count
	,
	-- count investment plans
	COALESCE(investment_plans.investment_count, 0) AS investment_count
	,
	-- total deposits amount
	COALESCE(saved_amount.total_deposits, 0) AS total_deposits
FROM users_customuser u
-- find savings plans
LEFT JOIN (
	SELECT owner_id
		,COUNT(*) AS savings_count
	FROM plans_plan
	WHERE is_regular_savings = 1
		AND is_deleted = 0
		AND is_archived = 0
	GROUP BY owner_id
	) AS savings_plans ON u.id = savings_plans.owner_id
-- find investment plans
LEFT JOIN (
	SELECT owner_id
		,COUNT(*) AS investment_count
	FROM plans_plan
	WHERE is_a_fund = 1
		AND is_deleted = 0
		AND is_archived = 0
	GROUP BY owner_id
	) AS investment_plans ON u.id = investment_plans.owner_id
-- get total deposits
LEFT JOIN (
	SELECT owner_id
		,SUM(amount) AS total_deposits
	FROM savings_savingsaccount
	GROUP BY owner_id
	) AS saved_amount ON u.id = saved_amount.owner_id
-- filter customers
WHERE COALESCE(savings_plans.savings_count, 0) > 0
	AND COALESCE(investment_plans.investment_count, 0) > 0
ORDER BY saved_amount.total_deposits DESC;