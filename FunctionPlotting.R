# Plotting function, sweeping parameters
# March 29, 2018
# EAT

setwd("~/Documents/UVM_2018/FirstProject")


# Use differing numbers or matrix rows and columns
z <- matrix(runif(9),nrow=3)
z[3,3]
z <- matrix(runif(20),nrow=5)
z[5,4] # no error

# using double for loops
m <- matrix(round(runif(20),digits = 2),nrow = 5)
print(m)

# loop over rows
for (i in 1:nrow(m)) {
  m[i,] <- m[i,] + i
}
print(m)
# loop over columns
m <- matrix(round(runif(20),digits = 2),nrow = 5)
for (j in 1:ncol(m)) {
  m[,j] <- m[,j] + j
}
print(m)
# loop over rows and columns
m <- matrix(round(runif(20),digits = 2),nrow = 5)
for (i in 1:nrow(m)) {
  for (j in 1:ncol(m)) {
    m[i,j] <- m[i,j] + i + j
  }
}
print(m)

# Sweeping over parameters in an equation

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

# now build a grid of plots
# each with different parameter values
# global variables
cPars <- c(100,150,175)
zPars <- c(0.10,0.16,0.26,0.30)
par(mfrow=c(3,4)) # graphic parameters in base R

# enter into double loop for plotting
for (i in 1:length(cPars)) {
  for (j in 1:length(zPars)) {
    SpeciesAreaPlot(c=cPars[i],z=zPars[j])
  }
}
par(mfrow=c(1,1))
# plotting redux with ggplot
library(ggplot2)

cPars <- c(100,150,175)
zPars <- c(0.10,0.16,0.26,0.30)
Area <- 1:5
# ggplot requires data frame
# set up model frame
modelFrame <- expand.grid(c=cPars,z=zPars,A=Area)
modelFrame
modelFrame$S <- NA
modelFrame

# tricky double for loop for filling new data frame
for (i in 1:length(cPars)) {
  for (j in 1:length(zPars)) {
    modelFrame[modelFrame$c==cPars[i] & modelFrame$z==zPars[j], "S"] <- SpeciesAreaCurve(A=Area,c=cPars[i],z=zPars[j])
  }
}
modelFrame

p1 <- ggplot(data=modelFrame)
p1 + geom_line(mapping=aes(x=A,y=S)) + facet_grid(c~z)

p2 <- p1
p2 + geom_line(mapping=aes(x=A,y=S,group=c)) + facet_grid(.~z)
