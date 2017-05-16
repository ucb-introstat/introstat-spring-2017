# Sampling Men

This is a Shiny app that illustrates the concept of chance errors in sampling.


## Motivation

The goal is to provide a visual display for the Introduction example in 
__Statistics, Chapter 20: Chance Errors in Sampling__

Reference: "Statistics" by David Freedman, Robert Pisani and Roger Purves (2007). Fourth Edition. Norton & Company.


## Data

The data consists of a box model with 6672 tickets: 3091 __1's__, and 3581 __0's__. 
The 1's tickets represent men, while the 0's represent women.
The app simulates taking samples from the box. There are two parameters, one is the sample size, and the other is the number samples (i.e. # of repetitions).


## Plots

There are two plots: 

1. The first tab shows a histogram with the number of men in the samples.
2. The second tab shows a histogram with the percentage of men in the samples.


## How to run it?

There are many ways to download the app and run it:

```R
library(shiny)

# Easiest way is to use runGitHub
runGitHub("introstat-spring-2017", "ucb-introstat", subdir = "apps/ch20-sampling-men")
```
