# 🧠 Customer Satisfaction Analysis – R Project

> 📊 A complete data analysis pipeline to explore and model customer satisfaction based on hotel service quality.

## 📁 Project Overview

This project analyzes customer satisfaction based on multiple service quality factors using a real-world-like dataset. It includes:

- Data Cleaning & Preprocessing
- Exploratory Data Analysis (EDA)
- Data Visualization
- Logistic Regression & Random Forest Modeling
- ROC Curve & AUC Evaluation
- Feature Importance Insights
- Business Recommendations

---

## 📌 Problem Statement

**Objective:**  
Analyze the relationship between **service quality variables** (like cleanliness, WiFi, booking experience, etc.) and **customer satisfaction**.  

**Goal:**  
Build predictive models to understand which service areas influence satisfaction and provide actionable insights for improvement.

---

## 🛠️ Tools & Technologies

- **R**: Core language for scripting
- **Libraries**: `tidyverse`, `ggplot2`, `caret`, `randomForest`, `pROC`, `ggcorrplot`
- **Modeling**: Logistic Regression, Random Forest
- **Evaluation**: Confusion Matrix, ROC Curve, AUC
- **Visualization**: Histograms, Boxplots, Correlation Heatmap, Pie Chart

---

## 📊 Key Insights

- The majority of users fall into the "neutral or dissatisfied" category (~56%), indicating room for service improvement.
- **Top factors influencing satisfaction**:
  - `Hotel.wifi.service`
  - `Type.Of.Booking`
  - `Type.of.Travel`
- Random Forest model achieved **94.83% accuracy** with a Kappa Score of **0.8944**.
- Logistic Regression AUC score was **0.9007**, showing strong classification capability.
- Business teams should focus on improving **WiFi, booking process, and comfort services** to boost customer satisfaction.

---

## 🔍 Project Structure

```bash
├── Report.docx                 # Final written report
├── sample_data_set.csv         # Dataset used
├── customer_satisfaction.R     # Full R script
├── plots/                      # Folder for exported plots
│   ├── histogram_cleanliness.png
│   ├── boxplot_cleanliness.png
│   ├── roc_curve.png
│   └── correlation_heatmap.png
├── README.md                   # This file
