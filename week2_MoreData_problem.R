# Loading data to dataframe
new_mangers_data <- read.csv("MoreData.csv")
new_mangers_data
str(new_mangers_data)

# Selecting the subset of data needed
mod_managers_data <- subset(new_mangers_data, select = c("Country", "Age", "Date", "Gender", "Q1", "Q2", "Q3", "Q4", "Q5"))
mod_managers_data

# We need to fill the new dataframe wit
# variables to match the original dataframe
# Option 1 - create new vars and fill with NA. Then do calculations
# Option 2 - apply logic and simultaneously create the relevant vars
attach(mod_managers_data)
mod_managers_data$AgeCat[Age >=45] <- "Elder"
mod_managers_data$AgeCat[Age >=26 & Age <=25] <- "Middle Aged"
mod_managers_data$AgeCat[Age <=25] <- "Young"
detach(mod_managers_data)
mod_managers_data
