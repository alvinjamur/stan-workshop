data {
	int<lower=0> N;
	vector[N] y;
	vector[N] x;
}
parameters {
	real alpha;
	real beta;
	real gamma;
	real<lower=0> sigma;
}
model {
	for (n in 2:N) {
		y[n] ~ normal(alpha + beta*y[n-1] + gamma*x[n-1], sigma);
	}
}
