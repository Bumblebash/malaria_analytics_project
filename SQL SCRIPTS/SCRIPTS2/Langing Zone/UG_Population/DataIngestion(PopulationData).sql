USE MalariaLanding_DB;

WITH rate AS(
SELECT
Region,
District,
population_2014,
population_2024,
((LOG(population_2024) - LOG(population_2014)) / 10) As rate
FROM UBOS_population_data
),
Estimated_population AS (
SELECT 
Region,
District,
rate,
(population_2014 * EXP(rate*6)) AS est_2020,
(population_2014 * EXP(rate*7)) AS est_2021,
(population_2014 * EXP(rate*8)) AS est_2022,
(population_2014 * EXP(rate*9)) AS est_2023,
population_2024
FROM rate
)
SELECT * FROM Estimated_population;