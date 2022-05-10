# Simple example using the women data set
str(women)

# Aiming to predict weight from height
# Dependent Variable = Weight
# Indepenednt Variable = Height

simple_linear_model <- lm(weight ~ height, data = women)
simple_linear_model

summary(simple_linear_model)

# plotting the simple lm model onto data used to create a model
plot(women$height,
     women$weight,
     main = "Scatter plot showing the regression line for weight predicetd from height",
     xlab = "Height (inches)",
     ylab = "Weight(lbs)"
     )
abline(simple_linear_model)

# Analyse the correlation coefficient
# measure the level of association between 2 variables
# -1 = perfect negative correlation
# +1 = perfect positive correlation

# A value -0.2 < x< 0.2 suggests that much of the
# variations in outcome variable is not explained by the predictor
# Then we should look for better predictor variables
confint(simple_linear_model)

cor(women$height, women$weight)

# Model accuracy - goodness of fit
# 3 quantities
# Residual Standard Error(RSE)
# R-Squared(r2)
# F-statistic
summary(simple_linear_model)
# RSEI = 1.525 = prediction error rate
# when comparing 2 models, smallest RSE is best
# In this model, observed weight values deviate from the true
# regression by approx 1.5 units on average

# r2
# Ranges from 0 - 1
# High r2 = good indicator that the model variability in the
# outcome can be explained by the model
# A numver close to 0 = model does not explain much of the variability

# f-statistic
# Overall significance of the model.
# a large F statistic corresponds to a significant p-value
# (p< 0.05)

# Build a model to predict distance from speed
# Using the cars data set

# 1st step - check model assumptions
# These are the core assumptions
# Linearity among the variables
# Normality - Normal distribution
# No Co-linearity - vars are not a linear combination of others
# Independence - residuals are independent and not correlated

# Check linearity first using the scatter plot
# X-axis = independent variable
# y-axis = dependent variable
# If relationship exists then the linearity assumption is validated

scatter.smooth(x = cars$speed,
               y = cars$dist,
               main = "Distance ~ speed",
               xlab = "car speed (mph)",
               ylab = "stopping distance")

cor(cars$speed, cars$dist)

# check for outliers
# An outlier = 1.5 X interquartile range
# IQR = distance between 25th and 75th percentile
# We need to check speed and distance for outliers

opar <- par(no.readonly = TRUE)
par(mfrow = c(1,2))
attach(cars)
boxplot(speed,
        main = "Speed",
        sub = paste("Outlier rows: ", boxplot.stats(speed)$out)
        )

boxplot(dist,
        main = "Distance",
        sub = paste("Outlier rows: ", boxplot.stats(dist)$out)
)
detach(cars)
par <- opar

# Remove line 120 because it is an outlier
cars <- subset(cars, cars$dist != 120)
