#################################
# Data wrangling, week 5
# 2.12.2018, SUvi Vainio

library(dplyr)

# I didn't complete the data wrangling last week, so download the data
human=read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep=",", header=T)

# Explore the structure and dimensions of the data
str(human); colnames(human); dim(human)

# Metadata can be found here: https://raw.githubusercontent.com/TuomoNieminen/Helsinki-Open-Data-Science/master/datasets/human_meta.txt
# HDI refers to human deveploment index that is an index developed by the UN
# Dataset has 195 rows and 19 columns (variables)
# [1] "HDI.Rank"       "Country"        "HDI"            "Life.Exp"       "Edu.Exp"       
# [6] "Edu.Mean"       "GNI"            "GNI.Minus.Rank" "GII.Rank"       "GII"           
# [11] "Mat.Mor"        "Ado.Birth"      "Parli.F"        "Edu2.F"         "Edu2.M"        
# [16] "Labo.F"         "Labo.M"         "Edu2.FM"        "Labo.FM" 
# The data combines several indicators from most countries in the world

keep_columns=c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human1=select(human, one_of(keep_columns))

# Keep only complete cases, aka rows with no missing values
human2=human1[complete.cases(human1),]
print(paste("Rows before: ", dim(human1)[1], " rows after: ", dim(human2)[1]))

# Remove rows that refer to regions instead of countries
unique(human2$Country)
areas=c(
"Arab States",                              
"East Asia and the Pacific",
"Europe and Central Asia",             
"Latin America and the Caribbean",           
"South Asia",       
"Sub-Saharan Africa",                        
"World"
)
human3=human2[!(human2$Country%in%areas),]
human3$Country

#  Set country names as row names
rownames(human3)=human3$Country
human3=select(human3, -Country)
head(human3)

# The data should now have 155 observations and 8 variables.
dim(human3)
# [1] 155   8 --> Ok

# Write table
write.table(human3, "./data/human.txt")



