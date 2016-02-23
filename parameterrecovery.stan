data {
	int<lower=0> J;
	int<lower=0> K;
	vector[J] y;
	matrix[J,K] X;
}
parameters {
	real alpha;
	vector[K] beta;
	real<lower=0> sigma;
}
model {
	y ~ normal(alpha + X*beta, sigma);
}