---
layout: default
title: lavaan features
published: true
submenu: lavaan
---

#### lavaan is reliable, open and extensible ####

- by default, lavaan implements the textbook/paper formulas, so there are no
surprises

- lavaan can mimic many results of several commercial packages (including Mplus
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
    myData <- read.csv("/path/to/mydata/myData.csv")
    myModel <- ' 
        f1 =~ item1 + item2 + item3
        f2 =~ item4 + item5 + item6
        f3 =~ item7 + item8 + item9
    '
    fit <- cfa(model = myModel, data = myData)
    summary(fit, fit.measures = TRUE)
    ```

- you can choose between a user-friendly interface in combination with the
fitting functions `cfa()` and `sem()` or a low-level interface using
the fitting function `lavaan()` where 'defaults' do not get in the way

- convenient arguments (eg. `group.equal="loadings"`) simplify many common tasks
(eg. measurement invariance testing)

- lavaan outputs all the information you need: a large number of fit measures,
modification indices, standardized solutions, and technical information that
is stored in a fitted lavaan object

#### lavaan provides many advanced options ####

- full support for meanstructures and multiple groups

- several estimators are available: ML (and robust variants MLM, MLMV, MLR),
GLS, WLS (and robust variants DWLS, WLSM, WLSMV), ULS (ULSM, ULMV), DLS, and
  pairwise ML (PML)

- standard errors: standard, robust/huber-white/sandwich, bootstrap

- test statistics: standard, Satorra-Bentler, Yuan-Bentler, Satterthwaite,
scaled-shifted, Bollen-Stine bootstrap

- missing data: FIML estimation

- linear and nonlinear equality and inequality constraints

- full support for analyzing **categorical data**: lavaan (from version 0.5 onwards) can handle any mixture of binary, ordinal
and continuous observed variables

- (from version 0.6 onwards): support for **multilevel level SEM**
