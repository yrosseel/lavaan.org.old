#
# civr() function for estimation of the causal instrumental variables 
#        regression (CIVR) model
#
# based on: 
#
# Maydeu-Olivares (forthcoming). Instrumental variable regression: A mean
# and covariance structure approach
#
# code written by Yves Rosseel, 17 April 2018
# - YR 22 April 2018: analytic jacobians for Delta.1, Delta.12, ...
#                     add intercepts/means (estimation only)
#                     remove iz.idx, replaced by beta.xz.zero.idx
# - YR 09 May 2018: cleanup, derivatives based on Delta, remove beta.xz.zero.idx
# - YR 10 May 2018: added meanstructure= argument
# - YR 13 May 2018: add fixed.x = FALSE/TRUE: treat 'v' as fixed or not?
# - YR 17 Dec 2018: rename: Z->X and V->Z


# first version: using numerical approximations for the jacobians
civr7 <- function(y = NULL,              # single outcome
                  X = NULL,              # predictors (data.frame or matrix)
                  Z = NULL,              # instrument (data.frame or matrix)
                  NAMES = NULL,          # variable names
                  meanstructure = FALSE, # add (unrestricted) meanstructure?
                  fixed.x = FALSE,       # treat 'Z' as fixed?
                  output = "list") {

    require(lavaan)

    # convert X to matrix
    if(is.data.frame(X)) {
        X <- as.matrix(X)
    } else if(!is.matrix(X)) {
        X <- matrix(X)
    }
    nx <- ncol(X)

    # convert Z to matrix
    if(is.data.frame(Z)) {
        Z <- as.matrix(Z)
    } else if(!is.matrix(Z)) {
        Z <- matrix(Z)
    }
    nz <- ncol(Z)

    #############################
    #### Part 1: estimation #####
    #############################

    # compute sample statistics
    all.data <- cbind(y, X, Z); nobs <- nrow(all.data); nvar <- ncol(all.data)
    all.data <- na.omit(all.data) # listwise deletion!
    if(nrow(all.data) != nobs) {
        warning("lavaan WARNING: ", 
                "listwise deletion reduced the sample size from ", nobs, 
                " to ", nrow(all.data))
        nobs <- nrow(all.data)
        attr(all.data, "na.action") <- NULL
    }
    sample.mean <- colMeans(all.data)
    sample.cov  <- crossprod(all.data)/nobs - tcrossprod(sample.mean)

    # indices in total data matrix
    y.idx <- 1L
    x.idx <- 1L + seq_len(nx)
    z.idx <- 1L + nx + seq_len(nz)
    vech.idx <- lav_matrix_vech_idx(nvar)
    pstar <- (nvar * (nvar + 1)) / 2

    # sample statistics parts 
    m.z <- sample.mean[z.idx]
    m.x <- sample.mean[x.idx]
    m.y <- sample.mean[y.idx]
    S.zz <- sample.cov[z.idx, z.idx, drop = FALSE]
    S.zx <- sample.cov[z.idx, x.idx, drop = FALSE]
    S.xx <- sample.cov[x.idx, x.idx, drop = FALSE]
    S.zy <- sample.cov[z.idx, y.idx, drop = FALSE]
    S.xy <- sample.cov[x.idx, y.idx, drop = FALSE]
    S.yy <- sample.cov[y.idx, y.idx, drop = FALSE]

    # inverses
    S.zz.inv <- solve(S.zz)


    ###########################
    # stage 1: regress x on z #
    ###########################
    psi.zz  <- S.zz
    beta.xz <- t(S.zx) %*% S.zz.inv
    psi.xx  <- S.xx - beta.xz %*% S.zz %*% t(beta.xz)     
    alpha.z <- m.z
    alpha.x <- m.x - as.numeric(beta.xz %*% m.z)

    ###########################
    # stage 2: regress y on x #
    ###########################
    beta.yx <- t( solve(t(S.zx) %*% S.zz.inv %*% S.zx) %*% 
                  t(S.zx) %*% S.zz.inv %*% S.zy )
    alpha.y <- m.y - as.numeric(beta.yx %*% m.x)

    #################################
    # stage 3: residual var/cov y-x #
    #################################
    psi.xy  <- ( S.xy -
                 beta.xz %*% psi.zz %*% t(beta.xz) %*% t(beta.yx) - 
                 psi.xx %*% t(beta.yx) )
    psi.yy  <- ( S.yy -
                 beta.yx %*% beta.xz %*% psi.zz %*% t(beta.xz) %*% t(beta.yx) -
                 beta.yx %*% psi.xx %*% t(beta.yx) -
                 2 * beta.yx %*% psi.xy )

    # model-based Sigma
    BETA <- rbind( cbind(0, t(matrix(beta.yx)), matrix(0, 1, nz)),
                   cbind(matrix(0, nx, nx + 1L), beta.xz), matrix(0, nz, nvar) )
    PSI <- rbind( cbind(psi.yy, t(psi.xy), matrix(0, 1, nz)),
                  cbind(psi.xy, psi.xx, matrix(0, nx, nz)),
                  cbind(matrix(0, nz, 1L + nx), psi.zz) )
    IB.inv <- solve(diag(nvar) - BETA)
    Sigma <- IB.inv %*% PSI %*% t(IB.inv)

    # model-based Mu
    ALPHA <- matrix( c(alpha.y, alpha.x, alpha.z) )
    Mu <- IB.inv %*% ALPHA
    


    #############################
    #### Part 2: inference  #####
    #############################

    # compute Gamma
    if(fixed.x) {
        Gamma.ADF <- lav_gamma_model(Y = all.data, Mu = Mu, Sigma = Sigma,
                                     meanstructure = meanstructure,
                                     x.idx = z.idx)
        Gamma.ADF.sample <- lav_gamma_model(Y = all.data, Mu = sample.mean,
                                     Sigma = sample.cov,
                                     meanstructure = meanstructure,
                                     x.idx = z.idx)
        Gamma.NT <- lavaan:::lav_samplestats_Gamma_NT(COV = Sigma,
            MEAN = Mu, meanstructure = meanstructure, fixed.x = TRUE,
            x.idx = z.idx)

    } else {
        Gamma.ADF <- lav_gamma_model(Y = all.data, Mu = Mu, Sigma = Sigma,
                                     meanstructure = meanstructure)
        Gamma.ADF.sample <- lav_gamma_model(Y = all.data, Mu = sample.mean, 
                                     Sigma = sample.cov,
                                     meanstructure = meanstructure)
        Gamma.NT <- lavaan:::lav_samplestats_Gamma_NT(COV = Sigma, MEAN = Mu,
                                     meanstructure = meanstructure)
    }


    # compute Delta -- beta
    BETA.logical <- matrix(FALSE, nvar, nvar); BETA.logical[1L, x.idx] <- TRUE
    beta.yx.idx <- which(lav_matrix_vec(BETA.logical))
    BETA.logical <- matrix(FALSE, nvar, nvar); BETA.logical[x.idx,z.idx] <- TRUE
    beta.xz.idx <- which(lav_matrix_vec(BETA.logical))
    beta.idx <- c(beta.yx.idx, beta.xz.idx)

    KOL.idx <- matrix(1:(nvar * nvar), nvar, nvar, byrow = TRUE)[beta.idx]
    DX <- (Sigma %x% IB.inv)[, beta.idx, drop = FALSE] + 
          (IB.inv %x% Sigma)[, KOL.idx, drop = FALSE]
    DX[, which(beta.idx %in% lav_matrix_diag_idx(nvar))] <- 0
    Delta.beta <- DX[vech.idx, , drop = FALSE]

    # compute Delta -- psi
    psi.yy.idx <- 1L
    psi.xy.idx <- seq_len(nx) + 1L
    PSI.logical <- matrix(FALSE, nvar, nvar); PSI.logical[x.idx, x.idx] <- TRUE
    PSI.logical[lav_matrix_vechu_idx(nvar, diagonal = FALSE)] <- FALSE
    psi.xx.idx <- which(lav_matrix_vec(PSI.logical))
    PSI.logical <- matrix(FALSE, nvar, nvar); PSI.logical[z.idx, z.idx] <- TRUE
    PSI.logical[lav_matrix_vechu_idx(nvar, diagonal = FALSE)] <- FALSE
    psi.zz.idx <- which(lav_matrix_vec(PSI.logical))
    psi.idx <- c(psi.yy.idx, psi.xy.idx, psi.xx.idx, psi.zz.idx)

    DX <- (IB.inv %x% IB.inv)
    lower.idx <- lav_matrix_vech_idx(nvar, diagonal = FALSE)
    upper.idx <- lav_matrix_vechru_idx(nvar, diagonal = FALSE)
    offdiagSum <- DX[, lower.idx] + DX[, upper.idx]
    DX[, c(lower.idx, upper.idx)] <- cbind(offdiagSum, offdiagSum)
    DX <- DX[, psi.idx, drop = FALSE]
    Delta.psi <- DX[vech.idx, , drop = FALSE]

    # compute DeltaMu
    Delta.Mu.psi   <- matrix(0, nvar, length(psi.idx))
    Delta.Mu.alpha <- IB.inv
    DX <- t(IB.inv %*% ALPHA) %x% IB.inv
    #DX[, lav_matrix_diag_idx(nvar)] <- 0
    Delta.Mu.beta  <- DX[,beta.idx]

    # selection matrices T1, T2, T3
    T1 <- cbind( matrix(0, pstar - nvar, nvar), diag(pstar - nvar) )
    T2 <- cbind( matrix(0, nz, 1 + nx), diag(nz), matrix(0, nz, (pstar - nvar)))
    T3 <- cbind( diag(1 + nx), matrix(0, 1 + nx, pstar - (1 + nx)) )

    if(meanstructure) {
        TM1 <- cbind( matrix(0, nvar - 1L, 1L), diag(nvar - 1L) )
        TM2 <- cbind( diag(1L), matrix(0, 1L, nvar - 1L) )
        T1 <- lav_matrix_bdiag(TM1, T1)
        T2 <- lav_matrix_bdiag(TM2, T2)
        T3 <- cbind( matrix(0, 1 + nx, nvar), T3 )
    }

    ## Delta.1 ##
    Delta.1 <- cbind(
        Delta.psi[ -seq_len(nvar), match( psi.xx.idx,  psi.idx), drop = FALSE], 
        Delta.beta[-seq_len(nvar), match(beta.xz.idx, beta.idx), drop = FALSE],
        Delta.psi[ -seq_len(nvar), match( psi.zz.idx,  psi.idx), drop = FALSE])
    ## Delta.21 ##
    Delta.21 <- cbind(
        Delta.psi[  z.idx, match( psi.xx.idx,  psi.idx), drop = FALSE],
        Delta.beta[ z.idx, match(beta.xz.idx, beta.idx), drop = FALSE],
        Delta.psi[  z.idx, match( psi.zz.idx,  psi.idx), drop = FALSE])
    ## Delta.2 ##
    Delta.2 <- 
        Delta.beta[ z.idx, match(beta.yx.idx, beta.idx), drop = FALSE]
    ## Delta.31 ##
    Delta.31 <- cbind(
        Delta.psi[  c(1,x.idx), match( psi.xx.idx,  psi.idx), drop = FALSE],
        Delta.beta[ c(1,x.idx), match(beta.xz.idx, beta.idx), drop = FALSE],
        Delta.psi[  c(1,x.idx), match( psi.zz.idx,  psi.idx), drop = FALSE])
    ## Delta.32 ##
    Delta.32 <- 
        Delta.beta[ c(1,x.idx), match(beta.yx.idx, beta.idx), drop = FALSE]
    ## Delta.3 ##
    Delta.3 <- cbind( 
        Delta.psi[  c(1,x.idx), match( psi.yy.idx,  psi.idx), drop = FALSE],
        Delta.psi[  c(1,x.idx), match( psi.xy.idx,  psi.idx), drop = FALSE] )

    if(meanstructure) {
        Delta.Mu.1 <- cbind(
            Delta.Mu.alpha[-1L, -1L, drop = FALSE],
            Delta.Mu.psi[  -1L, match( psi.xx.idx,  psi.idx), drop = FALSE],
            Delta.Mu.beta[ -1L, match(beta.xz.idx, beta.idx), drop = FALSE],
            Delta.Mu.psi[  -1L, match( psi.zz.idx,  psi.idx), drop = FALSE] )
        Delta.1 <- rbind(Delta.Mu.1,
                         cbind(matrix(0, nrow(Delta.1), nvar - 1L), Delta.1))
            
        Delta.Mu.21 <- cbind(
            Delta.Mu.alpha[ 1L, -1L, drop = FALSE],
            Delta.Mu.psi[   1L, match( psi.xx.idx,  psi.idx), drop = FALSE],
            Delta.Mu.beta[  1L, match(beta.xz.idx, beta.idx), drop = FALSE],
            Delta.Mu.psi[   1L, match( psi.zz.idx,  psi.idx), drop = FALSE] )
        Delta.21 <- rbind(Delta.Mu.21,
                          cbind(matrix(0, nrow(Delta.21), nvar - 1L), Delta.21))

        Delta.Mu.2 <- cbind(
            Delta.Mu.alpha[ 1L, 1L, drop = FALSE],
            Delta.Mu.beta[  1L, match(beta.yx.idx, beta.idx), drop = FALSE] )
        Delta.2 <- rbind(Delta.Mu.2,
                         cbind(matrix(0, nrow(Delta.2), 1L), Delta.2))

        Delta.31 <- cbind(matrix(0, nrow(Delta.31), nvar - 1L), Delta.31)
        Delta.32 <- cbind(matrix(0, nrow(Delta.32), 1L), Delta.32)
        Delta.3  <- Delta.3
    }

    # construct 'M'
    if(meanstructure) {
        # create augmented covariance matrix for 'Z'
        #A.zz <- S.zz + tcrossprod(m.z)
        #A2 <- lav_matrix_bdiag(matrix(1, 1L, 1L), A.zz)
        # add means
        #A2[-1,1] <- A2[1,-1] <- m.z
        #W2 <- solve(A2)
        W2 <- lav_matrix_bdiag(matrix(1, 1L, 1L), S.zz.inv)
    } else {
        W2 <- S.zz.inv 
    }


    M.1 <- solve(crossprod(Delta.1)) %*% t(Delta.1) %*% T1
    M.21 <- T2 - Delta.21 %*% M.1
    M.2 <- ( solve(t(Delta.2) %*% W2 %*% Delta.2) %*%
             t(Delta.2) %*% W2 %*% M.21 )
    M.312 <- T3 - Delta.31 %*% M.1 - Delta.32 %*% M.2
    M.3 <- solve( crossprod(Delta.3) ) %*% t(Delta.3) %*% M.312
    M <- rbind(M.1, M.2, M.3)

    # var(theta)
    VCOV.NT  <- 1/nobs * M %*% Gamma.NT %*% t(M)
    VCOV.ADF <- 1/nobs * M %*% Gamma.ADF %*% t(M)

    # Omega
    yhat <- alpha.y + as.numeric(X %*% matrix(beta.yx))
    Omega  <- crossprod(cbind(1,Z) * (y - yhat))/nobs

    Z2 <- t( t(Z) - colMeans(Z) ) # needed for Omega2!
    Omega2 <- crossprod(        Z2  * (y - yhat))/nobs

    Omega.inv <- solve(Omega)
    Omega2.inv <- solve(Omega2)

    # only for theta.2
    VCOV.NT.2  <- 1/nobs * M.2 %*% Gamma.NT %*% t(M.2)
    VCOV.ADF.2 <- 1/nobs * M.2 %*% Gamma.ADF %*% t(M.2)
    VCOV.ADF.2s <- 1/nobs * M.2 %*% Gamma.ADF.sample %*% t(M.2)

    # double check
    SzxSizzSxz.inv <- solve(t(S.zx) %*% S.zz.inv %*% S.zx)
    VCOV.NT.2e <- 1/nobs * unname(psi.yy[1,1] * SzxSizzSxz.inv)

    SzxSizz <- t(S.zx) %*% S.zz.inv
    VCOV.ADF.2e <- 1/nobs * unname(SzxSizzSxz.inv %*% SzxSizz %*% Omega2 %*% 
                                                t(SzxSizz) %*% SzxSizzSxz.inv)


    # test statistics
    T.Sargan <- as.numeric( nobs * 
                    ( t(S.zy - psi.zz %*% t(beta.xz) %*% t(beta.yx)) %*%
                      solve( psi.yy[1,1] * S.zz) %*%
                      (S.zy - psi.zz %*% t(beta.xz) %*% t(beta.yx)) ) )

    T.Hansen <- as.numeric( nobs *
                    ( t(c(0, S.zy - psi.zz %*% t(beta.xz) %*% t(beta.yx))) %*%
                      solve( Omega ) %*%
                      c(0, S.zy - psi.zz %*% t(beta.xz) %*% t(beta.yx)) ) )

    T.Hansen2 <- as.numeric( nobs *
                    ( t(S.zy - psi.zz %*% t(beta.xz) %*% t(beta.yx)) %*%
                           solve( Omega2 ) %*%
                       (S.zy - psi.zz %*% t(beta.xz) %*% t(beta.yx)) ) )

    # complete Delta in order (theta.1, theta.2, theta.3)
    if(meanstructure) {
        Delta.Mu <- cbind( # theta.1
               Delta.Mu.alpha[, -1L, drop = FALSE],
               Delta.Mu.psi[  , match( psi.xx.idx,  psi.idx), drop = FALSE],
               Delta.Mu.beta[ , match(beta.xz.idx, beta.idx), drop = FALSE],
               Delta.Mu.psi[  , match( psi.zz.idx,  psi.idx), drop = FALSE],
                           # theta.2
               Delta.Mu.alpha[, 1L, drop = FALSE],
               Delta.Mu.beta[ , match(beta.yx.idx, beta.idx), drop = FALSE],
                           # theta.3
               matrix(0, nvar, 1 + nx) )

        Delta.Sigma <- cbind( # theta.1
                    matrix(0, nrow(Delta.psi), nvar - 1L),
                    Delta.psi[ , match( psi.xx.idx,  psi.idx), drop = FALSE],
                    Delta.beta[, match(beta.xz.idx, beta.idx), drop = FALSE],
                    Delta.psi[ , match( psi.zz.idx,  psi.idx), drop = FALSE],
                        # theta.2
                    matrix(0, nrow(Delta.psi), 1L),
                    Delta.beta[, match(beta.yx.idx, beta.idx), drop = FALSE],
                        # theta.3
                    Delta.psi[ , match( psi.yy.idx,  psi.idx), drop = FALSE],
                    Delta.psi[ , match( psi.xy.idx,  psi.idx), drop = FALSE] )

        Delta <- rbind(Delta.Mu, Delta.Sigma)
    } else {
        Delta <- cbind( # theta.1
                    Delta.psi[ , match( psi.xx.idx,  psi.idx), drop = FALSE],
                    Delta.beta[, match(beta.xz.idx, beta.idx), drop = FALSE],
                    Delta.psi[ , match( psi.zz.idx,  psi.idx), drop = FALSE],
                        # theta.2
                    Delta.beta[, match(beta.yx.idx, beta.idx), drop = FALSE],
                        # theta.3
                    Delta.psi[ , match( psi.yy.idx,  psi.idx), drop = FALSE],
                    Delta.psi[ , match( psi.xy.idx,  psi.idx), drop = FALSE] )
    }

#    # numerical Delta
#    theta.x <- c(alpha.x, alpha.z,
#                 lav_matrix_vech(psi.xx),
#                 lav_matrix_vec(beta.xz),
#                 lav_matrix_vech(psi.zz),
#                 alpha.y, lav_matrix_vec(beta.yx),
#                 psi.yy, lav_matrix_vec(psi.xy))
#                 
#    Delta.x <- function(x) {
#        idx <- seq_len(nx)
#        alpha.x <- x[idx]
#        idx <- max(idx) + seq_len(nz)
#        alpha.z <- x[idx]
#        idx <- max(idx) + seq_len(nx*(nx+1)/2)
#        psi.xx <- lav_matrix_vech_reverse(x[idx])
#        idx <- max(idx) + seq_len(nx*nz)
#        beta.xz <- matrix(x[idx], nx, nz)
#        idx <- max(idx) + seq_len(nz*(nz+1)/2)
#        psi.zz <- lav_matrix_vech_reverse(x[idx])
#        idx <- max(idx) + seq_len(1L)
#        alpha.y <- x[idx]
#        idx <- max(idx) + seq_len(1L*nx)
#        beta.yx <- matrix(x[idx], 1L, nx)
#        idx <- max(idx) + seq_len(1L)
#        psi.yy <- x[idx]
#        idx <- max(idx) + seq_len(nx * 1L)
#        psi.xy <- matrix(x[idx], nx, 1L)
#
#        BETA <- rbind( cbind(0, t(matrix(beta.yx)), matrix(0, 1, nz)),
#                   cbind(matrix(0, nx, nx + 1L), beta.xz), matrix(0, nz, nvar) )
#        PSI <- rbind( cbind(psi.yy, t(psi.xy), matrix(0, 1, nz)),
#                  cbind(psi.xy, psi.xx, matrix(0, nx, nz)),
#                  cbind(matrix(0, nz, 1L + nx), psi.zz) )
#        IB.inv <- solve(diag(nvar) - BETA)
#        Sigma <- IB.inv %*% PSI %*% t(IB.inv)
#
#        # model-based Mu
#        ALPHA <- matrix( c(alpha.y, alpha.x, alpha.z) )
#        Mu <- IB.inv %*% ALPHA
#
#        c(Mu, lav_matrix_vech(Sigma))
#    }
#    Delta.numerical <- numDeriv:::jacobian(func = Delta.x, x = theta.x)
#
#    Delta <- Delta.numerical
#
    # orthogonal complement
    Delta.c <- lav_matrix_orthogonal_complement(Delta)

    # Browne's residual-based test statistic
    C.hat.NT <-  ( Delta.c %*% solve(t(Delta.c) %*% Gamma.NT %*% Delta.c)
                   %*% t(Delta.c) )
    C.hat.ADF <- ( Delta.c %*% solve(t(Delta.c) %*% Gamma.ADF %*% Delta.c)
                   %*% t(Delta.c) )
    C.hat.ADF.sample <- ( Delta.c %*% solve(t(Delta.c) %*% Gamma.ADF.sample
                           %*% Delta.c) %*% t(Delta.c) )

#    zero.idx <- which(diag(Gamma.NT) == 0)
#    if(length(zero.idx) > 0L) {
#        Gamma.NT.inv <- matrix(0, nrow(Gamma.NT), ncol(Gamma.NT))
#        tmp <- solve(Gamma.NT[-zero.idx, -zero.idx])
#        Gamma.NT.inv[-zero.idx, -zero.idx] <- tmp
#
#        DGD.inv <- MASS:::ginv(t(Delta) %*% Gamma.NT.inv %*% Delta)
#    } else {
#        Gamma.NT.inv <- solve(Gamma.NT)
#        DGD.inv <- solve(t(Delta) %*% Gamma.NT.inv %*% Delta)
#    }
#    C.hat.NT <- ( Gamma.NT.inv - Gamma.NT.inv %*% Delta %*%
#                        DGD.inv %*% t(Delta) %*% Gamma.NT.inv)
#
#    zero.idx <- which(diag(Gamma.ADF) == 0)
#    if(length(zero.idx) > 0L) {
#        Gamma.ADF.inv <- matrix(0, nrow(Gamma.ADF), ncol(Gamma.ADF))
#        tmp <- solve(Gamma.ADF[-zero.idx, -zero.idx])
#        Gamma.ADF.inv[-zero.idx, -zero.idx] <- tmp
#
#        DGD.inv <- MASS:::ginv(t(Delta) %*% Gamma.ADF.inv %*% Delta)
#    } else {
#        Gamma.ADF.inv <- solve(Gamma.ADF)
#        DGD.inv <- solve(t(Delta) %*% Gamma.ADF.inv %*% Delta)
#    }
#    C.hat.ADF <- ( Gamma.ADF.inv - Gamma.ADF.inv %*% Delta %*%
#                        DGD.inv %*% t(Delta) %*% Gamma.ADF.inv)
#
   
    if(meanstructure) {
        OBS <- c(sample.mean, lav_matrix_vech(sample.cov))
        EST <- c(Mu, lav_matrix_vech(Sigma))
    } else {
        OBS <- lav_matrix_vech(sample.cov)
        EST <- lav_matrix_vech(Sigma)
    }
    RES <- OBS - EST

    T.Browne.NT  <- as.numeric( nobs * (t(RES) %*% C.hat.NT  %*% RES) )
    T.Browne.ADF <- as.numeric( nobs * (t(RES) %*% C.hat.ADF %*% RES) )
    #T.Browne.ADF.s <- as.numeric( nobs * (t(RES) %*% C.hat.ADF.sample %*% RES) )


    ######################
    ### Part 3: output ###
    ######################

    # NAMES
    if(is.null(NAMES)) {
        NAMES <- c(paste0("y", seq_len(1L)),
                   paste0("x", seq_len(nx)),
                   paste0("z", seq_len(nz)))
    }

    # theta
    theta.1 <- c( lav_matrix_vech(psi.xx),
                  lav_matrix_vec(beta.xz),
                  lav_matrix_vech(psi.zz) )

    GRID.xx <- expand.grid(NAMES[x.idx], NAMES[x.idx])
    tmp.xx <- matrix(paste(GRID.xx$Var1, "~~", GRID.xx$Var2), nx)
    names.xx <- lav_matrix_vech(tmp.xx)

    GRID.zz <- expand.grid(NAMES[z.idx], NAMES[z.idx])
    tmp.zz <- matrix(paste(GRID.zz$Var1, "~~", GRID.zz$Var2), nz)
    names.zz <- lav_matrix_vech(tmp.zz)

    names.xz <- paste( rep(NAMES[x.idx], nz), "~", rep(NAMES[z.idx], nx))
    names(theta.1) <- c(names.xx, names.xz, names.zz)

    theta.2 <- lav_matrix_vec(beta.yx)
    names(theta.2) <- paste(NAMES[1], "~", NAMES[x.idx])

    theta.3 <- c(psi.yy, lav_matrix_vec(psi.xy))
    names(theta.3) <- paste(NAMES[c(1, x.idx)], "~~",
                            NAMES[c(1, x.idx)])

    if(meanstructure) {
        theta.1m <- c(alpha.x, alpha.z)
        names(theta.1m) <- paste0(NAMES[c(x.idx, z.idx)], "~1")
        theta.1 <- c(theta.1m, theta.1)

        theta.2m <- alpha.y
        names(theta.2m) <- paste0(NAMES[y.idx], "~1")
        theta.2 <- c(theta.2m, theta.2)
    }

    # output a list
    out <- list(m.y = m.y, m.x = m.x, m.z = m.z,
                S.yy = S.yy, S.xy = S.xy, S.zy = S.zy,
                S.xx = S.xx, S.zx = S.zx, S.zz = S.zz,
                S.zz.inv = S.zz.inv, W2 = W2,
                M.1 = M.1, M.2 = M.2, M.21 = M.21, M.3 = M.3, M.312 = M.312,
                Delta.1 = Delta.1, Delta.21 = Delta.21, Delta.2 = Delta.2,
                Delta.3 = Delta.3, Delta.31 = Delta.31, Delta.32 = Delta.32,
                Delta = Delta, Delta.c = Delta.c,
                T1 = T1, T2 = T2, T3 = T3,
                beta.yx = beta.yx, beta.xz = beta.xz,
                psi.yy = psi.yy, psi.xy = psi.xy, psi.xx = psi.xx, 
                psi.zz = psi.zz,
                alpha.y = alpha.y, alpha.x = alpha.x, alpha.z = alpha.z,
                Mu = Mu, Sigma = Sigma, 
                VCOV.NT = VCOV.NT, 
                VCOV.NT.2 = VCOV.NT.2, 
                VCOV.NT.2e = VCOV.NT.2e, 
                VCOV.ADF = VCOV.ADF,
                VCOV.ADF.2 = VCOV.ADF.2,
                VCOV.ADF.2s = VCOV.ADF.2s,
                VCOV.ADF.2e = VCOV.ADF.2e,
                Omega = Omega, Omega2 = Omega2,
                Omega.inv = Omega.inv, Omega2.inv = Omega2.inv,
                Gamma.NT = Gamma.NT, Gamma.ADF = Gamma.ADF,
                T.Sargan = T.Sargan, T.Hansen = T.Hansen,
                T.Hansen2 = T.Hansen2,
                T.Browne.NT = T.Browne.NT,
                T.Browne.ADF = T.Browne.ADF, RES = RES,
                #T.Browne.ADF.s = T.Browne.ADF.s,
                meanstructure = meanstructure,
                fixed.x = fixed.x,
                theta = c(theta.1, theta.2, theta.3))
    out
}



