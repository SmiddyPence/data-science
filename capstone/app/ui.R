library(shiny)

shinyUI(fluidPage(
  titlePanel("Text Predictor"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("This application will attempt to predict what you are going to say:"),
      
      textInput("var", label = "Enter Text"),
      br(),
      helpText("It may take a little while to warm up the first time the application opens"),
      helpText("Fun Starters:"),
      tags$li("Killing me..."),
      tags$li("The donkey...")
    ),
    
    mainPanel(
      h3("Next Word"),
      htmlOutput("prediction")
    )
    
  )
))