# Regression Scatterplot for Pearson's Height data

This is a Shiny app that generates a scatter diagram to illustrate the regression method using Pearson's heights data set.


## Motivation

The goal is to provide a visual display of some of the concepts from __Statistics, Chapter 10: Regression__ (pages 158-165):

- Point of averages
- SD line
- Graph of averages
- Regression line
- Correlation coefficient

Reference: "Statistics" by David Freedman, Robert Pisani and Roger Purves (2007). Fourth Edition. Norton & Company.


## Data

This app uses the Pearson's Height Data. The data is in the `data/` folder. which contains 1078 rows and 2 columns: 

- `Father`: The father's height, in inches
- `Son`: The height of the son, in inches

The app only uses variables: `Father, Mother, Child`

Original source: [http://www.math.uah.edu/stat/data/Pearson.csv](http://www.math.uah.edu/stat/data/Pearson.csv)


## How to run it?

There are many ways to download the app and run it:

```R
library(shiny)

# Easiest way is to use runGitHub
runGitHub("introstat-spring-2017", "ucb-introstat", subdir = "apps/ch10-heights-data")
```
