# Insurance dataset 
# Load the dataset into a data frame first

insurance_data <- read.csv("insurance.csv", na = "")
str(insurance_data)

# several variables need to be converted
# sex - male = 0, female = 1
# Smoker - yes = 1, no = 0
# Region contains 4 categories
# N = 4, so we need n-1 indicator variables
# = 3 indicator variables
# Code variables in alphabetical order
head(insurance_data$region, 15)

# Convert variables as described above
names(insurance_data)
attach(insurance_data)

insurance_data$sex <- factor(sex,
                             levels = c("male", "female"), 
                             ordered = FALSE)

insurance_data$smoker <- factor(smoker, 
                                levels = c("yes", "no"), 
                                ordered = FALSE)

insurance_data$region <- factor(region,  
                                levels = c("northeast", "northwest", "southeast", "southwest"), 
                                ordered = FALSE)

str(insurance_data)

# View the split of males and females within the data frame
table(insurance_data$sex)
table(insurance_data$smoker)
table(insurance_data$region)

pairs(insurance_data)
# Initial investigation of data variables
install.packages("psych")
library(psych)

# Seems there could be a positive correlation between 
# smoker and charges, perhaps charges and age
# and BMI and charges
pairs.panels(insurance_data,
             smooth = FALSE,      # If TRUE, draws loess smooths
             scale = FALSE,      # If TRUE, scales the correlation text font
             density = TRUE,     # If TRUE, adds density plots and histograms
             ellipses = FALSE,    # If TRUE, draws ellipses
             method = "pearson",# Correlation method (also "pearson" or "kendall")
             pch = 21,           # pch symbol
             lm = FALSE,         # If TRUE, plots linear fit rather than the LOESS (smoothed) fit
             cor = TRUE,         # If TRUE, reports correlations
             jiggle = FALSE,     # If TRUE, data points are jittered
             factor = 2,         # Jittering factor
             hist.col = 4,       # Histograms color
             stars = TRUE,       # If TRUE, adds significance level with stars
             ci = TRUE)          # If TRUE, adds confidence intervals

# if we build the model now, R will automatically split the
# factor variables
# Alternatively we will control this process

# in linear regression, mode lis:
# y = 𝛽0 + 𝛽1𝑥1 + 𝛽2𝑥2 + 𝛽3𝑥3 + 𝛽4𝑥4 + 𝑒
# Where:𝑦 = insurance charges we wish to predict
# Β0 = intercept
# x1 = person’s age
# x2 = persons BMI
# x3 = children
# x4 = smoker
# x5 = region
# e = the model’s residual error

set.seed(1)
model <- lm(formula = charges ~
              age +
              sex +
              bmi +
              children + 
              smoker + 
              region,
            data = insurance_data)
model
summary(model)

# obviously age, bmi, children, smokerno have an
# influence over the dependent variable "charges"
# p-value less than the sig value
# sexfemale is not influential on the model
# keep region for now as i need to use it
# for the research question

insurance_data <- insurance_data[c(1, 3:7)]
insurance_data$bmi <- round(bmi, 1)
insurance_data$charges <- round(charges, 2)

# Create the model again with the amended changes
model <- lm(formula = charges ~
              age +
              bmi +
              children +
              smoker +
              region,
            data = insurance_data)
model
summary(model)

# Now we need to check model assumptions
# Linearity
# We can examine whether a linear correlation exist
# between continuous variables

scatter.smooth(x = age,
               y = charges,
               main = "Insurance charges ~ age",
               xlab = "Age (years)",
               ylab = "Insurance charges(,000)")

scatter.smooth(x = bmi,
               y = charges,
               main = "Insurance charges ~ bmi",
               xlab = "bmi",
               ylab = "Insurance charges(,000)")

scatter.smooth(x = children,
               y = charges,
               main = "Insurance charges ~ children",
               xlab = "children",
               ylab = "Insurance charges(,000)")

scatter.smooth(x = children,
               y = charges,
               main = "Insurance charges ~ children",
               xlab = "Children",
               ylab = "Insurance charges (,000)")

# No info available for plot of continuous versus categorical
# Instead we can examine relationship with department
# and categorical data using box plot

attach(insurance_data)
plot(smoker,
     charges,
     main = "Charges by smoker status",
     xlab = "Smoker",
     ylab = "Insurance charges")

plot(region,
     charges,
     main = "Charges by region",
     xlab = "Region",
     ylab = "Insurance charges")

insurance_data$cor_smoker <- ifelse(smoker == "yes", 1, 0)
cor(charges, cor_smoker)

# Normality
with(insurance_data, {qqnorm(age, main = "Normality analysis of age data")
  qqline(age)
  })
