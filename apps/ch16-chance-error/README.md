# Chance Error

This is a Shiny app that illustrates the concept of chance error when simulating tossing a coin a given number of times.


## Motivation

The goal is to provide a visual display motivated by John Kerrich's coin-tossing experiment __Statistics, Chapter 16: The Law of Averages__

Reference: "Statistics" by David Freedman, Robert Pisani and Roger Purves (2007). Fourth Edition. Norton & Company.


## Data

The data simulates tossing a coin using the random binomial generator function `rbinom()`. The input parameters are the number of tosses, and optionally, the probability of heads.


## Plot

There are two options for the displayed plot: 

1. shows the chance error (i.e. number of heads minus half the number of tosses) on the y-axis, and the number of tosses on the x-axis.
2. shows the percent error (i.e. proportion of heads) on the y-axis, and the number of tosses on the x-axis.


## How to run it?

```R
library(shiny)

# Easiest way is to use runGitHub
runGitHub("introstat-spring-2017", "ucb-introstat", subdir = "apps/ch16-chance-error")
```
