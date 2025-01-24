#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(DT)

# Define server logic required to draw a histogram
function(input, output, session) {
  
  
  Modele_logistique <- readRDS("E:/WORLD/PERSO/Programmation/GitHub/DataScience_R/Pratique_7_Shiny/model_logistique_final.rds") 
  
  data <- reactiveVal() # Pour stocker les données importées
  
  observeEvent(input$loadData, {
    req(input$file1) # S'assurer qu'un fichier est bien chargé
    # Utilisation de ';' comme séparateur
    df <- read.csv(input$file1$datapath, sep =",")
    
    # Conversion de 'Pclass' et 'Sex' en facteurs
    df$Pclass <- as.factor(df$Pclass)
    df$Sex <- factor(df$Sex, levels = c("male", "female"))
    
    data(df)
    
    output$dataTable <- renderDT({
      req(data()) # S'assurer que les données sont disponibles
      data()
    }, options = list(pageLength = 5)) # Limiter le nombre de lignes affichées
  })
  
  
  
  
  
  
  
  
  
  
  output$prediction <- renderText({
    
    #Preparation des donees
    New_data <- data.frame(
      
      Pclass = as.factor(input$Pclass),
      Sex = as.factor(input$Sex),
      Age = as.numeric(input$Age),
      SibSp = as.numeric(input$SibSp),
      Parch = as.numeric(input$Parch),
      Fare = as.numeric(input$Fare)
      
    )
    
    pro <- predict(Modele_logistique, newdata = New_data, type = "response")
    
    pred <- ifelse(pro > 0.5, "Survie", "Non survie")
    
    paste(pred, " avec une probabilite de", pro)
    
  })
  
  
}
