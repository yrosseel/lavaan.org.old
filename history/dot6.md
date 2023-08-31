---
layout: default
title: Version History
published: true
submenu: history
---

#### 0.6 series ####


##### Version 0.6-16 #####

- Released on CRAN: 19 July 2023
- New features and user-visible changes:
  - this is another maintenance release (mainly fixing some bootstrap issues)
  - the computation of robust rmsea/cfi values can be switched off (if the computations take forever); for example: ```fitMeasures(fit, fm.args = list(robust = FALSE))``` or ```summary(fit, fit.measures = TRUE, fm.args = list(robust = FALSE))```
  - sam() handling of zero diagonal elements in THETA is now identical to what is done in lavPredict()
  - sam() now uses bounds = "wide.zerovar" when fitting the measurement blocks
- Bugs/glitches discovered after the release: 
  - (just released)


##### Version 0.6-15 #####

- Released on CRAN: 14 March 2023
- New features and user-visible changes:
  - this is just a maintenance release
  - estimator = "js" (james-stein) and "jsa" (james-stein aggregated)
    for (simple) CFA model only.
- Bugs/glitches discovered after the release:
  - bootstrap + defined parameters + unsuccessful bootstrap runs produced NA values for the standard errors
  - bootstrap + fiml + fixed.x = FALSE resulted in (many) unsuccessful boostrap runs
  - sam(): when mm.list contains measurement blocks with multiple latent variables, the covariances between the latent variables were fixed to zero
  - sam(): equality constraints in the structural part were not handled correctly when computing the (two-step) standard errors
  - modification indices: some ~~ elements (between elements in ov.names.y and o.names.x) were not included in the table
  - nobs<2 failed for multiple groups when using sampling weights
  - categorical + clustered seemed to work (while the clustering was just ignored)
  - parameter names were missing in the output of boostrapLavaan() 
  - sampling.weights= argument was missing in lavCor()

##### Version 0.6-14 #####

- Released on CRAN: 9 Feb 2023
- New features and user-visible changes:
  - this is mostly a bug-fix release
  - a new argument ov.order= can be set to "model" (= the default) or "data";
    this determines if the internal order of the observed variable names 
    (as reflected in the output of lavNames()) are
    based on the model syntax or the data
  - add new tests: browne.residual.nt.model and browne.residual.adf.model
  - initial support (point estimates only) for some non-iterative estimators 
    for (simple) CFA models: estimator = "fabin2", "fabin3", "guttman1952", 
    "bentler1982"
  - robust RMSEA/CFI values in the categorical setting will result in NA 
    values if the input (polychoric/tetrachoric) matrix is not
    positive-definite (use fm.args = list(cat.check.pd = FALSE) to override)
  - lavCor() now accepts a logical TRUE/FALSE value for the ordered= argument
- Bugs/glitches discovered after the release:
  - see version 0.6-15

##### Version 0.6-13 #####

- Released on CRAN: 9 Jan 2023
- New features and user-visible changes:
  - a new function efa() allows for classic (single-group) explorary
    factor analysis
  - a new function lavPredictY() allows for the prediction of 'y' values
    based on 'x' values (see ?lavPredictY for a reference)
  - a new function lavTest() allows to extract (or compute) one or several
    test statistics based on an already fitted object
  - new test statistics: browne.residual.adf and browne.residual.nt
  - summary() and fitMeasures() gain an fm.args= argument, allowing to set
    options (e.g., rmsea.ci.level) related to fit measures
  - lavTestLRT() will now provide the RMSEA based on the difference test
  - robust CFI and RMSEA are now computed for more settings: when (all)
    data is categorical/ordered, when data is continuous but the estimator 
    is MLMV, and when missing = "ml"
    (based on work done by Victoria Savalei and colleagues)
  - new global option scaled.test= determines which test statistic will be 
    scaled (if multiple test statistics have been requested)
  - new option gamma.unbiased: if set TRUE, an unbiased version of the so-called
    Gamma matrix will be used, instead of the regular (biased) version. See 
    this [paper](https://doi.org/10.1080/10705511.2022.2063870)
  - iseed now works correctly in bootstrapLavaan() and related functions
    thanks to a patch provided by Shu Fai Cheung
  - bootstrapLavaan() now always returns all bootstrap runs (not just the
    converged ones); it also warns about non-admissible solutions
  - when bounds = "standard" or "wide", bounds are now also computed for
    covariances per default
  - the output of lavInspect() for "gamma", "wls.v", "wls.obs" and "wls.est" 
    now includes labels
  - the sam() function gains alpha.correction= argument to allow for small
    sample corrections
- Important bug fix:
  - in all lavaan versions < 0.6-13, there was on error in the computation
    of scaled (difference) test statistics if 1) a mean and variance 
    adjusted test was used (i.e., test = "scaled.shifted", or 
    test = "mean.var.adjusted"), 2) multiple groups were involved, and
    3) equality constraints (across groups) were involved. A typical setting
    are measurement invariance tests when data is categorical. 
    In those settings, the resulting test statistic was slightly off 
    (typically <5%). 
    Many thanks
    to Steffen Gronneberg, Njal Foldnes and Jonas Moss for reporting this.
