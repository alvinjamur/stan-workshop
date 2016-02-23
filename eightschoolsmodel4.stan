data {
	int<lower=0> J; // number of observations
	real y[J]; // treatment effect
	real<lower=0> sigma[J]; // standard error of treatement effect
}
parameters {
	real theta[J]; // individual school effect
	real mu; // overall (mean) school effect
	real<lower=0> tau; // variance between schools
}
model {
	y ~ normal(theta, sigma);
	theta ~ normal(mu, tau);
}