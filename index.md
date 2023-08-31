---
layout: default
title: Welcome to lavaan.org
published: true
submenu: lavaan
---

#### News: ####

- (pinned): please consider a [donation](http://lavaan.ugent.be/donate.html) for the lavaan project.

- (19 July 2023): lavaan version 0.6-16 has been released on
  [CRAN](https://cran.r-project.org/web/packages/lavaan/).
  See [Version History](http://lavaan.ugent.be/history/dot6.html)
  for more information. This is just a maintenance release.


####  What is lavaan? ####
The lavaan package is developed to provide useRs, researchers and teachers a
free open-source, but commercial-quality package for latent variable modeling.
You can use lavaan to estimate a large variety of multivariate statistical
models, including path analysis, confirmatory factor analysis, structural
equation modeling and growth curve models.

The official reference to the lavaan package is the following paper:

> Yves Rosseel (2012). lavaan: An R Package for Structural Equation Modeling. 
> *Journal of Statistical Software*, 48(2), 1-36. 
> URL [http://www.jstatsoft.org/v48/i02/](http://www.jstatsoft.org/v48/i02/)


#### First impression ####
To get a first impression of how lavaan works in practice, consider the
following example of a SEM model. The figure below contains
a graphical representation of the model that we want to fit. 

<div class="row clearfix">
<div class="seven columns alpha">
<p>
<img src="/tutorial/figure/sem.png" alt="lavaan example" width="100%"/>
</p>
</div>
<div class="six columns omega">
<div class="highlight"><pre><code class="r">myModel <span class="o">&lt;-</span> <span class="s">&#39;</span>
<span class="s">   # latent variables</span>
<span class="s">     ind60 =~ x1 + x2 + x3</span>
<span class="s">     dem60 =~ y1 + y2 + y3 + y4</span>
<span class="s">     dem65 =~ y5 + y6 + y7 + y8</span>
<span class="s">   # regressions</span>
<span class="s">     dem60 ~ ind60</span>
<span class="s">     dem65 ~ ind60 + dem60</span>
<span class="s">   # residual covariances</span>
<span class="s">     y1 ~~ y5</span>
<span class="s">     y2 ~~ y4 + y6</span>
<span class="s">     y3 ~~ y7</span>
<span class="s">     y4 ~~ y8</span>
<span class="s">     y6 ~~ y8</span>
<span class="s">&#39;</span>
fit <span class="o">&lt;-</span> sem<span class="p">(</span>model<span class="o"> = </span>myModel<span class="p">,</span>
           data<span class="o">  = </span>PoliticalDemocracy<span class="p">)</span>
summary<span class="p">(</span>fit<span class="p">)</span>
</code></pre></div>
</div>
</div>

