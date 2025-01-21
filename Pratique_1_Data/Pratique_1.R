getwd()  # Identifier son répertoire de travail

setwd("E:\\WORLD\\PERSO\\Programmation\\GitHub\\DataScience_R\\Pratique_1") # Changer son répertoire de travail

##### installation et configuration de R et Rstudio ##### 
# Pour l'installation R, je vous conseil d'aller sur le site "https://cran.r-project.org/"
# Pour l'installation RStudio, je vous conseil d'aller sur le site "https://posit.co/"
##### Types et structures de donnees en R ##### 
##### Operations de base avec R ##### 



##### Exercice 1 : Commentaires
# Ajoutez un commentaire au-dessus de chaque ligne de code expliquant ce qu'elle fait.

##### Exercice 2 : Variables  // Création de la variable prénom
# Créez une variable appelée "animal" et assignez-lui le nom de votre animal préféré.
Animal <- "Requin"
Animal

Age <- 32

##### Exercice 3 : Modification de variables  // Création de la variable Animal
# Modifiez la variable "animal" pour qu'elle contienne le nom d'un animal différent. Affichez le contenu de la variable.
Animal <- "Megalodon"
Animal

Age <- 33

##### Exercice 4 : Graphiques de base  //  Création d'un graphique
# Utilisez la fonction plot() pour créer un graphique simple. Le graphique doit représenter les points (1,1), (2,4), (3,9) et (4,16).
plot(x = c(1,2,3,4, -2, 6,0), y=c(1,4,9,16,-2,6,1))

##### Exercice 5 : Installation et chargement des packages
# Installez le package "data.table" et chargez-le. Utilisez la fonction help() pour chercher de l'aide sur la fonction fread() de ce package.

# Installation de packages
install.packages("shiny")
install.packages("ggplot2")
# Chargement du package
library(ggplot2)
require(ggplot2)
ggplot(x,y)
# Aide sur les packages en R
?ggplot
help(ggplot)
??shiny

# Exemple ggplot 

set.seed(1)

sample_df <- data.frame(
  group = factor(rep(letters[1:3], each = 10)),
  value = rnorm(30)
)

group_means_df <- setNames(
  aggregate(value ~ group, sample_df, mean),
  c("group", "group_mean")
)

# The following three code blocks create the same graphic, each using one
# of the three patterns specified above. In each graphic, the sample data
# are plotted in the first layer and the group means data frame is used to
# plot larger red points on top of the sample data in the second layer.

# Pattern 1
# Both the `data` and `mapping` arguments are passed into the `ggplot()`
# call. Those arguments are omitted in the first `geom_point()` layer
# because they get passed along from the `ggplot()` call. Note that the
# second `geom_point()` layer re-uses the `x = group` aesthetic through
# that mechanism but overrides the y-position aesthetic.

ggplot(data = sample_df, mapping = aes(x = group, y = value)) +
  geom_point() +
  geom_point(
    mapping = aes(y = group_mean), data = group_means_df,
    colour = 'red', size = 3
  )


##### Exercice 6 : Vecteurs
# Créez un vecteur appelé "mois" contenant les noms des douze mois de l'année. Accédez au 6ème élément du vecteur.
# Les types de données en R

Bal <- c(100,55, 68, 96, 87, 30, 88)
Bal
# lire le premier élement Read
Bal[1]

# Deuxième élément
Bal[2]

# taille d'un vecteur
length(Bal)
# Dernier élément du vecteur
Bal[length(Bal)]


##### Exercice 7 : Modification de vecteurs
# Remplacez le 6ème élément du vecteur "30" par "51". Affichez le vecteur modifié.
# Mettre à jour le vecteur
Bal[6] <- 51
Bal


BalNew <- Bal[-c(1,2,3)]
BalNew

# Supprimer un élément dans un vecteur (Delete)
Bal <- Bal[-1]
Bal
length(Bal)

