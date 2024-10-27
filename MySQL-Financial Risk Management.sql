/*
Financial Risk Managemnet
Project 1: Fraud Detection
*/

/* 1. Identify High-Risk Transactions by Amount
Problem: Identify transactions exceeding a certain threshold to flag potential fraud. */
select
user_id, amount, location, device_type, is_fraud
from fraud_detection_dataset
where amount>1000 and is_fraud=1;

/* 2. Analyze Location-Based Fraud Trends
Problem: Determine if certain locations have higher fraud instances. */
select
location, count(is_fraud) as fraud_count
from fraud_detection_dataset
where is_fraud = 1
group by location
order by fraud_count desc;
 
/* 3. Device Type Analysis for Fraud
Problem: Understand if certain devices are more prone to fraudulent transactions. */
select
device_type, count(is_fraud) as fraud_count
from fraud_detection_dataset
where is_fraud = 1
group by device_type
order by fraud_count desc;

/* 4. Find Frequent Fraudulent Users
Problem: Detect users who have multiple fraud instances, indicating repeat offenders. */
select
user_id,
count(is_fraud) as fraud_occurance
from fraud_detection_dataset
where is_fraud = 1
group by user_id
having fraud_occurance > 1
order by fraud_occurance desc;

/* 5. Transaction Timing and Fraud Analysis
Problem: Investigate if frauds are more likely during specific times. */
select
hour(timestamp) as hour,
count(is_fraud) as fraud_count
from fraud_detection_dataset
where fraud_count = 1
group by hour
order by fraud_count desc;

/* 6. Identify Fraudulent Users with High Credit Scores
Problem: Uncover cases where high-credit-score users commit fraud. */
select
user_id,
count(is_fraud) as fraud_count,
max(credit_score) as credit_score
from fraud_detection_dataset
where is_fraud = 1 and credit_score > 750
group by user_id
order by fraud_count desc
limit 1000;

/* 7. Analyze Fraud Based on Time Intervals Between Transactions
Problem: Detect if closely timed transactions suggest fraudulent activity. */
select
user_id, timestamp,
	lead(timestamp) over (partition by user_id order by timestamp) as next_timestamp,
	timestampdiff(second, timestamp, lead(timestamp) over (partition by user_id order by timestamp)) as time_diff
from fraud_detection_dataset
where is_fraud = 1
having time_diff < 60;

/* 8. Analyze Age Group Trends in Fraud
Problem: Determine if fraud frequency varies across different age groups. */
select case
when age < 25 then 'Under 25'
when age between 25 and 40 then '25-40'
when age between 41 and 60 then '41-60'
else 'over 60'
end as age_group,
count(is_fraud) as fraud_count
from fraud_detection_dataset
where is_fraud = 1
group by age_group
order by fraud_count desc;

/* 9. Flag Fraudulent Transactions with High Debt Levels
Problem: Find fraud cases associated with high debt, indicating financial strain. */
select
user_id,amount,debt,is_fraud
from fraud_detection_dataset
where is_fraud = 1 and debt > 20000
order by debt desc;

/* 10.Track Multiple Fraudulent Transactions from a Single Location
Problem: Detect frauds repeatedly occurring from the same location. */
select
location, count(is_fraud) as fraud_count
from fraud_detection_dataset
where is_fraud = 1
group by location
having fraud_count > 1
order by fraud_count desc;

/* 11. Analyze Fraud Frequency Based on Transaction Day of the Week
Problem: Determine if fraud rates change depending on the day of the week. */
select
dayname(timestamp) as day_of_week,
count(is_fraud) as fraud_count
from fraud_detection_dataset
where is_fraud = 1
group by day_of_week
order by fraud_count desc;


/*
Financial Risk Managemnet
Project 2: Credit Risk Analysis
*/

