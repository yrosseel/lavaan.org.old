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