##### Exercice 8 : Suppression dans un vecteur
# Supprimez les 3 premiers éléments du vecteur "100,55 et 68" et affichez le vecteur résultant.

Bal <- c(100,55, 68, 96, 87, 30, 88)

BalNew <- Bal[-c(1,2,3)]
BalNew


##### Exercice 9 : Ajout à un vecteur
# Ajoutez le mot "Decembre" à la fin du vecteur "mois". Affichez le vecteur mis à jour.

# ajouter une nouvelle notes
Bal <- c(Bal, 99)
Bal

# Nom des matières
nom_matiere <- c("C++", "C#", "R", "Python", "Algèbre", "Analyse","Algèbre", "Analyse")

# Type des noms de matière
str(nom_matiere)

nom_matiere_facteur <- factor(nom_matiere)
nom_matiere_facteur
levels(nom_matiere_facteur)

##### Exercice 10 : Listes
# Créez une liste appelée "informations" contenant votre nom, votre âge et vos trois activités préférées. Affichez toute la liste.

# Création des listes: Create

liste_etudiants <- list(
  Nom = "Gibi", 
  Age = 32, 
  Bals = Bal
)

# Type de données
str(liste_etudiants)
# Lire les éléments de la liste
liste_etudiants$Nom
liste_etudiants$Age
liste_etudiants$Bals


##### Exercice 11 : Accès aux éléments d'une liste
# Accédez à votre âge dans la liste "informations" et affichez-le.

liste_2 <- list(
  Nom = "Gibi", 
  Age = 32, 
  Bals = Bal
)

liste_2$Age

# liste de liste 
liste_3 <- list(
  temp = liste_etudiants, 
  tempbis = liste_2
)

liste_3$tempbis

##### Exercice 12 : Matrices
# Créez une matrice 2x3 contenant les nombres de 1 à 6. Affichez la matrice.

# Créer des matrice Create
test <-1:15
#La matrice est remplie par des colonnes sinon la matrice est remplie par des lignes
matrice_1 <- matrix(test, nrow = 5, ncol = 3, byrow = F)
matrice_1

#La matrice est remplie par des lignes
matrice_2 <- matrix(test, nrow = 5, ncol = 3, byrow = T) 
matrice_2
##### Exercice 13 : Accès et modification de matrices
# Accédez au numéro situé à la deuxième ligne, première colonne de votre matrice. Modifiez-le par le nombre 10. Affichez la matrice modifiée.
# Première ligne première colonne
matrice_1[1,1]

# Deuxième ligne troisième colonne
matrice_1[2,3]

# Accéder à la ligne
matrice_1[1,]
# Accéder à la troisième colonne

matrice_1[,3]

# Modifier la première ligne
matrice_1[1,] <- c(20,30,40)
matrice_1

# Modifier la première colonne de la matrice
matrice_1[,1] <- c(21,45,200,0,35)
matrice_1

# Deux 
matrice_1[1:2,1:2]


##### Exercice 14 : Dataframes
# Créez un dataframe appelé 
df <- data.frame(
  Noms=c("Git", "Giz", "Gis", "Gibs", "Gely"), 
  Age = c(42, 38, 34, 32, 25)
)

df
# Visualiser le dataframe
View(df)

# Read 
df$Noms
df$Age
df[["Noms"]]
df[["Age"]]
df[[2]]

df[1:2,2]
# 3 première ligne et la première colonne
df[1:3, 1]


##### Exercice 15 : Opérations sur les dataframes
# Calculez la moyenne du nombre de pattes dans votre dataframe "animaux".
# Opération mathématique
moyenne <- mean(df$Age)
moyenne
maximum <- max(df$Age)
maximum

minimum <- min(df$Age)
minimum

variance <- var(df$Age)
variance

# Productivité vecteur
temp <- 1:10
temp

# Création des séquence
temp <- seq(1,10,1)
temp

# Repétition des éléments
temp_bis <- rep(5, 10)
temp_bis

temp_bis <- rep(c(1,4), 10)
temp_bis