- Bugs/glitches discovered after the release:
  - an error is produced when you have missing = "ml", a robust test 
    statistic, a model with exogenous covariates, fixed.x = TRUE (=the default),     and you request fit measures (quickfix: use fixed.x = FALSE) 
    (see github issue 261)
  - lavPredictY() did not work properly when newdata= was used, and 
    meanstructure = FALSE; in addition, the columns in the output could be
    in the wronger order if the order of ynames was different than the
    order of lavNames() (see github issue 259)
  - the NACOV and WLS.V matrices (if provided as arguments) naively assume
    that the internal order of the observed variables is the same as the order
    of the sample statistics (see github issue 260)

##### Version 0.6-12 #####

- Released on CRAN: 4 July 2022
- New features and user-visible changes:
  - twolevel SEM now also supports conditional.x = TRUE
  - out <- summary(fit) is now completely silent (i.e., nothing is printed);
    out contains a list with ingredients (github issue 193) 
  - parameterEstimates() gains boot.ci.type = "bca" (for the single-group
    setting only, for now)
  - syntax: allow for partial specifications of thresholds (github issue 215) 
  - lavaanify() gains a nthresholds= argument (see github issue 214) 
  - when bootstrapping is used, a warning is printed informing the user
     how many solutions were not admissible (see github issue 235)
- Bugs/glitches discovered after the release:
  - standardizedSolution() did not work if representation = "RAM"
  - iseed did not work properly in bootstrapLavaan() and other 
    bootstrap routines
  - the sam() function did not work (any longer) with categorical data
  - the scaled (difference) mean-and-variance adjusted test statistic is 
    wrong in the case of multiple groups involving equality constraints


##### Version 0.6-11 #####

- Released on CRAN: 31 March 2022
- New features and user-visible changes:
  - this is (again) only a maintenance release to prepare for R 4.2
  - new option ceq.simple; when set to TRUE, a more compact representation
    is used in the parameter table if only simple equality constraints are
    used; the default is FALSE (for now)
- Bugs/glitches discovered after the release:
  - ridge= option did not work properly
  - df counting bug when nlevels > 1L, ngroups > 1L and fixed.x = TRUE
  - EPC decisions were not based on the absolute value (pull request 231)
  - name clash between 'cl' argument and 'cluster' argument
  - interaction terms defined by a colon (a:b) were included in
    lavNames(,"ov.x") even if either a or b is a dependent variable
  - standardizedSolution() did not work if representation = "RAM"

##### Version 0.6-10 #####

- Released on CRAN: 25 January 2022
- New features and user-visible changes:
  - this is a maintenance release, with mostly minor changes under 
    the hood (the github issues >214 were not yet addressed in this release)
  - initial support for representation = "RAM"
  - better starting values for regression coefficients, when all variables
    are observed
  - sam(): an indicator can now also be a predictor in the structural part
  - estimator DLS: allow for non-positive Gamma, and allow sample.cov.rescale
    to be set by the user
  - new rotation criteria: bi-quartimin and bi-geomin
