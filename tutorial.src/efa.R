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

