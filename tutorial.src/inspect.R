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

