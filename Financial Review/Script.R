
#Setting the working directory
getwd()
setwd('E:/Financial Review')

#Importing dataset
dataset = read.csv('Future-500.csv', na.strings = c(''))

#Exploring dataset
head(dataset)
tail(dataset)
nrow(dataset)
ncol(dataset)
str(dataset)
summary(dataset)

#Converting ID & Inception to factor
dataset$ID = factor(dataset$ID)
dataset$Inception = factor(dataset$Inception)

#Checking if factor worked properly
str(dataset)
summary(dataset)

#Converting from Factor to Numeric
#Columns: Revenue, Expenses and Growth
#Data Cleaining/Preparation before conversion
#1) Removing ' Dollar' and ',' from Expenses column
dataset$Expenses = gsub(' Dollars','',dataset$Expenses)
dataset$Expenses = gsub(',','',dataset$Expenses)

#Check to see operations results
head(dataset)

#2) Removing '$' and ',' from Revenue column
dataset$Revenue = gsub('\\$','',dataset$Revenue)
dataset$Revenue = gsub(',','',dataset$Revenue)

#Check to see operations results
head(dataset)

#3) Removing '%' from Growth
dataset$Growth = gsub('%','',dataset$Growth)

#Check to see operations results
head(dataset)
str(dataset)

# Final setp: Converting from Factor to Numeric
dataset$Revenue = as.numeric(dataset$Revenue)
dataset$Expenses = as.numeric(dataset$Expenses)
dataset$Growth = as.numeric(dataset$Growth)

#Check
str(dataset)
summary(dataset)

#Dealing with Missing Data
#Locating Missing Data
dataset[!complete.cases(dataset),]

#Creating a backup
dataset_bac = dataset

#Deleting Records with Missing Data which cannot be replaced
#As we might need the industry column to calcualte mean, median, etc ahead,
#Deleting records which are empty in the industry column i.e. record with ID 14 & 15
dataset = dataset[!is.na(dataset$Industry),]

#Check
dataset[!complete.cases(dataset),]

#Resetting dataframe index
rownames(dataset) = 1:nrow(dataset)
tail(dataset)

#Replacing Missing Records with Factual Analysis
dataset[is.na(dataset$State),]

#As New York is in NY and San Francisco is in CA, replacing the NA in State with respective values
dataset[is.na(dataset$State) & dataset$City == 'New York','State'] = 'NY'
dataset[is.na(dataset$State) & dataset$City == 'San Francisco','State'] = 'CA'

#Check
dataset[c(11,82,265,377),]

#Check
dataset[!complete.cases(dataset),]

#Replacing data: Median Imputation Method
#Replacing Data in Employees
emply_retail_median =  median(dataset[dataset$Industry == 'Retail','Employees'],na.rm = TRUE)
dataset[is.na(dataset$Employees)&dataset$Industry == 'Retail','Employees'] = emply_retail_median
emply_finser_median=median(dataset[dataset$Industry=='Financial Services','Employees'],na.rm=TRUE)
dataset[is.na(dataset$Employees)&dataset$Industry=='Financial Services','Employees']=emply_finser_median

#Check
dataset[c(3,330),]

#Check
dataset[!complete.cases(dataset),]

#Replacing Data in Growth
gwth_cons_med = median(dataset[dataset$Industry == 'Construction','Growth'],na.rm = TRUE)
dataset[is.na(dataset$Growth)&dataset$Industry == 'Construction','Growth'] = gwth_cons_med

#Check
dataset[c(8),]

#Replacing Data in Revenue
rev_cons_med = median(dataset[dataset$Industry == 'Construction','Revenue'],na.rm = TRUE)
dataset[is.na(dataset$Revenue)&dataset$Industry == 'Construction','Revenue'] = rev_cons_med

#Check
dataset[c(8,42),]

#Check
dataset[!complete.cases(dataset),]

#Replacing Data in Expenses(Only Median ones)
exp_cons_med = median(dataset[dataset$Industry == 'Construction','Expenses'],na.rm = TRUE)
dataset[is.na(dataset$Expenses)&dataset$Industry == 'Construction','Expenses'] = exp_cons_med

#Check
dataset[c(8,42),]

#Check
dataset[!complete.cases(dataset),]

#Replacing Missing Values : Deriving Values Method
dataset[is.na(dataset$Profit),'Profit'] = dataset[is.na(dataset$Profit),'Revenue'] - dataset[is.na(dataset$Profit),'Expenses'] 

#Check
dataset[c(8,42),]

#Check
dataset[!complete.cases(dataset),]

#Replacing missing value in Expenses by Deriving Value Method
dataset[is.na(dataset$Expenses),'Expenses'] = dataset[is.na(dataset$Expenses),'Revenue'] - dataset[is.na(dataset$Expenses),'Profit'] 

#Check
dataset[c(15),]

#Check
dataset[!complete.cases(dataset),]
#Row 20(ID:22) is not altered because Inception is not needed for our Analysis

#Visualization
#install.packages(ggplot2)

#Importing Library
library(ggplot2)

#Plot 1 : Scatter PLot classified by Industry showing Revenue, Expenses and Profit
ggplot(data = dataset, aes(x = Revenue, y = Expenses,
                           color = Industry, size = Profit)) + geom_point() + xlab("Revenue") + ylab("Expenses") +
  ggtitle("Expenses vs Revenue(According to Industry)") + 
  theme(axis.title.x = element_text(color = 'Blue',size=20),
        axis.title.y = element_text(color = 'Blue',size=20),
        axis.text.x = element_text(size=15),
        axis.text.y = element_text(size=15),
        legend.title = element_text(size=20),
        legend.text = element_text(size = 15),
        plot.title = element_text(color = 'Red',size = 30, hjust = 0.5))

#Plot 2: Scatter PLot including Industry trends for the Expenses~Revenue relationship
ggplot(data = dataset, aes(x = Revenue, y = Expenses,
                           color = Industry, size = Profit)) + geom_point() + geom_smooth(fill = NA, size = 1.2) + xlab("Revenue") + ylab("Expenses") +
  ggtitle("Expenses vs Revenue(According to Industry) with Smoothers") + 
  theme(axis.title.x = element_text(color = 'Blue',size=20),
        axis.title.y = element_text(color = 'Blue',size=20),
        axis.text.x = element_text(size=15),
        axis.text.y = element_text(size=15),
        legend.title = element_text(size=20),
        legend.text = element_text(size = 15),
        plot.title = element_text(color = 'Red',size = 30, hjust = 0.5))

#Plot 3: BoxPlots showing growth by industry
ggplot(data = dataset, aes(x = Industry, y = Growth, 
                           color = Industry)) + geom_jitter() + geom_boxplot(size = 1, 
                                                                             alpha = 0.5,
                                                                             outlier.colour = NA) + xlab("Industry") + ylab("Growth") +
  ggtitle("Growth vs Industry") + 
  theme(axis.title.x = element_text(color = 'Blue',size=20),
        axis.title.y = element_text(color = 'Blue',size=20),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=15),
        legend.title = element_text(size=20),
        legend.text = element_text(size = 15),
        plot.title = element_text(color = 'Red',size = 30, hjust = 0.5))

