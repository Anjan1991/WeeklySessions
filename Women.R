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
