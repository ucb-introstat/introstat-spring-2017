# Expected value and Standard Error with De Mere's Games

This is a Shiny app that illustrates the concept of Expected Value and Standard Error 
when simulating De Mere's games (100 times by default).


## Motivation

The goal is to provide a visual display for the concepts in __Statistics, Chapter 17: The Expected Value and Standard Error.__

Reference: "Statistics" by David Freedman, Robert Pisani and Roger Purves (2007). Fourth Edition. Norton & Company.


## Data

The app allows you to simulate two main scenarios:

1. __Rolling a fair die 4 times.__ This actually done by drawing 4 tickets out of a box with six tickets.
The structure of the box consists of one ticket `1`, and five tickets `0`.
2. __Rolling a pair of dice 24 times.__ This actually done by drawing 24 tickets out of a box with 36 tickets.
The structure of the box consists of 1 ticket `1`, and 35 tickets `0`.


## Plots

There are three displayed graphs.

1. A probability distribution (theoretical probabilities for the number of tickets `1`).
2. An empirical pareto chart (cumulative distribution) with the proportion of tickets `1` when 
playing the game a given number of times.
3. A line chart with the empirical (net) gain when playing the game a given number of times.


## How to run it?

```R
library(shiny)

# Easiest way is to use runGitHub
runGitHub("introstat-spring-2017", "ucb-introstat", subdir = "ch17-demere-games")
```
