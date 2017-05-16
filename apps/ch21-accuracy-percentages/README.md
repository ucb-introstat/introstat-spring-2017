# Ch21 - Percent Estimation

This is a Shiny app that illustrates the concept of accuracy of percentages.
In other words, confidence intervals when esitmating a percentage.


## Motivation

The goal is to provide a visual display for the various examples in 
__Statistics, Chapter 21: Accuracy of Percentages__

Reference: "Statistics" by David Freedman, Robert Pisani and Roger Purves (2007). 
Fourth Edition. Norton & Company.


## Data

- The data consists of a box model with two types of tickets: 0's and 1's.
- The user can specify the nummber of both types of tickets (# of 1's, # of 0's).
- The app simulates drawing tickets with replacement from the box. 
- There are three arguments:
    + the number of draws (i.e. sample size)
    + the number samples (i.e. # of repetitions)
    + the confidence level


## Plots

There are three plots: 

1. The first tab shows a histogram for the sum of draws.
2. The second tab shows a histogram for the percentage of tickets 1's.
3. The third tab shows a chart with the percentage of the box (i.e. population percentage),
and the confidence intervals of the drawn samples.


## How to run it?

```R
library(shiny)

# Easiest way is to use runGitHub
runGitHub("introstat-spring-2017", "ucb-introstat", subdir = "apps/ch21-accuracy-percentages")
```
