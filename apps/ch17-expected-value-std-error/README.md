# Expected value and Standard Error

This is a Shiny app that illustrates the concept of Expected Value and Standard Error when simulating rolling a die (5 times by default).


## Motivation

The goal is to provide a visual display for the concepts in __Statistics, Chapter 17: The Expected Value and Standard Error.__

Reference: "Statistics" by David Freedman, Robert Pisani and Roger Purves (2007). Fourth Edition. Norton & Company.


## Data

The data simulates rolling a die 5 times by default.


## Plot

A bar-chart of frequencies for the sum of draws is displayed.


## How to run it?

```R
library(shiny)

# Easiest way is to use runGitHub
runGitHub("introstat-spring-2017", "ucb-introstat", subdir = "ch17-expected-value-std-error")
```
