---
layout: default
title: Version History
published: true
submenu: history
---

#### 0.6 series ####

##### Version 0.6-4 #####

- Released on CRAN: 3 July 2019
- New features and user-visible changes:
  - this release includes mostly changes under the hood
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
  - (just released)

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

