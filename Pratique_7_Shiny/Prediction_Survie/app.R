#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      numericInput("age","Quel est votre age", 18, min = 18)
    ),
    mainPanel(textOutput("age_affiche"))
  )

)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$age_affiche <- renderText({
    paste("L'age de l'individu est", input$age)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
