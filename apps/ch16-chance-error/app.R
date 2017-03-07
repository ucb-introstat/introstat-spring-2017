# Title: Chance Error and Percent Error
# Description: Chance error when tossing a coin (based on John Kerrich's)
# Chapter 16: The Law of Averages, p 275-278
# Author: Gaston Sanchez

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Give the page a title
  titlePanel("Coin Tossing Experiment"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      numericInput("seed", label = "Random Seed:", 12345, 
                   min = 10000, max = 50000, step = 1),
      sliderInput("chance", label = "Chance of heads:", 
                  min = 0, max = 1, value = 0.5, step = 0.01),
      sliderInput("tosses", label = "Number of tosses:", 
                  min = 100, max = 10000, value = 3000, step = 50),
      radioButtons("error", label = "Display",
                   choices = list("Chance error" = 1, 
                                  "Percent error" = 2), 
                   selected = 2),
      hr(),
      helpText('Total number of heads:'),
      verbatimTextOutput("num_heads"),
      helpText('Proportion of heads:'),
      verbatimTextOutput("prop_heads")
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("chancePlot")  
    )
  )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
  
  seed <- reactive({
    input$seed
  })
  tosses <- reactive({
    input$tosses
  })
  chance <- reactive({
    input$chance
  })
  
  # Number of heads
  output$num_heads <- renderPrint({ 
    set.seed(seed())
    flips <- rbinom(n = tosses(), 1, prob = chance())
    sum(flips)
  })
  
  # Proportion of heads
  output$prop_heads <- renderPrint({ 
    set.seed(seed())
    flips <- rbinom(n = tosses(), 1, prob = chance())
    round(100 * sum(flips) / tosses(), 2)
  })
  
  # Fill in the spot we created for a plot
  output$chancePlot <- renderPlot({
    set.seed(input$seed)
    tosses <- input$tosses
    flips <- rbinom(n = tosses, 1, prob = chance())
    num_heads <- cumsum(flips)
    prop_heads <- (num_heads / 1:tosses)
    num_tosses <- 1:tosses

    # Render a barplot
    difference <- num_heads[num_tosses] - (chance() * num_tosses)
    proportion <- prop_heads[num_tosses]
    if (input$error == 1) {
      plot(num_tosses, difference, 
           col = '#627fe2', type = 'l', lwd = 2,
           xlab = "Number of tosses",
           ylab = '# of heads - 1/2 # of tosses',
           axes = FALSE, main = 'Chance Error:  # successes - # expected')
      abline(h = 0, col = '#88888855', lwd = 2, lty = 2)
      axis(side = 2, las = 1)
    } else {
      plot(num_tosses, proportion, ylim = c(0, 1),
           col = '#627fe2', type = 'l', lwd = 2,
           xlab = 'Number of tosses',
           ylab = 'Proportion of heads',
           axes = FALSE, main = 'Percent Error:  % successes - % expected')
      abline(h = chance(), col = '#88888855', lwd = 2, lty = 2)
      axis(side = 2, las = 1, at = seq(0, 1, 0.1))
    }
    axis(side = 1)
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

