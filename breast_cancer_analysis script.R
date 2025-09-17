library(tidyverse)
library(readxl)
library(corrplot)

# Test pipe operator
data <- read_excel("data.xlsx")
data <- data %>% select(-id)
head(data)
#to see how many are m or b
table(data$diagnosis)
#Summary of numeric features:

summary(data)
#Average of key features by diagnosis (optional but useful):

data %>%
  group_by(diagnosis) %>%
  summarise(
    avg_radius = mean(radius_mean),
    avg_texture = mean(texture_mean),
    avg_area = mean(area_mean),
    avg_concavity = mean(concavity_mean)
  )

#Step 7: Visualizations

#Histogram of radius_mean by diagnosis:
  
  ggplot(data, aes(x = radius_mean, fill = diagnosis)) +
  geom_histogram(alpha = 0.6, position = "identity", bins = 30) +
  labs(title = "Distribution of Mean Radius by Diagnosis", x = "Mean Radius", y = "Count")


#Boxplot of texture_mean by diagnosis:
  
  ggplot(data, aes(x = diagnosis, y = texture_mean, fill = diagnosis)) +
  geom_boxplot() +
  labs(title = "Texture Mean by Diagnosis", x = "Diagnosis", y = "Texture Mean")


#Boxplot of concavity_worst by diagnosis:
  
  ggplot(data, aes(x = diagnosis, y = concavity_worst, fill = diagnosis)) +
  geom_boxplot() +
  labs(title = "Concavity Worst by Diagnosis", x = "Diagnosis", y = "Concavity Worst")

#Step 8: Correlation heatmap
# Select numeric columns only
numeric_data <- data %>% select_if(is.numeric)

# Compute correlation matrix
cor_matrix <- cor(numeric_data)

# Plot correlation heatmap
corrplot(cor_matrix, method = "color", type = "lower", tl.cex = 0.6)
