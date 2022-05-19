state.x77
# the data is not in the data frame format
class(state.x77)

states_df <- as.data.frame(state.x77)
states_df
class(states_df)

head(states_df)
# Move states names into a new variable
states_df$name <- state.name
head(states_df)

# Renaming the Life Exp and HS grad variable to 
# their default names
colnames(states_df)[colnames(states_df) == "Life Exp"] <-  "Life_Exp"
colnames(states_df)[colnames(states_df) == "HS Grad"] <-  "HS_Grad"
head(states_df)

# Showing co-linearity for the data set
states_comparison <- as.data.frame(state.x77)
pairs(states_comparison)

