# Socioeconomic Determinants of Life Expectancy: A Data Analysis Project

## Project Overview

This project explores the relationship between various socioeconomic factors and life expectancy using SQL and Python. The goal is to identify key determinants of life expectancy across different countries and regions.

## Data Source

The data used in this project is from the World Bank and other international organizations, compiled into a CSV file named `final_life_expectancy_dataset.csv`.  It includes information on life expectancy, prevalence of undernourishment, CO2 emissions, health expenditure, education expenditure, unemployment, sanitation, injuries, communicable diseases, non-communicable diseases, and income group for various countries over several years.

## Data Analysis

The analysis was conducted using both SQL (MySQL) and Python.  The following steps were taken:

### 1. Data Cleaning and Preprocessing (Python)

```
#**Missing Values**

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

