## ----eval=FALSE---------------------------------------------------------------
## install.packages("lavaan", dependencies = TRUE)


## ----eval=TRUE, comment=""----------------------------------------------------
library(lavaan)

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

## ----echo=FALSE, message=FALSE------------------------------------------------
library(lavaan)
library(semPlot)
HS.model <- ' visual  =~ x1 + x2 + x3
              textual =~ x4 + x5 + x6
              speed   =~ x7 + x8 + x9 '
fit <- cfa(HS.model, data = HolzingerSwineford1939)

## ----cfa, echo=FALSE, dev=c('png','pdf'), dpi=c(100,100), fig.cap="A 3 factor CFA example"----
semPaths(fit, layout="tree", curve=1, rotation=4, 
nCharNodes=0, mar=c(3,20,3,20), 
border.width=1.0, esize=1.0, edge.color="black", 
label.scale=FALSE,
label.cex=1.0,
residuals=FALSE,
fixedStyle=1,
freeStyle=1,
curvePivot=FALSE,
sizeMan=7, sizeLat=10)


## ----eval=FALSE, tidy=FALSE---------------------------------------------------
## HS.model <- ' visual  =~ x1 + x2 + x3
##               textual =~ x4 + x5 + x6
##               speed   =~ x7 + x8 + x9 '


## -----------------------------------------------------------------------------
fit <- cfa(HS.model, data = HolzingerSwineford1939)


## ---- eval=FALSE--------------------------------------------------------------
## summary(fit, fit.measures = TRUE)


## ---- echo=FALSE, comment=""--------------------------------------------------
summary(fit, fit.measures = TRUE)


## ----eval=FALSE, tidy=FALSE---------------------------------------------------
## # load the lavaan package (only needed once per session)
## library(lavaan)
## 
## # specify the model
## HS.model <- ' visual  =~ x1 + x2 + x3
##               textual =~ x4 + x5 + x6
##               speed   =~ x7 + x8 + x9 '
## 
## # fit the model
## fit <- cfa(HS.model, data = HolzingerSwineford1939)
## 
## # display summary output
## summary(fit, fit.measures = TRUE)

## ----sem, echo=FALSE, message=FALSE, dev=c("png","pdf"), dpi=c(100,100), fig.cap="Political Democracy SEM example", fig.keep="last"----
library(lavaan) # only needed once per session
library(semPlot)
library(qgraph)
model <- '
  # measurement model
    ind60 =~ x1 + x2 + x3
    dem60 =~ y1 + y2 + y3 + y4
    dem65 =~ y5 + y6 + y7 + y8
  # regressions
    dem60 ~ ind60
    dem65 ~ ind60 + dem60
  # residual correlations
    y1 ~~ y5
    y2 ~~ y4 + y6
    y3 ~~ y7
    y4 ~~ y8
    y6 ~~ y8
'
fit <- sem(model, data=PoliticalDemocracy)
Graph <- semPaths(fit,
#layout=L, 
layout="tree2",
nCharNodes=0,
curve=1,
rotation=4,
#mar=c(3,3,3,3),
edge.color="black",
border.width=1.0, esize=1.0,
label.scale=FALSE,
label.cex=1.0,
residuals=FALSE,
fixedStyle=1,
freeStyle=1,
curvePivot=FALSE,
#style="LISREL",
exoVar=FALSE,
sizeMan=7,
sizeLat=10,
DoNotPlot=FALSE
)

L <- matrix(c(
  0.4 ,   1 ,
  0.7 ,   1 ,
  1.0 ,   1 ,
 -1.0 ,   1 ,
 -1.0 ,   0.71 ,
 -1.0 ,   0.43 ,
 -1.0 ,   0.14 ,
 -1.0 ,  -0.14 ,
 -1.0 ,  -0.43 ,
 -1.0 ,  -0.71 ,
 -1.0 ,  -1    ,
  0.7 ,   0.4 ,
  0.0 ,   0.4 ,
  0.0 ,  -0.4
), 14,2, byrow=TRUE)

qgraph(Graph, layout=L, arrowAngle=0.5)


