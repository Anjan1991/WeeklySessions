?beavers
str(beaver2)
beavers_data <- beaver2

# look at the correlation
# between the variables
pairs(beavers_data,
      labels = colnames(beavers_data),
      main = "Beavers dataset correlation plot")

# We're examining body temp and activity
# so the vars need conversion first
beavers_data$activity <- factor(beavers_data$activ, labels = c("No", "yes"))

# Activity correlation of activity
plot(beavers_data$activity, beavers_data$temp)

hist(beavers_data$activ,
     main = "Frequency chart of original data distribution",
     col = 'red')

library("lattice")
attach(beavers_data)
histogram(~ temp | activity,
          data = beavers_data,
          main = "Distribution of beaver activity data",
          xlab = "Temp(degrees)",
          ylab = "Activity")

tapply(temp, activity, median)
tapply(temp, activity, mean)

# Q-Q plot for temp
qqnorm(beavers_data$temp)
qqline(beavers_data$temp, col = 'red')

# Q-Q plot for ativity
with(beavers_data, {
  qqnorm(temp[activity == "no"],
         main = "Inactive data")
  qqline(temp[activity == "no"])
})

with(beavers_data, tapply(temp, activity, shapiro.test))
