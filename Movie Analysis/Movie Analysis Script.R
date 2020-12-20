
#Setting the working Directory 
getwd()
setwd('E:/Pranav/Portfolio/Github/R Programming/Movies Analysis')

#Importing Dataset
dataset = read.csv('Movie.csv')

#Exploring Dataset
head(dataset)

#Renaming columns
colnames(dataset)
colnames(dataset) = c('Film','Genre','CriticRating','AudienceRating','BudgetMillions','Year')

#Checking if operation was successful
head(dataset)
tail(dataset)
nrow(dataset)
ncol(dataset)
str(dataset)
summary(dataset)

#Converting Year to Factor
dataset$Year = factor(dataset$Year)

#Checking if operation was successful
str(dataset)
summary(dataset)

#Importing Library
#install.packages('ggplot2')
library(ggplot2)

#Creating base plot
base = ggplot(data = dataset, aes(x = CriticRating, y = AudienceRating, 
                           color = Genre, size = BudgetMillions))

#Plot 1
base + geom_point() + geom_smooth() + facet_grid(Genre~Year) + coord_cartesian(ylim = c(0,100)) + xlab("Critic Rating") + ylab("Audience Rating") +
  ggtitle("Audience vs Critic Rating(According to Year and Genre)") + 
  theme(axis.title.x = element_text(color = 'Blue',size=20),
        axis.title.y = element_text(color = 'Blue',size=20),
        axis.text.x = element_text(size=15),
        axis.text.y = element_text(size=15),
        legend.title = element_text(size=20),
        legend.text = element_text(size = 15),
        plot.title = element_text(color = 'Red',size = 30, hjust = 0.5))

#Plot 2
base + geom_point() + xlab("Critic Rating") + ylab("Audience Rating") +
  ggtitle("Scatter Plot for Audience vs Critic Rating") + 
  theme(axis.title.x = element_text(color = 'Blue',size=20),
        axis.title.y = element_text(color = 'Blue',size=20),
        axis.text.x = element_text(size=15),
        axis.text.y = element_text(size=15),
        legend.title = element_text(size=20),
        legend.text = element_text(size = 15),
        plot.title = element_text(color = 'Red',size = 30, hjust = 0.5))

#Plot 3
hist = ggplot(data = dataset, aes(x = BudgetMillions))
hist + geom_histogram(binwidth = 10, aes(fill = Genre), 
                      colour = 'Black') + facet_grid(Genre~., scales = 'free') + xlab("Budget in Millions($)") + ylab("Count") +
  ggtitle("Count vs Budget(According to Year and Genre)") + 
  theme(axis.title.x = element_text(color = 'Blue',size=20),
        axis.title.y = element_text(color = 'Blue',size=20),
        axis.text.x = element_text(size=15),
        axis.text.y = element_text(size=15),
        legend.title = element_text(size=20),
        legend.text = element_text(size = 15),
        plot.title = element_text(color = 'Red',size = 30, hjust = 0.5))

#Density Plot
hist + geom_density(aes(fill = Genre),position = 'stack')

#Plot 4
hist2 = ggplot(data = dataset, aes(x = AudienceRating))
hist2 + geom_histogram(binwidth = 10, fill = 'White', colour = 'Blue') + xlab("Audience Rating") + ylab("Count") +
  ggtitle("Movie Performance according to Audience Rating") + 
  theme(axis.title.x = element_text(color = 'Blue',size=20),
        axis.title.y = element_text(color = 'Blue',size=20),
        axis.text.x = element_text(size=15),
        axis.text.y = element_text(size=15),
        legend.title = element_text(size=20),
        legend.text = element_text(size = 15),
        plot.title = element_text(color = 'Red',size = 30, hjust = 0.5))

#Plot 5 
hist3 = ggplot(data = dataset, aes(x = CriticRating))
hist3 + geom_histogram(binwidth = 10, fill = 'White', colour = 'Blue') + xlab("Critic Rating") + ylab("Count") +
  ggtitle("Movie Performance according to Critic Rating") + 
  theme(axis.title.x = element_text(color = 'Blue',size=20),
        axis.title.y = element_text(color = 'Blue',size=20),
        axis.text.x = element_text(size=15),
        axis.text.y = element_text(size=15),
        legend.title = element_text(size=20),
        legend.text = element_text(size = 15),
        plot.title = element_text(color = 'Red',size = 30, hjust = 0.5))

# 
base2 = ggplot(data = dataset, aes(x= CriticRating, y = AudienceRating, color = Genre))
base2 + geom_point(size = 3) + geom_smooth(fill = NA)


#Plot 6
box = ggplot(data = dataset, aes(x= CriticRating, y = AudienceRating, color = Genre))
box + geom_boxplot(size = 1.2) + geom_jitter()
box + geom_jitter() + geom_boxplot(size = 1.2, alpha = 0.5) + xlab("Critic Rating") + ylab("Audience Rating") +
  ggtitle("BoxPlot for Audience Rating vs Critic Rating") + 
  theme(axis.title.x = element_text(color = 'Blue',size=20),
        axis.title.y = element_text(color = 'Blue',size=20),
        axis.text.x = element_text(size=15),
        axis.text.y = element_text(size=15),
        legend.title = element_text(size=20),
        legend.text = element_text(size = 15),
        plot.title = element_text(color = 'Red',size = 30, hjust = 0.5))
