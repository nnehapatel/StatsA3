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

# convert severity and sex into numeric values
immuno$Severirty <- as.numeric(immuno$Severirty == "Severe")
immuno$SEX <- as.numeric(immuno$SEX == "M")

# fit a linear model with severity as the response variable
# exclude patient number, which is not a predictor variable
f0 <- lm(Severirty ~., data=immuno[,-1])

# view model and model matrix
summary(f0)
str(model.matrix(f0))
head(model.matrix(f0))

# remove intercept from model matrix
X <- model.matrix(f0)[,-1]

# set y as the response variable
y <- immuno$Severirty
table(y)

# set the indexes of 20% of the dataset for the test set
set.seed(1717)
test.index <- sample.int(dim(X)[1],round(dim(X)[1]*.2), replace = FALSE)

# make a search grid for alpha
alpha_grid <- seq(0,1,.01)
