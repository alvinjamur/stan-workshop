# install.packages("rstan")
library(rstan)
list.files()

#############################
### EIGHT SCHOOLS EXAMPLE ###
#############################

# import or create the data. 
eightschools <- data.frame(
  cbind(
    c("A","B","C","D","E","F","G","H"),
    c(28,8,-3,7,-1,1,18,12),
    c(15,10,16,11,9,11,10,18)
  )
)
names(eightschools) <- c("school","te","se")

# specify a list of the data to run in stan
eightschools_dataforstan <- list() # create a list
eightschools_dataforstan$y <- as.integer(eightschools[,2]) # y value for te
eightschools_dataforstan$sigma <- as.integer(eightschools[,3]) # sigma for se
eightschools_dataforstan$J <- length(eightschools[,2]) # length of vector

# school level effects
stanc("eightschools_notpooled.stan")
eightschools_fit1 <- stan(file = "eightschools_notpooled.stan", data = eightschools_dataforstan, chains = 4, iter = 50)
traceplot(eightschools_fit1)
print(eightschools_fit1)

eightschools_fit1_extract <- extract(eightschools_fit1)
names(eightschools_fit1_extract)

dim(eightschools_fit1_extract$theta)

eightschools_fit1_theta <- list()

png("eightschools_fit1_theta.png", width = 1500, height = 800, pointsize = 25)
par(mfrow=c(2,4))
for (i in 1:8) {
  hist(eightschools_fit1_extract$theta[,i], col = "grey", main = paste("Theta",i), xlab = "Theta")
  abline(v=mean(eightschools_fit1_extract$theta[,i]), col = "red", lwd = 3)
}
dev.off()
# complete pooling
# partial pooling
# hierarchical

##########################
### PARAMETER RECOVERY ###
##########################

# generate 1000 independent variables from the poission distribution
# with paramter lambda=7. generate 1000 independent variables from
# the normal distribution with mean 0 and standard deviation 1. 
# specify the following model: y = 0.3 + 0.8*x1 + 12*x2 + e where
# e ~ uniform(0,1). Recover the parameters.

#################################
### LINEAR REGRESSION EXAMPLE ###
#################################

# read in the cornwell rupert data.
# extract from stan

# visualize the distributions of the parameters by looping through and
# creating histograms.

# you can run a least squares regression using R's default lm() function.
# to compare your results. Note that your parameter estimates won't be
# identical since Stan is running a stochastic algorithm.

#######################################
### HIERARCHICAL REGRESSION EXAMPLE ###
#######################################

# split the cornwell and rupert data according to gender. specify separate
# models but apply a prior that controlls the degree of pooling. 

###################################
### LOGISTIC REGRESSION EXAMPLE ###
###################################

# read in credit card data.

###########################
### TIME SERIES EXAMPLE ###
###########################

# read in the longley data.
