# Shiny Apps

This is a collection of Shiny apps to be used mainly during lecture to illustrate some of the concepts in the textbook _Statistics_ (FPP) 4th edition.


## Running the apps

The easiest way to run an app is with the `runGitHub()` from the `"shiny"` package. For instance, to run the app contained in the [ch03-histograms](/ch03-histograms) folder, run the following code in R:

```R
library(shiny)

# Run an app from a subdirectory in the repo
runGitHub("introstat-spring-2017", "ucb-introstat", subdir = "apps/ch03-histograms")
```
