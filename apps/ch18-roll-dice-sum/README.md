# Rolling Dice: Sum of Points

This is a Shiny app that generates empirical histograms when simulating 
rolling dice and finding the total number of spots.


## Motivation

The goal is to provide a visual display similar to the empirical and 
probability histograms shown in page 311 of "Statistics", chapter 18.

Reference: "Statistics" by David Freedman, Robert Pisani and Roger Purves (2007). Fourth Edition. Norton & Company.


## Data

The data simulates rolling (by default) a pair of dice (but the user can choose between 
one and 10 dices). The input parameters are the number of dice, the random seed, and 
the number of repetitions.


## Plots

There are two tabs:

1. An empirical histogram.
2. A probability histogram (probability distribution).


## How to run it?

```R
library(shiny)

# Easiest way is to use runGitHub
runGitHub("introstat-spring-2017", "ucb-introstat", subdir = "apps/ch18-roll-dice-sum")
```
