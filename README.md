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

So, there were multiple columns in my dataset that had missing values. Corruption had a staggering of approximately 71% missing data. This column was dropped completely. Other columns include Life Expectancy World Bank, Prevelance of Undernourishment, CO2, Health Expenditure %, Education Expenditure %, Unemployment, and Sanitation were all imputed using mean/median imputation as well as the KNN Imputation technique.

Life Expectancy World Bank, CO2, Health Expenditure %, Unemployment were imputed using the mean/median imputation approach. Since the missingness is relatively small, these simple techniques are less likely to significantly distort the overall distribution. Choose mean if the data is normally distributed, otherwise, use the median.

Prevelance of Undernourishment, Sanitation and Education Expenditure % were imputed using KNN Imputation. These techniques can better estimate missing values while capturing relationships with other variables. KNN can capture complex patterns, while Regression assumes a linear relationship with other predictors.

So, the newly created df was then saved to a separate csv file and the original is intact in its raw form. It is always wise to keep the raw
dataset intact in it's original form. If one makes any mistakes in the new dataset, you can always refer back to the original.

# 2. Exploratory Data Analysis (EDA) & Data Visualization


