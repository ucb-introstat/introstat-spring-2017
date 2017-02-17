# Title: Spread within vertical strips in regression
# Description: this app uses Pearson's height data 
# Author: Gaston Sanchez

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
    checkboxInput('reg_line', label = strong('Regression line')),
    sliderInput("cex", 
                label = "Size of points",
                min = 0, max = 3, value = 1.5, step = 0.1),
    #checkboxInput('point_avgs', label = strong('Point of Averages')),
    #checkboxInput('sd_line', label = strong('SD line')),
    #checkboxInput('sd_guides', label = strong('SD guides')),
    sliderInput("center", 
                label = "x location",
                min = 60, 
                max = 76, 
                value = 70, step = 0.25),
    sliderInput("width", 
                label = "width",
                min = 0, 
                max = 4, 
                value = 0, step = 0.1),
    hr(),
    helpText('Correlation:'),
    verbatimTextOutput("correlation")
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    plotOutput("datPlot"),
    plotOutput("histogram")
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
    # Render scatterplot
    plot(dat[,input$xvar], dat[,input$yvar],
         main = 'scatter diagram', type = 'n', axes = FALSE,
         xlab = input$xvar, ylab = input$yvar)
    box()
    axis(side = 1)
    axis(side = 2, las = 1)
    points(dat[,input$xvar], dat[,input$yvar],
           pch = 21, col = 'white', bg = '#777777aa',
           lwd = 2, cex = input$cex)
    # vertical strips
    abline(v = c(input$center - input$width, input$center + input$width),
           lty = 1, lwd = 3, col = '#5A6DE3')
    # Regression line
    if (input$reg_line) {
      reg <- lm(dat[,input$yvar] ~ dat[,input$xvar])
      abline(reg = reg, lwd = 3, col = '#e35a6d')
    }
  })
  
  # histogram
  output$histogram <- renderPlot({
    xmin <- input$center - input$width
    xmax <- input$center + input$width
    child <- dat$Son[dat$Father >= xmin & dat$Father <= xmax]
    hist(child, main = '', col = '#ACB6FF', las = 1)
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

