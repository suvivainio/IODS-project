
# 17.11.2018
# Suvi Vainio
# This is the data wrangling exercise for week 2, theme: logistic regression
library(dplyr)
#setwd([file the directory where the data is])

mat0=read.csv("student-mat.csv", sep=';', header = T)
por0=read.csv("student-por.csv", sep=';', header=T)
# Check, that files look ok
head(mat0);head(por0)
str(mat0);str(por0)

# Join the two datasets, keep only students present in both: all=F
joinColumns=c( "school", "sex", "age", 
               "address", "famsize", "Pstatus", 
               "Medu", "Fedu", "Mjob", "Fjob", 
               "reason", "nursery","internet")
data0=merge(mat0, por0, by=joinColumns, suffixes = c('.mat', '.por'), 
            all=F)
colnames(data0); str(data0)

# The two orginal datasets had same variables, that were not used in
# the join-operation (e.g. guardian was present in both sets).
# Combine the duplicated answers in the joined data.
data1=select(data0, one_of(joinColumns))
notJoinedColumns=colnames(mat0)[!colnames(mat0) %in% joinColumns]

# for every column name not used for joining...
for(column_name in notJoinedColumns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(data0, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    data1[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    data1[column_name] <- select(two_columns, 1)[[1]]
  }
}
glimpse(data1)

# Take the average of the answers related to weekday and 
# weekend alchol consumption to create column alc_use.
# Create boolean variable high_use: alc_use > 2

# Variables and descriptions:
# 27 Dalc - workday alcohol consumption (numeric: from 1 - very low to 5 - very high) 
# 28 Walc - weekend alcohol consumption (numeric: from 1 - very low to 5 - very high) 

data1 = mutate(data1, alc_use=(Dalc+Walc)/2)
data1 = mutate(data1, high_use=alc_use > 2)
glimpse(data1)

# data has 382 observations and 35 variables

write.table(data1, "alc.txt")
glimpse(read.table('alc.txt'))

# Data ok.

