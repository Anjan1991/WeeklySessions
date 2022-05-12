# Cars linear regression example

scatter.smooth(x = cars$dist, 
               y = cars$speed, 
               main = "Distance ~ Speed",
               xlab = "Stopping distance",
               ylab = "Car speed")

# This is a high correlation value and suggests 
# a high positive correlation between both variables.
cor(cars$speed, cars$dist)

# Check for outliers in variables
# Generally, any data point that lies outside the 
# 1.5 * interquartile-range (1.5 * IQR) is considered 
# an outlier, Where:

# IQR is calculated as the distance between the 
# 25th percentile and 75th percentile values for that 
# variable.

# We’ll need to check both distance and speed.

opar <- par(no.readonly = TRUE)
par(mfrow = c(1, 2)) # divide graph area in 2 columns
attach(cars)
boxplot(speed, 
        main = "Speed", 
        sub = paste("Outlier rows: ", 
                    boxplot.stats(speed)$out)) # box plot for 'speed'

boxplot(dist, 
        main = "Distance", 
        sub = paste("Outlier rows: ", 
                    boxplot.stats(dist)$out)) # box plot for 'distance'

detach(cars)
par <- opar

# The boxplots suggest that there is 1 outlier 
# in the data in the distance variable where the 
# speed is 120.

nrow(cars)

# Remove the outlier row
cars <- subset(cars, cars$dist!=120)

# Check that outlier row has been removed
nrow(cars)

# Rerun the boxplot to verify that outliers have been removed
opar <- par(no.readonly = TRUE)
par(mfrow = c(1, 2)) # divide graph area in 2 columns
attach(cars)
boxplot(speed, 
        main = "Speed", 
        sub = paste("Outlier rows: ", 
                    boxplot.stats(speed)$out)) # box plot for 'speed'

boxplot(dist, 
        main = "Distance", 
        sub = paste("Outlier rows: ", 
                    boxplot.stats(dist)$out)) # box plot for 'distance'

detach(cars)
par <- opar

cars_data <- cars

# Checking normality with histogram and Q-Q plots
# Skewness function from e1071 library
library(e1071)

par(mfrow = c(1,2))
# density plot for speed
plot(density(cars$speed), main = "Density plot : speed",
     xlab = "Frequency", ylab = "Speed",
     sub = paste("skewness: ", round(e1071::skewness(cars$speed), 2)))
# fill the area under the plot with a color
# in this example it is red
polygon(density(cars$speed), col = "red")

# Skewness < 1 or > 1 highly skewed
# -1 to -0.5 and 0.5 to 1 = moderately skewed
# -0.5 to 0.5 = approx symmetrical

plot(density(cars$dist), main = "Density plot : distance",
     xlab = "Frequency", ylab = "Distance",
     sub = paste("skewness: ", round(e1071::skewness(cars$dist), 2)))
# fill the area under the plot with a color
# in this example it is red
polygon(density(cars$dist), col = "red")

hist(cars$dist,
     main = "Normality proportion of distance",
     xlab = "Distance")

qqnorm(cars$dist)
qqline(cars$dist)
par <- opar

# Split the data into training and testing
# Set the initial random variability seed
set.seed(1)

# Split the data into 70 % training, 30% testing
no_rows_data <- nrow(cars)
sample_data <- sample(1:no_rows_data, size = round(0.7 * no_rows_data), replace = FALSE)

training_data <- cars[sample_data,]
testing_data <- cars[-sample_data,]

nrow(training_data)
nrow(testing_data)

linear_model <- lm(dist ~ speed, data = training_data)
summary(linear_model)

AIC(linear_model)
BIC(linear_model)

# Predict values using the model
# Distance will be predicted and compared to
# test data

predicted_distance <- predict(linear_model, testing_data)
predicted_distance

actual_predictions <- data.frame(cbind(Actuals = testing_data$dist,
                                        Predicted = predicted_distance))
actual_predictions

correlation_accuracy <- cor(actual_predictions)
correlation_accuracy

# MAPE represents the mean forecast by which
# the results will produce an error
mape <- mean(abs(actual_predictions$Predicted - actual_predictions$Actuals) / 
               actual_predictions$Actuals)
mape

install.packages("DAAG")
library(DAAG)
cv_results <- suppressWarnings(CVlm(data = cars,
                                    form.lm = dist ~ speed,
                                    dots = FALSE,
                                    seed = 1,
                                    legend.pos = "topleft",
                                    main = "Small symbols are predicted values while bigger ones are actuals"))
