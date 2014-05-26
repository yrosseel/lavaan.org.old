---
layout: default
title: lavaan development
published: true
submenu: lavaan
---

#### Installing the development version of lavaan ####

To install the latest development version of lavaan, start up R and
type

    install.packages("lavaan", repos="http://www.da.ugent.be", type="source")

To make sure you are using the newly installed version of lavaan, restart your
R session.  If you want to revert to the official (CRAN) version of lavaan
again, simply type

    install.packages("lavaan")

and you will back to the official version. Again, you may need to restart
your R session.

#### GitHub ####

All development of lavaan happens on [GitHub](http://github.com). If
you want to download (or clone) the lavaan source code, or if you
simply want to browse through the source code, go to the lavaan github
page:

[https://github.com/yrosseel/lavaan](https://github.com/yrosseel/lavaan)

If you click on the
[commits](https://github.com/yrosseel/lavaan/commits/master) tab, you can see
all the recent changes that have been committed.

#### Future plans ####

Version 0.5 is already fairly complete, but new features (mostly related to categorical data) are still added. In particular, we are working on 1) implementing
marginal ML estimation for categorical SEM, 2) fine-tuning the PML estimator,
3) adding functions to assess the fit of SEM models when the data is categorical.

For version 0.6, we plan to redesign the internals of lavaan, and create an
API, so that it becomes easier for package developers to access/change the
internals of lavaan. We hope to start this in October 2013.

Other plans for future releases:

- support for Bayesian estimation (BUGS interface, perhaps a STAN interface, and eventually using custom code)
- full support for multilevel SEM (mostly likely, lavaan will adopt the GLLAMM approach)
- support for discrete latent variables (aka mixture modeling, latent class analysis)
- C++ engine for the core computations


