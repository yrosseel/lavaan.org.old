---
layout: default
title: Version History
published: true
submenu: history
---

#### 0.5 series ####


##### Version 0.5-23.1097 #####

- Released on CRAN: 24 February 2017
- New features and user-visible changes:
  - factor scores (computed by lavPredict()) are now complete, even
    if the items contain missing values
  - Bartlett factor scores now handle singular lambda and theta matrices
  - mplus2lavaan() function gains a run=FALSE argument (so it acts only
    as a syntax converter)
  - new function lavOptions() shows the default options used by the
    sem/cfa/lavaan functions; all these options are now described in a
    single man page (see ?lavOptions)
  - new functions semList(), cfaList() and lavaanList() allow for fitting
    the same model on multiple datasets
  - the (often many) warnings about empty cells in bivariate cells (when 
    categorical data is used) are now replaced by a single warning, and 
    lavInspect(fit, "zero.cell.tables") can be used to see these tables
- Known issues:
  - same as 0.5-19
- Bugs/glitches discovered after the release:
  - the commit number (1097) was not stripped from the version number
  - the fit measure rni.scaled was using the naive baseline values
    for chisq and df
  - when the model syntax contains only covariances (~~) (and perhaps
    intercepts), and some of the ~~ formulas correspond to values of
    the covariance matrix below the diagonal (instead of above), the
    order of the variable names in the final parameter table may be wrong; as
    a result, some of the variables in the extractor functions may be
    mislabeled; a symptom of this is that
    the output of lavNames(lavParseModelString(model.syntax)) is different
    from the output of lavNames(fit) (bug reported by Cory Costello)
  - lavTestLRT() with method = "satorra.bentler.2010" is broken, often
    resulting in negative values for the test statistic
  - scaled RMSEA value is wrong if mimic="EQS" and test="scaled.shifted" (but
    the confidence interval is still ok)

##### Version 0.5-22 #####

- Released on CRAN: 24 September 2016
- New features and user-visible changes:
  - (old) 'scaled' versions of CFI/TLI/RMSEA are again printed in the
    summary() output
  - the (new) robust versions of CFI/TLI/RMSEA are printed on separate
    lines
  - inspect/lavInspect/lavTech gains a "residuals" option, for printing raw
    residuals between observed and model-implied sample statistics
  - inspect/lavInspect/lavTech: options "sampstat",
    "implied", and "residuals" now consistently use the same names for
    the summary statistics (notably res.cov, res.int, res.slopes and res.th
    when conditional.x = TRUE)
- Known issues:
  - same as 0.5-19
- Bugs/glitches discovered after the release:
  - lavCor() with output="est" returns the unstandardized solution; therefore,
    when some variables were continuous, we got covariances instead of 
    correlations

##### Version 0.5-21 #####

- Released on CRAN: 7 September 2016
- New features and user-visible changes:
  - robust RMSEA and CFI values are now computed correctly, following
    Brosseau-Liard, P. E., Savalei, V., and Li, L. (2012), and
    Brosseau-Liard, P. E. and Savalei, V. (2014); in the output of
    fitMeasures(), the 'new' ones are called cfi.robust and rmsea.robust,
    while the 'old' ones are called cfi.scaled and rmsea.scaled
  - SRMR is now displayed in the summary(, fit.measures = TRUE) output in
    the categorical case
  - in the summary() output, a dot (.) is added in front of the names of
    endogenous intercepts, covariances and variances; this is mostly for
    teaching purposes, to distinguish between for example residual and plain
    variances; the '.' prefix was the least obtrusive way I could think of;
    feedback about this is welcome
  - the inspect/lavInspect() function will now always return a nested list
    in the multiple group setting
  - the inspect/lavInspect() function with the "free" argument will now
    show a header with equality constraints (if any)
  - GLS/WLS (and friends) now work when fixed.x = TRUE
  - a new argument conditional.x (TRUE/FALSE) can be used with all
    estimators (ML, GLS, (D)WLS)
  - a two-way interaction between observed variables can now be specified
    in the model syntax by using a colon, for example: y ~ x1 + x2 + x1:x2
    and a product term will be created automatically 
