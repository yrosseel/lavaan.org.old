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

