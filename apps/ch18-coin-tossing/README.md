# Tossing Coins

This is a Shiny app that generates a probability histogram when tossing
a coin a specified number of times.


## Motivation

The goal is to provide a visual display similar to the probability histograms
in chapter 18 of "Statistics".

Reference: "Statistics" by David Freedman, Robert Pisani and Roger Purves (2007). Fourth Edition. Norton & Company.


## Data

The data computes the probabilities when tossing a coin a specified number of times.
The input parameters are the number of tosses, and the chance of heads.


## Plot

The produced plot is a probability histogram.


## How to run it?

```R
library(shiny)

# Easiest way is to use runGitHub
runGitHub("introstat-spring-2017", "ucb-introstat", subdir = "tossing-coins")
```