- Known issues:
  - same as 0.5-19
- Bugs/glitches discovered after the release:
  - the (new) robust CFI/TLI/RMSEA values as printed in the summary() output 
    of version 0.5-21 (only) are wrong if (and only if) the test statistic is 
    "mean.var.adjusted" or "scaled.shifted" (the latter is used when 
    estimator = "WLSMV", the default estimator in the categorical case)

##### Version 0.5-20 #####

- Released on CRAN: 7 November 2015
- New features and user-visible changes:
  - this is mainly a small maintenance release, to ease the forthcoming
    updates of a few packages (blavaan, lavaan.survey, semTools)
  - when the model is just a simple univariate regression, lavaan does no 
    longer use an analytic shortcut (therefore, estimation may take
    much longer, in particular in the presence of (in)equality constraints)
  - more options have been added to lavTech/lavInspect, and the man page
    has been updated
  - lavScores() and vcov() gain a new argument `remove.duplicated', which
    is set to TRUE in the case of lavScores() (but not vcov); for lavScores(),
    this restores the behavior of <= 0.5-17 when only simple equality 
    constraints are used in the model
- Known issues:
  - same as 0.5-19
- Bugs/glitches discovered after the release:
  - when NACOV is provided as an argument, and mimic="Mplus", lavaan 
    (wrongly) tries to 'fix' the G11 part of the NACOV matrix
  - the "?"-modifier (as shortcut for start()*) did not work in many 
    settings (eg multiple groups)
  - combination of arguments se="robust.sem" and information="observed" was
    allowed and gave an error
  - lavTestLRT(, method="satorra.2000") failed in the multiple group case
  - combination se="robust" and esetimator="ULS" did not work
  - if data was a tiblle, lavaan would fail
  - fabin.uni() fails when trying to invert a singular matrix
  - WLS.VD was NULL when WLS.V was user-specified
  - lavtable(,dim=1) gave wrong frequencies in the presence of empty cells
  - lavInspect(,"information.first.order") failed when the model was fitted
    without a meanstructure
  - modindices() failed if the information matrix is singular


##### Version 0.5-19 #####

- Released on CRAN: 3 October 2015
- New features and user-visible changes:
  - the parameter estimates section of the summary() output has been
    redesigned: the section headers are now repeated, and the number of 
    digits after the decimal point can be changed; eg. summary(fit, nd = 5)
  - the function modindices() will now only show modification indices for
    newly added parameters; to assess the impact of releasing equality
    constraints, use the function lavTestScore()
  - new function lavTestScore() allows for univariate and multivariate
    score tests (aka Lagrange Multiplier tests) for releasing (general)
    equality constraints
  - the output of parTable(fit) now fully reflects the changes
    described [here](http://lavaan.ugent.be/notes/lavaan_eq_constraints.pdf)
  - lavPredict() now consistently ignores the structural component; it 
    only computes values for latent variables and their indicators; if
    all variables are observed, the function simply returns the observed
    values
  - lavTestLRT() gives a warning if the restricted model contains 
    parameters that are free in the restricted model, but fixed in the 
    full model
- Known issues:
  - marginal ML limitations: same as 0.5-16, 0.5-17 and 0.5-18 (this will be
    addressed in 0.6)
  - lav_partable_df() does not take the equality constraints into account,
    and does not handle the setting where the number of variables differs
    among groups in a multiple group analysis (this will be
    addressed in 0.6)
- Bugs/glitches discovered after the release:
  - in ill-conditioned settings, with equality constraints, NA may appear
    among the standard errors; this turned out to be a numerical issue, 
    due to a rather conservative tolerance value when computing the 
    generalized inverse



##### Version 0.5-18 #####

- Released on CRAN: 4 April 2015
- New features and user-visible changes:
  - huge improvement in speed and stability when (many) linear equality
    constraints are used in the model; the details of the 
    changes are described [here](http://lavaan.ugent.be/notes/lavaan_eq_constraints.pdf)
  - new function lavPredict() to compute predicted values for latent 
    variables and observed variables
  - many low-level lav_matrix_* functions are now public
  - modindices() function has gained many filter options, 
    including a sort= argument
  - estimator = "PML" now provides a goodness-of-fit test (PLRT)
  - many new output options for the lavTech/lavInspect/inspect functions
- Known issues:
  - marginal ML limitations: same as 0.5-16 and 0.5-17 (this will be
    addressed in 0.6)
  - the modification indices do not reflect (yet) what happens if
    an equality constraint is released; a warning is given in this case
  - the parameter table still contains the 'unco' and 'eq.id' columns,
    although they are not used anymore (they will be removed in 0.5-19)
  - lav_partable_df() does not take the equality constraints into account
- Bugs/glitches discovered after the release:
  - lavTestLRT(,method = "sattora.2000") gives the wrong result if
    the restricted model contains parameters that are free in the 
    restricted model, but fixed in the full model; a typical example
    is when comparing the weak invariance versus the strong invariance
    model (the latent means are free in the strong invariance model)
  - the modifier c(NA,NA)* does not work (in a multiple group analysis)
  - labels for the augmented part in lavInspect(fit, "augmented.information")
    are missing, resulting in an error
  - the post-estimation checks sometimes produce a false warning that
    the model-implied covariance matrix of the latent variables is 
    non-positive definite (only when `dummy' (phantom) latent variables
    are involved in the model)
  - inspect(fit, "cov.lv") had label issues when formative latent 
    variables were involved

