getwd()  # Identifier son répertoire de travail

setwd("E:\\WORLD\\PERSO\\Programmation\\GitHub\\DataScience_R\\Pratique_3") # Changer son répertoire de travail

# Principaux packages du tidyverse :
# - ggplot2 : Création intuitive de visualisations de données complexes.
# - dplyr : Manipulation de données (filtrage, sélection, réarrangement).
# - tidyr : Transformation des données pour les rendre "tidy" (ordonnées), optimisant leur analyse.
# - readr : Importation rapide et facile de données depuis des fichiers plats (CSV, etc.).
# - purrr : Programmation fonctionnelle pour un code plus clair.
# - tibble : Une version moderne du dataframe avec une impression et sous-ensemble améliorés.
# - stringr : Manipulation de chaînes de caractères.
# - forcats : Gestion de données catégorielles avec des facteurs.
# - lubridate : Manipulation simplifiée des dates et heures.


library(ggplot2)    # Visualisation des données
library(readxl)     # Bibliothèque de manipulation de données dans Excel
library(dplyr)      # Bibliothèque de manipulation de données statistiques
library(psych)     # Bibliothèque de statistiques descriptives
options(digits = 3) # Combien de décimales afficher

# graphique
require(stats)    # for lowess, rpois, rnorm
require(graphics) # for plot methods

# La lecture du fichier
# Importer des données d'un fichier (.txt ou .csv) dans Rstudio
#  sep=";" -- indique le separateur des colonnes du fichier (Exemple les format .txt) 
#  dec = "," -- indique le format decimal du fichier

############
# Importaion du fichier client (csv)
Clients = read.table(file.choose(), sep=";", header = T)
#dataC = read.csv(file.choose(), sep=";", header = T)

# Importaion du fichier client (xlsx)
Clients1 = read_excel(file.choose())

############
# Imporation de la base Ventes (csv)
Ventes = read.table(file.choose(), sep=";", header = T)
#dataV = read.csv(file.choose(), sep=";", header = T)

# Importaion du fichier Ventes (xlsx)
Ventes1 = read_excel(file.choose(), sheet=1, col_names = TRUE)
############

glimpse(Clients)    # Voir la structure de la base de données (format plus allonge)
str(Clients)        # voir la structure de la base de données
View(Clients)       # Visionner les donnees

# Voir les types de donnees de "Clients"
sapply(Clients, class)

# Voir les types de donnees de "Ventes"
sapply(Ventes, class)

# 5 premiers clients de la table 
head(Clients, 5)

#===============================================================================
# Créer la colonne montantTotal
Ventes$MontantTotal <- Ventes$Quantity * Ventes$Price

# Joindre les deux tables
jointure <- left_join(Ventes, Clients, by = "CustomerID")

jointure1 <- inner_join(Ventes, Clients, by = "CustomerID")

jointure2 <- merge(Ventes, Clients, by ="CustomerID") ## Faire joindre les 2 tableaux en ordre croissant

colnames(jointure)
# Somme du chiffre d'affaire par type client
summarise(group_by(jointure,CustomerCategory), nb =n())

jointure %>% 
  group_by(CustomerCategory) %>% 
  summarise(somme = sum(MontantTotal, na.rm = T), moyenne = mean(MontantTotal, na.rm = T), nombre = n())

#===============================================================================
# Relation entre la quantité et le prix
plot(x=jointure$Quantity, y = jointure$Price, xlab = "Quantité", ylab = "Prix", main = "Quantite en fonction du prix", type ="l", col ="blue")


