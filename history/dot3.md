---
layout: default
title: Version History
published: true
submenu: history
---

#### 0.3 series ####

##### Version 0.3-3 #####
- Released on CRAN: 19 Januari 2011
- only a fix for a missing link in the documentation

##### Version 0.3-1 #####

- Released on CRAN: 11 May 2010
- New features/changes for this version (compared to the older program semplus that was never released on CRAN):
  - name of the package has changed to 'lavaan'
  - 'ML.N' option is replaced by a 'mimic.Mplus' option
  - if do.fit=FALSE, a full summary (including standard errors) is now available
  - if a correlation matrix is supplied (instead of a covariance matrix), only a (big) warning is now spit out (instead of an error and stopping)
  - model syntax can now be specified as a string literal enclosed in single quotes
  - multiple values are now accepted within pre-multiplication commands when analyzing multiple groups
  - in a multiple group analysis, the sample moments can be provided using a list
  - using NA*x in a formula forces the corresponding parameter to be free
  - a new modifier 'label' can now be used to specify custom labels
  - added 'information' argument
  - if na.rm=FALSE and estimator="ML", full information ML (FIML) is used
- Known issues for this release:
  - MLM values are different in Mplus (but same as in EQS)
  - SRMR values are sometimes different in Mplus
  - EPCs for equality constraints are wrong
- Bugs/glitches discovered after the release:
  - If the data frame contained cases where all values were missing, this produced an error
  - In mimic models with a single covariate, the baseline chi-square test statistic was not computed correctly, and the standardized solution gave an error
  - If an observed or latent variance (for example x1 ~~ x1 ) was included in the model syntax without a starting value or a fixed value, the starting value was set to zero
  - lavaan could not handle some non-standard models; for example: latent variables where the indicators are a mixture of latent and observed variables; indicators that are also predictors in a regression
  - lavaan could not handle a model with latent variables and a dependent observed-only variable (for example y ~ f1 + f2 + f3 where f1, f2 and f3 are latent variables, but y is an observed variable)

