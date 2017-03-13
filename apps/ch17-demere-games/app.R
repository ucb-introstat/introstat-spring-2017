# Title: More Expected Value and Standard Error
# Description: Simulation of De Mere's rolling dice games using 
# a box model for the number of "aces" (ticket 1).
# Author: Gaston Sanchez

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Give the page a title
  titlePanel("De Mere's games"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      fluidRow(
        column(5, 
               numericInput("tickets1", "# Tickets 1", 1,
                            min = 1, max = 35, step = 1)),
        column(5,
               numericInput("tickets0", "# Tickets 0", 5,
                            min = 1, max = 35, step = 1))
      ),
      helpText('Avg of box, and SD of box'),
      verbatimTextOutput("avg_sd_box"),
      numericInput("draws", label = "Number of Draws:", value = 4,
                   min = 1, max = 100, step = 1),
      helpText('Expected Value and SE'),
      verbatimTextOutput("ev_se"),
      hr(),
      sliderInput("reps", label = "Number of games:", 
                  min = 1, max = 5000, value = 100, step = 1),
      helpText('Actual gain'),
      verbatimTextOutput("gain"),
      numericInput("seed", label = "Random Seed:", 12345, 
                   min = 10000, max = 50000, step = 1)
    ),
    
    # Create a spot for the barplot
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Sum", plotOutput("sumPlot")),
                  tabPanel("Pareto", plotOutput("paretoPlot")),
                  tabPanel("Games", plotOutput("gamesPlot"))
      )
    )
  )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
  
  tickets <- reactive({
    tickets <- c(rep(1, input$tickets1), rep(0, input$tickets0))
  })
  
  avg_box <- reactive({
    mean(tickets())
  })
  
  sd_box <- reactive({
    total <- input$tickets1 + input$tickets0
    sqrt((input$tickets1 / total) * (input$tickets0 / total))
  })
  
  sum_draws <- reactive({
    set.seed(input$seed)
    samples <- 1:input$reps
    for (i in 1:input$reps) {
      samples[i] <- sum(sample(tickets(), size = input$draws, replace = TRUE))
    }
    samples
  })
  
  # Average and SD of box
  output$avg_sd_box <- renderPrint({ 
    cat(avg_box(), ",  ", sd_box(), sep = '')
  })
  
  # Expected Value, and Standard Error
  output$ev_se <- renderPrint({ 
    ev = input$draws * avg_box()
    se = sqrt(input$draws) * sd_box()
    cat(ev, ",  ", se, sep = '')
  })

  # Probability Histogram
  output$sumPlot <- renderPlot({
    # Render a barplot
    total_tickets <- input$tickets1 + input$tickets0
    prob_ticket1 <- input$tickets1 / total_tickets
    probabilities <- dbinom(0:input$draws, size = input$draws, prob_ticket1)
    barplot(round(probabilities, 4), border = NA, las = 1, 
            names.arg = 0:input$draws,
            xlab = paste("Number of tickets 1"),
            ylab = 'Probability',
            main = paste("Probability Distribution\n", 
                         "(# ticekts 1)"))
    abline(h = 0.5, col = '#EC5B5B99', lty = 2, lwd = 1.4)
  })
  
  # Pareto chart: cumulative percentage of draws
  output$paretoPlot <- renderPlot({
    # Render a barplot
    freqs_draws <- table(sum_draws()) / input$reps
    freq_aux <- barplot(freqs_draws, plot = FALSE)
    barplot(freqs_draws, 
            ylim = c(0, 1.1),
            border = NA, las = 1,
            xlab = paste('Number of tickets 1 in', input$reps, 'games'),
            ylab = 'Percentage',
            main = paste("Empirical Cumulative Relative Frequency\n", 
                         "(at least one ticket 1)"))
    abline(h = 0.5, col = '#EC5B5B99', lty = 2, lwd = 1.4)
    lines(freq_aux[-1], cumsum(freqs_draws[-1]), lwd = 3, col = "gray60")
    points(freq_aux[-1], cumsum(freqs_draws[-1]), pch=19, col="gray30")
    text(freq_aux[-1], cumsum(freqs_draws[-1]), 
         round(cumsum(freqs_draws[-1]), 3), pos = 3)
  })
  
  # Plot with gains
  output$gamesPlot <- renderPlot({
    results <- rep(-1, input$reps)
    results[sum_draws() > 0] <- 1
    plot(1:input$reps, cumsum(results), type = "n", axes = FALSE,
         xlab = paste('Number of tickets 1 in', input$reps, 'games'),
         ylab = "Gained amount",
         main = "Empirical Gain")
    abline(h = 0, col = '#EC5B5B99', lty = 2, lwd = 1.4)
    axis(side = 1)
    axis(side = 2, las = 1, pos = 0)
    lines(1:input$reps, cumsum(results), lwd = 1.5)
  })
  
  # actual gain
  output$gain <- renderPrint({ 
    results <- rep(-1, input$reps)
    results[sum_draws() > 0] <- 1
    sum(results)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

