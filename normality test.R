# Read data into data frame
normal_data <- read.csv("NormalData.csv")
non_normal_data <- read.csv("nonnormaldata.csv")

# Define plotting region
opar <- par(no.readonly = TRUE)
par(mfrow = c(1, 2))

# Create histogram to show distribution
# of both data frames
# to visually check for normality
hist(normal_data$x,
     main = "Frequency chart of data distribution (paramatric data)",
     col = 'red')

hist(non_normal_data$x,
     main = "Frequency chart of data distribution (non-paramatric data)",
     col = 'red')

# Create a Q-Q plot for both data frames
qqnorm(normal_data$x,
       main = "Q-Q plot of first dataset variable")
qqline(normal_data$x)

qqnorm(non_normal_data$x,
       main = "Q-Q plot of second dataset variable")
qqline(non_normal_data$x)

# Shapiro-Wilk test
# If p-value > 0.05 then data variable is normally distributed
# If p-value < 0.05 then data variable is not normally distributed
# Test also presents a W statistics; we'll use the p-value

# Shapiro-Wilk test for parametric data
shapiro.test(normal_data$x)

# Shapiro-Wilk test for non-parametric data
shapiro.test(non_normal_data$x)

# Perform the Kolmogorov-Smirnov Test
# If p-value > 0.05, then data is normall distributed
# If p-value is < 0.05, then p-value is not normally distributed

# Kolmogorov-Smirnov Test for parametric data
ks.test(normal_data$x, 'pnorm')

# Kolmogorov-Smirnov Test for non-parametric data
ks.test(non_normal_data$x, "pnorm")

# Convert non-parametric data to parametric
# log transform

log_non_normal_data <- log10(non_normal_data$x)

# If badly skewed data then use this
neg_skewed_log_non_normal_data <- log10(max(non_normal_data$x + 1) - non_normal_data$x)
