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

