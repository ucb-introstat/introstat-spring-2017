# Correlation Coefficient Diagrams

This is a Shiny app that generates scatter diagrams based on the specified correlation coefficient.


## Motivation

The goal is to provide examples of scatter diagrams as those displayed on the FPP book, page 127. See Chapter 8: The Correlation Coefficient (page 127).

The scatter diagrams are based on random generated data following a multivariate normal distribution.

Reference: "Statistics" by David Freedman, Robert Pisani and Roger Purves (2007). Fourth Edition. Norton & Company.


## How to run it?


```R
library(shiny)

# Easiest way is to use runGitHub
runGitHub("introstat-spring-2017", "ucb-introstat", subdir = "apps/ch08-corr-coeff-diagrams")
```

