
#Setting the Working Directory
getwd()
setwd("E:/Diamonds")

#Importing the Dataset
diamonds = read.csv('Mispriced-Diamonds.csv')

#Exploring the dataset
head(diamonds)
tail(diamonds)
str(diamonds)
summary(diamonds)
nrow(diamonds)
ncol(diamonds)

#Importing packages
#install.packages(ggplot2)
library(ggplot2)

#Basic Plot
ggplot(data = diamonds, 
       aes(x =carat, y = price)) + geom_point()

#Adding colors
ggplot(data = diamonds, 
       aes(x =carat, y = price, color = clarity)) + geom_point()

#Adding transparency
ggplot(data = diamonds, 
       aes(x =carat, y = price, color = clarity )) + geom_point(alpha = 0.5)

#Removing the statistically unsignificant value
ggplot(data = diamonds[diamonds$carat<2.5,], 
       aes(x =carat, y = price, color = clarity )) + geom_point(alpha = 0.5)

#Adding smoothers to view averages
ggplot(data = diamonds[diamonds$carat<2.5,], 
       aes(x =carat, y = price, color = clarity )) + geom_point(alpha = 0.5) + geom_smooth()

#Making the Plot Visually more appealing
h = ggplot(data = diamonds[diamonds$carat<2.5,], 
       aes(x =carat, y = price, color = clarity )) + geom_point(alpha = 0.5) + geom_smooth()
h + xlab("Carat") + ylab("Prices") +
  ggtitle("Prices vs Carat") + 
  theme(axis.title.x = element_text(color = 'Blue',size=20),
        axis.title.y = element_text(color = 'Blue',size=20),
        axis.text.x = element_text(size=15),
        axis.text.y = element_text(size=15),
        legend.title = element_text(size=20),
        legend.text = element_text(size = 15),
        plot.title = element_text(color = 'Purple',size = 30, hjust = 0.5))
