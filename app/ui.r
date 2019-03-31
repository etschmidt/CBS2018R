library(shiny)
library(shinythemes)

plotsPanel <- tabPanel(
    'Plots', 
    fluidRow(
        column(
            width=4, 
            selectInput(
                inputId='ColumnName', 
                label='Choose a column',
                choice=names(mtcars)
            ), 
            sliderInput(
                inputId='NumBins', 
                label='How Mnay Bins',
                min=5, max=50, value=30
            )
        ),
        column(
            width=8, 
            plotOutput(
                outputId='CarsHistogram'
                
            )
        )
    )
)

mapPanel <- tabPanel(
    title='Pizza', 
    fluidRow(
        column(
            width=6, 
            DT::dataTableOutput(
                outputId = 'PizzaTable'
            )
        ),
        column(
            width=6, 
            leaflet::leafletOutput(
                outputId = 'PizzaMap'
            )
        )
    )
)
    

navbarPage(
    title='My First App',
    selected='Pizza',
    # themeSelector(),
    theme=shinytheme(theme='cosmo'),
    tabPanel(
        'Sator', 
        'Hello World'
    ),
    tabPanel(
        'Arepo'
    ), 
    plotsPanel, 
    mapPanel
)