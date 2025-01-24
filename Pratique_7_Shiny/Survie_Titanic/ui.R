#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(shinydashboard)

# Define UI for application that draws a histogram
ui <- dashboardPage(
  
  dashboardHeader(title = "Prediction de la survie sur le Titanic"),
  
  dashboardSidebar(
    menuItem("Inputs", tabName = "Inputs"),
    menuItem("Prediction", tabName = "Prediction", icon = icon("dashboard"))
  ),
  
  dashboardBody(
    
    tabItems(
      
      tabItem(tabName = "Inputs",
              
              selectInput("Pclass", "Classe du passager", c("1","2","3"), NULL),
              selectInput("Sex", "Genre du passager", c("male","female")),
              numericInput("Age", "Age du passager", 5, min = 0, max = 120),
              numericInput("SibSp", "Nombre de freres/soeurs ou epoux/epoues a bord", 2, min = 0, max = 8),
              numericInput("Parch", "Nombre de parents/enfants a bord", 2, min = 0, max = 10),
              numericInput("Fare", "Tarif", 30, min = 0, max = 3000),
              actionButton("predict", "Prédire")
        
      ),
      
      tabItem(tabName = "Prediction",
        
        h2("Le resultat de la prediction"),
        textOutput("prediction")
        
      )
      
    )
    
  )
  
)