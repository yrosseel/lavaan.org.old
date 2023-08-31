## ----echo=FALSE, message=FALSE------------------------------------------------
library(lavaan)


## ----eval=TRUE, tidy=FALSE----------------------------------------------------
model <- '
    level: 1
        fw =~ y1 + y2 + y3
        fw ~ x1 + x2 + x3
    level: 2
        fb =~ y1 + y2 + y3
        fb ~ w1 + w2
'


## ----eval=TRUE, tidy=FALSE----------------------------------------------------
fit <- sem(model = model, data = Demo.twolevel, cluster = "cluster")


## ----eval=TRUE, tidy=FALSE, comment = ""--------------------------------------
summary(fit)


## ----eval=TRUE, tidy=FALSE, comment = ""--------------------------------------
lavInspect(fit, "icc")


## ----eval=TRUE, tidy=FALSE, comment = ""--------------------------------------
lavInspect(fit, "h1")


## ----eval=FALSE, tidy=FALSE---------------------------------------------------
## model <- '
##     level: 1
##         fw =~ y1 + y2 + y3
##         fw ~ x1 + x2 + x3
##     level: 2
## '


## ----eval=FALSE, tidy=FALSE---------------------------------------------------
## model <- '
##     level: 1
##         fw =~ y1 + y2 + y3
##         fw ~ x1 + x2 + x3
##     level: 2
##         y1 ~~ y1 + y2 + y3
##         y2 ~~ y2 + y3
##         y3 ~~ y3
## '


## ----eval=FALSE, tidy=FALSE---------------------------------------------------
## fit <- sem(model = model, data = Demo.twolevel, cluster = "cluster",
##            verbose = TRUE, optim.method = "em")


## ----eval=FALSE, tidy=FALSE---------------------------------------------------
## fit <- sem(model = model, data = Demo.twolevel, cluster = "cluster",
##            verbose = TRUE, optim.method = "em", em.iter.max = 20000,
##            em.fx.tol = 1e-08, em.dx.tol = 1e-04)