## ----eval=FALSE, tidy=FALSE---------------------------------------------------
## model <- '
##   # measurement model
##     ind60 =~ x1 + x2 + x3
##     dem60 =~ y1 + y2 + y3 + y4
##     dem65 =~ y5 + y6 + y7 + y8
##   # regressions
##     dem60 ~ ind60
##     dem65 ~ ind60 + dem60
##   # residual correlations
##     y1 ~~ y5
##     y2 ~~ y4 + y6
##     y3 ~~ y7
##     y4 ~~ y8
##     y6 ~~ y8
## '


## ----eval=FALSE, tidy=FALSE---------------------------------------------------
## model <- '
##   # measurement model
##     ind60 =~ x1 + x2 + x3
##     dem60 =~ y1 + y2 + y3 + y4
##     dem65 =~ y5 + y6 + y7 + y8
##   # regressions
##     dem60 ~ ind60
##     dem65 ~ ind60 + dem60
##   # residual correlations
##     y1 ~~ y5
##     y2 ~~ y4 + y6
##     y3 ~~ y7
##     y4 ~~ y8
##     y6 ~~ y8
## '


## ---- comment=""--------------------------------------------------------------
fit <- sem(model, data = PoliticalDemocracy)
summary(fit, standardized = TRUE)


## ----eval=FALSE, tidy=FALSE---------------------------------------------------
## library(lavaan) # only needed once per session
## model <- '
##   # measurement model
##     ind60 =~ x1 + x2 + x3
##     dem60 =~ y1 + y2 + y3 + y4
##     dem65 =~ y5 + y6 + y7 + y8
##   # regressions
##     dem60 ~ ind60
##     dem65 ~ ind60 + dem60
##   # residual correlations
##     y1 ~~ y5
##     y2 ~~ y4 + y6
##     y3 ~~ y7
##     y4 ~~ y8
##     y6 ~~ y8
## '
## fit <- sem(model, data=PoliticalDemocracy)
## summary(fit, standardized=TRUE)

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

## ----echo=FALSE, message=FALSE------------------------------------------------
library(lavaan)
HS.model <- ' visual  =~ x1 + x2 + x3
              textual =~ x4 + x5 + x6
              speed   =~ x7 + x8 + x9 '


## ----tidy=FALSE, comment=""---------------------------------------------------
fit <- cfa(HS.model, 
           data = HolzingerSwineford1939, 
           meanstructure = TRUE)
summary(fit) 

## ----echo=FALSE, message=FALSE------------------------------------------------
library(lavaan)


## ----tidy=FALSE, comment=""---------------------------------------------------
HS.model <- ' visual  =~ x1 + x2 + x3
              textual =~ x4 + x5 + x6
              speed   =~ x7 + x8 + x9 '

fit <- cfa(HS.model, 
           data = HolzingerSwineford1939, 
           group = "school")

summary(fit)


## ----tidy=FALSE, comment=""---------------------------------------------------
HS.model <- ' visual  =~ x1 + 0.5*x2 + c(0.6, 0.8)*x3
              textual =~ x4 + start(c(1.2, 0.6))*x5 + c(a1, a2)*x6
              speed   =~ x7 + x8 + x9 '


## ----tidy=FALSE, comment=""---------------------------------------------------
fit <- cfa(HS.model, 
           data = HolzingerSwineford1939, 
           group = "school")
 summary(fit)


## ----tidy=FALSE, comment=""---------------------------------------------------
f =~ item1 + c(1,NA,1,1)*item2 + item3


## ----tidy=FALSE, eval=FALSE---------------------------------------------------
## HS.model <- ' visual  =~ x1 + x2 + c(v3,v3)*x3
##               textual =~ x4 + x5 + x6
##               speed   =~ x7 + x8 + x9 '


## ----tidy=FALSE, comment=""---------------------------------------------------
HS.model <- ' visual  =~ x1 + x2 + x3
              textual =~ x4 + x5 + x6
              speed   =~ x7 + x8 + x9 '
fit <- cfa(HS.model, 
           data = HolzingerSwineford1939, 
           group = "school",
           group.equal = c("loadings"))
summary(fit)


