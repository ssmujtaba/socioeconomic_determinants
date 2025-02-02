# Socioeconomic Determinants of Life Expectancy: A Data Analysis Project

## Project Overview

This project explores the relationship between socioeconomic factors and life expectancy across different countries and regions. Using **SQL** and **Python**, we analyze data from the World Bank and other international organizations to identify key determinants of life expectancy. The analysis includes data cleaning, exploratory data analysis (EDA), statistical modeling, and time series forecasting.

## Data Source

The dataset used in this project is sourced from the World Bank and other international organizations. It includes information on life expectancy, health expenditure, education expenditure, CO2 emissions, and other socioeconomic indicators. The data is available in a CSV file named `final_life_expectancy_dataset.csv`.

## Data Analysis

The analysis was conducted using **Python** for data cleaning, visualization, and statistical modeling, and **SQL** for database management and querying. Below is a summary of the key steps:

### 1. Data Cleaning and Preprocessing (Python)

# **Missing Values**
```
Life Expectancy World Bank 188
Prevelance of Undernourishment 684
CO2 152
Health Expenditure % 180
Education Expenditure % 1090
Unemployment 304
Corruption 2331
Sanitation 1247
```

* Missing values in the 'Life Expectancy', 'CO2', 'Health Expenditure', and 'Unemployment' columns were handled using median imputation.
* Missing values in 'Prevalence of Undernourishment', 'Sanitation', and 'Education Expenditure' were imputed using KNN imputation.
* The 'Corruption' column, with a high percentage of missing values, was removed.
* A new feature, 'Spending Category', was engineered based on 'Health Expenditure %' quartiles, categorized as 'Low Spending', 'Moderate Spending', 'High Spending', and 'Very High Spending'.

# Percentage of Missing Values

```
Life Expectancy World Bank 5.686630
Prevelance of Undernourishment 20.689655
CO2 4.597701
Health Expenditure % 5.444646
Education Expenditure % 32.970357
Unemployment 9.195402
Corruption 70.508167
Sanitation 37.719298
```

# Imputing Missing Values

```
Imputing Life Expectancy World Bank with median: 72.1685
Imputing CO2 with median: 10204.999923706051
Imputing Health Expenditure % with median: 5.89235234
Imputing Unemployment with median: 5.92000007629395
Imputing Life Expectancy World Bank with median: 72.1685
Imputing CO2 with median: 10204.999923706051
Imputing Health Expenditure % with median: 5.89235234
Imputing Unemployment with median: 5.92000007629395
```

# Dealing with Missing Values

---
So, there were multiple columns in my dataset that had missing values. Corruption had a staggering of approximately 71% missing data. This column was dropped completely. Other columns include Life Expectancy World Bank, Prevelance of Undernourishment, CO2, Health Expenditure %, Education Expenditure %, Unemployment, and Sanitation were all imputed using mean/median imputation as well as the KNN Imputation technique.

Life Expectancy World Bank, CO2, Health Expenditure %, Unemployment were imputed using the mean/median imputation approach. Since the missingness is relatively small, these simple techniques are less likely to significantly distort the overall distribution. Choose mean if the data is normally distributed, otherwise, use the median.

Prevelance of Undernourishment, Sanitation and Education Expenditure % were imputed using KNN Imputation. These techniques can better estimate missing values while capturing relationships with other variables. KNN can capture complex patterns, while Regression assumes a linear relationship with other predictors.

So, the newly created df was then saved to a separate csv file and the original is intact in its raw form. It is always wise to keep the raw
dataset intact in it's original form. If one makes any mistakes in the new dataset, you can always refer back to the original.

---

# 2. Exploratory Data Analysis (EDA) & Data Visualization

