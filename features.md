---
layout: default
title: lavaan features
published: true
submenu: lavaan
---

#### lavaan is reliable, open and extensible ####

- by default, lavaan implements the textbook/paper formulas, so there are no
surprises

- lavaan can mimic the results of several commercial packages (including Mplus
and Eqs using the `mimic="Mplus"` or `mimic="EQS"`
arguments)

- lavaan is not a black box: you can browse the source code on [GitHub](https://github.com/yrosseel/lavaan/)

- lavaan can be extended: see the [Related Projects](/resources/related.html)
page for extensions and add-ons.

#### lavaan is easy and intuitive to use ####

- the 'lavaan model syntax' allows users to express their models in a compact,
elegant and useR-friendly way; for example, a typical CFA analysis looks
as follows:

    ```r
    library(lavaan)
    myData <- read.cv("/path/to/mydata/myData.csv")
    myModel <- ' 
        f1 =~ item1 + item2 + item3
        f2 =~ item4 + item5 + item6
        f3 =~ item7 + item8 + item9
    '
    fit <- cfa(model=myModel, data=myData)
    summary(fit, fit.measures=TRUE)
    ```

- you can choose between a user-friendly interface (in combination with the
fitting functions `cfa()`, `sem()`, `growth()`) or a low-level interface (using
the fitting function `lavaan()` where 'defaults' do not get in the way)

- convenient arguments (eg. `group.equal="loadings"`) simplify many common tasks
(eg. measurement invariance testing)

- lavaan outputs all the information you need: a huge number of fit measures,
modification indices, R-squared values, standardized solutions, and much much
more

#### lavaan provides many advanced options ####

- full support for meanstructures and multiple groups

- several estimators are available: ML (and robust variants MLM, MLMV, MLR),
GLS, WLS (and robust variants DWLS, WLSM, WLSMV), ULS (ULSM, ULMV) and
  pairwise ML (PML)

- standard errors: standard, robust, huber-white, bootstrap

- test statistics: standard, Satorra-Bentler, Yuan-Bentler, Satterthwaite,
scale-shifted, Bollen-Stine bootstrap

- missing data: FIML estimation

- linear and nonlinear equality and inequality constraints

- full support for analyzing **categorical data**: lavaan (from version 0.5 onwards) can handle any mixture of binary, ordinal
and continuous observed variables
