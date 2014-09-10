
#' Calcule le nombre de nouveaux cas

new.case <- function(d, pays, compte = "Total"){
  a <- tapply(d$Total[d$Pays=="Guinea"], d$Date[d$Pays=="Guinea"], sum)
  n <- length(a)
  b <- a[n] - a[n-1]
  return(b)
}