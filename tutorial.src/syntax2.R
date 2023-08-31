## ----echo=FALSE, message=FALSE------------------------------------------------
library(lavaan)


## ----eval=FALSE, tidy=FALSE---------------------------------------------------
## HS.model <- ' visual  =~ x1 + x2 + x3
##               textual =~ x4 + x5 + x6
##               speed   =~ x7 + x8 + x9 '
## 
## fit.HS.ortho <- cfa(HS.model,
##                     data = HolzingerSwineford1939,
##                     orthogonal = TRUE)


## ----eval=FALSE, tidy=FALSE---------------------------------------------------
## HS.model <- ' visual  =~ x1 + x2 + x3
##               textual =~ x4 + x5 + x6
##               speed   =~ x7 + x8 + x9 '
## 
## fit <- cfa(HS.model,
##            data = HolzingerSwineford1939,
##            std.lv = TRUE)


## ----tidy=FALSE, comment=""---------------------------------------------------
model <- '
  # latent variable definitions
    ind60 =~ x1 + x2 + x3
    dem60 =~ y1 + y2 + y3 + y4
    dem65 =~ y5 + y6 + y7 + y8
  # regressions
    dem60 ~ ind60
    dem65 ~ ind60 + dem60
  # residual (co)variances
    y1 ~~ y5
    y2 ~~ y4 + y6
    y3 ~~ y7
    y4 ~~ y8
    y6 ~~ y8
'

fit <- sem(model, 
           data = PoliticalDemocracy)

coef(fit)


## ----eval=FALSE, tidy=FALSE---------------------------------------------------
## model <- '
##   # latent variable definitions
##     ind60 =~ x1 + x2 + myLabel*x3
##     dem60 =~ y1 + y2 + y3 + y4
##     dem65 =~ y5 + y6 + y7 + y8
##   # regressions
##     dem60 ~ ind60
##     dem65 ~ ind60 + dem60
##   # residual (co)variances
##     y1 ~~ y5
##     y2 ~~ y4 + y6
##     y3 ~~ y7
##     y4 ~~ y8
##     y6 ~~ y8
## '


## ----comment="", tidy=FALSE---------------------------------------------------
set.seed(1234)
Data <- data.frame(y  = rnorm(100), 
                   x1 = rnorm(100), 
                   x2 = rnorm(100),
                   x3 = rnorm(100))
model <- ' y ~ b1*x1 + b2*x2 + b3*x3 '
fit <- sem(model, data = Data)
coef(fit)


## ----eval=FALSE, tidy=FALSE---------------------------------------------------
## model.constr <- ' # model with labeled parameters
##                     y ~ b1*x1 + b2*x2 + b3*x3
##                   # constraints
##                     b1 == (b2 + b3)^2
##                     b1 > exp(b2 + b3) '


## ----comment="", tidy=FALSE---------------------------------------------------
model.constr <- ' # model with labeled parameters
                    y ~ b1*x1 + b2*x2 + b3*x3
                  # constraints
                    b1 == (b2 + b3)^2
                    b1 > exp(b2 + b3) '
fit <- sem(model.constr, data = Data)
coef(fit)