- Bugs/glitches discovered after the release:
  - if all data is missing for a pair of variables, the degrees of freedom
    should be adapted

##### Version 0.6-9 #####

- Released on CRAN: 27 June 2021
- New features and user-visible changes:
  - the sam() function is now public
  - initial support for multilevel + missing = "ml"; only for 
    estimator = "ML" (not "MLR")
  - if missing = "two-stage", h1.information is now always set to "unstructured"
  - group.w.free = TRUE now also works for DWLS/WLS/WLSMV estimators
- Bugs/glitches discovered after the release:
  - multilevel+missing="ml" did not work if there was only 1 variabele on the 
    within level
  - see github issues >214

##### Version 0.6-8 #####

- Released on CRAN: 10 March 2021
- New features and user-visible changes:
  - new estimator = "DLS" for distributionally-weighted
          least squares (see Du, H., & Bentler, P.M. (in press).
    Distributionally-weighted least squares in structural equation modeling. 
    Psychological Methods.)
  - new optimizer: optim = "GN" provides Gauss-Newton optimization
  - group.w.free = TRUE now also works in the categorical case
  - the information=, observed.information= and h1.information= arguments now
    accept a vector of two elements, eg information = c("observed", "expected");
    the first entry is used for the standard errors, while the second entry
    is used for the test statistic
  - new arguments omega.information=, omega.h1.information=, 
    omega.information.mean=, and omega.h1.information.meat= allow for even 
    more variants of various robust test statistics
  - test = "yuan.bentler" now always uses observed.information = "h1" 
    (if information is observed) and omega.h1.information = "unstructured" 
  - lavResiduals() has a new output = "table" argument
  - rotations.se = "bordered" per default (only used when rotation is used)
  - in a multiple group analysis, a single modifier is always recycled
    accross; this is now also true for labels (with a warning, unless
    group.equal= is used)
- Known issues:
  - same as 0.6-1
- Bugs/glitches discovered after the release:
  - standardizedSolution() did not show labels (if any)
  - lavResiduals() gave wrong results when the solution was rotated
  - lav_mvnorm_missing_h1.R sometimes failed to produce starting
    values (and stopped with an error)
  - a check to force the (co)variance matrix of standardized parameters to
    be positive definite was too strict (and is now omitted)
  - lavTestLRT + satorra2002 + A.method = "exact" did not work when equality
    constraints were involved (github issue 211)

##### Version 0.6-7 #####

- Released on CRAN: 31 July 2020
- New features and user-visible changes:
  - latent ~~ observed formulas are now supported; the observed variables
    are automatically upgraded to (single-indicator) latent variables
  - new option check.lv.names: when set to FALSE, lavaan proceeds even if
    it detects that some latent variable names occur in the dataset
  - optimization is made somewhat more robust: if a first attempt fails
    (no convergence) three additional attempts are made (with 
    optim.parscale= "standardize", with start = "simple", and with the
    combination optim.parscale = "standardized" and start = "simple")
  - the second argument of lavPredict() is now newdata (instead of type),
    to be consistend with predict()
- Known issues:
  - same as 0.6-1
- Bugs/glitches discovered after the release:
  - fitMeasures() did not longer work for estimator = "PML"
  - lavPredict + newdata + categorical did not work
  - lavCor() did not listen to the missing = "fiml" argument
  - lavPredict + Bartlett + missing: if all indicators
    of a factor are missing, the factor score was 0 (should be NA)
  - block syntax for groups was no longer working

##### Version 0.6-6 #####

