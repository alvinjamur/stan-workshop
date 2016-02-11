# Stan for Econometrics

[Stan](http://mc-stan.org/) is a powerful probabilistic programming language that is useful for Bayesian inference. This is intended to be a "quick-start" guide for those who want to get familiar with Bayesian modeling in R's interface with Stan, known as RStan. It is not a replacement for the [Stan Reference Manual](http://mc-stan.org/documentation/) which is an unequivocally useful resource for using Stan.

The files here cover modeling the canonical Eight Schools data set, and also provides information on how to write least squares, logistic, and time series models in Stan. Also included is a brief example on parameter recovery.

* `r_basics.R` - useful for getting the fundamentals down in R so that you can start running Bayesian inference in Stan.
* `stan_tutorial.R` - code to import data, run the Stan files, and extract information from the fitted model.

NOTE: all files will be uploaded as of Thursday (02.10.16) evening.

## Eight Schools Example

The Eight Schools Data was an Educational Testing Service study to determine the effect of coaching on examination performance.
* School: school indicator
* TE: treatment effect
* SE: standard error of treatment effect

The models follow Daniel Lee's [slides](http://astrostatistics.psu.edu/su14/lectures/Daniel-Lee-Stan-2.pdf) and consist of no pooling, complete pooling, partially pooling, and hierarchical models.

## Parameter Recovery

Before running a model on actual data it is good to check and see whether your model is appropriately specified. One way to do this is to specify an arbitrary model and generate fake data from it. Then you can set up the appropriate model in Stan and run the data through it. If you cannot recover the original parameters then your model is not appropriately specified.

## Regression Examples

The data used in these examples comes from Green's [Econometric Analysis](http://pages.stern.nyu.edu/~wgreene/Text/econometricanalysis.htm). The user is referred to the textbook and the accompanying website for a better understanding regarding of the data.

### Least squares

This example uses the Cornwell and Rupert data labor market data on 595 individuals over 7 years.

#### Simple Hierarchical Least Squares

Using the same dataset above split the data according to gender and estimate separate models for each demographic. A prior can then be specified for the degree of pooling.  

### Logistic

This example uses the credit card data which contains information on a cross-section of 100 credit card applications and whether the application was denied or not.

### Time Series

This example looks at the Longley data which is a times series of 15 observations on various macroeconomic indicators.
