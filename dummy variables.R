# Insurance data set

insurance_data <- read.csv("Insurance.csv")
str(insurance_data)

# Several variables need to be converted
# Sex - male = 0, female = 1
# Smoker - yes = 1, no = 0
# Region - 4 regions
# N = 4, so we need n-1 indicator variables

# Convert the sex variable
insurance_data$sex <- factor(insurance_data$sex,
                             levels = c("male", "female"),
                             ordered = FALSE)
str(insurance_data)

# Convert smoker variable
insurance_data$smoker <- factor(insurance_data$smoker,
                                levels = c("yes", "no"),
                                ordered = FALSE)
str(insurance_data)

# Convert region variable
insurance_data$region <- factor(insurance_data$region,
                                levels = c("northeast",
                                           "northwest",
                                           "southeast",
                                           "southwest"),
                                ordered = FALSE)
str(insurance_data)

# Correlations between the variables
library(psych)
pairs.panels(insurance_data,
             smooth = FALSE,      # If TRUE, draws loess smooths
             scale = FALSE,      # If TRUE, scales the correlation text font
             density = TRUE,     # If TRUE, adds density plots and histograms
             ellipses = FALSE,    # If TRUE, draws ellipses
             method = "spearman",# Correlation method (also "pearson" or "kendall")
             pch = 21,           # pch symbol
             lm = FALSE,         # If TRUE, plots linear fit rather than the LOESS (smoothed) fit
             cor = TRUE,         # If TRUE, reports correlations
             jiggle = FALSE,     # If TRUE, data points are jittered
             factor = 2,         # Jittering factor
             hist.col = 4,       # Histograms color
             stars = TRUE,       # If TRUE, adds significance level with stars
             ci = TRUE)          # If TRUE, adds confidence intervals

# If we build the model at this point
# R will automatically split the factor variables
# Alternatively, we want to control the model build process

attach(insurance_data)
set.seed(1)
model <- lm(formula = charges ~ age + sex + bmi + smoker + region,
            data = insurance_data)
summary(model)

# Instead we will control the model build process
# We will created our own variables
insurance_data$male <- ifelse(insurance_data$sex == "male", 1, 0)
insurance_data$female <- ifelse(insurance_data$sex == "female", 1, 0)

#smoker
insurance_data$smoker <- ifelse(insurance_data$smoker == "yes", 1, 0)
insurance_data$nonsmoker <- ifelse(insurance_data$smoker == "no", 1, 0)

# region
insurance_data$northeast <- ifelse(insurance_data$region == "northeast", 1, 0)
insurance_data$northwest <- ifelse(insurance_data$region == "northwest", 1, 0)
insurance_data$southeast <- ifelse(insurance_data$region == "southeast", 1, 0)
insurance_data$southwest <- ifelse(insurance_data$region == "southwest", 1, 0)

names(insurance_data)
# drop unneeded variables first
# using age, male, female, BMI, ne, nw, se, sw
insurance_data <- insurance_data[c(1, 3, 5, 7:14)]
insurance_data

# Round the BMI and charges values
insurance_data$bmi <- round(bmi, 1)
insurance_data$charges <- round(charges, 2)
insurance_data

# Check model assumptions
# Linearity
scatter.smooth(x=charges,
               y=age,
               main = "Insurance charges ~ age",
               xlab = "Insurance charges (,000)",
               ylab = "Age(years)")

scatter.smooth(x=charges,
               y=bmi,
               main = "Insurance charges ~ bmi",
               xlab = "Insurance charges (,000)",
               ylab = "BMI")

# instead check correlation between both variables
cor(charges, age)
cor(charges, bmi)
cor(charges, children)





# Measure colinearity
# this is a measure of the relationship between multiple variables

# check colinearity of the model
model <- lm(formula = charges ~ 
              age + 
              bmi + 
              male + 
              female + 
              northeast + 
              northwest + 
              southeast + 
              southwest)
summary(model)
