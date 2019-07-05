---
layout: default
title: Getting started
published: true
submenu: lavaan
---

#### Install R ####
lavaan is implemented as an R package. This means that before installing
lavaan, you should have installed a recent version (>= 3.0.0) of R. You can
download the latest version of R from the 
[R-project website](http://www.r-project.org). 


#### Install lavaan ####
Once you have installed R, you can install the lavaan package simply by
starting up R, and typing

```r
install.packages("lavaan", dependencies = TRUE)
```
  
To check if the installation was succesful, you can load the lavaan package and try one of the examples. For example:
 
```r
library(lavaan)
example(cfa)
```

If you can see the output, everything is set up and ready.

#### Getting Started ####
Now that you have installed lavaan, you can:

- read the lavaan tutorial; either [online](/tutorial/index.html) or as 
a [PDF](/tutorial/tutorial.pdf)
- read the [lavaan paper](http://www.jstatsoft.org/v48/i02/)
- have a look at the teaching materials, code examples and more at
the [Resources](/resources/index.html) page.
