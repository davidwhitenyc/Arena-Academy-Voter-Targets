--creates table containing "Tiers" for turnout, support and persuadability

CREATE OR REPLACE TABLE `dwarenaacademy.arena2022.tiers` AS

SELECT
  s.unique_id,
  s.state_code,
  s.turnout_score,
  s.support_score,
  s.persuadability_score,
  CASE
    WHEN s.turnout_score BETWEEN 90 AND 100 THEN 'Tier 1'
    WHEN s.turnout_score BETWEEN 85 AND 90 THEN 'Tier 2'
    WHEN s.turnout_score BETWEEN 80 AND 85 THEN 'Tier 3'
    WHEN s.turnout_score BETWEEN 75 AND 80 THEN 'Tier 4'
  ELSE
  ""
END
  AS turnout_tier,
  
CASE
    WHEN s.support_score BETWEEN 90 AND 100 THEN 'Tier 1'
    WHEN s.support_score BETWEEN 85 AND 90 THEN 'Tier 2'
    WHEN s.support_score BETWEEN 80 AND 85 THEN 'Tier 3'
    WHEN s.support_score BETWEEN 75 AND 80 THEN 'Tier 4'
  ELSE
  ""
END
  AS support_tier,
  
CASE
    WHEN s.persuadability_score BETWEEN 2 AND 5 THEN 'Tier 1'
    WHEN s.persuadability_score BETWEEN 1.5 AND 2 THEN 'Tier 2'
    WHEN s.persuadability_score BETWEEN 1.25 AND 1.5 THEN 'Tier 3'
    WHEN s.persuadability_score BETWEEN 1 AND 1.25 THEN 'Tier 4'
  ELSE
  ""
END
  AS persuasion_tier,
FROM
  `arenatraining.scores.scores_2022` s;