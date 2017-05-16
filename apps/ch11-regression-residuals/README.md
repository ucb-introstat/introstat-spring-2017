# Regression Residuals

This is a Shiny app that generates two graphs: 1) a scatterplot with a 
regression line, and 2) a residual plot from the fitted regression line.


## Motivation

The goal is to illustrate the concepts of homoscedastic and heteroscedastic  
residuals described in 
__Statistics, Chapter 11: The R.M.S. Error for Regression__ (pages 180-201):

Reference: "Statistics" by David Freedman, Robert Pisani and Roger 
Purves (2007). Fourth Edition. Norton & Company.


## Data

This app uses the data from NBA basketball players in the 2015-2016 season. 
The csv file `nba_players.csv` is the `data/` folder of the github repository. 


## How to run it?


```R
library(shiny)

# Easiest way is to use runGitHub
runGitHub("introstat-spring-2017", "ucb-introstat", subdir = "apps/ch11-regression-residuals")
```
