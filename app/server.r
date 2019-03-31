library(shiny)
library(ggplot2)
library(leaflet)
library(magrittr)

pizza <- jsonlite::fromJSON('FavoriteSpots.json') %>% 
    tidyr::unnest()

shinyServer(function(input, output, session){
    
    output$CarsHistogram <- renderPlot(
        ggplot(mtcars, aes_string(x=input$ColumnName)) +
            geom_histogram(bins=input$NumBins)
    )
    
    output$PizzaTable <- DT::renderDataTable(
        pizza, rownames=FALSE
    )
    
    output$PizzaMap <- renderLeaflet(
        leaflet() %>% 
            addTiles() %>% 
                addMarkers(
                    lng = ~ longitude, 
                    lat = ~ latitude, 
                    popup = ~ Name,
                    data=pizza %>% 
                        dplyr::slice(
                            as.integer(
                                input$PizzaTable_rows_selected
                            )
                        )
                )
    )
        
})