## ----eval=FALSE, tidy=FALSE---------------------------------------------------
## fit <- cfa(HS.model,
##            data = HolzingerSwineford1939,
##            group = "school",
##            group.equal = c("loadings", "intercepts"),
##            group.partial = c("visual=~x2", "x7~1"))


## ----eval = TRUE, tidy = FALSE, comment = ""----------------------------------
HS.model <- ' visual  =~ x1 + x2 + x3
              textual =~ x4 + x5 + x6
              speed   =~ x7 + x8 + x9 '

# configural invariance
fit1 <- cfa(HS.model, data = HolzingerSwineford1939, group = "school")

# weak invariance
fit2 <- cfa(HS.model, data = HolzingerSwineford1939, group = "school",
            group.equal = "loadings")

# strong invariance
fit3 <- cfa(HS.model, data = HolzingerSwineford1939, group = "school",
            group.equal = c("intercepts", "loadings"))

# model comparison tests
lavTestLRT(fit1, fit2, fit3)

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

## ----eval=FALSE, tidy=FALSE---------------------------------------------------
## Data[,c("item1",
##         "item2",
##         "item3",
##         "item4")] <-
##     lapply(Data[,c("item1",
##                    "item2",
##                    "item3",
##                    "item4")], ordered)


## ----eval=FALSE, tidy=FALSE---------------------------------------------------
## fit <- cfa(myModel, data = myData,
##            ordered = c("item1","item2",
##                        "item3","item4"))

## ----echo=FALSE, message=FALSE------------------------------------------------
library(lavaan)


## ----tidy=FALSE---------------------------------------------------------------
lower <- '
 11.834
  6.947   9.364
  6.819   5.091  12.532
  4.783   5.028   7.495   9.986
 -3.839  -3.889  -3.841  -3.625  9.610
-21.899 -18.831 -21.748 -18.775 35.522 450.288 '

wheaton.cov <- 
    getCov(lower, names = c("anomia67", "powerless67", 
                            "anomia71", "powerless71",
                            "education", "sei"))


## ----tidy=FALSE, comment=""---------------------------------------------------
# classic wheaton et al. model
wheaton.model <- '
  # latent variables
    ses     =~ education + sei
    alien67 =~ anomia67 + powerless67
    alien71 =~ anomia71 + powerless71
  # regressions
    alien71 ~ alien67 + ses
    alien67 ~ ses
  # correlated residuals
    anomia67 ~~ anomia71
    powerless67 ~~ powerless71
'
fit <- sem(wheaton.model, 
           sample.cov = wheaton.cov, 
           sample.nobs = 932)
summary(fit, standardized = TRUE)

## ----echo=FALSE, message=FALSE------------------------------------------------
library(lavaan)
HS.model <- ' visual =~ x1 + x2 + x3
              textual =~ x4 + x5 + x6
              speed   =~ x7 + x8 + x9 '


## ----comment="", tidy=FALSE---------------------------------------------------
fit <- cfa(HS.model, 
           data = HolzingerSwineford1939, 
           likelihood = "wishart")
fit


## ----eval=FALSE---------------------------------------------------------------
## ?lavOptions

## ----echo=FALSE, message=FALSE------------------------------------------------
library(lavaan)


## ----tidy=FALSE, comment=""---------------------------------------------------
set.seed(1234)
X <- rnorm(100)
M <- 0.5*X + rnorm(100)
Y <- 0.7*M + rnorm(100)
Data <- data.frame(X = X, Y = Y, M = M)
model <- ' # direct effect
             Y ~ c*X
           # mediator
             M ~ a*X
             Y ~ b*M
           # indirect effect (a*b)
             ab := a*b
           # total effect
             total := c + (a*b)
         '
fit <- sem(model, data = Data)
summary(fit)

## ----echo=FALSE, message=FALSE------------------------------------------------
library(lavaan)
HS.model <- ' visual  =~ x1 + x2 + x3
              textual =~ x4 + x5 + x6
              speed   =~ x7 + x8 + x9 '


## ----comment = ""-------------------------------------------------------------
fit <- cfa(HS.model,
           data = HolzingerSwineford1939)
modindices(fit, sort = TRUE, maximum.number = 5)