![output](https://github.com/user-attachments/assets/12b5313b-d739-42b5-a79b-62f870f771d5)

---

**Insight**

**Histogram 1: Distribution of Life Expectancy**

* Shape: The distribution appears to be roughly bell-shaped, with a slight skew to the left. This suggests that the majority of countries have a life expectancy clustered around the mean (which seems to be in the 70s), with a tail extending towards lower life expectancies.

* Center: The peak of the histogram indicates the mode, which represents the most frequent life expectancy range.

* Spread: The spread of the histogram gives us an idea of the variability in life expectancies. A wider spread would suggest greater differences in life expectancies across countries.

**Histogram 2: Distribution of CO2 Emissions**

* Shape: This histogram displays a heavily right-skewed distribution. This implies that a small number of countries have very high CO2 emissions, pulling the tail of the distribution to the right. Most countries likely have lower CO2 emissions clustered towards the left side of the graph.

* Center: The mode in this case would represent the most common range of CO2 emissions, likely falling towards the lower end.

* Spread: The long tail to the right indicates a large spread, suggesting substantial variation in CO2 emissions among countries.

**Histogram 3: Distribution of Health Expenditure**

* Shape: This histogram also exhibits a right-skewed distribution. This means that while many countries have lower health expenditures, a few countries spend significantly more, creating the tail on the right.

* Center: The mode would represent the most frequent range of health expenditure, likely located towards the lower end.

* Spread: The spread is considerable due to the tail, indicating a wide range of health expenditure percentages across countries.

**Overall Observations:**

* It's interesting to note that both CO2 emissions and health expenditure show right-skewed distributions, suggesting that a small proportion of countries have a disproportionately large impact or investment in these areas.

* The life expectancy histogram, being more bell-shaped, suggests a more even distribution of life expectancies across countries.

---

![output1](https://github.com/user-attachments/assets/b1ae2b89-c5be-45b3-bece-50eb44b3ad22)

**Insight**

* At first glance, the scatterplot seems to suggest a very weak positive relationship between Health Expenditure and Life Expectancy. As Health Expenditure increases along the x-axis, there is a slight tendency for Life Expectancy to increase on the y-axis. However, this trend is not very pronounced, and there is substantial scatter of points throughout the plot.

**Key Observations**

* Clustering: A significant cluster of points is concentrated towards the lower end of Health Expenditure and mid-range Life Expectancy. This suggests that many countries achieve a decent life expectancy without extremely high health expenditures.

* Outliers: There are a few outliers with very high Health Expenditure but without correspondingly high Life Expectancy. This might indicate that increased spending doesn't always translate directly into longer lifespans, and other factors could be at play.

* Spread: The considerable spread of points across the entire plot highlights the variability in both Health Expenditure and Life Expectancy among different countries.

**Possible Explanations for Weak Trend:**

* Diminishing Returns: It's possible that beyond a certain level, additional health expenditure yields diminishing returns in terms of life expectancy. Other factors like socioeconomic conditions, lifestyle choices, and access to basic healthcare might play a more significant role.

* Data Limitations: The scatterplot might not capture all the relevant factors influencing life expectancy, such as education, nutrition, and environmental factors.

---

![output2](https://github.com/user-attachments/assets/1e294b8f-9953-457a-a4ef-28bc39a68d69)

![output3](https://github.com/user-attachments/assets/bb85b8e8-fe34-4aaf-ae53-ef13c8bf3f23)

**Insight**

* The first bar chart illustrates variations in average life expectancy across different regions. North America boasts the highest life expectancy, exceeding 80 years, while Sub-Saharan Africa reports the lowest, around 58 years. There is considerable variation between the remaining regions, with life expectancies ranging from roughly 68 to 75 years.

* The second bar chart reveals a clear trend: as national income level rises, so does life expectancy. High-income countries enjoy the longest lifespans, averaging around 80 years, whereas low-income countries have the shortest, at roughly 58 years. The two middle-income categories fall somewhere in between, with life expectancies progressively increasing alongside income levels.

This pattern suggests a strong correlation between a nation's wealth and the average lifespan of its citizens.

---

# **3. Feature Engineering**

![output4](https://github.com/user-attachments/assets/dc3a47ce-424d-48b5-b568-f7ace9905db0)

**Insight**

* Positive Trend: There's a clear upward trend in life expectancy as healthcare expenditure increases, suggesting a positive relationship.

* Non-Linearity: The relationship might not be perfectly linear. The initial increase in life expectancy seems steeper, possibly slowing down at higher expenditure levels. This suggests that increasing healthcare spending beyond a certain point may yield diminishing returns in terms of life expectancy.

* Outliers: There are a few outliers, particularly at higher expenditure levels, where life expectancy is lower than expected. These outliers could be due to various factors and warrant further investigation.

* Variation: Even within similar expenditure ranges, there's some variation in life expectancy. This indicates that other factors besides healthcare expenditure play a role.

![output5](https://github.com/user-attachments/assets/56a9466a-fe85-4f25-9431-b66380d5653b)

**Insight**

* Increasing Trend: Life expectancy generally increases as spending category moves from 'Low' to 'Very High'. This confirms the positive relationship observed earlier.

* Overlap: There's some overlap between categories, particularly between 'Moderate' and 'High' spending. This suggests that other factors beyond healthcare expenditure influence life expectancy.

* Outliers: Outliers are present in all categories, indicating that within each category, there's variability in life expectancy.

* Distribution: The distributions within each category are right-skewed, meaning there are more countries with lower life expectancy within each category.

**Additional Observations**

**'Very High' Spending:** The 'Very High' spending category has the widest range of life expectancy, suggesting that factors other than healthcare expenditure play a significant role at higher spending levels.

* Outliers in **'Very High' Spending:** The presence of outliers in the 'Very High' spending category is particularly noteworthy and warrants further investigation to understand the reasons behind the lower life expectancy.

---

# **4. Statistical Analysis**

![output6](https://github.com/user-attachments/assets/85fb98de-394b-4988-af2f-718be360c916)

# **Insight**

## **Key Observations:**

1. **Strong Positive Correlations:**

* Life Expectancy World Bank has a strong positive correlation with Health Expenditure % (0.29) and Education Expenditure % (0.18). This suggests that higher spending on healthcare and education is associated with increased life expectancy.

* Sanitation has a moderate positive correlation with Life Expectancy World Bank (0.53). This indicates that better sanitation practices are linked to improved life expectancy.

* There are strong positive correlations between CO2 emissions and several variables, including Injuries (0.95), NonCommunicable (0.82), and Health Expenditure % (0.11). This suggests that higher CO2 emissions are associated with increased injuries, noncommunicable diseases, and healthcare spending.

2. **Strong Negative Correlations:**

* Prevelance of Undernourishment has strong negative correlations with Life Expectancy World Bank (-0.62), Health Expenditure % (-0.19), and Education Expenditure % (-0.24). This indicates that higher levels of undernourishment are associated with lower life expectancy, lower healthcare spending, and lower education expenditure.

* Sanitation has a strong negative correlation with Prevelance of Undernourishment (-0.48). This suggests that better sanitation practices are associated with lower levels of undernourishment.

3. **Other Notable Relationships:**

* There's a moderate positive correlation between Health Expenditure % and Education Expenditure % (0.32), suggesting that countries with higher healthcare spending also tend to invest more in education.

* Injuries have strong positive correlations with Communicable (0.77) and NonCommunicable (0.95) diseases, indicating a link between injuries and these types of diseases.

**Overall Analysis**:

* Life Expectancy: As expected, life expectancy is positively associated with healthcare expenditure and education, and negatively associated with undernourishment.

* Healthcare and Education: There's a moderate positive relationship between healthcare and education expenditure, suggesting that countries investing in one often invest in the other.

* Environmental Factors: CO2 emissions have complex relationships with various health outcomes, suggesting potential negative environmental impacts on health.

* Sanitation and Undernourishment: Better sanitation is associated with improved life expectancy and lower undernourishment, highlighting the importance of basic infrastructure for health.

# **Important Considerations:**

* Correlation does not imply causation: While the heatmap reveals associations between variables, it doesn't prove causality. Further analysis is needed to establish causal relationships.

* Multicollinearity: Some variables, such as Health Expenditure % and Education Expenditure %, have moderate correlations with each other. This can affect the interpretation of regression models and may require further consideration.


# **Linear Regression Analysis**

<table style="text-align:center"><tr><td colspan="2" style="border-bottom: 1px solid black"></td></tr>
<tr><td style="text-align:left"></td><td colspan="1"><em>Dependent variable: Q("Life Expectancy World Bank")</em></td></tr><tr><td style="text-align:left"></td><tr><td style="text-align:left"></td><td>(1)</td></tr>
<tr><td colspan="2" style="border-bottom: 1px solid black"></td></tr>

<tr><td style="text-align:left">CO2</td><td>0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.000)</td></tr>
<tr><td style="text-align:left">Intercept</td><td>62.149<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.470)</td></tr>
<tr><td style="text-align:left">Q("Education Expenditure %")</td><td>0.549<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.088)</td></tr>
<tr><td style="text-align:left">Q("Health Expenditure %")</td><td>0.800<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.058)</td></tr>

<td colspan="2" style="border-bottom: 1px solid black"></td></tr>
<tr><td style="text-align: left">Observations</td><td>3306</td></tr><tr><td style="text-align: left">R<sup>2</sup></td><td>0.102</td></tr><tr><td style="text-align: left">Adjusted R<sup>2</sup></td><td>0.101</td></tr><tr><td style="text-align: left">Residual Std. Error</td><td>8.679 (df=3302)</td></tr><tr><td style="text-align: left">F Statistic</td><td>124.790<sup>***</sup> (df=3; 3302)</td></tr>
<tr><td colspan="2" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align: left">Note:</td><td colspan="1" style="text-align: right"><sup>*</sup>p&lt;0.1; <sup>**</sup>p&lt;0.05; <sup>***</sup>p&lt;0.01</td></tr></table>

# **Interpretation of the Regression Analysis**

**Key Findings:**

* Health Expenditure: A 1% increase in health expenditure (as % of GDP) is associated with a 0.800 unit increase in life expectancy, holding other factors constant. This effect is statistically significant (p<0.01).

* Education Expenditure: A 1% increase in education expenditure (as % of GDP) is associated with a 0.549 unit increase in life expectancy, holding other factors constant. This effect is also statistically significant (p<0.01).

* CO2 Emissions: A 1 unit increase in CO2 emissions is associated with a very small (0.000) but statistically significant (p<0.01) increase in life expectancy. This might seem counterintuitive, but it's important to remember that correlation doesn't equal causation, and this relationship could be influenced by other factors not included in the model.

* Model Fit: The R-squared value of 0.102 indicates that the model explains about 10.2% of the variation in life expectancy. This suggests that other factors not included in the model also play a significant role in determining life expectancy.

---

# **5. Time Series Analysis**

![image](https://github.com/user-attachments/assets/d71d3c6d-4181-48fd-b159-11f47813ae36)

# **Interpretation of the Time Series Trend Analysis**

# **1. Trend:**

* The trend component shows a clear upward trajectory in life expectancy over the years, indicating a long-term increase.

* This suggests that overall, life expectancy has been consistently improving.

# **2. Seasonality:**

* The seasonality component is relatively flat, indicating minimal seasonal variation in life expectancy.

* This means that life expectancy does not exhibit any significant fluctuations throughout the year.

# **3. Residuals:**

* The residuals appear to be random and centered around zero, suggesting that there's no significant underlying pattern left unexplained by the trend component.

# **Overall Interpretation**

* The analysis suggests that the primary driver of the increase in life expectancy over time is a long-term trend, rather than seasonal fluctuations.

* This finding is consistent with the earlier analysis that showed a positive relationship between life expectancy and various socio-economic factors, which likely contribute to the overall upward trend.

# **Forecasting of Life Expectancy**

![image](https://github.com/user-attachments/assets/3674c9ab-6502-4dc5-9926-0b36edcec541)

# **Interpretation of the Life Expectancy Forecast:**

# **Overall Trend:**

* The forecast suggests that global average life expectancy is expected to continue increasing over the next 10 years (from 2019 to 2028).


* This is indicated by the red forecast line, which shows a gradual upward slope.

# **Historical Data:**

* The blue dots represent the average global life expectancy for each year from 2001 to 2019.

* While there's a general upward trend in the historical data, it's important to remember that these are yearly averages, and the plot doesn't show any within-year variations. (The reason for this is because the data is yearly, not montly or quartlery, hence no variation).

# **Confidence Intervals:**

* The shaded pink area around the forecast line represents the confidence intervals. This indicates the range within which the actual life expectancy is likely to fall with a certain degree of confidence (typically 95%).

* The width of the confidence intervals increases as we move further into the future, reflecting the increasing uncertainty of the forecast over longer time horizons.

# **Specific Predictions:**

* Based on the forecast, average global life expectancy is projected to reach around 73.5 years by 2028.

* The 95% confidence interval for this prediction ranges from approximately 72.5 to 74.5 years.

* This suggests a high probability that life expectancy will continue to improve, but the exact magnitude of the increase is uncertain.

### This concludes the analysis of the dataset using Python. Please note that libraries such as Pandas, NumPy, Seaborn, Matplotlib and Statsmodel. In the next part, I will provide the analysis using SQL on my dataset.
---

# **1. Data Loading and Table Creation**

# CountryName, CountryCode, Region, IncomeGroup, Year, LifeExpectancy, Undernourishment, CO2, HealthExpenditure, EducationExpenditure, Unemployment, Corruption, Sanitation, Injuries, Communicable, NonCommunicable

| CountryName | CountryCode | Region | IncomeGroup | Year | LifeExpectancy | Undernourishment | CO2 | HealthExpenditure | EducationExpenditure | Unemployment | Corruption | Sanitation | Injuries | Communicable | NonCommunicable |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Afghanistan | AFG | South Asia | Low income | 2001 | 56.308 | 47.8 | 730.0000 |  |  | 10.8090 |  |  | 2179727.1000 | 9689193.7000 | 5795426.3800 |
| Angola | AGO | Sub-Saharan Africa | Lower middle income | 2001 | 47.059 | 67.5 | 15960.0000 | 4.4835 |  | 4.0040 |  |  | 1392080.7100 | 11190210.5300 | 2663516.3400 |
| Albania | ALB | Europe & Central Asia | Upper middle income | 2001 | 74.288 | 4.9 | 3230.0000 | 7.1395 | 3.4587 | 18.5750 |  | 40.5209 | 117081.6700 | 140894.7800 | 532324.7500 |
| Andorra | AND | Europe & Central Asia | High income | 2001 |  |  | 520.0000 | 5.8659 |  |  |  | 21.7887 | 1697.9900 | 695.5600 | 13636.6400 |
| United Arab Emirates | ARE | Middle East & North Africa | High income | 2001 | 74.544 | 2.8 | 97200.0000 | 2.4844 |  | 2.4930 |  |  | 144678.1400 | 65271.9100 | 481740.7000 |
| Argentina | ARG | Latin America & Caribbean | Upper middle income | 2001 | 73.755 | 3 | 125260.0000 | 8.3718 | 4.8337 | 17.3200 |  | 48.0540 | 1397676.0700 | 1507068.9800 | 8070909.5200 |
| Armenia | ARM | Europe & Central Asia | Upper middle income | 2001 | 71.8 | 26.1 | 3600.0000 | 4.6456 | 2.4694 | 10.9120 |  | 46.3519 | 103371.7500 | 122238.1300 | 767916.1900 |
| American Samoa | ASM | East Asia & Pacific | Upper middle income | 2001 |  |  |  |  |  |  |  |  | 1683.9800 | 2933.9800 | 10752.1300 |
| Antigua and Barbuda | ATG | Latin America & Caribbean | High income | 2001 | 74.171 |  | 350.0000 | 5.4359 |  |  |  |  | 2201.1200 | 3279.7200 | 14289.6900 |
| Australia | AUS | East Asia & Pacific | High income | 2001 | 79.6341 | 2.5 | 345640.0000 | 7.6962 |  | 6.7400 |  | 58.7889 | 612233.8100 | 208282.7300 | 4158052.8600 |

**Output**

* The output shows the first few rows of the economic_info table after loading the data from the CSV file. Here’s a sample of the output:

* The economic_info table was successfully created and populated with data from the life_expectancy.csv file. The table includes columns for various socioeconomic indicators such as life expectancy, undernourishment, CO2 emissions, health expenditure, education expenditure, unemployment, corruption, sanitation, injuries, communicable diseases, and non-communicable diseases.

* The LOAD DATA INFILE statement was used to load the data, and the NULLIF function was applied to handle missing values in the dataset. For example, missing values in columns like LifeExpectancy, HealthExpenditure, and Corruption were replaced with NULL to ensure data integrity.

* The output shows a snapshot of the data, highlighting the diversity of countries, regions, and income groups. For instance:

* Afghanistan (Low income) has a life expectancy of 56.3 years and a high undernourishment rate of 47.8%.

* Albania (Upper middle income) has a higher life expectancy of 74.3 years and lower undernourishment (4.9%), reflecting better socioeconomic conditions.

* Andorra (High income) has missing data for life expectancy and undernourishment but shows relatively high health expenditure (5.87%).

# **2. Backup Table Creation and Updates**

**Insight**

* A backup of the economic_info table was created as economic_info_backup to preserve the original data.

* The IncomeGroup column in the backup table was updated based on conditions involving AvgLifeExpectancy and TotalCO2 from the CountryStats table. This demonstrates the use of conditional logic (CASE statement) to dynamically categorize countries into income groups based on their life expectancy and CO2 emissions.

**For example:**

* Countries with an average life expectancy below 50 years and total CO2 emissions below 1000 were categorized as Low Income.

* Countries with an average life expectancy between 50 and 60 years and total CO2 emissions below 2000 were categorized as Lower Middle Income.

* This approach ensures that the income group classification is aligned with the latest socioeconomic indicators.

# **3. Identifying Countries with Above-Average Life Expectancy**

**Key Skills Demonstrated:**

* Use of CTEs for modular and efficient query design.
* Data aggregation and filtering to extract meaningful insights.
* Joins and conditional logic to compare data across tables.

**OUtput**
| countryname | avg_life | year |
|---|---|---|
| Lesotho | 47.11 | 2018 |
| Lesotho | 47.11 | 2016 |
| Lesotho | 47.11 | 2012 |
| Lesotho | 47.11 | 2014 |
| Lesotho | 47.11 | 2015 |
| Lesotho | 47.11 | 2013 |
| Lesotho | 47.11 | 2017 |
| Lesotho | 47.11 | 2019 |
| Central African Republic | 47.86 | 2012 |
| Central African Republic | 47.86 | 2017 |
| Central African Republic | 47.86 | 2014 |
| Central African Republic | 47.86 | 2019 |
| Central African Republic | 47.86 | 2015 |
| Central African Republic | 47.86 | 2016 |
| Central African Republic | 47.86 | 2011 |
| Central African Republic | 47.86 | 2013 |
| Central African Republic | 47.86 | 2018 |
| Sierra Leone | 48.64 | 2011 |
| Sierra Leone | 48.64 | 2012 |
| Sierra Leone | 48.64 | 2017 |
| Sierra Leone | 48.64 | 2014 |
| Sierra Leone | 48.64 | 2016 |
| Sierra Leone | 48.64 | 2015 |
| Sierra Leone | 48.64 | 2013 |
| Sierra Leone | 48.64 | 2010 |
| Sierra Leone | 48.64 | 2019 |
| Sierra Leone | 48.64 | 2018 |
| Eswatini | 49.18 | 2014 |
| Eswatini | 49.18 | 2012 |
| Eswatini | 49.18 | 2016 |

* The table shows shows countries with above-average life expectancy for their respective income groups in specific years. Here’s a sample of the output.

# **Insight**

**Objective**: The query identifies countries where the life expectancy in a specific year is above the average life expectancy for that country across all years. This helps in understanding which countries performed better than their historical average in terms of life expectancy.

**Key Findings:**

* Lesotho: The average life expectancy for Lesotho is 47.11 years, and the output shows multiple years where the life expectancy exceeded this average. This indicates that Lesotho has made some progress in improving life expectancy, though it remains low compared to global standards.

* Central African Republic: With an average life expectancy of 47.86 years, the country also shows several years where life expectancy was above this average. This suggests some improvement in health outcomes, though challenges remain.

* Sierra Leone: The average life expectancy is 48.64 years, and the output shows consistent years where life expectancy exceeded this average. This reflects gradual improvements in healthcare and living conditions.

* Eswatini: With an average life expectancy of 49.18 years, Eswatini also shows years where life expectancy was above average, indicating positive trends in health and socioeconomic conditions.

**Trends:**

* The countries listed in the output are primarily from Sub-Saharan Africa, a region historically challenged by low life expectancy due to factors such as poverty, disease, and limited access to healthcare.

* Despite these challenges, the results show that these countries have had years where life expectancy improved, suggesting that targeted interventions (e.g., healthcare investments, disease prevention programs) may have had a positive impact.

**Limitations:**

* The analysis is based on historical averages, so it doesn’t account for external factors (e.g., epidemics, economic crises) that may have influenced life expectancy in specific years.

* The results highlight countries with low life expectancy, so further analysis is needed to understand the drivers of improvement and how these trends compare to global benchmarks.

# **4. Ranking Countries by Health Expenditure**

**Key Skills Demonstrated:**

* Use of CTEs for modular and efficient query design.
* Advanced ranking with window functions (RANK() and PARTITION BY).
* Data aggregation and sorting to extract meaningful insights.

**Output**
| countryname | region | avg_health_expenditure | rnk |
|---|---|---|---|
|  |  |  | 1 |
| Marshall Islands | East Asia & Pacific | 16.70305789 | 1 |
| Tuvalu | East Asia & Pacific | 15.53382632 | 2 |
| Nauru | East Asia & Pacific | 12.13936842 | 3 |
| Kiribati | East Asia & Pacific | 10.79040000 | 4 |
| Palau | East Asia & Pacific | 10.69863158 | 5 |
| Japan | East Asia & Pacific | 9.20888947 | 6 |
| New Zealand | East Asia & Pacific | 8.90035789 | 7 |
| Australia | East Asia & Pacific | 8.56964211 | 8 |
| Cambodia | East Asia & Pacific | 6.68654737 | 9 |
| Solomon Islands | East Asia & Pacific | 6.30735263 | 10 |
| Samoa | East Asia & Pacific | 5.24047895 | 11 |
| Tonga | East Asia & Pacific | 4.69134211 | 12 |
| China | East Asia & Pacific | 4.50154211 | 13 |
| Vietnam | East Asia & Pacific | 4.44452632 | 14 |
| Mongolia | East Asia & Pacific | 4.00740526 | 15 |
| Philippines | East Asia & Pacific | 3.74024737 | 16 |
| Singapore | East Asia & Pacific | 3.52774211 | 17 |
| Vanuatu | East Asia & Pacific | 3.48903684 | 18 |
| Thailand | East Asia & Pacific | 3.46133684 | 19 |
| Malaysia | East Asia & Pacific | 3.27918947 | 20 |
| Fiji | East Asia & Pacific | 3.27800000 | 21 |
| Myanmar | East Asia & Pacific | 3.12832105 | 22 |
| Indonesia | East Asia & Pacific | 2.67184737 | 23 |
| Papua New Guinea | East Asia & Pacific | 2.42980000 | 24 |
| American Samoa | East Asia & Pacific |  | 25 |
| Guam | East Asia & Pacific |  | 25 |
| Northern Mariana Islands | East Asia & Pacific |  | 25 |
| France | Europe & Central Asia | 10.83386842 | 1 |
| Germany | Europe & Central Asia | 10.75399474 | 2 |
| Switzerland | Europe & Central Asia | 10.30450000 | 3 |
| Austria | Europe & Central Asia | 9.97465263 | 4 |
| Belgium | Europe & Central Asia | 9.91111579 | 5 |
| Netherlands | Europe & Central Asia | 9.70224737 | 6 |
| Denmark | Europe & Central Asia | 9.70204737 | 7 |
| Sweden | Europe & Central Asia | 9.43733684 | 8 |
| Portugal | Europe & Central Asia | 9.42996316 | 9 |
| United Kingdom | Europe & Central Asia | 9.26078421 | 10 |
| Norway | Europe & Central Asia | 9.09031579 | 11 |
| Bosnia and Herzegovina | Europe & Central Asia | 8.95115789 | 12 |
| Moldova | Europe & Central Asia | 8.79665263 | 13 |
| Finland | Europe & Central Asia | 8.78487368 | 14 |
| Serbia | Europe & Central Asia | 8.70704737 | 15 |
| Iceland | Europe & Central Asia | 8.57859474 | 16 |
| Italy | Europe & Central Asia | 8.51157895 | 17 |
| Spain | Europe & Central Asia | 8.44842105 | 18 |
| Greece | Europe & Central Asia | 8.44731053 | 19 |
| Montenegro | Europe & Central Asia | 8.33840000 | 20 |
| Armenia | Europe & Central Asia | 8.30568421 | 21 |
| Ireland | Europe & Central Asia | 8.25787895 | 22 |
| Slovenia | Europe & Central Asia | 8.24580000 | 23 |
| Georgia | Europe & Central Asia | 7.86469474 | 24 |
| Hungary | Europe & Central Asia | 7.23034737 | 25 |
| North Macedonia | Europe & Central Asia | 7.13312105 | 26 |
| Croatia | Europe & Central Asia | 7.08586316 | 27 |
| Bulgaria | Europe & Central Asia | 7.05770526 | 28 |
| Ukraine | Europe & Central Asia | 6.71404211 | 29 |
| Turkmenistan | Europe & Central Asia | 6.66234737 | 30 |
| Lithuania | Europe & Central Asia | 6.30594737 | 31 |
| San Marino | Europe & Central Asia | 6.27641053 | 32 |
| Poland | Europe & Central Asia | 6.20763158 | 33 |
| Cyprus | Europe & Central Asia | 6.20564211 | 34 |
| Luxembourg | Europe & Central Asia | 6.18720526 | 35 |
| Andorra | Europe & Central Asia | 6.02969474 | 36 |
| Tajikistan | Europe & Central Asia | 5.91194737 | 37 |
| Latvia | Europe & Central Asia | 5.81412105 | 38 |
| Estonia | Europe & Central Asia | 5.74512105 | 39 |
| Albania | Europe & Central Asia | 5.65728333 | 40 |
| Belarus | Europe & Central Asia | 5.62332632 | 41 |
| Uzbekistan | Europe & Central Asia | 5.19576842 | 42 |
| Romania | Europe & Central Asia | 5.13422105 | 43 |
| Kazakhstan | Europe & Central Asia | 3.18306316 | 44 |
| Azerbaijan | Europe & Central Asia | 2.92361053 | 45 |
| Monaco | Europe & Central Asia | 1.96268947 | 46 |
| Greenland | Europe & Central Asia |  | 47 |
| Cuba | Latin America & Caribbean | 10.14603158 | 1 |
| Argentina | Latin America & Caribbean | 8.82137368 | 2 |
| Brazil | Latin America & Caribbean | 8.46850526 | 3 |
| Uruguay | Latin America & Caribbean | 8.45995263 | 4 |
| El Salvador | Latin America & Caribbean | 7.93132105 | 5 |
| Honduras | Latin America & Caribbean | 7.69480000 | 6 |
| Chile | Latin America & Caribbean | 7.45270000 | 7 |
| Costa Rica | Latin America & Caribbean | 7.29868947 |

# **Insight**

**Objective:**

* The query ranks countries within each region based on their average health expenditure (as a percentage of GDP). This helps identify which countries invest the most in healthcare relative to their GDP and how they compare within their respective regions.

**Key Findings:**

* **East Asia & Pacific:**
Marshall Islands and Tuvalu top the list with average health expenditures of 16.70% and 15.53%, respectively. These small island nations likely face unique healthcare challenges, necessitating higher spending. Developed countries like Japan (9.21%) and Australia (8.57%) also rank high, reflecting their strong healthcare systems.

* **Europe & Central Asia:**
France leads the region with an average health expenditure of 10.83%, followed closely by Germany (10.75%) and Switzerland (10.30%). These countries are known for their robust healthcare systems and high public spending on health.
Eastern European countries like Moldova (8.80%) and Serbia (8.71%) also rank relatively high, indicating significant investments in healthcare.

* **Latin America & Caribbean:**
Cuba tops the region with an average health expenditure of 10.15%, reflecting its well-known public healthcare system. Argentina (8.82%) and Brazil (8.47%) follow, showing substantial investments in healthcare despite economic challenges.

# **Trends**

* **High-Income Countries:** Generally, high-income countries (e.g., France, Germany, Japan) rank high in health expenditure, reflecting their ability to invest more in healthcare infrastructure and services.

* **Small Island Nations:** Countries like Marshall Islands and Tuvalu, despite being small and resource-constrained, allocate a significant portion of their GDP to healthcare, likely due to unique challenges such as geographic isolation and vulnerability to climate change.

* **Regional Disparities:** There are notable disparities within regions. For example, in East Asia & Pacific, while some countries like Japan and Australia spend heavily on healthcare, others like Indonesia (2.67%) and Papua New Guinea (2.43%) lag behind.

# **Limitations:**

* The analysis is based on average health expenditure and does not account for the efficiency or effectiveness of healthcare spending.

* Countries with missing data (e.g., American Samoa, Greenland) are excluded from the rankings, which may skew the results for certain regions.

# **5. Percentage change in CO2 emissions for each country between two specified years.**

**Key Skills Demonstrated:**

* Use of CTE's

| countryname | Year_Current | CO2_Current | Year_Previous | CO2_Previous | % Change in CO2 Emissions |
|---|---|---|---|---|---|
| Afghanistan | 2010 | 7110.0001 | 2009 | 4880.0001 | 45.69672038 |
| Angola | 2010 | 22799.9992 | 2009 | 21149.9996 | 7.80141670 |
| Albania | 2010 | 4449.9998 | 2009 | 4219.9998 | 5.45023723 |
| Andorra | 2010 | 520.0000 | 2009 | 520.0000 | 0.00000000 |
| United Arab Emirates | 2010 | 162789.9933 | 2009 | 157020.0043 | 3.67468402 |
| Argentina | 2010 | 167220.0012 | 2009 | 156570.0073 | 6.80206515 |
| Armenia | 2010 | 4340.0002 | 2009 | 4510.0002 | -3.76940116 |
| American Samoa | 2010 |  | 2009 |  |  |
| Antigua and Barbuda | 2010 | 490.0000 | 2009 | 1390.0000 | -64.74820144 |
| Australia | 2010 | 387540.0085 | 2009 | 395290.0085 | -1.96058586 |

# **Insight**

**Significant Changes:**

* **Antigua and Barbuda:** Experienced a dramatic decrease of 64.75% in CO2 emissions. This could be due to a variety of factors, including shifts in energy sources, economic changes, or policy implementations.

* **Afghanistan:** Saw a substantial increase of 45.70% in CO2 emissions. This might indicate economic growth, increased industrial activity, or changes in energy consumption patterns.

**Moderate Changes:**

* **Most other countries:** Showed relatively smaller changes in CO2 emissions, ranging from -3.77% (Armenia) to 7.80% (Angola). These fluctuations could be due to a combination of economic factors, population growth, and energy policies.

**No Data/No Change:**

* **American Samoa:** No data is available for CO2 emissions in either year, making it impossible to assess changes.

* **Andorra:** Had no change in CO2 emissions, suggesting a stable situation in terms of energy use and emissions.

# **General Observations:**

* Variability: The data highlights the significant variability in CO2 emission changes across different countries. This underscores the diverse factors influencing emissions, including economic development, energy sources, and environmental policies.

* Limited Scope: The data only covers a single year-over-year change. To understand broader trends, it would be necessary to analyze data over a longer period.

# **6. Running average of LifeExpectancy over the years for each country using a window function.**

**Key Skills Demonstrated:**

* Window Function Expertise: Masterfully applied window functions to calculate running averages, showcasing advanced SQL skills beyond basic aggregation.
* Precise Data Handling: Utilized partitioning and ordering within the window function to accurately track life expectancy trends over time on a per-country basis.
* Effective Trend Analysis: Enabled the analysis of life expectancy trends by calculating running averages, providing a clearer view of long-term patterns compared to raw yearly data.

**output**
| CountryName | Year | LifeExpectancy | RunningAvgLifeExpectancy |
|---|---|---|---|
| Angola | 2001 | 47.059 | 47.06 |
| Antigua and Barbuda | 2001 | 74.171 | 74.17 |
| Argentina | 2001 | 73.755 | 73.75 |
| Armenia | 2001 | 71.8 | 71.8 |
| Australia | 2001 | 79.6341 | 79.63 |
| Austria | 2001 | 78.5756 | 78.58 |
| Azerbaijan | 2001 | 67.054 | 67.05 |
| Bahrain | 2001 | 74.635 | 74.64 |
| Bangladesh | 2001 | 65.956 | 65.96 |
| Barbados | 2001 | 77.362 | 77.36 |
| Belarus | 2001 | 68.5073 | 68.51 |
| Belgium | 2001 | 77.9732 | 77.97 |
| Belize | 2001 | 69.04 | 69.04 |
| Benin | 2001 | 55.668 | 55.67 |
| Bermuda | 2001 | 77.8854 | 77.89 |
| Bhutan | 2001 | 61.808 | 61.81 |
| Bolivia | 2001 | 63.054 | 63.05 |
| Bosnia and Herzegovina | 2001 | 74.637 | 74.64 |
| Botswana | 2001 | 50.281 | 50.28 |
| Brazil | 2001 | 70.462 | 70.46 |
| Bulgaria | 2001 | 71.7683 | 71.77 |
| Burkina Faso | 2001 | 50.893 | 50.89 |
| Burundi | 2001 | 49.93 | 49.93 |
| Cambodia | 2001 | 59.335 | 59.33 |
| Cameroon | 2001 | 51.222 | 51.22 |
| Canada | 2001 | 79.339 | 79.34 |
| Central African Republic | 2001 | 44.061 | 44.06 |
| Chad | 2001 | 47.789 | 47.79 |
| Chile | 2001 | 76.634 | 76.63 |
| China | 2001 | 71.732 | 71.73 |
| Colombia | 2001 | 73.241 | 73.24 |
| Comoros | 2001 | 59.529 | 59.53 |
| Costa Rica | 2001 | 77.601 | 77.6 |
| Cote d'Ivoire | 2001 | 49.495 | 49.49 |
| Croatia | 2001 | 74.5129 | 74.51 |
| Cuba | 2001 | 76.905 | 76.9 |
| Cyprus | 2001 | 78.139 | 78.14 |
| Denmark | 2001 | 76.7927 | 76.79 |
| Djibouti | 2001 | 57.1 | 57.1 |
| Dominica | 2001 |  |  |
| Dominican Republic | 2001 | 69.69 | 69.69 |
| Ecuador | 2001 | 73.078 | 73.08 |
| El Salvador | 2001 | 69.162 | 69.16 |
| Equatorial Guinea | 2001 | 53.581 | 53.58 |
| Eritrea | 2001 | 55.864 | 55.86 |
| Estonia | 2001 | 70.2585 | 70.26 |
| Eswatini | 2001 | 45.799 | 45.8 |
| Ethiopia | 2001 | 52.595 | 52.6 |
| Fiji | 2001 | 65.863 | 65.86 |
| Finland | 2001 | 77.9659 | 77.97 |
| France | 2001 | 79.1585 | 79.16 |
| Gabon | 2001 | 57.968 | 57.97 |
| Georgia | 2001 | 70.065 | 70.07 |
| Germany | 2001 | 78.3293 | 78.33 |
| Ghana | 2001 | 57.158 | 57.16 |
| Greece | 2001 | 78.3878 | 78.39 |
| Greenland | 2001 | 66.7093 | 66.71 |
| Grenada | 2001 | 72.805 | 72.81 |
| Guam | 2001 | 75.373 | 75.37 |
| Guatemala | 2001 | 68.304 | 68.3 |
| Guinea | 2001 | 51.255 | 51.26 |
| Guinea-Bissau | 2001 | 50.744 | 50.74 |
| Guyana | 2001 | 65.532 | 65.53 |
| Haiti | 2001 | 57.382 | 57.38 |
| Honduras | 2001 | 70.976 | 70.98 |
| Hungary | 2001 | 72.2488 | 72.25 |
| Iceland | 2001 | 80.6902 | 80.69 |
| India | 2001 | 62.907 | 62.91 |
| Indonesia | 2001 | 66.037 | 66.04 |
| Iraq | 2001 | 68.983 | 68.98 |
| Ireland | 2001 | 77.1341 | 77.13 |
| Israel | 2001 | 79.4073 | 79.41 |
| Italy | 2001 | 80.1268 | 80.13 |
| Jamaica | 2001 | 74.139 | 74.14 |
| Japan | 2001 | 81.4171 | 81.42 |
| Jordan | 2001 | 71.907 | 71.91 |
| Kazakhstan | 2001 | 65.76 | 65.76 |
| Kenya | 2001 | 51.101 | 51.1 |
| Kiribati | 2001 | 63.446 | 63.45 |
| Kuwait | 2001 | 73.21 | 73.21 |

# **Insight**

* **Overall Trend:**  The RunningAvgLifeExpectancy column likely shows how life expectancy is generally increasing over time for many countries. This is because a running average smooths out year-to-year fluctuations, revealing the underlying long-term trend.

* **Country-Specific Trends:** By looking at how the RunningAvgLifeExpectancy changes for each country, we can see which countries have experienced significant improvements in life expectancy and identify any periods of stagnation or decline.

* **Comparison Between Countries:**  Comparing the RunningAvgLifeExpectancy across different countries allows us to see which countries have higher or lower life expectancies and how these differences have evolved over time.

# **7. Ranking Countries within its Region based on CO2 emissions using the RANK() window function**.

**Key Skills Demonstrated:**

* Data Aggregation and Ranking: Combined aggregate functions (AVG()) with window functions (RANK()) to rank countries by average CO2 emissions within their respective regions.
* Regional Analysis: Used PARTITION BY to perform analysis within geographic regions, enabling comparisons and ranking of countries within specific contexts.
* Insightful Ranking: Generated a ranking of countries by CO2 emissions, providing valuable information for understanding regional and global emission patterns.

**Output**
| countryname | region | Avg CO2 Emissions | Ranking of Emissions |
|---|---|---|---|
|  |  |  | 1 |
| China | East Asia & Pacific | 7862437.86 | 1 |
| Japan | East Asia & Pacific | 1183793.67 | 2 |
| Indonesia | East Asia & Pacific | 427685.79 | 3 |
| Australia | East Asia & Pacific | 377437.37 | 4 |
| Thailand | East Asia & Pacific | 232332.63 | 5 |
| Malaysia | East Asia & Pacific | 197462.11 | 6 |
| Vietnam | East Asia & Pacific | 154021.58 | 7 |
| Philippines | East Asia & Pacific | 92639.47 | 8 |
| Singapore | East Asia & Pacific | 42386.32 | 9 |
| New Zealand | East Asia & Pacific | 32452.11 | 10 |
| Myanmar | East Asia & Pacific | 15065.26 | 11 |
| Mongolia | East Asia & Pacific | 14942.11 | 12 |
| Cambodia | East Asia & Pacific | 6264.21 | 13 |
| Papua New Guinea | East Asia & Pacific | 5457.89 | 14 |
| Fiji | East Asia & Pacific | 1254.74 | 15 |
| Solomon Islands | East Asia & Pacific | 330.00 | 16 |
| Palau | East Asia & Pacific | 228.95 | 17 |
| Samoa | East Asia & Pacific | 215.26 | 18 |
| Marshall Islands | East Asia & Pacific | 144.21 | 19 |
| Tonga | East Asia & Pacific | 129.47 | 20 |
| Vanuatu | East Asia & Pacific | 124.74 | 21 |
| Kiribati | East Asia & Pacific | 61.05 | 22 |
| Nauru | East Asia & Pacific | 56.32 | 23 |
| Tuvalu | East Asia & Pacific | 10.00 | 24 |
| Guam | East Asia & Pacific |  | 25 |
| American Samoa | East Asia & Pacific |  | 25 |
| Northern Mariana Islands | East Asia & Pacific |  | 25 |
| Germany | Europe & Central Asia | 770663.69 | 1 |
| United Kingdom | Europe & Central Asia | 467431.05 | 2 |
| Italy | Europe & Central Asia | 397458.42 | 3 |
| France | Europe & Central Asia | 343980.52 | 4 |
| Poland | Europe & Central Asia | 301864.74 | 5 |
| Spain | Europe & Central Asia | 288681.58 | 6 |
| Ukraine | Europe & Central Asia | 261663.69 | 7 |
| Kazakhstan | Europe & Central Asia | 199282.63 | 8 |
| Netherlands | Europe & Central Asia | 161187.37 | 9 |
| Uzbekistan | Europe & Central Asia | 118143.68 | 10 |
| Belgium | Europe & Central Asia | 102268.42 | 11 |
| Greece | Europe & Central Asia | 85068.95 | 12 |
| Romania | Europe & Central Asia | 84458.42 | 13 |
| Austria | Europe & Central Asia | 68211.58 | 14 |
| Turkmenistan | Europe & Central Asia | 60523.68 | 15 |
| Belarus | Europe & Central Asia | 57167.37 | 16 |
| Finland | Europe & Central Asia | 54872.63 | 17 |
| Portugal | Europe & Central Asia | 54478.42 | 18 |
| Hungary | Europe & Central Asia | 49418.95 | 19 |
| Serbia | Europe & Central Asia | 48153.68 | 20 |
| Bulgaria | Europe & Central Asia | 45192.63 | 21 |
| Sweden | Europe & Central Asia | 44859.47 | 22 |
| Denmark | Europe & Central Asia | 44792.11 | 23 |
| Switzerland | Europe & Central Asia | 42468.42 | 24 |
| Ireland | Europe & Central Asia | 40865.79 | 25 |
| Norway | Europe & Central Asia | 37727.37 | 26 |
| Azerbaijan | Europe & Central Asia | 29613.68 | 27 |
| Bosnia and Herzegovina | Europe & Central Asia | 19438.42 | 28 |
| Croatia | Europe & Central Asia | 19113.68 | 29 |
| Estonia | Europe & Central Asia | 16631.05 | 30 |
| Slovenia | Europe & Central Asia | 15076.84 | 31 |
| Lithuania | Europe & Central Asia | 11829.47 | 32 |
| Luxembourg | Europe & Central Asia | 10276.32 | 33 |
| North Macedonia | Europe & Central Asia | 8574.74 | 34 |
| Moldova | Europe & Central Asia | 7954.21 | 35 |
| Latvia | Europe & Central Asia | 7657.89 | 36 |
| Cyprus | Europe & Central Asia | 7496.84 | 37 |
| Georgia | Europe & Central Asia | 6402.11 | 38 |
| Armenia | Europe & Central Asia | 4840.53 | 39 |
| Albania | Europe & Central Asia | 4362.63 | 40 |
| Tajikistan | Europe & Central Asia | 3958.42 | 41 |
| Montenegro | Europe & Central Asia | 2205.79 | 42 |
| Iceland | Europe & Central Asia | 2038.42 | 43 |
| Andorra | Europe & Central Asia | 511.05 | 44 |
| Monaco | Europe & Central Asia |  | 45 |
| San Marino | Europe & Central Asia |  | 45 |
| Greenland | Europe & Central Asia |  | 45 |
| Mexico | Latin America & Caribbean | 448063.68 | 1 |
| Brazil | Latin America & Caribbean | 397163.15 | 2 |
| Argentina | Latin America & Caribbean | 161945.79 | 3 |
| Chile | Latin America & Caribbean | 70095.26 | 4 |
| Colombia | Latin America & Caribbean | 67377.89 | 5 |
| Peru | Latin America & Caribbean | 42608.42 | 6 |
| Ecuador | Latin America & Caribbean | 34036.32 | 7 |
| Cuba | Latin America & Caribbean | 27083.16 | 8 |
| Dominican Republic | Latin America & Caribbean | 21372.63 | 9 |
| Trinidad and Tobago | Latin America & Caribbean | 18705.79 | 10 |
| Bolivia | Latin America & Caribbean | 15517.37 | 11 |
| Guatemala | Latin America & Caribbean | 13180.53 | 12 |
| Jamaica | Latin America & Caribbean | 8898.42 | 13 |
| Panama | Latin America & Caribbean | 8763.68 | 14 |
| Honduras | Latin America & Caribbean | 8437.37 | 15 |
| Costa Rica | Latin America & Caribbean | 7153.68 | 16 |

* Regional Disparities:  It's clear that CO2 emissions vary significantly across regions.  For example, 'East Asia & Pacific' has some of the highest emitters like China, while 'Sub-Saharan Africa' has many countries with much lower emissions. This highlights the unequal distribution of emissions globally.

* Regional Leaders:  Within each region, you can identify the top emitters. This allows for targeted analysis of major polluters within specific geographic contexts. For example, Germany leads in 'Europe & Central Asia', while the United States is the top emitter in 'North America'.

* Data Gaps: The presence of NULL values for some countries indicates missing data, which could impact the accuracy of regional comparisons and rankings. It's important to acknowledge these limitations.

# **8. Conditional Logic using case statements to categorize countries into different groups based on their LifeExpectancy**

**Key Skills Demonstrated**

* Data Categorization: Effectively used CASE statements to categorize countries based on life expectancy ranges, demonstrating the ability to transform continuous data into meaningful groups.
* Logical Condition Handling: Applied logical conditions within CASE statements to assign countries to different categories, showcasing conditional logic handling in SQL.
* Data Interpretation: Facilitated the interpretation of life expectancy data by creating clear categories, making it easier to understand and analyze global health patterns.

**Output**
| countryname | Life Expectancy Category |
|---|---|
| Afghanistan | Low |
| Angola | High |
| Albania | High |
| Andorra | High |
| United Arab Emirates | High |
| Argentina | High |
| Armenia | High |
| American Samoa | High |
| Antigua and Barbuda | High |
| Australia | High |

# **Insight**

* General Health and Development: The categorization provides a quick and easy way to understand the general health and development status of countries. Countries in the 'High' category likely have better healthcare systems, nutrition, and overall living conditions compared to those in the 'Low' category.

* Potential Outliers:  It's interesting to note that some countries like Angola and Antigua and Barbuda are categorized as 'High' despite potentially facing economic or development challenges. This could indicate areas for further investigation to understand the factors contributing to their higher life expectancy.

---
## Conclusion

This project highlights the importance of socioeconomic factors in determining life expectancy. The analysis reveals that investments in health and education, along with improved sanitation and reduced undernourishment, are critical for increasing life expectancy. Future work could explore causal relationships and the impact of specific policies on life expectancy.

## Tools and Technologies

- **Python Libraries:** Pandas, NumPy, Seaborn, Matplotlib, Scikit-learn, Statsmodels
- **SQL:** MySQL
- **Data Visualization:** Matplotlib, Seaborn
 
---

## How to Run the Code

**1. Clone the repository:**
   ```bash
   git clone https://github.com/ssmujtaba/socioeconomic_determinants

**2. Install the required Python libraries:**
pip install -r requirements.txt

**3. Run the Jupyter Notebook for Python analysis:**
jupyter notebook analysis.ipynb

4. Execute the SQL scripts in your MySQL environment.

5. Python and SQL code files have also been uploaded for you to download them.