- Released on CRAN: 13 May 2020
- New features and user-visible changes:
  - lavPredict() + se = TRUE now works correctly in the presence of
    missing data and missing = "fiml"
  - lavResiduals() + summary = TRUE now provides confidence intervals and
    better labelling
  - lavResiduals() + summary = TRUE now works for categorical data, but
    only in models without exogenous covariates (for now)
  - lavCor() gains cor.smooth= argument to force the correlation matrix 
    to be positive definite
  - sum(sampling.weights) no longer needs to equal the total sample size
  - sampling.weights can now be used in combination with categorical data
    and estimator WLSMV and friends
  - information/h1.information/observed.information arguments now accept
    a vector of two elements: the first one is for the standard errors, the
    second for the test statistic
  - the data (provided by the data= argument) is now always converted to
    a data.frame (in case it is a tibble, or another class that inherits
    from data.frame)
  - experimental feature: when the sample size is (very) small, adding the
    argument bounds = TRUE may stabilize estimation, by automatically 
    choosing upper and lower bounds for several sets of model parameters
- Known issues:
  - same as 0.6-1
- Bugs/glitches discovered after the release:
  - lavPredict + method="Bartlett" + fsm=TRUE failed
  - lavPredict + newdata failed if newdata contained a single observation
  - parallel= option did not work in boostrapLavaan()
  - standardizedSolution + type = "std.lv" failed
  - missing = "ml" (or "fiml") + sampling.weights failed
  - lavaan:::fsr() failed, unless missing = "listwise" was given explicitly

##### Version 0.6-5 #####

