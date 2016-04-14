library(shiny)
library(ggplot2)

bigrams <- read.csv('bigrams.csv')
trigrams <- read.csv('trigrams.csv')

shinyServer(
  function(input, output) {
    
    bigramPrediction <- reactive({
        term <- paste("^",input$var, sep = "")
        bigramsFound <- bigrams[grep(term, bigrams$bigram), ]
        bigramsFound <- bigramsFound[order(bigramsFound$Frequency, decreasing = TRUE),]
        bigramsFound[1:3,1]
    })
    
    output$prediction <- renderUI({ 
      prediction <- bigramPrediction()
      HTML(paste(prediction[1], prediction[1], prediction[3], sep = '<br/>'))
    })
    
  }
)