--creates base table to be used as Google Data Studio datasource

CREATE OR REPLACE TABLE `dwarenaacademy.arena2022.universes` AS
SELECT

  --columns from `arenatraining.analytics.person` p
  p.unique_id,
  p.first_name,
  p.last_name,
  p.county_name,
  p.state_code,
  p.media_market,
  p.us_cong_district,
  p.state_senate_district,
  p.state_house_district,
  p.age,
  p.gender,
  p.ethnicity,
  p.party_name,
  p.email_id,
  p.cell_id,
  p.landline_id,
  p.voting_address_id,
  
  --columns from `arenatraining.analytics.person_votes` v
  v.vote18,
  v.vote20,
  
  --columns from `arenatraining.scores.scores_2022` s
  s.turnout_score,
  s.support_score,
  s.persuadability_score,
  
  --tier calculated from scores and stored in `dwarenaacademy.arena2022.tiers` t
  t.turnout_tier,
  t.support_tier,
  t.persuasion_tier,
  
  --calculate gotv tiers
  CASE
  WHEN t.persuasion_tier = 'Tier 1' AND (t.support_score BETWEEN 90 AND 100) AND (t.turnout_score BETWEEN 45 AND 55) THEN 'Tier 1'
  WHEN t.persuasion_tier = 'Tier 2' AND (t.support_score BETWEEN 85 AND 90) AND (t.turnout_score BETWEEN 40 AND 60) THEN 'Tier 2'
  WHEN t.persuasion_tier = 'Tier 3' AND (t.support_score BETWEEN 80 AND 85) AND (t.turnout_score BETWEEN 35 AND 65) THEN 'Tier 3'
  WHEN t.persuasion_tier = 'Tier 4' AND (t.support_score BETWEEN 75 AND 80) AND (t.turnout_score BETWEEN 35 AND 65) THEN 'Tier 4'
  ELSE ""
  END AS gotv_tier,

  --create age group buckets
  CASE
  WHEN p.age BETWEEN 18 AND 24 THEN '18 to 24'
  WHEN p.age BETWEEN 25 AND 34 THEN '25 to 34'
  WHEN p.age BETWEEN 35 AND 49 THEN '35 to 49'
  WHEN p.age BETWEEN 50 AND 64 THEN '50 to 64'
  WHEN p.age BETWEEN 65 AND 999 THEN '65+'
  ELSE ""
  END AS age_group
  
  
FROM
  `arenatraining.analytics.person` p
LEFT JOIN
  `arenatraining.analytics.person_votes` v
ON
  p.unique_id = v.unique_id
LEFT JOIN
  `arenatraining.scores.scores_2022` s
ON
  p.unique_id = s.unique_id
LEFT JOIN
  `dwarenaacademy.arena2022.tiers` t
ON
  p.unique_id = t.unique_id
  
  --include only voters in Florida CD-27
WHERE
  p.state_code = 'FL'
  AND p.us_cong_district ='027';