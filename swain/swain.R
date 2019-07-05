# Public R function                                                 swain.R  

# Version 1.0: April 19, 2006
# Version 1.1: April 11, 2008
# Version 1.2: August 20, 2013


  # swain.R
  #
  # Swain-corrected estimates of likelihood-ratio test statistics, 
  # RMSEA, Gamma_1, TLI, and CFI 
  # 
  # Version 1.2 
  # Date 20-08-2013 
  # Authors and maintainers: Anne Boomsma and Walter Herzog
  #
  # Copyright 2007-2013 Anne Boomsma and Walter Herzog
  #
  # This program is free software: you can redistribute it and/or modify
  # it under the terms of the GNU General Public License as published by
  # the Free Software Foundation, either version 3 of the License, 
  # or (at your option) any later version.
  #
  # This program is distributed in the hope that it will be useful,
  # but WITHOUT ANY WARRANTY; without even the implied warranty of
  # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
  # See the GNU General Public License for more details.
  #
  # You should have received a copy of the GNU General Public License
  # along with this program. If not, see http://www.gnu.org/licenses.
  #
  # Documentation: swain.pdf (Boomsma & Herzog, 2008)
  # Equation numbers refer to Herzog, Boomsma and Reinecke (2007)
  #
    
  swain <- function(N, p, d, TML, TMLi, conf.level=0.90) {
  
  # N: sample size
  # p: number of observed variables
  # d: number of degrees of freedom for model M_j
  # TML: chi-square likelihood-ratio test statistic for model M_j,
  #      i.e., T_{ML_j}
  # TMLi: chi-square test statistic for the independence model M_i, T_{ML_i}
  # conf.level: confidence level for interval estimation (default 0.90)

  n <- N - 1
  t <- p*(p+1)/2 - d                       # number of parameters
  pTML <- 1 - pchisq(TML,d)                # p-value of T_ML_j
  q <- (sqrt(1+8*t)-1)/2                   # (11) 
  num <- p*(2*p^2+3*p-1)-q*(2*q^2+3*q-1)   # numerator in (10)
  den <- 12*d*(N-1)                        # denominator in (10)
  s <- 1 - num/den                         # Swain's correction factor s (10)
  TMLs <- s*TML                            # Swain-corrected test statistic (12)
  pTMLs <- 1 - pchisq(TMLs,d)              # p-value of T_MLs
  di <- p*(p-1)/2                          # degrees of freedom of model M_i
  RMSEA <- sqrt(max((TML-d)/(n*d),0))      # Root Mean Square Error of
                                           # Approximation 
  RMSEAs <- sqrt(max((TMLs-d)/(n*d),0))    # Swain's estimate RMSEAs
  
  # Calculating confidence limits for RMSEA and RMSEAs using
  # function uniroot for one-dimensional root finding
  lower.tail <- (1 - conf.level)/2
  upper.tail <- 1 - lower.tail
  interval <- c(0, 500000)
  lower <- uniroot(function(x)
     ifelse(x > 0, pchisq(ncp=x,q=TML,df=d) - upper.tail, 1), interval)$root
  RMSEAl <- sqrt(max((lower)/(n*d),0))  
  upper <- uniroot(function(x)
     ifelse(x > 0, pchisq(ncp=x,q=TML,df=d) - lower.tail, 1), interval)$root
  RMSEAu <- sqrt(max((upper)/(n*d),0))
  lowers <- uniroot(function(x)
     ifelse(x > 0, pchisq(ncp=x,q=TMLs,df=d) - upper.tail, 1), interval)$root
  RMSEAsl <- sqrt(max((lowers)/(n*d),0))
  uppers <- uniroot(function(x)
     ifelse(x > 0, pchisq(ncp=x,q=TMLs,df=d) - lower.tail, 1), interval)$root
  RMSEAsu <- sqrt(max((uppers)/(n*d),0))
  
  L <-  0.05^2*n*d
  pclose <- 1-pchisq(ncp=L,q=TML,df=d)
  pcloses <- 1-pchisq(ncp=L,q=TMLs,df=d)
  Gamma1 <- p/(p+2*(TML-d)/n)              # Gamma_1 (Steiger) 
  Gamma1l <- p/(p+2*(upper)/n)
  Gamma1u <- p/(p+2*(lower)/n)
  Gamma1s <- p/(p+2*(TMLs-d)/n)            # Swain's estimate of Gamma_1   
  Gamma1sl <- p/(p+2*(uppers)/n)
  Gamma1su <- p/(p+2*(lowers)/n)
  TLI <- (TMLi/di - TML/d)/(TMLi/di - 1)   # Tucker-Lewis Index
  TLIs <- (TMLi/di - TMLs/d)/(TMLi/di -1)  
  tau <-  max(TML-d, 0)                  
  taus <-  max(TMLs-d, 0)                  # Swain's estimate TLIs   
  taui <-  max(TMLi-di, TML-d, 0)          
  CFI <- 1 - tau/taui                      # Comparative Fit Index (Bentler)
  CFIs <- 1 - taus/taui                    # Swain's estimate CFIs
  CIV2 <-  100*conf.level

  cat("\n  R function swain (Version 1.2)          -- Boomsma & Herzog (2013)", "\n")
  cat("\n  Equations and Monte-Carlo results of the corrections are available",
    "\n")
  cat("  in Herzog, Boomsma, & Reinecke (2007) and Herzog & Boomsma (2006);", 
    "\n")
  cat("  see the online documentation of the swain function.", "\n")
  cat("\nSample size, N =", N, "\n")                              
  cat("Number of observed variables, p =", p, "\n")
  cat("Number of degrees of freedom, d =", d, "\n")
  cat("Chi-square test statistic, TML = ", TML,", p-value: ", pTML, "\n",
    sep="")
  cat("Swain's correction factor:", s, "\n")
  cat("Swain-corrected chi-square test statistic: ", TMLs,", p-value: ", 
    pTMLs, "\n", sep="")
  cat("Chi-square test statistic of the independence model, TMLi =", TMLi, 
    "\n")
  cat("\nEstimate of the Root Mean Square Error of Approximation (RMSEA):",
    RMSEA, "\n")
  cat(CIV2, "% confidence interval for RMSEA: (", RMSEAl, ", ", RMSEAu,
    ")", "\n", sep="")
  cat("Test of close fit: H_0: RMSEA < .05, p-value:", pclose, "\n")
  cat("Swain-corrected RMSEA:", RMSEAs, "\n")
  cat("Swain-corrected ", CIV2, "% confidence interval for RMSEA: (", 
    RMSEAsl, ", ", RMSEAsu, ")", "\n", sep="")
  cat("Swain-corrected test of close fit: H_0: RMSEA < .05, p-value:",
    pcloses, "\n")
  cat("\nEstimate of Gamma_1:", Gamma1, "\n")
  cat(CIV2, "% confidence interval for Gamma_1: (", Gamma1l, ", ", Gamma1u, 
    ")", "\n", sep="")
  cat("Swain-corrected Gamma_1:", Gamma1s, "\n")
  cat("Swain-corrected ", CIV2, "% confidence interval for Gamma_1: (",
    Gamma1sl, ", ", Gamma1su, ")", "\n", sep="")
  cat("\nTucker-Lewis Index (TLI):", TLI,"\n")
  cat("Swain-corrected Tucker-Lewis Index:", TLIs,"\n")
  cat("Comparative Fit Index (CFI):", CFI,"\n")
  cat("Swain-corrected Comparative Fit Index:", CFIs,"\n","\n")
}                                                   # end of swain function

# Examples
# swain(N=50, p=25, d=265, TML=400, TMLi=1100, conf.level=0.90)
# swain(50, 25, 265, 400, 1100)
# swain(50, 25, 265, 400, 1100, 0.80)
# swain(7929, 40, 730, 23262.1, 76214.9, 0.90)

