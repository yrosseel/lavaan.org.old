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

