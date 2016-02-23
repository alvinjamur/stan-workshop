data {
	int<lower=0> J; // number of observations
	real y[J]; // treatment effect
	real<lower=0> sigma[J]; // standard error of treatement effect
}
parameters {
	real theta[J]; // individual school effect
	real mu; // overall (mean) school effect
}
model {
	y ~ normal(theta, sigma);
	mu ~ normal(theta, sigma);
}