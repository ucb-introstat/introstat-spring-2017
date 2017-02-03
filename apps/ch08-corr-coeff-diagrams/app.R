#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(MASS)


# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Scatter Diagrams and Correlation"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        numericInput("seed",
                     "Random seed",
                     min = 100,
                     max = 99999,
                     value = 1234),
        sliderInput("corr",
                     "Correlation Coefficient",
                     min = -1,
                     max = 1,
                     step = 0.05,
                     value = 0.7),
         sliderInput("size",
                      "Number of points",
                      min = 10,
                      max = 5000,
                      step = 5,
                      value = 500),
         sliderInput("cex",
                     "Size of points",
                     min = 0,
                     max = 5,
                     step = 0.1,
                     value = 1),
        sliderInput("alpha",
                    "Transparency of points",
                    min = 0,
                    max = 1,
                    step = 0.01,
                    value = 0.8)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("scatterplot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$scatterplot <- renderPlot({
     # generate bins based on input$bins from ui.R
     set.seed(input$seed)
     cor_matrix = matrix(c(1, input$corr, input$corr, 1), 2)
     xy = mvrnorm(input$size, c(0, 0), cor_matrix)
     plot(xy, type = "n", axes=FALSE, xlab="", ylab="",
          xlim=c(-3, 3), ylim=c(-3, 3))
     abline(h=0, v=0, col="gray80", lwd = 2)
     points(xy[,1], xy[,2], pch=20, cex=input$cex,
            col=rgb(0.45, 0.59, 0.84, alpha = input$alpha))
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

