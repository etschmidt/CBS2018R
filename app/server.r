library(shiny)
library(ggplot2)

shinyServer(function(input, output, session){
    
    output$CarsHistogram <- renderPlot(
        ggplot(mtcars, aes_string(x=input$ColumnName)) +
            geom_histogram(bins=input$NumBins)
    )
    
})