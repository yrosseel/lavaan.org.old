
Before you start, please read these points carefully:

-   First of all, you must have a recent version (4.0.0 or higher) of
    R installed. You can download the latest version of R from this
    page: <http://cran.r-project.org/>.

-   Some important features are NOT available (yet) in lavaan:

    -   multilevel sem with random slopes (this is under developement)

    -   support for variable types other than continuous, binary and ordinal
        (for example: zero-inflated count data, nominal data, non-Gaussian
         continuous data); it is unlikely that this will be part of lavaan
        any time soon, for the simple reason that these variable types need
        numerical quadrature, and this is too slow to be practical in (pure) R.

    -   support for discrete latent variables (mixture models, latent
        classes) (although you can use the sampling weights and multiple
        group features to mimic some mixture models)

    We hope to add these features to lavaan in the near future (but please do 
    not ask when).

-   The lavaan package is free open-source software. This means (among
    other things) that there is no warranty whatsoever. On the other hand,
    you can verify the source code yourself:
    <https://github.com/yrosseel/lavaan/>

-   If you need help, you can (only) ask questions in the lavaan 
    discussion group. Go to <https://groups.google.com/d/forum/lavaan/> and 
    join the group. Once you have joined the group, you can email your 
    questions to <lavaan@googlegroups.com>. Please do not email me directly.
 
-   I do not offer statistical advice. For general (non lavaan-specific)
    questions about SEM, consider posting to the SEMNET discussion group.

-   If you think you have found a bug, or if
    you have a suggestion for improvement, you can either email me directly, or
    open an issue on github (see <https://github.com/yrosseel/lavaan/issues>).
    If you report a bug, always provide a minimal
    reproducible example (a short R script and some data).
