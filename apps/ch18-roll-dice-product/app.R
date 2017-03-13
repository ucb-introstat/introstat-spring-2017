# Title: Roll dice and multiply spots
# Description: Empirical vs Probability Histograms
# Chapter 18: Probability Histograms, page 313
# Author: Gaston Sanchez

library(shiny)
source("helpers.R")

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Give the page a title
  titlePanel("Rolling Dice: Product"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      numericInput("dice", label = "Number of dice:", 2, 
                   min = 1, max = 10, step = 1),
      numericInput("seed", label = "Random Seed:", 12330, 
                   min = 10000, max = 50000, step = 1),
      sliderInput("reps", label = "Number of repetitions:", 
                  min = 100, max = 10000, value = 100, step= 10)
    ),
    
    # Create tabs for plots
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Empirical", plotOutput("empiricalPlot")),
                  tabPanel("Probability", plotOutput("probabilityPlot"))
      )
    )
  )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # Empirical average of sum of draws
  output$num_heads <- renderPrint({ 
    set.seed(input$seed)
    total_points <- sapply(rep(input$dice, input$reps), sum_rolls)
    # avg of sums
    mean(total_points)
  })
  
  # Empirical SD of product of draws
  output$prop_heads <- renderPrint({ 
    set.seed(input$seed)
    total_points <- sapply(rep(input$dice, input$reps), sum_rolls)
    # avg of sums
    sd(total_points) * sqrt((input$reps - 1)/input$reps)
  })
  
  # Empirical Histogram
  output$empiricalPlot <- renderPlot({
    set.seed(input$seed)
    total_points <- sapply(rep(input$dice, input$reps), prod_rolls)
    # put in relative terms
    prop_points <- 100 * table(total_points) / input$reps
    ymax <- find_ymax(max(prop_points), 2)
    # Render a barplot
    # Frequencies of products
    freq <- numeric((6^input$dice))
    freq[1:(6^input$dice) %in% names(prop_points)] <- prop_points
    names(freq) <- 1:(6^input$dice)
    
    # Render a barplot
    barplot(freq, space = 0, las = 1, border = "gray40",
            cex.names = 0.8, ylim = c(0, ymax),
            main = sprintf("%s Repetitions", input$reps))
  })

  # Probability Histogram
  output$probabilityPlot <- renderPlot({
    outcomes <- multiply_spots(input$dice)
    freq <- rep(0, 6^input$dice)
    freq[as.numeric(names(outcomes))] <- outcomes
    # Render a barplot
    barplot(100 * freq, names.arg = 1:6^input$dice,
            las = 1, border = "gray40",
            space = 0,
            xlab = "Number of spots",
            ylab = "Chance (%)",
            main = "Probability Histogram")
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

