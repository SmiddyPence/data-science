library(shiny)
library(ggplot2)

shinyUI(fluidPage(
  titlePanel("Text Predictor"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("This application will attempt to predict your next word:"),
      
      textInput("var", label = "Enter Text")
    ),
    
    mainPanel(
      htmlOutput("prediction")
    )
  )
))