lav_gamma_model <- function(Y = NULL, Mu = NULL, Sigma = NULL,
                            meanstructure = TRUE, x.idx = integer(0L),
                            gamma.n.minus.one  = FALSE) {

    Y <- unname(as.matrix(Y)); N <- nrow(Y); p <- ncol(Y)

    if(meanstructure) {
        stopifnot(!is.null(Mu))
        sigma <- c(as.numeric(Mu), lav_matrix_vech(Sigma))
    } else {
        sigma <- lav_matrix_vech(Sigma)
    }

    # denominator
    if(gamma.n.minus.one) {
        N <- N - 1
    }

    Yc <- t( t(Y) - as.numeric(Mu) )

    idx1 <- lav_matrix_vech_col_idx(p)
    idx2 <- lav_matrix_vech_row_idx(p)

    if(length(x.idx) == 0L) {
        if(meanstructure) {
            Z <- cbind(Y, Yc[,idx1] * Yc[,idx2])
        } else {
            Z <- Yc[,idx1] * Yc[,idx2]
        }

        # model-based!
        Zc <- t( t(Z) - sigma )
    } else {
        if(meanstructure) {
            # fixed.x = TRUE
            Y.bar <- colMeans(Y)

            res.cov <- ( Sigma[-x.idx, -x.idx, drop = FALSE] -
                         Sigma[-x.idx, x.idx, drop = FALSE] %*%
                          solve(Sigma[x.idx, x.idx, drop = FALSE]) %*%
                         Sigma[x.idx, -x.idx, drop = FALSE] )
            res.slopes <- ( solve(Sigma[x.idx, x.idx, drop = FALSE]) %*%
                            Sigma[x.idx, -x.idx, drop = FALSE] )
            res.int <- ( Y.bar[-x.idx] -
                 as.numeric(colMeans(Y[,x.idx,drop = FALSE]) %*% res.slopes) )
            x.bar <- Y.bar[x.idx]
            yhat.bar <- as.numeric(res.int + as.numeric(x.bar) %*% res.slopes)
            YHAT.bar <- numeric( ncol(Y) )
            YHAT.bar[-x.idx] <- yhat.bar; YHAT.bar[x.idx] <- x.bar
            YHAT.cov <- Sigma
            YHAT.cov[-x.idx, -x.idx] <- Sigma[-x.idx, -x.idx] - res.cov


            yhat <- cbind(1, Y[,x.idx]) %*% rbind(res.int, res.slopes)
            YHAT <- cbind(yhat, Y[,x.idx])
            YHATc <- t( t(YHAT) - YHAT.bar )
            Z <- ( cbind(Y, Yc[,idx1] * Yc[,idx2]) -
                   cbind(YHAT, YHATc[,idx1] * YHATc[,idx2]) )

            sigma1 <- c(Mu, lav_matrix_vech(Sigma))
            sigma2 <- c(YHAT.bar, lav_matrix_vech(YHAT.cov))
            Zc <- t( t(Z) - (sigma1 - sigma2) )
        } else {
            # fixed.x, but no meanstructure
            Y.bar <- colMeans(Y)

            res.cov <- ( Sigma[-x.idx, -x.idx, drop = FALSE] -
                         Sigma[-x.idx, x.idx, drop = FALSE] %*%
                          solve(Sigma[x.idx, x.idx, drop = FALSE]) %*%
                         Sigma[x.idx, -x.idx, drop = FALSE] )
            res.slopes <- ( solve(Sigma[x.idx, x.idx, drop = FALSE]) %*%
                            Sigma[x.idx, -x.idx, drop = FALSE] )
            res.int <- ( Y.bar[-x.idx] -
                 as.numeric(colMeans(Y[,x.idx,drop = FALSE]) %*% res.slopes) )
            x.bar <- Y.bar[x.idx]
            yhat.bar <- as.numeric(res.int + as.numeric(x.bar) %*% res.slopes)
            YHAT.bar <- numeric( ncol(Y) )
            YHAT.bar[-x.idx] <- yhat.bar; YHAT.bar[x.idx] <- x.bar
            YHAT.cov <- Sigma
            YHAT.cov[-x.idx, -x.idx] <- Sigma[-x.idx, -x.idx] - res.cov


            yhat <- cbind(1, Y[,x.idx]) %*% rbind(res.int, res.slopes)
            YHAT <- cbind(yhat, Y[,x.idx])
            YHATc <- t( t(YHAT) - YHAT.bar )
            Z <- ( Yc[,   idx1] * Yc[,   idx2] -
                   YHATc[,idx1] * YHATc[,idx2] )

            sigma1 <- lav_matrix_vech(Sigma)
            sigma2 <- lav_matrix_vech(YHAT.cov)
            Zc <- t( t(Z) - (sigma1 - sigma2) )
        }
    }

    Gamma <- base::crossprod(Zc) / N
    Gamma
}


