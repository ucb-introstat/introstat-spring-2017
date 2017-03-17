# Title: Probability histograms
# Description: Probability histograms for the number of heads 
#              in "n" tosses of a coin
# Chapter 18: Normal Approx, p 316
# Author: Gaston Sanchez

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Give the page a title
  titlePanel("Tossing Coins"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      sliderInput("tosses", label = "Number of tosses:",  
                   min = 1, max = 500, value = 100, step = 1),
      sliderInput("chance", label = "Chance of heads", 
                  min = 0, max = 1, value = 0.5, step= 0.05),
      hr(),
      helpText('Expected Value:'),
      verbatimTextOutput("exp_value"),
      helpText('Standard Error'),
      verbatimTextOutput("std_error")
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("chancePlot")  
    )
  )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # Expected Value
  output$exp_value <- renderPrint({ 
    input$tosses * input$chance
  })
  
  # Standard Error
  output$std_error <- renderPrint({ 
    sqrt(input$tosses * input$chance * (1 - input$chance))
  })

  # Fill in the spot we created for a plot
  output$chancePlot <- renderPlot({
    probs <- 100 * dbinom(0:input$tosses, 
                          size = input$tosses, 
                          prob = input$chance)
    
    exp_value <- input$tosses * input$chance
    std_error <- sqrt(input$tosses * input$chance * (1 - input$chance))
    
    below3se <- (exp_value - 3 * std_error)
    above3se <- (exp_value + 3 * std_error)
    
    from <- floor(below3se) + 1
    to <- ceiling(above3se) + 1
    
    if (input$tosses >= 10 & from > 0) {
      xpos <- barplot(probs[from:to], plot = FALSE)
      # Render probability histogram as a barplot
      op = par(mar = c(6.5, 4.5, 4, 2))
      barplot(probs[from:to], axes = FALSE, col = "gray70", 
              names.arg = (from-1):(to-1), border = NA,
              ylim = c(0, ceiling(max(probs))),
              ylab = "probability (%)", 
              main = sprintf("Probability Histogram\n %s Tosses", 
                             input$tosses))
      axis(side = 2, las = 1)
      axis(side = 1, line = 3,
           at = seq(xpos[1], xpos[length(xpos)], length.out = 7),
           labels = seq(-3, 3, 1))
      mtext("Standard Units", side = 1, line = 5.5)
      par(op)
    } else {
      barplot(probs, axes = FALSE, col = "gray70", 
              names.arg = 0:input$tosses, border = NA,
              ylim = c(0, ceiling(max(probs))),
              ylab = "probability (%)", 
              main = sprintf("Probability Histogram\n %s Tosses", 
                             input$tosses))
      axis(side = 2, las = 1)
    }
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

