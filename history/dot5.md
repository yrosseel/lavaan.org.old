---
layout: default
title: Version History
published: true
submenu: history
---

#### 0.5 series ####

##### Version 0.5-16 #####

- Released on CRAN: 7 March 2014
- New features and user-visible changes:
  - parameterization="theta" is now available for categorical data
  - initial support for marginal maximum likelihood (estimator = "MML")
  - new function lavTestLRT() to compare nested models using LRT; the anova()
    function is now just a wrapper around this function
  - in both the anova() and lavTestLRT() function, SB.classic=TRUE is the
    default; to get the old behaviour, use SB.classic=FALSE
  - new function lavTestWald() allows for arbitrary Wald tests
  - new function lavCor() to compute polychoric/tetrachoric/... correlations
    directly from the data
  - fitMeasures() gains a new baseline.model argument to allow for user-defined
    baseline models
  - new group.w.free argument allows the group weights to be treated 
    as free parameters in a multiple group analysis
  - new functions lavTablesFitCf(), lavTablesFitCm(), lavTablesFitCp() provide
    three measures of fit for the PML method (contributed by Mariska Barendse)
  - SRMR is now identical to the Mplus value if information = "observed"; the
    WRMR is added to the output if mimic = "Mplus"
  - allow for zero iterations using control=list(optim.method="none") argument
- Known issues:
  - marginal ML limitations: only works if we have latent variables; 
    only probit metric; extremely slow (for now) if more than 2 dimensions; no 
    documentation yet; only Gauss-Hermite quadrature
- Bugs/glitches discovered after the release:
 - summary(fit, fit.measures=TRUE) gives error: object 'logl.H1' not found; this   can occur if the columns of the data.frame are of type 'matrix' (instead
   of numeric/integer/factor/ordered)
 - predict() with continuous observed variables fails in the presence of
   exogenous covariates
 - when we have both continuous and categorical (endogenous) variables,
   the latter with more than 2 response categories, the signs of the
   thresholds/means are reversed (although the estimates are accurate)
 - simulateData() with skewness/kurtosis argument(s) (ie using ValeMaurelli)
   sometimes resulted in wrong means for the observed variables, due to
   the scale() function which first centers, and then scales (while it should
   be the other way around). This has no effect on the covariance structure.
 - free residual covariances between ordered endogenous variables are set to
   zero (post-estimation) under parameterization="delta" (the default)

##### Version 0.5-15 #####

- Released on CRAN: 15 November 2013
- New features and user-visible changes:
  - this is mainly a maintenance release
  - lavTables() has been redesigned
  - zero.add and zero.keep.margins arguments control how lavaan deals 
    with missing values in bivariate frequency tables
  - PML estimator uses a different objective function and converges 
    (much) faster
  - inspect(fit, "covarage") and inspect(fit, "patterns") return information
    about missingness coverage and missing patterns respectively
- Known issues:
  - parameterization="theta" is not implemented yet
  - (marginal) ML estimation for categorical data is not implemented yet
- Bugs/glitches discovered after the release:
  - the shortcut 'item ~ 0' to fix an intercept to zero seems to be broken;
    workaround: use 'item ~ 0*1' instead
  - the polychoric correlation between two variables is computed wrongly if
    (and only if) the variables are binary and they happen to have exactly
    the same threshold (ie the marginal distributions are identical); the
    result is a fatal error (so it does not happen silently)
  - modindices did not work if explicit equality constraints 
    (using the "==" operator) were included in the model syntax
  - missing="pairwise" (if data are categorical) was also deleting cases with
    missing values in the exogenous covariates
  - if some cases have only missing values (and should be removed), 
    the exogenous covariate values (if any) were not removed
  - if a ";" was included after a comment ("#"), this confused the syntax parser

##### Version 0.5-14 #####