- Released on CRAN: 28 Aug 2019
- New features and user-visible changes:
  - a new option `effect.coding' can be used to scale the latent variables;
    a typical use is effect.coding = "loadings", or 
    effect.coding = c("loadings", "intercepts"); if "loadings" is included,
    equality constraints are used so that the average of the factor
    loadings (per latent variable) equals 1; if "intercepts" is included,
    equality constraints are used so that the sum of the intercepts (belonging
    to the indicators of a single latent variable) equals zero; as a shortcut,
    you can also set effect.coding = TRUE, which implies
    effect.coding = c("loadings", "intercepts");
    note that his may not work well with bifactor models, or any other type
    of model where items depend on multiple factors
  - summary(fit, nd = 4) now shows 4 digits (after the decimal point) for
    all (non-integer) numbers, including the header; the header has been
    re-arranged slightly: the estimator is now shown on the top; the test
    statistic(s) are now in a section 'Model Test User Model:'
  - the test= argument now accepts a vector of multiple test statistics,
    for example test = c("satorra.bentler", "mean.var.adjusted")
  - parameterEstimates(), standardizedSolution() and fitMeasures() have a new
    output= argument which can be set to "text" for pretty printing
- Known issues:
  - same as 0.6-1
- Bugs/glitches discovered after the release:
  - in the categorical setting (estimator U/WLSMV) + missing = "pairwise" + the     number of thresholds is larger than one: some entries in the weight matrix
    are not correct, resulting in (small) bias for some parameters
  - optim.method="none" is ignored in nlminb.constr() settings; as a 
    side-effect, this produces wrong results in lavTestLRT() if 
    method="satorra.bentler.2010", and explicit inequality constraints 
    are used in the model
  - wrong labels for lavInspect(,"lv.mean") and lavInspect(,"cov.all") if
    both formative and reflexive latent variables are used
  - the "<~" operator did not work well in the categorical setting in 
    combination with conditional.x = TRUE
  - parameterEstimates + fmi = TRUE often gives crazy results
  - lavTestLRT + MLR + df=0 for one of the models results in an error 
  - estimator = "WLS" + continuous data + missing = "pairwise" does not
    work
  - loglikelood value if fixed.x = TRUE and only sample statistics are
    provided is still reflecting the joint loglikelihood

##### Version 0.6-4 #####

- Released on CRAN: 3 July 2019
- New features and user-visible changes:
  - this release includes mostly changes under the hood
  - an extra check is done for convergence (even if the optimizer claims
    convergence): we check if all the elements of the (unscaled) gradient
    are smaller than 0.0001 (in absolute value). 
    If not, we set converged = FALSE. The tolerance value
    0.0001 can be changed by the option optim.dx.tol. To switch off this
    check, use optim.dx.tol = +Inf
  - lavInspect() gains new options: "vcov.def.joint" (and standardized 
    variants) to give the (joint) variance-covariance matrix of both the
    free and `defined' (using the := operator) variables;
     "loglik.casewise" to extract casewise (log)likelihood values (only
    if ML has been used);
    "h1.information" to extract the information matrix of the 
    unrestricted h1 model
  - lavTestScore() + uni table and modindices() output (in particular epc 
    and epv values) are now more alike
  - lavPredict() + Bartlett now uses FIML to compute factor scores (in the
    presence of missing data); new append.data= argument cbinds factor
    scores and raw data; if assemble = TRUE, factor scores of multiple
    groups will be joined in a single data.frame (with a group column);
    accept newdata= argument, even if sample statistics were used when
    fitting the original model
  - using ordered = TRUE implies all variables should be treated as ordinal
  - new logical arguments orthogonal.y and orthogonal.x can be used to specify 
    zero covariances between endogenous and exogenous latent variables (only)
    respectively
  - new option sampling.weights.normalization (set to "total" by default)
  - group.equal now also accepts "composite.loadings" when the "<~" 
    operator is used
  - parameterEstimates() gains a remove.nonfree= argument
  - initial (but still experimental and undocumented) support for
    rotation, EFA, and ESEM (contact me if you wish to test this)
  - initial (but still experimental and undocumented) support for
    the `Structural After Measurement' (SAM) approach (see the new
    lavaan:::sam() function; contact me if you wish to test this)
- Known issues:
  - same as 0.6-1 (although many long standing github issues have been resolved)
- Bugs/glitches discovered after the release:
  - twolevel models: standard errors are off for fixed effects (only) if the 
    model contains a regression of the form y ~ x, both variables are 
    observed, and x is not centered
  - twolevel models: the chi-square test statistic for the baseline model
    is wrong (too low): the chi-square test statistic for the full model
    was substracted; therefore, if the user model fitted really bad, the
    baseline test statistic was too low; if the user model fitted reasonably
    well, there was (almost) no impact on the CFI/TLI fit measures
  - lavPredict(): labels were wrong in the multigroup twolevel case

##### Version 0.6-3 #####

- Released on CRAN: 22 September 2018
- New features and user-visible changes:
  - new function lavResiduals() provides raw and standardized residuals 
    in addition to
    summary statistics (rmr, srmr and crmr, including their standard error,
    a test for exact fit, and an unbiased version);
    for continuous data only (single-level, conditional.x = FALSE)
  - new option missing = "ml.x" or missing = "fiml.x" will not delete
    cases with missing values on exogenous covariates, even if fixed.x = TRUE
    (this restores the behavior of < 0.6); this can be useful for models
    with a large number of exogenous covariates, which you can treat as
    stochastic, but where fixed.x = TRUE is just more convenient
  - lavInspect/lavTech + "sampstat" now always returns the data summaries from
    the h1 slot; this implies that if data is missing, and missing = "(fi)ml)",
    you get the 'EM' estimated covariance matrix and mean vector (instead
    of the pairwise deleted covariance matrix from the samplestats slot)
  - lavInspect/lavTech + "sampstat" and "implied" no longer return the mean
    vector if meanstructure = FALSE
  - srmr_bollen is renamed crmr in the output of fitMeasures(), and does no
    longer count the (zero) diagonal elements when taking the average
  - if conditional.x = TRUE, the baseline model
    will now set the slopes free (instead of fixing them to zero); this
    will usually result in a much better fit for the baseline model, and a 
    less optimistic value for CFI/TLI and friends; to get back the old 
    behaviour, set the option 'baseline.conditional.x.free.slopes' to FALSE
- Known issues:
  - same as 0.6-1
- Bugs/glitches discovered after the release:
  - mimic = "Mplus" was no longer setting meanstructure = TRUE
  - if a partable was provided as input (instead of model syntax), the 
    `y' variables were identified by using lavNames(fit, "ov.y") instead
    of lavNames(fit, "ov.nox"); therefore, we 'missed' some variables in
    lav_dataframe_check_ordered(), not (automatically) treating them as
    ordered
  - mimic = "EQS" was not setting all the correct settings any longer
  - lavPredict() + Bartlett + missing data did not produce 'true' FIML
    factor scores (although they were very close)
  - lav_partable_merge() did not set the group/level column right, affecting
    lavTestLRT() when method = "SatorraBentler2010" (producing a warning
    that the optimizer could not find a solution, and no test statistic)
  - when a second-order factor was included in the model, the summary
    output did not print a dot ('.', to indicate endogenous) in front of the
    (residual) variances of the first-order latent variables
  - lavTestLRT() + Satorra2000 with two models having the same df resulted
    in a strange error
  - lavTestScore() + uni resulted in epc values with the wrong sign; as a 
    result, the epv values were in the wrong direction
  - lavaanList() produced "nlev too low for some vars" error, when ordered
    variables were involved that included missing values (NA) (the NA was
    counted as an additional category)

