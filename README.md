# malaria_analytics_project
Analysisng Malaria data from 2020 to 2024(MOH , Uganda)
🧭 Spatial Statistical Findings Report
Project: Spatial Distribution and Hotspot Analysis of Malaria Cases in Uganda (2020–2024)
Prepared for: Ministry of Health (MoH), Republic of Uganda
Prepared by: SSIMBWA BASHIR (Data Analyst)
Date: [06/10/2025]
1.	Overview
This study analysed the spatial distribution of confirmed malaria cases across all districts in Uganda between 2020 and 2024, using both descriptive and spatial autocorrelation techniques. The objective was to determine whether malaria cases are clustered, random, or evenly dispersed across the country and to identify significant hotspots (high-incidence clusters) and cold spots (low-incidence clusters) for targeted intervention.
2.	Key Data Inputs
•	Data Source: Ministry of Health Uganda, National Malaria Database (2020–2024)
•	Spatial Unit: 136 districts of Uganda
Variables Used:
•	Confirmed Malaria Cases (B/S & RDT)
•	Total Population (district-level)
•	Coordinates (Latitude & Longitude)
•	Derived: Incidence Rate = (Confirmed Cases / Population) × 1,000
3. Analytical Methods
•	Descriptive Analysis:
Examined malaria trends and incidence rate distribution across years, regions, and districts.
•	Global Spatial Autocorrelation:
Conducted using the Global Moran’s I statistic to determine whether malaria incidence exhibits spatial clustering.
•	Local Spatial Autocorrelation (LISA):
Used Local Moran’s I to detect localized clusters (hotspots and coldspots) across the country.
•	Spatial Weights:
Hybrid Queen + KNN (k=5) matrix applied to account for border contiguity and isolated districts (“islands”).
3.	Result Summary:

Statistic	Value
	Interpretation
Moran’s I	0.5200
	Strong positive spatial autocorrelation
Expected I	-0.0074	(Random distribution baseline)
Z-score	9.88	Highly significant clustering 
P-value	0.001	Statistically significant(<0.05)

➡️ Interpretation:
	The Moran’s I value of 0.52 with a p-value of 0.001 indicates strong, statistically significant clustering of malaria incidence.
This means districts with high malaria rates tend to be geographically close to other high-incidence districts, and similarly for low-incidence ones.


4.	Local Moran’s I (LISA) – Hotspot & Cold spot Analysis
Cluster Type	Number of Districts	Interpretation
High-High (HH)	13	Hotspots — high malaria incidence surrounded by high-incidence neighbours
Low-Low (LL)	22	Coldspots — low incidence surrounded by low-incidence neighbours
Significant Total	38	Districts with statistically significant spatial clustering

Implications:
Approximately 28% of districts (38 out of 136) show statistically significant local clustering.
Hotspot districts are likely concentrated in northern and eastern Uganda, consistent with known malaria endemic zones.
Coldspots are more frequent in southwestern and central Uganda, where transmission intensity is typically lower.

Interpretation of “Islands” and Connectivity
•	Islands identified: 2 (Districts 134 & 135) lacked contiguity neighbors, likely due to geographic isolation (e.g., island districts on Lake Victoria or border areas).
•	These districts were assigned KNN-based neighbors (k=5) to ensure analytical inclusion.
•	The spatial weight matrix thus formed two connected components, which is acceptable for analysis and does not compromise validity.
________________________________________



6. Key Insights for MoH Uganda
Observation	Strategic Implication
Strong clustering (Moran’s I = 0.52)	Malaria is not randomly distributed — interventions should be spatially targeted.
13 hotspots (High-High)	Require immediate surveillance strengthening, vector control intensification, and resource prioritization.
22 coldspots (Low-Low)	Reflect effective malaria control; these areas can serve as benchmark regions for best practices.
Islands with no contiguity	Need special logistical strategies, e.g., aerial spraying or mobile health units.
Stable temporal trends (2020–2024)	Suggests endemic persistence, not seasonal randomness.
________________________________________
7. Technical Notes
•	The User Warnings about “Legend not supported” are visualization-related only, not analytical errors.
They can be resolved by customizing Matplotlib’s legend handler but do not affect the results.
•	The two disconnected spatial components reflect geographic isolation — expected in Uganda’s topology and handled correctly using Queen + KNN hybrid weights.
________________________________________
8. Recommendations
1.	Targeted Interventions:
Deploy intensified vector control (IRS, LLINs, larval management) in identified High-High clusters (northern/eastern Uganda).
2.	Monitoring & Evaluation:
Establish continuous geospatial surveillance using district-level dashboards in Power BI.
3.	Coldspot Maintenance:
Maintain preventive efforts in low-incidence regions to prevent resurgence.
4.	Data Integration:
Link spatial results with health facility data (DHIS2) for real-time malaria risk mapping.
5.	Predictive Modeling Phase (Next):
Combine this spatial layer with Bayesian and regression-based models to predict future outbreak regions under climate and population dynamics scenarios.
________________________________________

9. Next Steps
•	✅ Export results (uganda_district_metrics_with_spatial_stats.csv) to MySQL or Power BI for interactive visualization.
•	🧠 Proceed to Power BI dashboarding with key performance indicators (KPIs):
o	Incidence rate by district & region
o	Annual malaria trends (2020–2024)
o	Hotspot vs Coldspot maps (choropleth)
o	Temporal-spatial trend analytics
________________________________________

Conclusion
The analysis provides strong statistical evidence that malaria cases in Uganda are spatially clustered, particularly in northern and eastern regions.
This underscores the need for data-driven, geographically targeted malaria control programs to accelerate national malaria elimination goals.

