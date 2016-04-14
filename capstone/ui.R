library(shiny)

shinyUI(fluidPage(
  titlePanel("Text Predictor"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("This application will attempt to predict what you are going to say:"),
      
      textInput("var", label = "Enter Text")
    ),
    
    mainPanel(
      htmlOutput("prediction")
    )
  )
))