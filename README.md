# Socioeconomic Determinants of Life Expectancy: A Data Analysis Project

## Project Overview

This project explores the relationship between various socioeconomic factors and life expectancy using SQL and Python. The goal is to identify key determinants of life expectancy across different countries and regions.

## Data Source

The data used in this project is from the World Bank and other international organizations, compiled into a CSV file named `final_life_expectancy_dataset.csv`.  It includes information on life expectancy, prevalence of undernourishment, CO2 emissions, health expenditure, education expenditure, unemployment, sanitation, injuries, communicable diseases, non-communicable diseases, and income group for various countries over several years.

## Data Analysis

The analysis was conducted using both SQL (MySQL) and Python.  The following steps were taken:

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