## ----comment="", tidy=FALSE---------------------------------------------------
fit <- cfa(HS.model, 
           data = HolzingerSwineford1939)
mi <- modindices(fit)
mi[mi$op == "=~",]

## ----echo=FALSE, message=FALSE------------------------------------------------
library(lavaan)
HS.model <- ' visual =~ x1 + x2 + x3
              textual =~ x4 + x5 + x6
              speed   =~ x7 + x8 + x9 '


## ----comment=""---------------------------------------------------------------
fit <- cfa(HS.model, data=HolzingerSwineford1939)
parameterEstimates(fit)


## ----comment=""---------------------------------------------------------------
fit <- cfa(HS.model, data = HolzingerSwineford1939)
fitted(fit)


## ----comment=""---------------------------------------------------------------
fit <- cfa(HS.model, data = HolzingerSwineford1939)
resid(fit)


## ----comment=""---------------------------------------------------------------
fit <- cfa(HS.model, data=HolzingerSwineford1939)
fitMeasures(fit)


## ----comment=""---------------------------------------------------------------
fit <- cfa(HS.model, data=HolzingerSwineford1939)
fitMeasures(fit, "cfi")


## ----comment=""---------------------------------------------------------------
fitMeasures(fit, c("cfi","rmsea","srmr"))


## ----comment=""---------------------------------------------------------------
fit <- cfa(HS.model, data=HolzingerSwineford1939)
lavInspect(fit)


## ----comment=""---------------------------------------------------------------
lavInspect(fit, what = "start")


## ----comment=""---------------------------------------------------------------
lavInspect(fit, what = "list")


## ----eval=FALSE, tidy=FALSE---------------------------------------------------
## ?lavInspect

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

## ----echo=FALSE, message=FALSE------------------------------------------------
library(lavaan)


## ----eval=TRUE, tidy=FALSE----------------------------------------------------
model <- '
    # efa block 1
    efa("efa1")*f1 + 
    efa("efa1")*f2 =~ x1 + x2 + x3 + x4 + x5 + x6

    # efa block 2
    efa("efa2")*f3 + 
    efa("efa2")*f4 =~ y1 + y2 + y3 + y4 + y5 + y6

    # cfa block
    f5 =~ z7 + z8 + z9
    f6 =~ z10 + z11 + z12

    # regressions
    f3 ~ f1 + f2
    f4 ~ f3
'


## ----eval=FALSE, tidy=FALSE---------------------------------------------------
## fit <- sem(model = model, data = myData, rotation = "geomin")


## ----eval=TRUE, tidy=FALSE----------------------------------------------------
ex5_25 <- read.table("http://statmodel.com/usersguide/chap5/ex5.25.dat")
names(ex5_25) = paste0("y",1:12)


## ----eval=TRUE, tidy=FALSE----------------------------------------------------
model <- '
    # efa block 
    efa("efa1")*f1 + 
    efa("efa1")*f2 =~ y1 + y2 + y3 + y4 + y5 + y6

    # cfa block
    f3 =~ y7 + y8 + y9
    f4 =~ y10 + y11 + y12

    # regressions
    f3 ~ f1 + f2
    f4 ~ f3
'


## ----eval=TRUE, tidy=FALSE, comment = ""--------------------------------------
fit <- sem(model = model, data = ex5_25, rotation = "geomin",
           # mimic Mplus
           information = "observed",
           rotation.args = list(rstarts = 30, row.weights = "none",
                                algorithm = "gpa", std.ov = TRUE,
                                geomin.epsilon = 0.0001))
summary(fit)


## ----eval=TRUE, tidy=FALSE, comment = ""--------------------------------------
efa.model <- '
    efa("efa")*f1 + 
    efa("efa")*f2 + 
    efa("efa")*f3 =~ x1 + x2 + x3 + x4 + x5 + x6 + x7 + x8 + x9
'
fit <- cfa(efa.model, data = HolzingerSwineford1939)
summary(fit, standardized = TRUE)


## ----eval=TRUE, tidy=FALSE, comment = ""--------------------------------------
var.names <- paste("x", 1:9, sep = "")
fit <- efa(data = HolzingerSwineford1939[,var.names], nfactors = 1:3)
summary(fit)

