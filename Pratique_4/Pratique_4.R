getwd()  # Identifier son répertoire de travail

setwd("E:\\WORLD\\PERSO\\Programmation\\GitHub\\DataScience_R\\Pratique_4") # Changer son répertoire de travail

library(ggplot2)    # Visualisation des données
library(readxl)     # Bibliothèque de manipulation de données dans Excel
library(dplyr)      # Bibliothèque de manipulation de données statistiques
library(psych)     # Bibliothèque de statistiques descriptives
options(digits = 3) # Combien de décimales afficher

# Creer une fonction qui va realiser les statistiques descriptives --------
# de toutes les colonnes quantitatives d'une base de donnees --------------
# Retourne un dataframe avec le resultat ----------------------------------

# Calcul de la somme de deux nombres
Somme <- function(a,b){
  resultat <- a+b;
  return(resultat)
}
#Application
a <- 6;
b <- 5;
Somme(a,b)


# La lecture du fichier
# Importer des données d'un fichier (.txt ou .csv) dans Rstudio
#  sep=";" -- indique le separateur des colonnes du fichier (Exemple les format .txt) 
#  dec = "," -- indique le format decimal du fichier


# Importation -------------------------------------------------------------

# Importaion du fichier client (csv)
DClients = read.table(file.choose(), sep=";", header = T)
#dataC = read.csv(file.choose(), sep=";", header = T)

# Importaion du fichier client (xlsx)
DClients1 = read_excel(file.choose())

############
# Imporation de la base Ventes (csv)
DVentes = read.table(file.choose(), sep=";", header = T)
#dataV = read.csv(file.choose(), sep=";", header = T)

# Importaion du fichier Ventes (xlsx)
DVentes1 = read_excel(file.choose(), sheet=1, col_names = TRUE)
############

glimpse(DClients)    # Voir la structure de la base de données (format plus allonge)
str(DClients)        # voir la structure de la base de données
View(DClients)       # Visionner les donnees

# Duplication de la base de donnee
Clients <- DClients
Ventes <- DVentes

# Suppression des lignes avec des données manquantes
Clients <- na.omit(Clients)
Ventes <- na.omit(Ventes)
# - -----------------------------------------------------------------------

# if else en R: tester si une variable est quantitative
if (is.numeric(Ventes$Quantity)){
  Ans = "Numerique";
  print(Ans)
}else {
  Ans = "Non Numerique";
  print(Ans)
}

# Boucle For en R
for (variable in names(Ventes)) {
  if (is.numeric(Ventes[[variable]])){
    print(paste0(variable," est un numerique"))
  }else {
    print(paste0(variable," n'est pas numerique"))
  }
}


base_donnee <- Ventes;
statistique_descriptive <- function(base_donnee){
  Resultat <- data.frame(Nom_variable = character(), 
                         min = numeric(), 
                         max = numeric(), 
                         moyenne = numeric(), 
                         variance = numeric()
                         )
  liste_variable <- names(base_donnee)
  
  for (variable in liste_variable) {
    if(is.numeric(base_donnee[[variable]])){
      min <- min(base_donnee[[variable]]);
      max <- max(base_donnee[[variable]]);
      moyenne <- mean(base_donnee[[variable]]);
      variance <- var(base_donnee[[variable]]);
      
      Resultat[nrow(Resultat)+1,] <- c(variable, min, max, moyenne, variance)
    }
  }
  return(Resultat)
}

statistique_descriptive(Ventes)