- Released on CRAN: 21 July 2013
- New features and user-visible changes:
  - lavTables(, dimension=1L) produces one-way tables
  - WLS(MV) estimator + categorical data now allows for missing data via
    the missing="pairwise" argument
  - predict() and bootstrapping now also work in the categorical case
  - relax check for non positive-definite theta and psi matrices: eigenvalues
    are allowed to be negative within a tolerance of .Machine$double.eps^(3/4)
  - resid() and residuals() gain type="casewise" argument to compute 
    (unstandardized) casewise residuals
  - inspect(fit, "data") now returns the raw data
- Known issues:
  - parameterization="theta" is not implemented yet
  - (marginal) ML estimation for categorical data is not implemented yet
- Bugs/glitches discovered after the release:
  - the (rarely used) ":" operator added an extra group
  - predict() and resid(, "casewise") fail in the presence of exogenous
    covariates
  - RMSEA is using N-g (instead of N) even if likelihood == "normal"
  - 0.5 was added to all bivariate frequency cell; for larger tables with
    many empty cells, this may distort the polychoric correlation in small
    samples
  - poor starting values (always 1) for factor loadings if only two indicators

##### Version 0.5-13 #####

- Released on CRAN: 11 May 2013
- New features and user-visible changes:
  - mplus2lavaan() (written by Michael Hallquist) is capable of reading (and
    fitting) models specified in an Mplus input file
  - new function lavExport() allows exporting a lavaan model to an external
    program (currently only Mplus)
  - new function lavTables() shows observed and expected frequencies for
    pairwise tables of categorical variables
  - new function lavMatrixRepresentation()
  - changes of function names: lavaanNames() becomes lavNames(), parseModelString(), becomes lavParseModelString(), lavaanify() becomes lavParTable() (but the
  old names are still valid)
  - scale check has been relaxed (but see bugs!)
  - standardized=TRUE in simulateData() now also applies to latent variables
- Bugs/glitches discovered after the release:
  - scale check should ignore exogenous variables, but instead, only includes
    exogenous variables (workaround: warn=FALSE)
  - simulateData() can not handle a parameter table as input (although the
    documentation claims it can)
  - user-specified 'ordered' variables with numeric 0 values were not (always)
    properly converted to integer codes (starting from 1)

##### Version 0.5-12 #####

- Released on CRAN: 8 March 2013
- New features and user-visible changes:
  - estfun.lavaan() or lavScores() function computes case-wise scores (first gradient) values
  - better starting values (using an instrumental variables approach) for factor loadings when indicators are categorical
  - full support for categorical variables in simulateData()
- Known issues:
  - factor scores, bootstrapping and theta parameterization are not yet implemented if data is categorical
- Bugs/glitches discovered after the release:
  - WLS with multiple groups with small (say, < 50) and unequal sample sizes often fails (non-convergence)
  - fitMeasures(fit, "npar") was not computed correctly if explicit equality constraints (using "==") were used in the model; this affects the computation of AIC and BIC in these cases

##### Version 0.5-11 #####

- Released on CRAN: 19 Dec 2012
- New features and user-visible changes:
  - estimator="PML" is now available if all data is categorical; this is based on work done by Myrsini Katsikatsou
  - simulateData() supports thresholds and creates ordinal data
  - inspect() gains 'WLS.V', 'NACOV', 'cov.lv', 'cor.lv', 'cov.all', and 'cor.all' arguments
  - fitMeasures() spits out many more fit indices: rmr, cn, nnfi, nfi, rfi, ifi, rni, gfi, agfi, pnfi, mfi, ecvi
  - new argument 'sample.cov.rescale' to control if the sample covariance must be internally rescaled (by a factor N-1/N) or not
- Known issues:
  - bootstrapping and theta parameterization are not yet implemented if data is categorical
- Bugs/glitches discovered after the release:
  - defined (:=) and constrained (<,>,==) parameters are not standardized if a standardized solution is requested
  - simulateData(): if intercepts are included in the script, and the skewness/kurtosis argument is used, the sign of the intercepts/means is switched
  - if sample.cov is provided, and estimator="WLS" (with a user-provided weight matrix), lavaan complains about the (new) sample.cov.rescale argument not set to a logical
  - if a parameter table is given to the 'start' argument, an error occurs
        in some extreme cases, the starting value for a polyserial correlation fell outside the [-1,1] range, causing an error
  - vnames(partable, type=lv.y/lv.x/ov.y) did not always respect the correct order of the variable names, leading to parameters that were inadvertently set to zero
  - consider the following model syntax: 'y ~ x; z ~~ y': here, y is upgraded to a phantom/dummy latent variable (in the LISREL representation), but z was not upgraded (while it should) if it was not involved in a regression formula

