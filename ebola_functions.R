
#' Calcule le nombre de nouveaux cas

new.case <- function(d, state, compte = "Total"){
  a <- tapply(d$Total[d$Pays == state], d$Date[d$Pays == state], sum)
  a1 <- names(a)
  a2 <- as.numeric(a)
  a3 <- c(0, diff(a)) # premier élément = 0 car 1ère différence nulle
  a3[a3 < 0] <- 0 # si différence négative on ramène à 0
  b <- data.frame(a1,a2,a3)
  
  return(b)
}

new.death <- function(d, state, compte = "Death"){
  a <- tapply(d$Death[d$Pays == state], d$Date[d$Pays == state], sum)
  a1 <- names(a)
  a2 <- as.numeric(a)
  a3 <- c(0, diff(a)) # premier élément = 0 car 1ère différence nulle
  a3[a3 < 0] <- 0 # si différence négative on ramène à 0
  b <- data.frame(a1,a2,a3)
  
  return(b)
}