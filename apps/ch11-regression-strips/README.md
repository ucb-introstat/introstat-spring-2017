# Vertical Strips for Pearson's Height data

This is a Shiny app that generates a scatter diagram to illustrate the 
distribution of values on the y-axis within a vertical strip.


## Motivation

The goal is to provide a visual display of some of the concepts from 
__Statistics, Chapter 11: The R.M.S. Error for Regression__ (pages 180-201):

- Looking at vertical strips
- Using the normal curve inside a vertical strip

Reference: "Statistics" by David Freedman, Robert Pisani and Roger 
Purves (2007). Fourth Edition. Norton & Company.


## Data

This app uses the Galton's Height Data as described in [Pearson's Height Data](http://www.math.uah.edu/stat/data/Pearson.csv). The data is in the `pearson.csv` file.


## How to run it?


```R
library(shiny)

# Easiest way is to use runGitHub
runGitHub("introstat-spring-2017", "ucb-introstat", subdir = "ch11-regression-strips")
```
