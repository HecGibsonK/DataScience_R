#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)











# Define server logic required to draw a histogram
server <- function(input, output) {
  
  Modele_logistique <- readRDS("E:/WORLD/PERSO/Programmation/GitHub/DataScience_R/Pratique_7_Shiny/model_logistique_final.rds") 
  
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



# Run the application 
shinyApp(ui = ui, server = server)
