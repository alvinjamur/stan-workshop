setwd("/Users/imad/Desktop/Git/stan-workshop")
list.files()

#######################################################
### variables, lists, matrices, indexing, functions ###
#######################################################

# creating vectors and matrices
x <- c(4,6,7)
M <- matrix(c(6,7,8, 1,2,7), nrow = 2)
# scalar and matrix multiplication
3*x # this is scalar multiplication
x%*%t(M) # matrix multiplication
D <- diag(1, nrow=10)
D2 <- diag(70, nrow=10)
D
D2

# creating lists
my_list <- list()
my_list$x <- c(3,4,6)
my_list$item2 <- seq(1,10,0.5)
my_list$item2

# indexing
x[2] # indexing from vector
M[2,2] #indexing from a matrix
M[,2] # extract a column
M[1:2,2]
M[1,] # extract a row
M[1:2,1:2] # submatrix

# functions
f <- function(x) {
  output <- x^2
  return(output)
}

f_xy <- function(x_input, y_input) {
  return(x_input^2 + y_input^2)
}
f_xy(2,2)

# removing from the evironment and clearing the environment
remove(v, x) # remove some objects
remove(list=ls()) # clear the environment

####################################
### reading data and data frames ###
####################################

# read.csv
booleantext <- read.csv("booleantext.csv")

# cbind
cbind_stuff <- list()
cbind_stuff$M <- diag(1,3)
cbind_stuff$v <- c(rep(3,3))
cbind_stuff$M_and_v <- cbind(cbind_stuff$M, cbind_stuff$v)
cbind_stuff$r <- c(rep(2,4))
cbind_stuff$Mvr <- rbind(cbind_stuff$M_and_v, cbind_stuff$r)
cbind_stuff$Mvr

# data.frame
matrixdata <- data.frame(cbind_stuff$Mvr)
names(matrixdata) <- c("var1","var2","var3","var4")
names(matrixdata)

###############################################################
### loops: for,while,if-else (including cat, paste, paste0) ###
###############################################################

# for
for(t in 1:10) {
  print(paste("iteration:",t))
}

# while
i <- 4
while(i <= 5) {
  print(paste(i,"is less than 5"))
  i <- i + 1
}

# if-else
condition <- 0.2

if (condition >= 0.5) {
  print(1)
} else {
  print(0)
}

binarydata <- ifelse(booleantext[,2]=="TRUE",1, 0)
booleantext$binary <- binarydata
booleantext <- booleantext[,-1]
booleantext$binary

# write.csv
write.csv(booleantext,"binarydata.csv")
list.files()

########################################################################
### distributions (uni, binom, normal, beta, cauchy, poission, etc.) ###
########################################################################

# uniform distribution
runif(1)
runif(100)
dunif(0.112157078)
dunif(12)
dunif(12,0,13)

# normal distribution
rnorm(100)

# binomial
rbinom(1, 6, 0.5)

# cauchy
rcauchy(10)

# beta
rbeta(10, 2, 2)
rbeta(10, 2, 4)

################
### plotting ###
################

f <- function(x) {
  return(-(x-5)^2)
}

plot(seq(-10,10,0.05), f(seq(-10,10,0.05)), type = "l", lwd = 3, main = "Some Function", xlab = "x", ylab = "f(x)")
abline(v = 5, col = "red", lty = 2)
points(5, f(5), col = "blue", pch = 20, cex = 2)

beta_rand <- rbeta(1000,2,2)
hist(beta_rand, col = "grey", main = "Histogram Beta(2,2)", xlab = "x")
abline(v = mean(beta_rand), col = "red", lwd = 3)

# INSTALL RSTAN!
install.packages("rstan")
library(rstan)

#######################
### newton's method ###
#######################

