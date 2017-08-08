# Load libraries:
library("data.table")
# library("Hmisc")
# library(shiny)
# library(DT)
# library("shinythemes")
# library("formattable")
# library("htmltools")
# library("htmlwidgets")
# library(plotly)
# # library("shinydashboard")
# # library(leaflet)
# library(dplyr)
# library("sjmisc")
# library("ggplot2")
library("tidyverse")


setwd("~/Titanic")

train <- fread("Data/train.csv", stringsAsFactors= TRUE)
test <- fread("Data/test.csv", stringsAsFactors= TRUE)


# Basic exploring of datasets:

dim(train)
str(train)
summary(train)
names(train)
dim(test)
str(test)

# I want some of the columns to be factors, therefore:
int_to_factor <- which(rapply( train, is.integer) )[-1]
train[ , int_to_factor] <- train[ , lapply(.SD, factor), .SDcols=int_to_factor]
str(train)
summary(train[, -"Name"])
# Now that we have each column in the format that we want we can do some simple visualizations:
ggplot(train, aes(x=Survived, fill = Sex )) + 
  geom_bar( alpha=0.6)
# Clean data from NA's: 
train <- train[!is.na(train)]


## Basic Exploratory Data Analysis (EDA)

# Is age important?
library(plyr)
mean_train <- ddply(train, .(Survived), numcolwise(mean, na.rm= T))
#ctrain_age <- ddply(train, "Survived", summarise, rating.mean=mean(Age, na.rm= T))

ggplot(data = train) +
  geom_point(mapping = aes_string(x = "Pclass",
                           y = "Age",
                           color = "Survived" ))
# Histogram
ggplot(data = train, aes(x = Age, fill = Survived )) +
  ggtitle("Age relevance to Surviving") +
  ylab("Survivors") +
  geom_histogram(binwidth = 10, position = "identity", alpha = .5, na.rm=TRUE) +
  geom_vline(data = mean_train, aes(xintercept = mean_train[["Age"]],  colour = Survived),
             linetype="dashed", size=1)
# Density
ggplot(data = train, aes(x = Age, fill = factor(Survived) )) +
  geom_density(alpha = .5, na.rm=TRUE) +
  geom_vline(data = ctrain_age, aes(xintercept = rating.mean,  colour = factor(Survived)),
             linetype="dashed", size=1)

## Analysis Pclass
metric <- "Pclass"
ctrain <- ddply(train, "Survived", summarise, rating.mean=mean(Pclass, na.rm= T))

# Histogram
ggplot(data = train, aes(x = Pclass, fill = factor(Survived) )) +
  ggtitle("Pclass relevance to Surviving") +
  ylab("Survivors") +
  geom_histogram(binwidth = 0.5 , position = "identity", alpha = .5, na.rm=TRUE) +
  geom_vline(data = ctrain, aes(xintercept = rating.mean,  colour = factor(Survived)),
             linetype="dashed", size=1)

# Is sex important?
library(plyr)
ctrain_age <- ddply(train, "Survived", summarise, rating.mean=mean(Sex, na.rm= T))

# Histogram
ggplot(data = train) +
  geom_bar( mapping = aes_string(x = "Sex", fill = "Survived" ), position = "fill") +
  ggtitle("Sex relevance to Surviving") +
  ylab("Survivors") 
ggplot(data = train) +
  geom_bar( mapping = aes_string(x = "Survived", fill = "Sex" ), position = "fill") +
  ggtitle("Sex relevance to Surviving") +
  ylab("Sex") 


  
# Density
ggplot(data = train, aes(x = Age, fill = factor(Survived) )) +
  geom_density(alpha = .5, na.rm=TRUE) +
  geom_vline(data = ctrain_age, aes(xintercept = rating.mean,  colour = factor(Survived)),
             linetype="dashed", size=1)








ggplot(data = train, aes(x = Pclass, fill = factor(Survived) )) +
  geom_histogram(binwidth = .5, position = "identity", alpha = .5, na.rm=TRUE)

# Density plot


hist(train$Survived)

# Scatter plot:
scatterplotMatrix(~Age+Pclass|"Survived", data=train , reg.line="" , smoother="", col=Survived , smoother.args=list(col="grey") , cex=1.5 , pch=c(15,16,17) , main="Scatter plot with Three Cylinder Options")
library(car)
install.packages("spm")

# Print frequencies:
head(train)
qplot( Survived, data = train)
qplot(Age,  Survived, data = train )
qplot(Pclass,  Fare, data = train , colour = Survived, binwidth= 1)
ggplot( data = train  ) +
  geom_bar( mapping = aes( x = Fare, fill = Survived)) +
  facet_wrap( ~Pclass)

train_numeric <- train[, which(rapply(train, is.numeric))]
plot( train_numeric)

