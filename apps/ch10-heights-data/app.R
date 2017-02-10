#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
source('helpers.R')

# reading a couple of lines just to get the names of variables
dat <- read.csv('../../data/pearson.csv')

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Pearson's Height Data Set"),
   
   # Define the sidebar with one input
   sidebarPanel(
     selectInput("xvar", "X-axis variable", 
                 choices = colnames(dat), selected = 'Father'),
     selectInput("yvar", "Y-axis variable", 
                 choices = colnames(dat), selected = 'Son'),
     sliderInput("cex", 
                 label = "Size of points",
                 min = 0, max = 3, value = 2, step = 0.1),
     checkboxInput('reg_line', label = strong('Regression line')),
     checkboxInput('point_avgs', label = strong('Point of Averages')),
     checkboxInput('sd_line', label = strong('SD line')),
     checkboxInput('sd_guides', label = strong('SD guides')),
     sliderInput("breaks", 
                 label = "Graph of Averages",
                 min = 0, max = 10, value = 0, step = 1),
     hr(),
     helpText('Correlation:'),
     verbatimTextOutput("correlation")
   ),
   
   # Show a plot of the generated distribution
   mainPanel(
     plotOutput("datPlot")
   )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
   
  # Correlation
  output$correlation <- renderPrint({ 
    cor(dat[,input$xvar], dat[,input$yvar])
  })
  
  # Fill in the spot we created for a plot
  output$datPlot <- renderPlot({
    # standard deviations
    sdx <- sd(dat[,input$xvar])
    sdy <- sd(dat[,input$yvar])
    avgx <- mean(dat[,input$xvar])
    avgy <- mean(dat[,input$yvar])
    
    # Render scatterplot
    plot(dat[,input$xvar], dat[,input$yvar],
         main = 'scatter diagram', type = 'n', axes = FALSE,
         xlab = paste(input$xvar, " height (in)"), 
         ylab = paste(input$yvar, "height (in)"))
    box()
    axis(side = 1)
    axis(side = 2, las = 1)
    points(dat[,input$xvar], dat[,input$yvar],
           pch = 21, col = 'white', bg = '#777777aa',
           lwd = 2, cex = input$cex)
    # Point of Averages
    if (input$point_avgs) {
      points(avgx, avgy, 
             pch = 21, col = 'white', bg = 'tomato',
             lwd = 3, cex = 3)
    }
    # SD line
    if (input$sd_line) {
      cor_xy <- cor(dat[,input$xvar], dat[,input$yvar])
      if (cor_xy >= 0) {
        sd_line <- line_equation(avgx - sdx, avgy - sdy, avgx + sdx, avgy + sdy)
        abline(a = sd_line$intercept, b = sd_line$slope, 
               lwd = 4, lty = 2, col = 'orange')
      } else {
        sd_line <- line_equation(avgx + sdx, avgy - sdy, avgx - sdx, avgy + sdy)
        abline(a = sd_line$intercept, b = sd_line$slope, 
               lwd = 4, lty = 2, col = 'orange')
      }
    }
    # SD guides
    if (input$sd_guides) {
      abline(v = c(avgx - sdx, avgx + sdx), 
             h = c(avgy - sdy, avgy + sdy), 
             lty = 1, lwd = 3, col = '#FFA600aa')
    }
    # Graph of averages
    if (input$breaks > 1) {
      graph_avgs <- averages(dat[,input$xvar], dat[,input$yvar],
                             breaks = input$breaks)
      points(graph_avgs$x, graph_avgs$y, pch = "+",
             col = '#ff6700', cex = 3)
    }    
    # Regression line
    if (input$reg_line) {
      reg <- lm(dat[,input$yvar] ~ dat[,input$xvar])
      abline(reg = reg, lwd = 4, col = '#4878DF')
    }
    
  }, height = 650, width = 650)
}


# Run the application 
shinyApp(ui = ui, server = server)

