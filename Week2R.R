date_col <- c("10/15/18", "1/11/18", "10/21/18", "10/28/18", "05/01/18")
country_col <- c("US", "US", "IRL", "IRL", "IRL")
gender_col <- c("M", "F", "F", "M", "F")
age_col <- c(32, 45, 25, 39, 99)
q1_col <- c(5, 3, 3, 3, 2)
q2_col <- c(4, 5, 5, 3, 2)
q3_col <- c(5, 2, 5, 4, 1)
q4_col <- c(5, 5, 5, NA, 2)
q5_col <- c(5, 5, 2, NA, 1)
managers_data <- data.frame(date_col,
                            country_col,
                            gender_col,
                            age_col,
                            q1_col,
                            q2_col,
                            q3_col,
                            q4_col,
                            q5_col)
str(managers_data)

#changing column names using colnamese
column_names <- c("Dates", "Gender", "Country", "Age", "Q1", "Q2", "Q3", "Q4", "Q5")
colnames(managers_data) <- column_names
str(managers_data)

head(managers_data)

#recoding the incorrect age to NA
#using [] to transverse the var in the data frame
#using $ to refer to a variable in the data frame

managers_data$Age[managers_data$Age == 99] <- NA
head(managers_data)
str(managers_data)

managers_data$Age_cat[managers_data$Age <= 25] <- "young" 
managers_data$Age_cat[managers_data$Age > 25 & managers_data$Age < 44] <- "Middle Aged"
managers_data$Age_cat[managers_data$Age >= 45] <- "elder"

managers_data