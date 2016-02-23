data {
	int<lower=0> J; // number of observations
	real y[J]; // treatment effect
	real<lower=0> sigma[J]; // standard error of treatement effect
}
parameters {
	real theta[J]; // school effect
}
model {
	y ~ normal(theta, sigma);
}