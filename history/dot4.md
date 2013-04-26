---
layout: default
title: Version History
published: true
submenu: history
---

#### 0.4 series ####

##### Version 0.4-14 #####

- Released on CRAN: 11 May 2012
- New features/changes:
  - this is a maintenance release, to go along with the official publication of the 'lavaan' paper in the Journal of Statistical Software (volume 48)
  - citation("lavaan") will provide correct citation information
  - internal slot @User has been renamed @parTable
  - internal slot @Sample has been renamed @SampleStats
- Bugs/glitches discovered after the release:
  - a bug (introduced in 0.4-12) resulted in wrong derivatives for the PSI matrix; this may affect some SEs for models with more than 2 latent factors (or more than 2 observed dependent variables, since they are converted to latents) (bug reported by Mijke Rhemtulla)
  - when estimator="(fi)ml", estimation may fail for saturated models (e.g. univariate regression models); workaround: use fixed.x=FALSE
  - univariate regression where intercept is explicitly included in the model syntax sometimes returns the parameters in the wrong order

##### Version 0.4-13 #####

- Released on CRAN: 10 April 2012
- New features/changes:
  - this is a maintenance release, mainly reorganizing internal code
  - bootstrapLavaan() and bootstrapLRT() functions gain a type="yuan" method; contributed by Ed Merkle
  - parameterEstimates() will add an 'fmi' column containing the fraction of missing information if missing="fiml"; suggested by Mijke Rhemtulla
  - improved check for linear constraints
  - updated versions of InformativeTesting() and related functions
  - parseModelString() is now exported
  - lavaan now requires R version 2.14.0 or higher
- Bugs/glitches discovered after the release:
  - defined parameters (created using the ":=" operator) are not standardized in the Std.lv and Std.all columns

##### Version 0.4-12 #####

- Released on CRAN: 2 February 2012
- New features/changes:
  - bootstrapLavaan() uses a generic FUN argument to extract any type of information from a fitted lavaan object
  - bootstrapLRT() gains a calibrate argument to switch on a double (nested) bootstrap
  - both bootstrapLavaan() and bootstrapLRT() functions have support for the parallel package
  - simulateData() gains a skewness and kurtosis argument to simulate nonnormal multivariate data
  - new function InformativeTesting() for testing order restricted hypothesis; contributed by Leonard Vanbrabant
  - initial support for a new operator "<~" to specify formative constructs (composites)
- Bugs/glitches discovered after the release:
  - bootstrapLRT() with type="bollen.stine" and multiple groups is broken
  - bollen.stine plus mean structure used sample.mean instead of Mu.hat for the transformation
  - if data is deleted listwise, summary() does not show the 'Total' (original) number of observations
  - parameters for composites defined by the <~ operator are not standardized, even if standardized=TRUE

##### Version 0.4-11 #####

- Released on CRAN: 21 December 2011
- New features/changes:
  - parametric bootstrap, see bootstrapLavaan() function
  - simulateData() to generate data starting from a lavaan model syntax
  - getCov() function to easily read in the lower triangular elements of a covariance matrix
  - new operator ":" to allow for different models for different groups
  - there is no need to use the 'label()' and 'equal()' modifiers anymore; in multiple groups, labels can
  - be provided as follows: c(a1,a2,a3,a4)*x1 (no quotes needed!)
  - models with only covariances and/or means (i.e. no "~" or "=~" operators) are now supported
- Bugs/glitches discovered after the release:
   - bootstrapLavaan() with type="parametric" only produces an error (in the CRAN version)
   - sometimes, the optimizer (nlminb) falsely reports non-convergence if the fx is below .Machine$tol.eps
   - modindices() with multiple groups is broken in 0.4-11
   - estimator="MLM" fails if data contains missing values (workaround: use na.omit() to remove missing cases or use estimator="MLR")

##### Version 0.4-10 #####

- Released on CRAN: 3 October 2011
- New features/changes:
  - mimic="Mplus" is no longer the default; the default is mimic="lavaan"
  - added 'start' argument to control the way the starting values are chosen
  - added 'control' argument to pass control parameters to the optimizer
  - parameterEstimates() function always includes confidence intervals, and only standardized estimates if standardized=TRUE
  - standardized estimates now come in three flavors: std.lv, std.all and std.nox
  - se="boot" or se="bootstrap" provides bootstrap standard errors
  - test="bollen.stine" or test="bootstrap" provides a p-value for the test statistic based on the Bollen-Stine bootstrap
  - if data is missing, the h1 model is now estimated using the EM algorithm (instead of quasi-newton)
  - new operator := for defining arbitrary (linear or nonlinear) functions of free parameters (eg ab := a*b where both a and b are labels of free parameters); standard errors are computed using the delta method