##### Version 0.5-10 #####

- Released on CRAN: 25 Okt 2012
- New features and user-visible changes:
  - modification indices, Rsquare now work if data is categorical
  - changed package mvtnorm to package mnormt, resulting in (slightly) faster
computations of the thresholds and polychoric correlations in some cases
  - predict() gains a newdata argument
  - a user-specified weight matrix can now be provided (using the WLS.V
argument) to be used in estimation when using estimator WLS and friends
  - a user-specified asymptotic variance matrix of the sample statistics can be
provided (using the NACOV argument) to be used when computing robust standard
errors and robust test statistics
  - if a model does not converge, lavaan will not attempt to compute standard errors and a test statistic
  - better handling of multibyte characters in summary() function
        better handling of empty cells in pairwise frequency tables
- Known issues:
  - bootstrapping and theta parameterization are not yet implemented if data is categorical
- Bugs/glitches discovered after the release:
  - if the model only contains a single variable, lavaan fails
  - if the model only contains a single categorical variable (eg a probit regression), lavaan fails
  - residual variances that are set to zero during estimation (eg residual variance of composite latent variable), are internally set to 1.0 again in the model matrices after model fitting; this only affects post-fitting operations using the model matrices directly (eg the predict() function)
   - resid(fit, type="standardized") fails if there are any exogenous variables in the model, and if estimator="MLM" or "MLR" is used
   - bootstrapping fails if missing="ml" and the model contains exogenous variables
   - in the categorical case, an internal function (muthen1984) can not handle variables that are of type integer (workaround: coerce them to type numeric)

##### Version 0.5-9 #####

- Released on CRAN: 8 Sept 2012
- New features and user-visible changes:
  - full support for ordinal (and binary) dependent variables using the three stage WLS approach as described in
  - Muthén (1984); this implies support for multiple groups (using the delta parameterization), support for a mixture of binary/ordinal/continuous (dependent) variables, and support for exogenous 'fixed.x' covariates
  - new test statistics: mean.var.adjusted (aka the Satterthwaite approach), and scaled.shifted (to mimic the behavior of Mplus 6 and higher)
  - new estimators: MLMV, ULS, ULSM, ULSMV, DWLS, WLSM, WLSMV
  - the 'se' option robust.mlm has been renamed to robust.sem, while robust.mlr has been renamed to robust.huber.white
  - better handling of standard errors if constraints have been used
  - new operator '|' in the syntax: 'u | t1 + t2 + t3' refers to the (three) thresholds of an ordinal variable u with four levels
  - 'u ~*~ u' refers to the scaling parameter (of the delta parameterization) of an ordinal variable u
        'y ~ 1 + x1 + x2' is now legal syntax
  - the convenience function 'measurementInvariance()' has been moved to another package (semTools)
- Known issues:
  - bootstrapping, modification indices, Rsquare and theta parameterization are not yet implemented (if data is categorical)
        some cases will run very slow (in fact slower than 0.5-8), due to the fact that new CRAN policies disallow using .Fortran calls to external packages (eg mvtnorm); therefore, the computation of probabilities under the bivariate standard normal distribution is not vectorized, and hence extremely slow
- Bugs/glitches discovered after the release:
  - if a two-way table contains zeroes, the computation of the polychoric correlation may fail with the message 'Error in if (rho == 0) { : missing value where TRUE/FALSE needed' (fixed in 0.5-10)
  - estimator="ULS" does not work if only sample statistics are provided
  - if the ordered= argument contains a single variable only, it fails
  - the anova() function may fail for scaled difference tests if the (full) M1 model contains parameters that are not listed in the parameterTable of (restricted) M0 model (workaround: use anova(fit1, fit2, SB.classic=TRUE)

