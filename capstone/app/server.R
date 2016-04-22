library(shiny)

bigrams <- read.csv('bigrams.csv')
trigrams <- read.csv('trigrams.csv')

shinyServer(function(input, output) {
  
  bigramPrediction <- reactive({
    lastWord <- paste(tail(strsplit(input$var,split=" ")[[1]],1), collapse = ' ')
    term <- paste("^", lastWord, sep = "")
    bigramsFound <- bigrams[grep(term, bigrams$bigram),]
    bigramsFound <- bigramsFound[order(bigramsFound$Frequency, decreasing = TRUE), ]
    bigramsFound[1, 1]
  })
  
  trigramPrediction <- reactive({
    if (length(grep(" ", input$var)) == 1) {
      lastTwoWords <- paste(tail(strsplit(input$var,split=" ")[[1]],2), collapse = ' ')
      term <- paste("^", lastTwoWords, sep = "")
      trigramsFound <- trigrams[grep(term, trigrams$trigram),]
      trigramsFound <- trigramsFound[order(trigramsFound$Frequency, decreasing = TRUE), ]
      trigramsFound[1:1, 1]
    }
  })
  
  output$prediction <- renderUI({
    biPred <- bigramPrediction()
    triPred <- trigramPrediction()
    
    if(length(triPred) > 0 && !is.na(triPred)){
      pred <- c(as.character(triPred))
    } else if(length(biPred) > 0 && !is.na(biPred)) {
      pred <- c(as.character(biPred))
    } else {
      pred <- 'the'
    }
    
    HTML(tail(strsplit(pred,split=" ")[[1]],1))
  })
})