getwd()  # Identifier son répertoire de travail

setwd("E:\\WORLD\\PERSO\\Programmation\\GitHub\\DataScience_R\\Pratique_2") # Changer son répertoire de travail


library(ggplot2)    # Visualisation des données
library(readxl)     # Bibliothèque de manipulation de données dans Excel
library(dplyr)      # Bibliothèque de manipulation de données statistiques
library(psych)     # Bibliothèque de statistiques descriptives
options(digits = 3) # Combien de décimales afficher

#La lecture du fichier
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

# 5 derniers clients de la table
tail(Clients, 5)

# Structrure de la base de données
str(Ventes)

# Nombre de ligne 
nrow(Clients)
nrow(Ventes)

# nombre de colonne
ncol(Clients)
ncol(Ventes)

# dimension de la base des donnees
dim(Clients)
dim(Ventes)

# nom des colonnes
nom_colonne_Client <- colnames(Clients)

nom_colonne_Vente <- colnames(Ventes)

# Description rapide de la base de donnée
summary(Ventes)
summary(Clients)
Clients$AgeGroup <- as.factor(Clients$AgeGroup)
Clients$EducationLevel <- as.factor(Clients$EducationLevel)


# Les groupes de la base de données
unique(Clients$AgeGroup)
unique(Clients$CustomerCategory)

# Nombre d'individu par groupe
categorie_stat <- table(Clients$CustomerCategory)
prop.table(categorie_stat)

# Nombre de valeur manquante sur le prix
sum(is.na(Ventes$Price))

# Nombre de valeur manquante sur la base de donnée
colSums(is.na(Ventes))

# Remplacer la valeur manquante sur le prix par la valeur zero
venteb <- Ventes
venteb$Price[is.na(venteb$Price)] <- 0
colSums(is.na(venteb))

# Supprimer les valeurs manquantes
ventec <- na.omit(Ventes)
dim(ventec)
colSums(is.na(ventec))

# Renommer la colonne name en nom
rename(Clients, "name" = "nom") # Cette fonction ne change pas le nom de la colonne dans le fichier source
View(Clients)

colnames(Clients)[2] <- "nom" # Cette fonction change le nom de la colonne dans le fichier source


View(Ventes)
# Créer la colonne montantTotal
Ventes$MontantTotal <- Ventes$Quantity * Ventes$Price

# Somme du chiffre d'affaire total
sum(Ventes$MontantTotal, na.rm = T)
View(Ventes)

# Liste des produits dont le prix est supérieur à 40
liste_produit <- Ventes[Ventes$Price > 40, ]

liste_produit <- Ventes[Ventes$Price > 40, c("CustomerID", "ProductID")]


View(Clients)
# Donner la liste des Clients premium
liste_premium <- Clients[Clients$CustomerCategory == "Premium", ]
liste_premium

liste_client_premium <- Clients %>% 
  filter(CustomerCategory == "Premium")

liste_client_premium <- filter(Clients, CustomerCategory == "Premium")

# Joindre les deux tables
jointure <- left_join(Ventes, Clients, by = "CustomerID")

jointure1 <- inner_join(Ventes, Clients, by = "CustomerID")

jointure2 <- merge(Ventes, Clients, by ="CustomerID") ## Faire joindre les 2 tableaux en ordre croissant

colnames(Clients)
# Somme du chiffre d'affaire par type client
summarise(group_by(jointure,CustomerCategory), nb =n())

jointure %>% 
  group_by(CustomerCategory) %>% 
  summarise(somme = sum(MontantTotal, na.rm = T), moyenne = mean(MontantTotal, na.rm = T), nombre = n())

# Liste des produits dont le prix est supérieur à 40 sans les valeurs manquantes
liste_produit <- Ventes[(Ventes$Price > 40) & is.na(Ventes$Price) == FALSE, ]
View(liste_produit)
View(Ventes)
 
 