library(shiny)
library(ggplot2)

dataset <- read.csv('TweetImageData.csv')

fluidPage(
  
  headerPanel("Imaged Tweets"),
  
  sidebarPanel(

    h3("Instructions"),
    
    tags$li("Select image from one of the drop downs (color or facet recommended)"),
    tags$li("Select another feature to explore the data"),
    tags$li("Optionally choose smooth to see the mean line"),
    
    br(),
    
    sliderInput('sampleSize', 'Sample Size', min=1, max=nrow(dataset),
                value=min(50, nrow(dataset)), step=5, round=0),
    
    selectInput('x', 'X', names(dataset)),
    selectInput('y', 'Y', names(dataset), names(dataset)[[2]]),
    selectInput('color', 'Color', c('None', names(dataset))),
    selectInput('facet_row', 'Facet Row', c(None='.', 'Image')),
    checkboxInput('smooth', 'Smooth')
  ),
  
  mainPanel(
    plotOutput('plot')
  )
)
