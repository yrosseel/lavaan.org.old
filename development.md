---
layout: default
title: lavaan development
published: true
submenu: lavaan
---

#### Installing the development version of lavaan ####

If you have not installed lavaan before, first install the current version
of lavaan and all of its dependencies. Then, to install the latest development 
version of lavaan, you can type at the R prompt:
   
    library(remotes)
    remotes::install_github("yrosseel/lavaan")

To make sure you are using the newly installed version of lavaan, restart your
R session.  If you want to revert to the official (CRAN) version of lavaan
again, simply type

    install.packages("lavaan")

and you will back to the official version. Again, you may need to restart
your R session.

#### lavaan source code ####

All development of lavaan happens on [GitHub](http://github.com). If
you want to download (or clone) the lavaan source code, or if you
simply want to browse through the source code, go to the lavaan github
page:

[https://github.com/yrosseel/lavaan](https://github.com/yrosseel/lavaan)

If you click on the
[commits](https://github.com/yrosseel/lavaan/commits/master) tab, you can see
all the recent changes that have been committed.

#### Development notes ####

Here, I will publish some notes that document important changes from
version to version (or perhaps possible changes that are not implemented
yet). I welcome any comments or suggestions on these notes.

- handling [linear equality constraints](http://lavaan.ugent.be/notes/lavaan_eq_constraints.pdf) in lavaan 0.5-18 (compared to 0.5-17 and lower)

#### Future plans ####

Too many. Eventually, we will get (most) of the features of
LISREL/Mplus/gllamm/... in lavaan. But it takes time. Please do not ask me when
a feature will be ready. I have no idea.

Features that are planned for future updates within the 0.6 series:

- exploratory SEM (ESEM) and exploratory factor analysis (EFA) (available in 0.6-8)
- two-level SEM with random slopes
- fiml for two-level SEM (to handle missing values) (available in 0.6-9)
- accelerated EM
- structural after measurement (SAM) estimation strategies (available in 0.6-9)

Other plans for future releases:

- better support for models with NO latent variables
- non-iterative estimators, James-Stein type shrinkage estimators
- improved small sample inference
- multilevel SEM with categorical data (using adaptive quadrature)
- support for discrete latent variables (aka mixture modeling, latent class analysis)