##### Version 0.5-17 #####

- Released on CRAN: 30 September 2014
- New features and user-visible changes:
  - this is mainly a maintenance release
  - two new functions: lavInspect() and lavTech() extend the familiar
    inspect() function (with more arguments); they now have a dedicated
    help page (see ?lavInspect)
  - for saturated models (df = 0), the p-value will always be 'NA' (instead
    of 1 or sometimes 0)
  - more low-level functions are now public: lav_partable_independence,
    lav_partable_unrestricted, lav_partable_npar, lav_partable_ndat,
    lav_partable_df, lav_func_gradient_complex, lav_func_gradient_simple,
    lav_func_jacobian_complex, lav_func_jacobian_simple
- Known issues:
  - marginal ML limitations: same as 0.5-16
  - modindices() does not work in models with both explictit equality 
    constraints (==), and label-based (or group.equal based) equality 
    constraints
  - resid(, "casewise") fails in the presence of exogenous covariates
- Bugs/glitches discovered after the release:
 - resid(,"obs") fails if the model contains exogenous covariates
 - parameterization="theta" does not work in a multiple group analysis if 
   there are exogenous covariates in the model
 - when a variable in the model syntax was called `label', this would
   confuse the syntax parser
 - modindices() did not (alwayw) work when estimator = "WLS"
 - pc_cor_TS (the function computing polychoric correlations) could fail 
   (integer overflow) in very large samples
 - std.all was wrong for covariances ("~~") where the lhs was a factor, while
   the rhs was a observed variable (and hence fixed.x = FALSE)
 - std.ov = TRUE fails when the model contains (exactly) one exogenous variable
 - standard errors of standardized parameters (as shown in the output of
   the standardizedSolution() function) are mostly wrong, because they do
   not take the sampling variability of the latent variables into account
 - lavTestLRT() does not warn (or throw an error) if the restricted model (H0)
   contains model parameters that are free in H0, but fixed in H1. A common
   example of this is in measurement invariance testing when testing for
   strong (versus weak) invariance (by default, the strong invariance model will   free up the latent means). In combination with SB.classic = FALSE, 
   the resulting test statistic is not correct (Note: 0.5-18 does not solve 
   this, but issues a warning when H0 contains such free parameters). In
   general, SB.classic = FALSE only works correctly when the free 
   parameters in H0 are a subset of the free parameters of H1.

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
 - simuldateData() failed (cov.x error) in the presence of exogenous
   covariates and if standardized = TRUE
 - free residual covariances between ordered endogenous variables are set to
   zero (post-estimation) under parameterization="delta" (the default)
 - anova(..., SB.classic = FALSE) complains about multiple actual arguments
 - modindices() fails when parameteriation = "theta"
 - summary(.., rsquare = TRUE) does not show the R-square values (while
   inspect(, "rsquare") works)

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

