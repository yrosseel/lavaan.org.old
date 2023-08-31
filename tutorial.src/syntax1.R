## ----eval=FALSE, tidy=FALSE---------------------------------------------------
## myModel <- ' # regressions
##              y1 + y2 ~ f1 + f2 + x1 + x2
##                   f1 ~ f2 + f3
##                   f2 ~ f3 + x1 + x2
## 
##              # latent variable definitions
##                f1 =~ y1 + y2 + y3
##                f2 =~ y4 + y5 + y6
##                f3 =~ y7 + y8 + y9 + y10
## 
##              # variances and covariances
##                y1 ~~ y1
##                y1 ~~ y2
##                f1 ~~ f2
## 
##              # intercepts
##                y1 ~ 1
##                f1 ~ 1
##            '


## ----eval=FALSE, tidy=FALSE---------------------------------------------------
## part1 <- '   # latent variable definitions
##                f1 =~ y1 + y2 + y3
##                f2 =~ y4 + y5 + y6
##                f3 =~ y7 + y8 + y9 + y10
##          '
## part2 <- '   # fix covariance between f1 and f2 to zero
##                f1 ~~ 0*f2
##          '


## ----eval=FALSE, tidy=FALSE---------------------------------------------------
## fit <- cfa(model = c(part1, part2), data = myData)

