library(shiny)

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

navbarPage(
    title='My First App',
    selected='Plots',
    tabPanel(
        'Sator', 
        'Hello World'
    ),
    tabPanel(
        'Arepo'
    ), 
    plotsPanel
)