- Bugs/glitches discovered after the release:
  - using multiple modifiers on intercepts [eg f ~ a*1 + start(1)*1] produces a syntax error
  - upper CI RMSEA fails if RMSEA is zero but df > 0
  - the baseline model used by the lavaan() function (not the other fitting functions) is wrong if there were multiple groups and group equality constraints; this affects the CFI/TLI indices
  - multiple group analyses with missing="ml" has some convergence issues, due to a faulty group weight
    
##### Version 0.4-9 #####
- Released on CRAN: 15 June 2011
- New features/changes:
  - all bugs/glitches in 0.4-8 are fixed
  - new starting values for factor loadings
  - better scaling of free parameters in the optimization routine
  - new modelCov() function to inspect the covariance matrix before analysis
- Bugs/glitches discovered after the release:
  - if equality constraints are included in the model using the "==" operator, the df count is wrong
  - in some cases, the combination of both within-group and between-group equality constraints produces errors
  - if the argument missing="ml" is used but the data does not contain any missings, the summary() function produces an error
  - it was not allowed to specify a covariance using the "~~" operator where one element was an observed variable, and the other element a latent variable
    
##### Version 0.4-8 #####

- Released on CRAN: 24 April 2011
- New features/changes:
  - all bugs/glitches in 0.4-7 are fixed
  - AIC, BIC and logLik use S4 generics from the stats4 package
  - new lavaan-method 'nobs()' returns the total sample size used for the analysis
  - additional options for the 'group.equal' argument
  - new 'anova()' function to compare nested models using a (possibly scaled) chi-square difference test
  - better internal scaling makes the optimizer (nlminb) more robust, if the data is badly scaled
  - instead of using 'label("mylabel")*x1' to assign a parameter label, you can now use 'mylabel*x1'
  - instead of using the 'equal()' modifier, you can now enforce equality constraints by using the same label for several parameters
  - initial (and experimental) support has been added for general linear and nonlinear equality and inequality constraints
- Bugs/glitches discovered after the release:
  - if the "group" variable in the data frame contained missing values, an additional group was added for those cases
  - the parameter names in the group.partial argument were converted to lower caps; if some parameter names included capitals, the group.partial argument had no effect
  - the NA* modifier is interpreted as a label, and is ignored (workaround: as.numeric(NA)* works)
  - a bug in the code for the auto.single.fix argument (which is automatically set to TRUE in the cfa/sem/growth functions) produces the wrong model if indicators are shared by several latent variables (workaround: use the lavaan() function for these models)
   
##### Version 0.4-7 #####
- Released on CRAN: 21 Februari 2011
- New features/changes:
  - completely rewritten codebase (much smaller, more modular and much faster)
  - improved parsing mechansism using the new function lavaanify()
  - improved model syntax (multiple modifiers, multiple lhs elements, and more)
  - MLM results are now identical to Mplus (except for fixed.x covariates)
  - added MLF and MLR estimators
  - new functions: standardizedSolution, parameterEstimates, modindices, fitMeasures, update, AIC, BIC,
            predict
  - normalized and standardized residuals
  - a new low-level function lavaan() has the 'feature' of doing nothing automagically
  - measurement.invariance function has been renamed to measurementInvariance
  - improved summary, reporting sample size and missingness information
  - mimic.Mplus argument is replaced by a 'mimic' argument; can be set to "Mplus" (default) or "EQS"
  - new argument 'likelihood' can be set to "wishart" or "normal" (for maximum likelihood estimation only)
  - na.rm argument is replaced by a 'missing' argument; can be set to "listwise" (default) or "ml"
  - group.constraints argument is replaced by a 'group.equal' argument; new
argument 'group.partial' allows for partial equality constraints
  - standard.errors argument is replaced by a 'se' argument'; new argument 'test' for choosing the test statistic
            new 'fixed.x' argument
  - new argument 'representation' as a placeholder for the future
  - in the standardized solutions, the (residual) covariances are now in a correlation metric
- Known issues for this release:
  - MLM value in models with fixed x covariates is (slightly) different in Mplus
  - SRMR value is sometimes different in Mplus: if information is observed, if data is missing, and if equality constraints are used with multiple groups
  - EPCs for equality constraints are not entirely correct (but almost)
- Bugs/glitches discovered after the release:
  - function modindices: sepc.all column contains value 'Inf' for all covariances; in a multiple group analysis, only the last group is shown
  - rsquare labels in the summary output are sometimes in the wrong order
  - internal function 'vnames' (called by function lavaanNames) with type 'lv.x' or 'lv.y' does not (always) return the names of the variables in the same order as for type 'lv'
  - function measurementInvariance(): the group.partial argument produces an error
  - if the data contains cases where all variables are missing, these cases are silently removed from the data, but
  - the total number of observations is not adjusted
  - the logLik function returns a 'df' attribute (to be used in the AIC() function); this should be the number of free parameters,
         not (as in 0.4-7) the degrees of freedom of the model 
