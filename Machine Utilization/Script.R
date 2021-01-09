
#Setting working directory
getwd()
setwd('E:/Machine Utilization')

#Importing the dataset
dataset = read.csv('Machine-Utilization.csv')

#Exploring the Dataset
head(dataset)
tail(dataset)
nrow(dataset)
ncol(dataset)
str(dataset)
summary(dataset)

#Adding Utilization Column
dataset$Utilization = 1 - dataset$Percent.Idle

#Check
head(dataset,20)

#Handling Date & Time
dataset$Timestamp = as.POSIXct(dataset$Timestamp, format = '%d/%m/%Y %H:%M')

#Check
head(dataset)
summary(dataset)

#Creating the RL1 list
RL1 = dataset[dataset$Machine == 'RL1',]

#Check
head(RL1)
tail(RL1)
nrow(RL1)
ncol(RL1)
str(RL1)
summary(RL1)

#Removing remaining machine names from summary by using factors
RL1$Machine = factor(RL1$Machine)

#Check
summary(RL1)

#Finding min, mean and max for RL1
util_stats_rl1 = c(min(RL1$Utilization, na.rm = TRUE), 
                   mean(RL1$Utilization, na.rm = TRUE), 
                   max(RL1$Utilization, na.rm = TRUE))

util_stats_rl1

#Checking if Utilization fell below 90%
which(RL1$Utilization < 0.9)
#Yes, utilization did fall below 90%.
#Thus, converting above operation to boolean to add to list
util_under_90 = (length(which(RL1$Utilization < 0.9)) > 0)
util_under_90

#Building the list
list_rl1 = list("RL1", util_stats_rl1, util_under_90)
list_rl1

#Naming the components
names(list_rl1) = c('Machine', 'Stats(min,mean,max)','Low Threshold')
list_rl1

#Adding the NA hours to the list
list_rl1$UnknownHours = RL1[is.na(RL1$Utilization),'Timestamp']
list_rl1

#Adding the Dataframe
list_rl1$Data = RL1
list_rl1

#Check
summary(list_rl1)
str(list_rl1)

#Building Time Series Plot for All Machines
#install.packages('ggplot2')
#Importing library
library(ggplot2)
p = ggplot(data = dataset, aes(x = Timestamp, y = Utilization, color = Machine))
p + geom_line(size = 1.2) + facet_grid(Machine~.) + geom_hline(yintercept = 0.90, 
                                                               color = 'Gray',
                                                               size = 1.2,
                                                               linetype = 3)
plot = p + geom_line(size = 1.2) + facet_grid(Machine~.) + geom_hline(yintercept = 0.90, 
                                                                      color = 'Gray',
                                                                      size = 1.2,
                                                                      linetype = 3) + xlab("Time Stamp") + ylab("Utilization") +
  ggtitle("Utilization vs Time Stamp") + 
  theme(axis.title.x = element_text(color = 'Blue',size=20),
        axis.title.y = element_text(color = 'Blue',size=20),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=15),
        legend.title = element_text(size=20),
        legend.text = element_text(size = 15),
        plot.title = element_text(color = 'Red',size = 30, hjust = 0.5))

#Adding plot to list
list_rl1$Plot = plot
list_rl1

#Checking to see if plot is added
summary(list_rl1)
str(list_rl1)

#Final Needed list
list_rl1
