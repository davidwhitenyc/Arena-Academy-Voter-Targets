--all columns in `arenatraining.analytics.person` p
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


--all columns in `arenatraining.analytics.person_votes` v
v.unique_id,
v.state_code,
v.vote18,
v.vote20,

--all columns in `arenatraining.scores.scores_2022` s
s.unique_id,
s.state_code,
s.turnout_score,
s.support_score,
s.persuadability_score,

--tier calculated from scores and stored in `dwarenaacademy.arena2022.tiers` t
t.turnout_tier,
t.support_tier,
t.persuasion_tier,