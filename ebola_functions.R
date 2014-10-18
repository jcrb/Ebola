
#' Calcule le nombre de nouveaux cas
#' @param d: dataframe des données
#' @param state: Guinea, Liberia, Sierra Leone, Nigeria, Senegal, Spain, USA, Congo
#' @param compte: Total ou Death pour les décès
#' @usage x <- new.case(d, "liberia")

new.case <- function(d, state, compte = "Total"){
  
  if(compte == "Total"){
    a <- tapply(d$Total[d$Pays == state], d$Date[d$Pays == state], sum)
  }
  else if(compte== "Death"){
    a <- tapply(d$Death[d$Pays == state], d$Date[d$Pays == state], sum)
  }
  else stop("Le compte est inexact")
  
  a1 <- names(a)
  a2 <- as.numeric(a)
  a3 <- c(0, diff(a)) # premier élément = 0 car 1ère différence nulle
  a3[a3 < 0] <- 0 # si différence négative on ramène à 0
  a3[1] <- a2[1] # première ligne
  b <- data.frame(a1,a2,a3)
  names(b) <- c("date","cumul","delta")
  return(b)
}

#===========================================================================
# ebola.curve
#===========================================================================
#'@title copyrigth
#'@author JcB
#'@description 
#'@param b un objet de type new.case
#'@param state
#'@param col: couleur de l'histogramme
#'@param title: Nouveaux cas, Décès
#'@usage nd <-new.case(d,"Liberia", "Death"); ebola.curve(nd, "Libéria", title="Décès")
#'
ebola.curve <- function(b, state, col="#A8DDB5", title = "Nouveaux cas"){
  # On crée autant d'enregistrements qu'il y a de cas
  x.date <- rep(b$date, b$delta)
  ebola <- epicurve.weeks(x.date, sunday = FALSE, axisnames = FALSE, col = col)
  axis(1, at = ebola$xvals, labels = ebola$cweek, tick = FALSE, line = 0)
  axis(1, at = ebola$xvals, labels = ebola$cmonth, tick = FALSE, line = 1)
  title(main= paste0(state,": Ebola - ", title), ylab = "fréquence", xlab = "2014 - semaines")
  copyright(an=2014, titre="HUS-Cellule NRBCE")
}

#===========================================================================
# copyrigth
#===========================================================================
#'@title copyrigth
#'@author JcB
#'@description Place un copyright Resural sur un graphique. 
#'Par défaut la phrase est inscrite verticalement sur le bord droit de l'image
#'@param an (str) année du copyright (par défaut 2013)
#'@param side coté de l'écriture (défaut = 4)
#'@param line distance par rapport au bord. Défaut=-1, immédiatement à l'intérieur du cadre
#'@param titre
#'@param cex taille du texte (défaut 0.8)
#'@return "© 2012 Resural"
#'@usage copyright()
#'
copyright<-function(an ="2013",side=4,line=-1,cex=0.8, titre = "Resural"){
  titre<-paste("©", an, titre, sep=" ")
  mtext(titre,side=side,line=line,cex=cex)
}

# obsolète
new.death <- function(d, state, compte = "Death"){
  a <- tapply(d$Death[d$Pays == state], d$Date[d$Pays == state], sum)
  a1 <- names(a)
  a2 <- as.numeric(a)
  a3 <- c(0, diff(a)) # premier élément = 0 car 1ère différence nulle
  a3[a3 < 0] <- 0 # si différence négative on ramène à 0
  b <- data.frame(a1,a2,a3)
  names(b) <- c("date","cumul","delta")
  return(b)
}