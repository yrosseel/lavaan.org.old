## ----echo=FALSE, message=FALSE------------------------------------------------
library(lavaan)


## ----tidy=FALSE, comment=""---------------------------------------------------
model <- ' i =~ 1*t1 + 1*t2 + 1*t3 + 1*t4
           s =~ 0*t1 + 1*t2 + 2*t3 + 3*t4 '
fit <- growth(model, data=Demo.growth)
summary(fit)


## ----growth, echo=FALSE, message=FALSE, dev=c("png","pdf"), dpi=c(100,100), fig.cap="A growth curve examples", warning=FALSE----
library(semPlot)
# a linear growth model with a time-varying covariate
model <- '
  # intercept and slope with fixed coefficients
    i =~ 1*t1 + 1*t2 + 1*t3 + 1*t4
    s =~ 0*t1 + 1*t2 + 2*t3 + 3*t4
  # regressions
    i ~ x1 + x2
    s ~ x1 + x2
  # time-varying covariates
    t1 ~ c1
    t2 ~ c2
    t3 ~ c3
    t4 ~ c4
'
fit <- growth(model, data=Demo.growth)

L <- matrix(
  c('t1','t2','t3','t4',NA,NA,
    NA,NA,NA,NA,'i','s',
    'c1','c2','c3','c4','x1','x2'), 3,,byrow=TRUE)

semPaths(fit, layout=L, rotation=3,
exoVar=FALSE,
exoCov=FALSE,
intercepts=FALSE,
nCharNodes=0, mar=c(3,3,3,3),
border.width=1.0, esize=1.0, edge.color="black",
label.scale=FALSE,
label.cex=1.0,
residuals=FALSE,
fixedStyle=2,
freeStyle=1,
curvePivot=FALSE,
sizeMan=7, sizeLat=10)


## ----eval=FALSE, tidy=FALSE---------------------------------------------------
## # a linear growth model with a time-varying covariate
## model <- '
##   # intercept and slope with fixed coefficients
##     i =~ 1*t1 + 1*t2 + 1*t3 + 1*t4
##     s =~ 0*t1 + 1*t2 + 2*t3 + 3*t4
##   # regressions
##     i ~ x1 + x2
##     s ~ x1 + x2
##   # time-varying covariates
##     t1 ~ c1
##     t2 ~ c2
##     t3 ~ c3
##     t4 ~ c4
## '
## fit <- growth(model, data = Demo.growth)
## summary(fit)

