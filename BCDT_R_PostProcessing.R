####################################################
# * BCDT * Coast-down test * data post-processing ##
# STengattini & AYBigazzi                         ##
###################################################

#################################################################################################
## FUNCTION NEEDED TO COMPUTE BICYCLE RESISTANCES PARAMETERS
#################################################################################################

#************************************************************************************************
# t(x) finite element modelization fucntion for numerical integration of the coast-down equation
calc_t_x <-
  function(x,
           Cr,
           m,
           CdAf,
           v0,
           WDT,
           Alt,
           Temp,
           Stadia,
           g = 9.81,
           Step = 1) {
    rho <- rho(Alt, Temp)
    Out <-
      data.frame(
        x = seq(0, max(x), by = Step),
        t = NA,
        wappx = NA,
        wappy = NA,
        wapp = NA,
        beta = NA,
        acc_air = NA,
        a = NA,
        v = NA
      )
    Out$G <- calcGrade(Out$x, Stadia)
    Out$A <- g * (Cr + Out$G)
    Out$B <- 0.5 * rho * CdAf / m
    #Out$mu <- mu
    Out$v[1] <- v0
    Out$t[1] <- 0
    for (i in 1:(nrow(Out) - 1)) {
      #ws <- WDT[which.min(abs(WDT$RelTime - Out[i,'t'])), 'ws']
      alpha <-
        approx(WDT$RelTime,
               WDT$Wind_Dir_deg_0isN,
               Out[i, 't'],
               method = "linear",
               rule = 2)
      alpha <- alpha$y
      
      wabs <-
        approx(WDT$RelTime,
               WDT$Wind_Vel_m.s,
               Out[i, 't'],
               method = "linear",
               rule = 2)
      wabs <- wabs$y
      
      wsx1 <- wabs * cos(alpha * 180 / pi)
      wsx2 <-
        approx(WDT$RelTime,
               WDT$ws,
               Out[i, 't'],
               method = "linear",
               rule = 2)
      wsx2 <- wsx2$y
      
      ws_avg_x <- (wsx1 + wsx2) / 2
      
      wsy1 <- wabs * sin(alpha * 180 / pi)
      wsy2 <-
        approx(WDT$RelTime,
               WDT$ws_perp,
               Out[i, 't'],
               method = "linear",
               rule = 2)
      wsy2 <- wsy2$y
      
      ws_avg_y <- (wsy1 + wsy2) / 2
      
      
      Out[i, 'wappx'] <- ws_avg_x - Out[i, 'v']
      Out[i, 'wappy'] <- ws_avg_y
      Out[i, 'wapp'] <-
        sqrt((Out[i, 'wappx']) ^ 2 + (Out[i, 'wappy']) ^ 2)
      Out[i, 'beta'] <- atan2(Out[i, 'wappy'], Out[i, 'wappx'])
      Out[i, 'acc_air'] <- Out[i, 'B'] * (Out[i, 'wappx']) ^ 2
      Out[i, 'a'] <-
        -(Out[i, 'A']) + (Out[i, 'acc_air'] * sign(cos(Out[i, 'beta']))) #plus beacuse cos(beta will take care)
      
      Out[i + 1, 'v'] <-
        Out[i, 'v'] + (Out[i, 'a'] / Out[i, 'v'] * Step)
      if (Out[i + 1, 'v'] < 0 | is.na(Out[i + 1, 'v']))
        break
      Out[i + 1, 't'] <-
        Out[i, 't'] + Step / mean(Out[i:(i + 1), 'v'])
    }
    Out$v[is.na(Out$v) | Out$v < 0] <- 0
    #Out$t <- c(0,cumsum(diff(Out$x)*2/(Out$v[-1] + Out$v[-nrow(Out)])))
    Out$t <-
      c(0, cumsum(Step * 2 / (Out$v[-1] + Out$v[-nrow(Out)])))
    Out$t[Out$t == Inf] <- NA
    Out[factor(x, levels = Out$x), 't']
  }

#************************************************************************************************
# Calculation of grade as a function of coasting distance, given stadia readings
calcGrade <- function(x, Stadia) {
  Stadia <- -Stadia / 100
  StadX <- 0:10 * 10
  GradeCoef <-
    coef(lm(
      Stadia ~ StadX + I(StadX ^ 2) + I(StadX ^ 3) + I(StadX ^ 4) + I(StadX ^
                                                                        5) + I(StadX ^ 6)
    ))
  NewCoef <- GradeCoef[-1] * c(1:6)
  Out <- x
  for (i in 1:length(Out))
    Out[i] <- sum(x[i] ^ (0:5) * NewCoef)
  Out
}

#************************************************************************************************
# Calculation of rho - i.e. Air density, given altitude and temperature
rho <- function(Alt, Temp) {
  rho_adj <- 1.293 * exp(-0.127 * Alt) * (273 / (Temp + 273.15))
  rho_adj
}

#************************************************************************************************
# FITNESS function (i.e. OBJECTIVE FUNCTION) used for GA*****************************************
fitness <- function(param, Ts, Xs, Beams, ...) {
  Est <- calc_t_x(
    x = Xs,
    Cr = param[1],
    CdAf = param[2],
    v0 = param[3],
    ...
  )
  Est <- Est[1:(Beams)]
  Ts <- Ts[1:(Beams)]
  Est <- Est[-2]
  Ts <- Ts[-2]
  SSE <- sum((Est - Ts) ^ 2)
  
  #TsDiff <- diff(Ts[])
  #EstDiff <- diff(Est[])
  #SSE <- sum((EstDiff-TsDiff)^2)
  if (!is.na(SSE))
    - SSE
  else
    - 10 * sum((Est - Ts) ^ 2, na.rm = T)
}

#################################################################################################
## GENETIC ALGORITHM AND PARAMETERS SPECIFICATIONS
#################################################################################################
#************************************************************************************************
# GA - Genetic algorithm (using L.Scrucca's "GA" R package)

GAlist[[i]] <-
  ga(
    type = "real-valued",
    fitness = fitness,
    names = c("Cr", "CdAf", "v0"),
    Ts = Data$Ts,
    Xs = Xs,
    WDT = WindData,
    Beams = Beams,
    m = Mass,
    Stadia = Stadia,
    Alt = Alt,
    Temp = Temp,
    min = c(0.001, 0.2, (v0s - 0.75)),
    max = c(0.02, 1.2, (v0s + 0.75)),
    suggestions = c(0.008, 0.75, v0s),
    popSize = 50,
    updatePop = F,
    maxiter = 2000,
    run = 150,
    parallel = T,
    #monitor=plot,
    pmutation = 0.1,
    pcrossover = 0.8,
    optim = T,
    keepBest = F
  )