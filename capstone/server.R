library(shiny)

bigrams <- read.csv('bigrams.csv')
trigrams <- read.csv('trigrams.csv')

shinyServer(function(input, output) {
  
  bigramPrediction <- reactive({
    term <- paste("^", input$var, sep = "")
    bigramsFound <- bigrams[grep(term, bigrams$bigram),]
    bigramsFound <- bigramsFound[order(bigramsFound$Frequency, decreasing = TRUE), ]
    bigramsFound[1:3, 1]
  })
  
  trigramPrediction <- reactive({
    if (length(grep(" ", input$var)) == 1) {
      term <- paste("^", input$var, sep = "")
      trigramsFound <- trigrams[grep(term, trigrams$trigram),]
      trigramsFound <- trigramsFound[order(trigramsFound$Frequency, decreasing = TRUE), ]
      trigramsFound[1:3, 1]
    }
  })
  
  output$prediction <- renderUI({
    biPred <- bigramPrediction()
    all <- c(as.character(biPred))
    
    triPred <- trigramPrediction()
    
    if(length(triPred) > 0){
      all <- c(as.character(triPred), all)
    }
    
    HTML(paste(all, collapse = '<br/>'))
  })
  
})