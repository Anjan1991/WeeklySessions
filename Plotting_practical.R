# Build the dataset using vectors
dose <- c(20, 30, 40, 45, 60)
drugA <- c(16, 20, 27, 40, 60)
drugB <- c(15, 18, 25, 31, 40)

# storing info in dataframe called drugs
drugs <- data.frame(dose, drugA, drugB)

plot(drugs)
?plot

attach(drugs)
plot(dose, type = 'o', col = "blue")

# option type = "b" means
# we can plot both points and lines
plot(dose, drugA, type = 'b')

# Store the contents of par() to a variable
help(par)

opar <- par(no.readonly = TRUE)
plot(dose, drugB, type = "b")

# lty = 2 (dashed line)
# pch = 17(triangles)
par(lty = 2, pch = 17)
plot(dose, drugA, type = "b")
par(opar)

# Specify graphical paramteters
plot(dose, type = "b", lty = 2, pch = 17)

# Three times wider than default
plot(drugA, 
     type = 'b', 
     lty = 3, 
     lwd = 3, 
     pch = 15, 
     ylim = c(0, 100))
title(main = "Drug Dosage",
      col.main = "blue",
      font.main = 4)
# plot drug b with red dashed line and square points
# pch = 12
plot(drugB,
     type = "b",
     lty = 2,
     lwd = 2,
     pch = 12,
     ylim = c(0, graph_range[2]),
     col = "red")
title(main = "Drug Dosage",
      col.main = "blue",
      font.main = 4)

graph_range <- range(0, drugA, drugA)
graph_range

# Label the axis values
# Make the x axis have ml labels

axis(1, at = 1:5, lab = c("20ml", "40ml", "60ml", "80ml", "100ml"))

# y-axis with tick every 5 points
axis(2, at = 0:graph_range[2]/5)

# Full example of charts
# Plot dose with
# With labels
plot(dose, drugA, type = "b", col = "red", pch = 2,
     lwd = 2, main = "clinical trial for drug A",
     sub = "This is hypothetical data", xlab = "dosage",
     ylab = "Drug Response", xlim = c(0,60), ylim = c(0,70))

# Use mtcar
?mtcars
# Capture parameters
opar <- par(no.readonly = TRUE)
# include mfrow = c(nrow, ncol)
par(mfrow = c(2,2))
attach(mtcars)
str(mtcars)
plot(wt, mpg, main = "scatter plot of weight vs mpg")
plot(wt, disp, main = "scatter plot of weight vs displacement")
par(opar)

# Show 3 plot in 3 rows and 1 col
# of wt, mpg and disp

opar <- par(no.readonly = TRUE)
par(mfrow = c(3,1))
graph_range <- range(0, wt, mpg, disp)
graph_range
plot(wt,main = "scatter plot of weight", 
     xlab = "100", ylab = "weight of cars")
plot(mpg, main = "scatter plot of miles per gallon", xlab = "100", ylab = "miles per gallon")
plot(disp, main = "scatter plot of displacement", xlab = "100", ylab = "displacement")