/* 1. Calculate Debt-to-Income Ratio
Problem: Identify borrowers with high debt-to-income (DTI) ratios who may struggle with repayments. */
SELECT
id, annual_income, debt_to_income,
round((debt_to_income / annual_income),6) as debt_income_ratio
FROM credit_score_dataset
where debt_to_income is not null and annual_income is not null
order by debt_income_ratio desc;

/* 2. Determine Grade-Based Default Trends
Problem: Understand if certain grades correlate with higher default rates.*/
SELECT
grade, count(id) as total_loans,
sum(case when delinq_2yrs >= 1 then 1 else 0 end) as default_count,
(sum(case when delinq_2yrs >= 1 then 1 else 0 end)/count(id))*100 as default_rate
from credit_score_dataset
group by grade
order by default_rate desc;

/* 3. Employment Length and Creditworthiness
Problem: Assess if employment stability affects default rates. */
SELECT
employment_length, count(id) as total_loans,
sum(case when delinq_2yrs >= 1 then 1 else 0 end) as default_count,
(sum(case when delinq_2yrs >= 1 then 1 else 0 end)/count(id))*100 as default_rate
from credit_score_dataset
group by employment_length
order by default_rate desc;

/* 4. Analyze Loan Purpose and Default Rates
Problem: Discover if certain loan purposes have higher default rates. */
SELECT
purpose, count(id) as total_loans,
sum(case when delinq_2yrs >= 1 then 1 else 0 end) as default_count,
(sum(case when delinq_2yrs >= 1 then 1 else 0 end)/count(id))*100 as default_rate
from credit_score_dataset
group by purpose
order by default_rate desc;

/* 5. Calculate Revolving Utility Ratio
Problem: Higher revolving utility often correlates with default risk. */
SELECT
id, revolving_balance, revoling_utility,
(revolving_balance / (revoling_utility + 1)) AS revolv_util_ratio
from credit_score_dataset
where revoling_utility is not null and revolving_balance is not null
order by revolv_util_ratio desc;

/* 6. Loan Amount vs. Default Rate
Problem: Find out if larger loan amounts have higher counts. */
SELECT
loan_amount,
sum(case when delinq_2yrs >= 1 then 1 else 0 end) as default_count,
(sum(case when delinq_2yrs >= 1 then 1 else 0 end)/count(id))*100 as default_rate
from credit_score_dataset
group by loan_amount
order by default_count desc;

/* 7. State-Level Default Analysis
Problem: Identify states with high default rcounts. */
SELECT
address_state, count(id) as total_loans,
sum(case when delinq_2yrs >= 1 then 1 else 0 end) as default_count,
(sum(case when delinq_2yrs >= 1 then 1 else 0 end)/count(id))*100 as default_rate
from credit_score_dataset
group by address_state
order by default_count desc;

/* 8. Early Credit History and Default Probability
Problem: Determine if borrowers with earlier credit histories have lower default rates. */
SELECT
earliest_credit_line, count(id) as total_loans,
sum(case when delinq_2yrs >= 1 then 1 else 0 end) as default_count,
(sum(case when delinq_2yrs >= 1 then 1 else 0 end)/count(id))*100 as default_rate
from credit_score_dataset
group by earliest_credit_line
order by default_rate asc;

/* 9. High Credit Line Utilization and Default Rates
Problem: Determine if higher credit utilization increases default likelihood. */
SELECT
revoling_utility, count(id) as total_loans,
sum(case when delinq_2yrs >= 1 then 1 else 0 end) as default_count,
(sum(case when delinq_2yrs >= 1 then 1 else 0 end)/count(id))*100 as default_rate
from credit_score_dataset
group by revoling_utility
order by default_rate desc;

/* 10. Monthly Income and Default Probability
Problem: Analyze the relationship between annual income and the likelihood of default. */
SELECT
annual_income, count(id) as total_loans,
sum(case when delinq_2yrs >= 1 then 1 else 0 end) as default_count,
(sum(case when delinq_2yrs >= 1 then 1 else 0 end)/count(id))*100 as default_rate
from credit_score_dataset
where annual_income is not null
group by annual_income
order by default_count desc;