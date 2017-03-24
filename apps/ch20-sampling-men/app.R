# Title: Roll dice and add spots
# Description: Empirical vs Probability Histograms
# Chapter 18: Probability Histograms, page 311
# Author: Gaston Sanchez

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Give the page a title
  titlePanel("Sampling Men (p 359)"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      fluidRow(
        column(5, 
               numericInput("tickets1", "men [1]", 3091,
                            min = 1, max = 4000, step = 1)),
        column(5,
               numericInput("tickets0", "women [0]", 3581,
                            min = 1, max = 4000, step = 1))
      ),
#      helpText('Avg box,  SD box'),
      verbatimTextOutput("avg_sd_box"),
      numericInput("size", label = "Sample Size (# draws):", value = 100,
                   min = 10, max = 1500, step = 1),
      sliderInput("reps", label = "Number of repetitions:", 
                  min = 50, max = 2000, value = 100, step = 50),
      numericInput("seed", label = "Random Seed:", 12345, 
                   min = 10000, max = 50000, step = 1),
      hr(),
      helpText('Number average'),
      verbatimTextOutput("num_avg"),
      helpText('Percent average'),
      verbatimTextOutput("perc_avg")
    ),
    
    # Create tabs for plots
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Number", plotOutput("numberPlot")),
                  tabPanel("Percentage", plotOutput("percentPlot"))
      )
    )
  )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # Number of men
  output$avg_sd_box <- renderPrint({
    total <- input$tickets1 + input$tickets0
    avg_box <- input$tickets1 / total
    sd_box <- sqrt((input$tickets1/total) * (input$tickets0/total))
    cat(sprintf('Avg = %0.3f,  SD = %0.3f', avg_box, sd_box))
  })

    num_men <- reactive({
    tickets <- rep(c(1, 0), c(input$tickets1, input$tickets0))
    
    set.seed(input$seed)
    size <- input$size
    samples <- 1:input$reps
    for (i in 1:input$reps) {
      samples[i] <- sum(sample(tickets, size = size))
    }
    samples
  })
  
  # Number of men
  output$num_avg <- renderPrint({ 
    round(mean(num_men()), 2)
  })
  
  # Percentage of men
  output$perc_avg <- renderPrint({ 
    round(100 * mean(num_men() / input$size), 2)
  })
  
  # Plot with number of men in samples
  output$numberPlot <- renderPlot({
    # Render a barplot
    barplot(table(num_men()), 
            space = 0, las = 1,
            xlab = 'Number of men',
            ylab = '',
            main = 'Sample Men')
  })
  
  # Plot with percentage of men in samples
  output$percentPlot <- renderPlot({
    # Render a barplot
    percentage_men <- round(100 * num_men() / input$size)
    barplot(table(percentage_men) / length(num_men()), 
            space = 0, las = 1,
            xlab = 'Percentage of men',
            ylab = 'Proportion',
            main = 'Sample Men')
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

