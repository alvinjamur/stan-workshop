# Eight Schools Not Pooled Model (i.e. School Effects)
data { 
	int<lower=0> J; 	// dimensions of data
	vector[J] y; 		// te vector
	vector[J] sigma; 	// se vector
	# real y[J]; 		// array instead of vector
	# real sigma[J]; 	// array instead of vector
}
parameters {
	vector[J] theta; // treating each school individually
	real mu;
	real tau;
}
model {
	y ~ normal(theta, sigma);
	theta ~ normal(mu, tau);
}