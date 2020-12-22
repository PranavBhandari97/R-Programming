
#Setting working directory
getwd()
setwd('E:/Pranav/Portfolio/Github/R Programming/Weather Data Analysis')

#Importing the datasets
Chicago = read.csv('Chicago-C.csv', row.names = 1)
Houston = read.csv('Houston-C.csv', row.names = 1)
NewYork = read.csv('NewYork-C.csv', row.names = 1)
SanFrancisco = read.csv('SanFrancisco-C.csv', row.names = 1)

#Checks
#Chicago
Chicago

#Houston
Houston

#New York
NewYork

#San Francisco
SanFrancisco

#Checking data type
is.data.frame(Chicago)

#Converting to Matrix for project purpose
Chicago = as.matrix(Chicago)
Houston = as.matrix(Houston)
NewYork = as.matrix(NewYork)
SanFrancisco = as.matrix(SanFrancisco)

#Check
is.matrix(Chicago)

#Combining everything into a List
Weather = list(Chicago = Chicago, Houston = Houston, NewYork = NewYork, SanFrancisco=SanFrancisco)
Weather

#Calculating the yearly averages for one city
apply(Chicago, 1, mean)

#Calculating the yearly max for one city
apply(Chicago, 1, max)

#Calculating the yearly min for one city
apply(Chicago, 1, min)

#Comparing the yearly averages for all cities
apply(Chicago, 1, mean)
apply(Houston, 1, mean)
apply(NewYork, 1, mean)
apply(SanFrancisco, 1, mean)

#Task 1
round(sapply(Weather, rowMeans),2)

#Task 2
lapply(Weather, function(z) round((z[1,]-z[2,])/z[2,],2))
sapply(Weather, function(z) round((z[1,]-z[2,])/z[2,],2)) 

#Task 3
lapply(Weather,apply,1,max)
sapply(Weather, apply, 1, max)

#Task 4
lapply(Weather,apply,1,min)
sapply(Weather, apply, 1, min)

#Task 5 
lapply(Weather, function(y) apply(y, 1, function(x) names(which.max(x))))
sapply(Weather, function(y) apply(y, 1, function(x) names(which.max(x))))

#FINAL DELIVERABLE
round(sapply(Weather, rowMeans),2)
sapply(Weather, function(z) round((z[1,]-z[2,])/z[2,],2)) 
sapply(Weather, apply, 1, max)
sapply(Weather, apply, 1, min) 
sapply(Weather, function(y) apply(y, 1, function(x) names(which.max(x))))