##### Utilisation de ggplot #####
# Les 7 éléments clés de la structure d'un graphique avec ggplot2 sont :
# 1. Le jeu de données : spécifié dans ggplot(data = <données>)
# 2. Les esthétiques (aes) : définissent comment les variables sont mappées sur les aspects visuels tels que x, y, couleur, forme, etc. (aes(x = <variable_x>, y = <variable_y>, color = <variable_couleur>, ...))
# 3. Les couches (layers) : comprennent les objets géométriques (geoms) pour le type de graphique (points, lignes, barres, etc.), les statistiques (stat), et les positions (position)
# 4. Les échelles (scales) : contrôlent le mappage des esthétiques aux valeurs visuelles (échelles de couleurs, échelles de taille, etc.)
# 5. Les systèmes de coordonnées (coord) : ajustent la manière dont l'espace du graphique est utilisé et vu (par exemple, coord_cartesian(), coord_polar(), etc.)
# 6. Les facettes (facets) : pour créer des graphiques en grille basés sur une ou plusieurs variables de regroupement
# 7. Les thèmes (theme) : permettent de personnaliser l'apparence du graphique (couleurs de fond, polices, lignes des axes, etc.)

# Première approche
ggplot(data = jointure, aes(x = Quantity, y = Price, fill = CustomerCategory)) +
  geom_point( size = 3)+
  scale_color_manual(values = c("blue","red","green","grey"))+
  facet_wrap(~CustomerCategory)


ggplot(data = jointure, aes(x = Quantity, y = Price)) +
  geom_point(col = "red", size = 3)+
  xlab(label = "Quantite")+
  ylab(label ="Prix")+
  ggtitle("Quantité en fonction du prix")


# Histogramme avec une fonction native
hist(jointure$Price)
ggplot(data = jointure, aes(Price))+
  geom_histogram(bins = 40, color = "blue", aes(fill=CustomerCategory))+
  facet_grid(vars(CustomerCategory))


# Boxplot avec les fonctions natives
boxplot(Price ~ CustomerCategory, data = jointure)

##
list_variable <- c("Price", "Quantite")
for (i  in list_variable) {
  
}
##

# Couleurs par catégorie
ggplot(data = jointure, aes(x=CustomerCategory, y=Price))+
  geom_boxplot(aes(fill = CustomerCategory))

# Couleurs par catégorie changer les couleurs manuellement
ggplot(data = jointure, aes(x=CustomerCategory, y=Price))+
  geom_boxplot(aes(fill = CustomerCategory))+
  scale_fill_manual(values = c("blue", "red", "green", "grey"))

# Repartition des groupes d'âge

# Fonction native
jointure$AgeGroup <- as.factor(jointure$AgeGroup)
barplot(table(jointure$AgeGroup))

ggplot(data = jointure, aes(AgeGroup))+
  geom_bar()

ggplot(data = jointure, aes(AgeGroup))+
  geom_col()


#===============================================================================

# Date en avec lubridate
View(jointure)
str(jointure)

library(lubridate)
jointure$datebis <- dmy_hm(jointure$Date)
jointure$datebis2 <- as.Date(jointure$datebis)
str(jointure)
# obtenir le mois
mois <- month(jointure$datebis2)
jour <- day(jointure$datebis2)
annee <- year(jointure$datebis2)


# Utiliser des chaîne de caractère en R
library(stringr)
ma_chaine <- "Bienvenue sur LeCoinStat"
str_c("Letter: ", letters)

fruit <- c("apple", "banana", "pear", "pineapple")
str_like(fruit, "app")
str_like(fruit, "app%")
str_like(fruit, "ba_ana")
str_like(fruit, "%APPLE")


#===============================================================================
str_length(ma_chaine)
# Exemple de dataframe
set.seed(123) # Pour la reproductibilité
df <- data.frame(
  var1 = rnorm(100),
  var2 = rnorm(100, mean = 2),
  var3 = rnorm(100, mean = -1, sd = 2)
)

# Liste des noms de variables pour lesquelles tu veux des boxplots
variables <- names(df)

# Boucle pour générer un boxplot pour chaque variable
for(var in variables) {
  p <- ggplot(df, aes_string(x = "factor(1)", y = var)) +
    geom_boxplot() +
    labs(title = paste("Boxplot de", var),
         x = "",
         y = var) +
    theme_minimal()
  
  # Afficher le plot
  print(p)
  ggsave()
}
