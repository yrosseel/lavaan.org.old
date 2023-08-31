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

