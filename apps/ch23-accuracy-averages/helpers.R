# function to compute SE factor 
# for a confidence level
ci_factor <- function(level = 95) {
  area <- level + ((100 - level) / 2)
  qnorm(area/100)
}

# tests

# 90% confidence level 
# ci_factor(90)

# 95% confidence level 
# ci_factor(95)

# 99% confidence level 
# ci_factor(99)
