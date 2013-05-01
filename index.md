---
layout: default
title: Welcome to lavaan.org
published: true
submenu: lavaan
---

#### News: ####

- **26 April 2013**: the lavaan.org website has been redesigned
- **8 March 2013**: version 0.5-12 has been released on CRAN.
  This is a maintenance release, fixing some small issues only.

####  What is lavaan? ####
The lavaan package is developed to provide useRs, researchers and teachers a
free open-source, but commercial-quality package for latent variable modeling.
You can use lavaan to estimate a large variety of multivariate statistical
models, including path analysis, confirmatory factor analysis, structural
equation modeling and growth curve models.

The official reference to the lavaan package is the following paper:

> Yves Rosseel (2012). lavaan: An R Package for Structural Equation Modeling. 
> *Journal of Statistical Software*, 48(2), 1-36. 
> URL [http://www.jstatsoft.org/v48/i02/](http://www.jstatsoft.org/v48/i02/)


#### First impression ####
To get a first impression of how lavaan works in practice, consider the
following example of a SEM model. The figure below contains
a graphical representation of the model that we want to fit. 

![lavaan example](/tutorial/figure/sem.png)

This is the corresponding R code to fit this model using the lavaan package:

```r
model <- '
   # latent variables
     ind60 =~ x1 + x2 + x3
     dem60 =~ y1 + y2 + y3 + y4
     dem65 =~ y5 + y6 + y7 + y8
   # regressions
     dem60 ~ ind60
     dem65 ~ ind60 + dem60
   # residual covariances
     y1 ~~ y5
     y2 ~~ y4 + y6
     y3 ~~ y7
     y4 ~~ y8
     y6 ~~ y8
'
fit <- sem(model, 
           data=PoliticalDemocracy)
summary(fit)
```
