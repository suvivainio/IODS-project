# 9.11.2018 Suvi Vainio
# This is the second week's data wranglingexercise
library(dplyr)
learning2014 =read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", 
                 sep="\t", header = T)
# Inspect columns
colnames(learning2014)

# Create an analysis dataset with the variables gender, age, attitude, 
# deep, stra, surf and points
col0=c("gender", "Age", "Attitude", "Points")
data1=dplyr::select(learning2014, dplyr::one_of(col0))

# Calculate variables deep, stra, surf
#d_sm     Seeking Meaning           ~D03+D11+D19+D27
#d_ri     Relating Ideas            ~D07+D14+D22+D30
#d_ue     Use of Evidence           ~D06+D15+D23+D31
# Deep     Deep approach             ~d_sm+d_ri+d_ue
#st_os    Organized Studying        ~ST01+ST09+ST17+ST25
#st_tm    Time Management           ~ST04+ST12+ST20+ST28
# Stra     Strategic approach        ~st_os+st_tm
# su_lp    Lack of Purpose           ~SU02+SU10+SU18+SU26
# su_um    Unrelated Memorising      ~SU05+SU13+SU21+SU29
# su_sb    Syllabus-boundness        ~SU08+SU16+SU24+SU32
# Surf     Surface approach          ~su_lp+su_um+su_sb
attach(learning2014)
data1$deep=D03+D11+D19+D27 +D07+D14+D22+D30 +D06+D15+D23+D31
data1$stra=ST01+ST09+ST17+ST25 +ST04+ST12+ST20+ST28
data1$surf=SU02+SU10+SU18+SU26 +SU05+SU13+SU21+SU29 +SU08+SU16+SU24+SU32
detach(learning2014)
# I prefer colnames lower case
colnames(data1)=casefold(colnames(data1))
# Take means of combination variables
data1$deep=data1$deep / 12
data1$stra=data1$stra / 8
data1$surf=data1$surf / 12
# Select columns where points > 0
data2=dplyr::filter(data1, points > 0)

# Set the working directory of you R session the iods project folder, save dataset
setwd("C:/Users/Suvi/Dropbox/Tilastotieteen opinnot/Open data science/IODS-project")
write.table(data2, "./data/learning2014.txt")
#Demonstrate that you can also read the data again by using read.table() or 
# read.csv().  (Use `str()` and `head()` to make sure that the structure 
# of the data is correct). 
testData=read.table("./data/learning2014.txt")
head(data2)
head(testData)
# They match.
str(data2)
str(testData)
# Structure ok.
