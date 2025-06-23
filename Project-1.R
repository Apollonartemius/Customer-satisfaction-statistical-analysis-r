# Load libraries
library(tidyverse)
library(ggplot2)
library(GGally)
library(ggcorrplot)
library(caret)
library(randomForest)
library(e1071)

# Load data
data <- read.csv("D:/sample data set.csv", stringsAsFactors = FALSE)

# Inspect data
str(data)
summary(data)
head(data)
tail(data)

# Check missing values
colSums(is.na(data))

# Check duplicated rows
sum(duplicated(data))

# Drop ID column
data <- data[ , !(names(data) %in% c("id"))]

# Convert target variable to factor
data$satisfaction <- as.factor(data$satisfaction)

# Convert relevant columns to factors
factor_cols <- c("Gender", "Customer.Type", "Type.of.Travel", "Class")
data[factor_cols] <- lapply(data[factor_cols], as.factor)

# Summary of cleaned data
summary(data)

# EDA ----------------------------------------

# Numeric and Categorical columns
num_cols <- sapply(data, is.numeric)
cat_cols <- sapply(data, is.factor)

# Frequency plot for categorical columns
for (col in names(data[cat_cols])) {
  p <- ggplot(data, aes_string(x = col, fill = col)) +
    geom_bar() +
    theme_minimal() +
    labs(title = paste("Frequency of", col), x = col, y = "Count") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1),
          plot.title = element_text(face = "bold"))
  
  print(p)
}

# Histogram for each numeric column
for (col in names(data[num_cols])) {
  p <- ggplot(data, aes_string(x = col)) +
    geom_histogram(binwidth = 0.5, fill = "#69b3a2", color = "white", alpha = 0.8) +
    labs(title = paste("Histogram & Frequency of", col), x = col, y = "Count") +
    theme_minimal() +
    theme(plot.title = element_text(face = "bold"))
  
  print(p)
}

# Boxplot for each numeric column
for (col in names(data[num_cols])) {
  p <- ggplot(data, aes_string(y = col)) +
    geom_boxplot(fill = "#FF6F61", color = "black") +
    labs(title = paste("Boxplot of", col), y = col) +
    theme_minimal() +
    theme(plot.title = element_text(face = "bold"))
  
  print(p)
}

# Correlation matrix heatmap
cor_matrix <- cor(data[num_cols])
ggcorrplot(cor_matrix,
           hc.order = TRUE,
           type = "lower",
           lab = TRUE,
           title = "Correlation Heatmap",
           lab_size = 2.5,
           colors = c("red", "white", "blue"))

# Satisfaction pie chart
satisfaction_freq <- as.data.frame(table(data$satisfaction))

colnames(satisfaction_freq) <- c("Satisfaction", "Count")

ggplot(satisfaction_freq, aes(x = "", y = Count, fill = Satisfaction)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y") +
  theme_void() +
  labs(title = "Customer Satisfaction Distribution") +
  scale_fill_brewer(palette = "Set2")


#-----------------------------------------
# Modeling Section
#-----------------------------------------

# Prepare data
set.seed(123)
splitIndex <- createDataPartition(data$satisfaction, p = 0.7, list = FALSE)
train_data <- data[splitIndex, ]
test_data <- data[-splitIndex, ]

# Logistic Regression ----------------------------------------
log_model <- glm(satisfaction ~ ., data = train_data, family = "binomial")
summary(log_model)

log_pred <- predict(log_model, newdata = test_data, type = "response")
log_class <- ifelse(log_pred > 0.5, "satisfied", "neutral or dissatisfied")
log_class <- as.factor(log_class)
confusionMatrix(log_class, test_data$satisfaction)

# ROC Curve for Logistic Regression
library(pROC)
log_roc <- roc(test_data$satisfaction, as.numeric(log_pred))
plot(log_roc, col = "blue", main = "ROC Curve - Logistic Regression")
auc(log_roc)


# Random Forest ----------------------------------------
rf_model <- randomForest(satisfaction ~ ., data = train_data, importance = TRUE, ntree = 100)
print(rf_model)
rf_pred <- predict(rf_model, newdata = test_data)
confusionMatrix(rf_pred, test_data$satisfaction)
varImpPlot(rf_model)

