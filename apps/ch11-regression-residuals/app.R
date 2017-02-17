# Title: Spread within vertical strips in regression
# Description: this app uses Pearson's height data 
# Author: Gaston Sanchez

library(shiny)

# reading a couple of lines just to get the names of variables
nba <- read.csv('../../data/nba_players.csv')

# quantitative variables
quantitative <- c(
  "height","weight","experience","age","games","games_started",
  "minutes_played","field_goals","field_goal_attempts","field_goal_percent",
  "points3","points3_attempts","points3_percent","points2","points2_attempts",
  "points2_percent","effective_field_goal_percent","free_throws",
  "free_throw_attempts","free_throw_percent","offensive_rebounds",
  "defensive_rebounds","total_rebounds","assists","steals","blocks",
  "turnovers","fouls","points")

# select just quantitative variables
dat <- nba[ ,quantitative]

# Define UI for application that draws a histogram
ui <- fluidPage(
  # Give the page a title
  titlePanel("NBA Players"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      selectInput("xvar", "X-axis variable", 
                  choices = colnames(dat), selected = 'height'),
      selectInput("yvar", "Y-axis variable", 
                  choices = colnames(dat), selected = 'weight'),
      hr(),
      helpText('Correlation:'),
      verbatimTextOutput("correlation"),
      helpText('r.m.s. error:'),
      verbatimTextOutput("rms_error")
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("datPlot"),
      plotOutput("residualPlot")
    )
    
  )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # Correlation
  output$correlation <- renderPrint({ 
    cor(dat[,input$xvar], dat[,input$yvar])
  })
  
  # r.m.s. error
  output$rms_error <- renderPrint({
    reg <- lm(dat[,input$yvar] ~ dat[,input$xvar])
    sqrt(mean((reg$residuals)^2))
  })
  
  # Fill in the spot we created for a plot
  output$datPlot <- renderPlot({
    
    # Render a scatter diagram
    plot(dat[,input$xvar], dat[,input$yvar],
         main = 'scatter diagram', type = 'n', axes = FALSE,
         xlab = input$xvar, ylab = input$yvar)
    box()
    axis(side = 1)
    axis(side = 2, las = 1)
    points(dat[,input$xvar], dat[,input$yvar],
           pch = 21, col = 'white', bg = '#4878DFaa',
           lwd = 2, cex = 2)
    # regression line
    reg <- lm(dat[,input$yvar] ~ dat[,input$xvar])
    abline(reg = reg, lwd = 3, col = '#e35a6d')
    
  })
  
  # histogram
  output$residualPlot <- renderPlot({
    reg <- lm(dat[,input$yvar] ~ dat[,input$xvar])
    # Render scatterplot
    plot(dat[,input$xvar], reg$residuals, las = 1,
         main = 'Residual plot', xlab = input$xvar,
         ylab = 'residuals', col = '#ACB6F1', type = 'n')
    abline(h = 0, col = 'gray70', lw = 2)
    points(dat[,input$xvar], reg$residuals,
           pch = 20, col = '#888888aa', cex = 2)
  })
}



# Run the application 
shinyApp(ui = ui, server = server)

