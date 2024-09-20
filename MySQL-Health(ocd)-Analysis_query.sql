/* OCD Pateient's Data analysis. And here some problems are based on demography, clinical history
Diagnosis, Medications, and Y-BOCS(Yale-Brown Obsessive Compulsive Scale) score. */
-- Demographies
-- 1. Count of Female vs Male that have OCD & Average obsession score by gender
Select
gender,
count(patient_ID) as patient_count,
round(avg(Y_BOCS_score_Obsessions),2) as avg_obs_score
from ocd_patient_dataset
group by gender
order by patient_count desc;

-- 2. Count of patients by ethnicity  & their respective Average obsession score
Select
ethnicity,
count(patient_ID) as patient_count,
round(avg(Y_BOCS_score_Obsessions),2) as avg_obs_score
from ocd_patient_dataset
group by ethnicity
order by patient_count desc;

-- Clinical History
-- 3. What are the most common previous diagnoses among OCD patients?
Select
previous_diagnoses,
count(patient_ID) as patient_count
from ocd_patient_dataset
group by previous_diagnoses
order by patient_count desc;

-- 4. How many patients have a family history of OCD?
Select
family_history_of_ocd,
count(patient_ID) as patient_count
from ocd_patient_dataset
group by family_history_of_ocd
order by patient_count desc;

-- Diagnosis
-- 5. What is the most common Obsession type(count) & its respective average score
select
obsession_type,
count(patient_ID) as patient_count,
avg(Y_BOCS_score_Obsessions) as  avg_obs_score
from ocd_patient_dataset
group by 1
order by 2;

-- 6. what is the most common complulsion type(count) and its respective average score
select
compulsion_type,
count(patient_ID) as patient_count,
avg(Y_BOCS_score_Compulsions) as  avg_obs_score
from ocd_patient_dataset
group by 1
order by 2;

-- 7. What is the distribution of OCD symptom duration in months?
SELECT 
    duration_of_symptoms_months,
    CONCAT(
        FLOOR(duration_of_symptoms_months / 12), ' years, ',    -- Calculate the years
        FLOOR(MOD(duration_of_symptoms_months, 12)), ' months, ',  -- Calculate remaining months
        (duration_of_symptoms_months * 30) % 30, ' days'          -- Approximate days
    ) AS duration_in_years_months_days,
    COUNT(patient_ID) AS patient_count
FROM 
    ocd_patient_dataset
GROUP BY 
    duration_of_symptoms_months;

-- 8. How many patients are diagnosed with both depression and anxiety?
select 
count(patient_ID) as _combined_patient_count
from ocd_patient_dataset
where depression_diagnosis ='Yes' and anxiety_diagnosis = 'Yes';

-- Y-BOCS(Yale-Brown Obsessive Compulsive Scale) score
-- 9. Which patients have the highest total Y-BOCS score (obsessions + compulsions)?
SELECT 
patient_ID, 
(Y_BOCS_score_Obsessions + Y_BOCS_score_Compulsions) AS total_score
FROM ocd_patient_dataset
ORDER BY total_score DESC
LIMIT 10;

-- Medications
-- 10. What are the most commonly prescribed medications?
select
medications,
count(patient_ID) as patient_count
from ocd_patient_dataset
group by medications
order by patient_count desc;
