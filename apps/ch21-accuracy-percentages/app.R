# Box with two types of tickets [# 1's, # 0's]
# Drawing tickets from the box
# Chapter 21: Accuracy of Percentages

library(shiny)

source('helpers.R')

# Define the overall UI
ui <- fluidPage(
  
  # Give the page a title
  titlePanel("Accuracy of Percentages"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      fluidRow(
        column(5, 
               numericInput("tickets1", "# Tickets 1", 5,
                            min = 1, max = 100, step = 1)),
        column(5,
               numericInput("tickets0", "# Tickets 0", 5,
                            min = 1, max = 200, step = 1))
      ),
      helpText('Avg of box, and SD of box'),
      verbatimTextOutput("avg_sd_box"),
      # helpText('Sum of Box'),
      # verbatimTextOutput("avg_box"),
      # helpText('SD of Box'),
      # verbatimTextOutput("sd_box"),
      hr(),
      sliderInput("draws", label = "Sample size (# draws):", value = 25,
                   min = 5, max = 200, step = 1),
      numericInput("reps", label = "Number of samples:", 
                  min = 10, max = 1000, value = 50, step = 10),
      sliderInput("confidence", label = "Confidence level (%):", value = 68,
                  min = 1, max = 99, step = 1),
      numericInput("seed", label = "Random Seed:", 12345, 
                   min = 10000, max = 50000, step = 1)
    ),
    
    # Create a spot for the barplot
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Sum", plotOutput("sumPlot")),
                  tabPanel("Percentage", plotOutput("percentPlot")),
                  tabPanel("Estimates", plotOutput("intervalPlot"))
      )
    )
  )
)



# Define server logic required to draw a histogram
server <- function(input, output) {
  tickets <- reactive({
    tickets <- c(rep(1, input$tickets1), rep(0, input$tickets0))
  })
  
  sum_draws <- reactive({
    set.seed(input$seed)
    samples <- 1:input$reps
    for (i in 1:input$reps) {
      samples[i] <- sum(sample(tickets(), size = input$draws, replace = TRUE))
    }
    samples
  })
  
  avg_box <- reactive({
    mean(tickets())
  })
  
  sd_box <- reactive({
    total <- input$tickets1 + input$tickets0
    sqrt((input$tickets1 / total) * (input$tickets0 / total))
  })
  
  # Average and SD of box
  output$avg_sd_box <- renderPrint({ 
    cat(avg_box(), ",  ", sd_box(), sep = '')
  })
  
  # Plot with sum of draws
  output$sumPlot <- renderPlot({
    # Render a barplot
    barplot(table(sum_draws()), 
            space = 0, las = 1,
            xlab = 'Sum',
            ylab = '',
            main = sprintf('Sum of Box for %s Draws', input$draws))
  })
  
  # Plot with percentage of draws
  output$percentPlot <- renderPlot({
    # Render a barplot
    avg_draws <- round(sum_draws() / input$draws, 1)
    barplot(table(avg_draws), 
            space = 0, las = 1,
            xlab = 'Percentage',
            ylab = '',
            main = "Percentage of 1's")
  })
  
  # Plot with confidence intervals
  output$intervalPlot <- renderPlot({
    avg_box <- mean(tickets())
    n <- length(tickets())
    sd_box <- sqrt((n-1)/n) * sd(tickets())
    se_sum <- sqrt(input$draws) * sd_box
    se_perc <- se_sum / input$draws
    
    # Render plot
    samples <- sum_draws() / input$draws
    
    #a <- samples - se_perc
    #b <- samples + se_perc
    
    a <- samples - ci_factor(input$confidence) * se_perc
    b <- samples + ci_factor(input$confidence) * se_perc
    covers <- (a <= avg_box & avg_box <= b)
    ci_cols <- rep('#ff000088', input$reps)
    ci_cols[covers] <- '#0000ff88'
    
    xlim <- c(min(samples) - ci_factor(input$confidence) * se_perc, 
              max(samples) + ci_factor(input$confidence) * se_perc)
    plot(samples, 1:length(samples), axes = FALSE,
         col = '#444444', pch = 21, cex = 0.5,
         xlim = c(0, 1), 
         ylab = 'Number of samples',
         xlab = "Confidence Intervals",
         main = "Percentage of 1's")
    axis(side = 1, at = seq(0, 1, 0.1))
    axis(side = 2, las = 1)
    abline(v = avg_box, col = '#0000FFdd', lwd = 2.5)
    segments(x0 = a,
             x1 = b,
             y0 = 1:length(samples),
             y1 = 1:length(samples),
             col = ci_cols)
  })
  
}


# Run the application 
shinyApp(ui = ui, server = server)

