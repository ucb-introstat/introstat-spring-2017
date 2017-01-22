# Histograms for NBA players data

This is a Shiny app that generates histograms using data of NBA players from the season 2015-2016..


## Motivation

The goal is to provide examples of histograms and distributions of quantitative variables.  __Statistics, Chapter 3: The Histogram__ (pages 32-56):

- A _variable_ is a characteristic of the subjects in a study. It can be either qualitative or quantitative.
- A _histogram_ is a visual display used to look at the distribution of a quantitative variable.
- A _histogram_ represents precents by area. It consists of a set of blocks. The area of each block represents the percentage of cases in the correspoding class interval.
- With the _density scale_, the height of each block equals the percentage of cases in the the corresponding class interval, divided by the length of that interval.

Reference: "Statistics" by David Freedman, Robert Pisani and Roger Purves (2007). Fourth Edition. Norton & Company.


## Data

The data set is in the `nba_players.csv` file (see `data/` folder) which contains 528 rows and 39 columns, although this app only uses quantitative variables.


## How to run it?


```R
library(shiny)

# Easiest way is to use runGitHub
runGitHub("introstat-spring-2017", "ucb-introstat", subdir = "apps/ch03-histograms")
```

