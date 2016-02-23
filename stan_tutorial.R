setwd("/Users/imad/Dropbox/Stan Workshop")
list.files()
library(rstan)

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

# specify a list of the data to run in stan.
eightschoolsdata <- list()
eightschoolsdata$J <- dim(eightschools)[1]
eightschoolsdata$y <- eightschools$te
eightschoolsdata$sigma <- eightschools$sd

# school level effects
stanc("eightschoolsmodel1.stan")
model1 <- stan("eightschoolsmodel1.stan", data = eightschoolsdata, chains = 4, iter = 1000)
traceplot(model1)

# complete pooling
stanc("eightschoolsmodel2.stan")
model2 <- stan("eightschoolsmodel2.stan", data = eightschoolsdata, chains = 4, iter = 1000)

# partial pooling
stanc("eightschoolsmodel3.stan")
model3 <- stan("eightschoolsmodel3.stan", data = eightschoolsdata, chains = 4, iter = 1000)
print(model3)

# hierarchical
stanc("eightschoolsmodel4.stan")
model4 <- stan("eightschoolsmodel4.stan", data = eightschoolsdata, chains = 4, iter = 1000)
print(model4)
traceplot(model4)

##########################
### PARAMETER RECOVERY ###
##########################

parameterrecoverydata <- list()
parameterrecoverydata$X <- cbind(rpois(100,7),rnorm(100))
parameterrecoverydata$y <- 0.8 + 0.3*parameterrecoverydata$X[,1] + 12*parameterrecoverydata$X[,2] + runif(100)
parameterrecoverydata$J <- dim(parameterrecoverydata$X)[1]
parameterrecoverydata$K <- dim(parameterrecoverydata$X)[2]

stanc("parameterrecovery.stan")
pr_m1 <- stan(file = "parameterrecovery.stan", data = parameterrecoverydata, chains = 4, iter = 1000)
traceplot(pr_m1)
print(pr_m1)

#################################
### LINEAR REGRESSION EXAMPLE ###
#################################

# read in the data. the data comes from Green's Econometric Analysis.
cornwellrupert <- read.csv(file = "cornwellrupert.csv", header = TRUE)

crdata <- list()
crdata$y <- cornwellrupert[,c("LWAGE")]
crdata$X <- cornwellrupert[,c("EXP","FEM","MS")]
crdata$K <- dim(crdata$X)[2]
crdata$J <- dim(crdata$X)[1]

stanc("crmodel1.stan")
cr_m1 <- stan(file = "crmodel1.stan", data = crdata, chains = 4, iter = 1000)
traceplot(cr_m1)
print(cr_m1)

# extract

cr_m1_extract <- extract(cr_m1)
names(cr_m1_extract)

cr_m1_extract$alpha <- cr_m1_extract$alpha
cr_m1_extract$beta <- cr_m1_extract$beta
cr_m1_extract$sigma <- cr_m1_extract$sigma

cr_plotdata <- list()

cr_plotdata$alpha$mean <- mean(cr_m1_extract$alpha)
cr_plotdata$alpha$sd <- sd(cr_m1_extract$alpha)
cr_plotdata$sigma$mean <- mean(cr_m1_extract$sigma)
cr_plotdata$sigma$sd <- sd(cr_m1_extract$sigma)

for (i in 1:dim(cr_m1_extract$beta)[2]) {
  index <- paste0("beta",i)
  cr_plotdata[[index]]$mean <- mean(cr_m1_extract$beta[,i])
  cr_plotdata[[index]]$sd <- sd(cr_m1_extract$beta[,i])
}

# visualize the distributions of the parameters by looping through and
# creating histograms.

png("cr_m1_hist.png", width = 500, height = 800)
par(mfrow=c(2,2))
for (i in cr_m1_extract) {
  hist(item, col = "grey")
}

###################################
### LOGISTIC REGRESSION EXAMPLE ###
###################################

# read in credit card data
creditdata <- read.csv(file = "creditcard.csv", header = TRUE)

cdata <- list()
cdata$y <- creditdata[,"ACC"]
cdata$X <- creditdata[,c("AGE","INCOME")]
cdata$J <- dim(cdata$X)[1]
cdata$K <- dim(cdata$X)[2]

stanc("ccmodel1.stan")

c_m1 <- stan(file = "ccmodel1.stan", data = cdata, chains = 4, iter = 1000)
traceplot(c_m1)
print(c_m1)

###########################
### TIME SERIES EXAMPLE ###
###########################

longleydata <- read.csv("longley.csv", header = TRUE)

ldata <- list()
ldata$y <- longleydata[,"EMPLOY"]
ldata$x <- longleydata[,"ARMED"]
ldata$N <- length(ldata$y)

stanc("longley_model1.stan")

longley_m1 <- stan(file = "longley_model1.stan", data = ldata, chains = 4, iter = 1000)
traceplot(longley_m1)
print(longley_m1)

################################################
### HIERARCHICAL REGRESSION MODELING EXAMPLE ###
################################################

cornwellrupert <- read.csv(file = "cornwellrupert.csv", header = TRUE)
test <- data.frame(cornwellrupert[which(cornwellrupert$SOUTH==0),])
crhdata <- list()
crhdata$y <- list(y1=cornwellrupert[which(cornwellrupert$SOUTH==0),"LWAGE"], y2=cornwellrupert[which(cornwellrupert$SOUTH==1),"LWAGE"])
crhdata$X <- list(X1=cornwellrupert[which(cornwellrupert$SOUTH==0),c("MS","FEM","EXP","ED")], X2=cornwellrupert[which(cornwellrupert$SOUTH==1),c("MS","FEM","EXP","ED")])
crhdata$J <- list(dim(crhdata$X$X1)[1], dim(crhdata$X$X2)[1])
crhdata$K <- list(dim(crhdata$X$X1)[2], dim(crhdata$X$X2)[2])

cr_m1 <- stan()

# baltagi

baltagidata$COUNTRYINDEX <- c(baltagidata$COUNTRY)
index <- unique(baltagidata$COUNTRYINDEX)
bdata <- list()
for (i in 1:length(index)) {
  name_y <- paste0("y",i)
  bdata$y[[name_y]] <- baltagidata[which(baltagidata$COUNTRYINDEX==i), "LGASPCAR"]
  name_x <- paste0("X",i)
  bdata$X[[name_x]] <- baltagidata[which(baltagidata$COUNTRYINDEX==i), c("LINCOMEP","LRPMG","LCARPCAP")]
}
bdata$J <- dim(bdata$X$X1)[1]
bdata$K <- dim(bdata$X$X1)[2]
bdata$D <- length(index)

gasdata <- list()
gasdata$y <- array(bdata$y, length(index))
gasdata$X <- array(bdata$X, length(index))
gasdata$J <- dim(bdata$X$X1)[1]
gasdata$K <- dim(bdata$X$X1)[2]
gasdata$D <- length(index)

gasdata$y <- array(NA_real_, dim = c(1,19,18))
for(i in 1:18) {
  gasdata$y[,,i] <- baltagidata[which(baltagidata$COUNTRYINDEX==i), "LGASPCAR"]
}
stanc("baltagi_model1.stan")
stan(file = "baltagi_model1.stan", data = bdata, chains = 4, iter = 100)


