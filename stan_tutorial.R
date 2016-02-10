
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
# school level effects
# complete pooling
# partial pooling
# hierarchical

##########################
### PARAMETER RECOVERY ###
##########################

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

###################################
### LOGISTIC REGRESSION EXAMPLE ###
###################################

# read in credit card data.

###########################
### TIME SERIES EXAMPLE ###
###########################

# read in the longley data.

################################################
### HIERARCHICAL REGRESSION MODELING EXAMPLE ###
################################################

# read in the baltagi data.
