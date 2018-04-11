# Homework 11: Function Plotting
# April 4, 2018
# EAT

setwd("~/Documents/UVM_2018/BIO381")



# Sweeping over parameters in an equation
# install plyr
install.packages("plyr")
library(plyr)
# Calculating standard error
# S = cA^z

###################################
# Function: SpeciesAreaCurve
# Creates power function for relationship of S and A
# input: A = vector of island areas
# input: c = intercept constant
# input: z = slope constant
# output: S = vector of species richness values
#---------------------------------
SpeciesAreaCurve <- function(A=1:5000,c=0.5,z=0.26) {
  S <- c*(A^z)
  return(S)
}


# head(SpeciesAreaCurve())

###################################
# Function: SpeciesAreaPlot
# plot curve in base graphics
# input: A = vector of areas
# input: c = intercept
# input: z = slope
# output: base graph with parameter values
#---------------------------------
SpeciesAreaPlot <- function(A=1:5000,c=0.5,z=0.26) {
  plot(x=A,y=SpeciesAreaCurve(A,c,z),type = "l",xlab = "Island Area",ylab = "S",ylim = c(0,2500))
  mtext(paste("c =",c,"z =",z),cex=0.7)
  return()
}
SpeciesAreaPlot()


# -----------------------------
# Body of Code
# Read in data
df <- as.data.frame(read.csv("Data.csv",header = T))
df
# Run a for loop to subtract values from columns. I need to put zero for the first index because the first column is labels
subtractor <- c(0,5,12,19,26,33,40,47,54,61,68,75)
df
# create a for loop that will subract the correct value from each column
for (i in 2:12) {
  df[,i] <- df[,i] - subtractor[i]
}
df
# in my data frame sort by 2 things
df <- ddply(df, c("SampleID","Zero"))
df
One <- subset(df,SampleID == 1)
One
meanOne <- mean(One[,2])
meanOne
# package "plyr"
# function "ddply"
dflist <- list()
dflist
for (i in 1:20) {
  dflist[[i]] <- as.data.frame(matrix(rep(NA,24),nrow = 2, ncol = 12))
}
dflist
dflist[[1]] <- One
dflist
SampleID <- c(1,2,3,4,5,6,7,9,10,12,13,14,15,16,17,18,19,20,5.2,18.2)
counter = 1
for (j in SampleID) {
  dflist[[counter]] <- subset(df,SampleID == j)
  counter <- counter + 1
}
dflist
df
dfAvgSd <- as.data.frame(matrix(rep(NA,480),nrow = 40,ncol = 12))
dfAvgSd


dfAvgSd <- as.matrix(dfAvgSd)
vec <- c(1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39)

for (k in 1:20) {
  avgvec <- vector()
  sdvec <- vector()
  for (l in 2:12) {
    avgvec <- c(avgvec,mean(dflist[[k]][,l]))
    sdvec <- c(sdvec,sd(dflist[[k]][,l]))
  }
dfAvgSd[vec[k],2:12] <- avgvec
dfAvgSd[vec[k]+1,2:12] <- sdvec
}
dfAvgSd
dfAvgSd <- as.data.frame(dfAvgSd)
dfAvgSd$V1 <- c("Avg1","Sd1","Avg2","Sd2","Avg3","Sd3","Avg4","Sd4","Avg5","Sd5","Avg6","Sd6","Avg7","Sd7","Avg9","Sd9","Avg10","Sd10","Avg12","Sd12","Avg13","Sd13","Avg14","Sd14","Avg15","Sd15","Avg16","Sd16","Avg17","Sd17","Avg18","Sd18","Avg19","Sd19","Avg20","Sd20","Avg5.2","Sd5.2","Avg18.2","Sd18.2")
dfAvgSd
colnames <- c("sample","zero","one","two","three","four","five","six","seven","eight","nine","ten")
colnames(dfAvgSd) <- colnames
dfAvgSd <- t(dfAvgSd)
dfAvgSd
# I want to make a matrix with sd's and one with averages
SD <- matrix(nrow = 12,ncol = 20)
AVG <- matrix(nrow = 12,ncol = 20)
counter = 1
for (m in vec) {
  AVG[,counter] <- dfAvgSd[,m]
  SD[,counter] <- dfAvgSd[,m+1]
  counter <- counter + 1
}

colnames(SD) <- SD[1,]
colnames(AVG) <- AVG[1,]

AVG <- AVG[-1,]
SD <- SD[-1,]

write.csv(AVG,file="AVG.csv")
write.csv(SD,file = "SD.csv")