##### Version 0.6-2 #####

- Released on CRAN: 16 July 2018
- New features and user-visible changes:
  - cluster-robust standard errors are reported when the cluster= argument
    is used in combination with a standard single-level syntax
    (without the "level:" keywords); this can be used in combination with 
    missing = "fiml" (to handle missing values) and sampling weights
  - added lower() and upper() modifiers in the model syntax; it works
    in a similar way as the start() modifier to provide starting values;
    for example,
    to force a variance (say, y1 ~~ y1) to be larger than 0.001, you can
    now write y ~~ lower(0.001)*y1
  - even if the optimizer claims to have found a solution, we check if 
    the gradient is (almost) zero, and warn if not;
    this check can be turned on/off by the option check.gradient = TRUE/FALSE
  - more effort is done to check if the model is identified in the
    presence of equality constraints; a warning is given if vcov is (nearly)
    singular; this check can be turned on/off by the option 
    check.vcov = TRUE/FALSE
  - header of the summary() function now shows the optimizer, the number
    of free parameters, and the number of constraints (if any)
  - fabin3 starting values for factor loadings are now also computed if
    std.lv = TRUE
- Known issues:
  - same as 0.6-1
- Bugs/glitches discovered after the release:
  - ifi.scaled fit measure was not scaled
  - lavTables() did not work if the first argument was a data.frame
  - two-level + optim.method = "em" resulted in an error (about the check argument)
  - modindices() did not work if conditional.x = TRUE
  - lavInspect(, "data") did not return covariates if conditional.x = TRUE


##### Version 0.6-1 #####

- Released on CRAN: 22 May 2018
- New features and user-visible changes:
  - initial support for two-level SEM with random intercepts; see
    example(Demo.twolevel) 
  - initial support for sampling weights (for non-clustered data only for now)
  - the code to compute (robust) standard errors and
    (robust) test statistics has been rewritten; the code is now much more 
    consistent, but this may result in small changes in the values of some 
    robust test statistics as printed in the output of summary(); 
    a meanstructure is no longer added automatically when switching to a
    robust estimator
  - conditional.x = FALSE now works in the categorical case (both with
    estimators DWLS and PML)
  - if fixed.x = TRUE, we compute the loglikelihood without the exogenous
    covariates, and we do not allow for missing values in the exogenous
    covariates when missing = "ml" (and fixed.x = TRUE)
  - estimator = "PML" now works for continuous-only data, or mixed
    continuous/ordinal data
  - lavTestLRT(, method = "satorra2000") which is the default when comparing
    models that were fitted with estimator MLMV or WLSMV now uses the so-called
    'delta' method by default; this allows for comparing models that are
    nested in the covariance sense (and not just in the parameter sense);
    in addition, a scaled.shifted test statistic will be used by default
  - the warning about empty cells in bivariate cells (when
    categorical data is used) is no longer shown
  - many, many small changes under the hood
- Known issues:
  - two-level SEM: no random slopes, no missing data, no categorical data
  - the marginal ML infrastructure (estimator = "MML") has not been updated yet
  - several github issues have not been resolved yet
- Bugs/glitches discovered after the release:
  - robust CFI/TLI and robust RMSEA values are printed as NA when 
    estimator = "MLR"
  - lavPredict(, level = 2) does not handle phantom latent variables properly

