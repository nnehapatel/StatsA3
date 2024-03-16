#Assignment 2 - BINF 6970

# Problem 1 ----
# load packages
library(readxl)
library(glmnet)


# load dataset
immuno <- read_excel("Immunologic profiles of patients with COVID-19.xlsx")

# data exploration
str(immuno)
summary(immuno)
head(immuno)
sapply(immuno, class)
sapply(immuno, function(x) sum(is.na(x)))
cor(immuno)