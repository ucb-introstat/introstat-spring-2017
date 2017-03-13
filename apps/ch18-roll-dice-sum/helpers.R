# Helper functions to simulate rolling a die
# and adding-or-multiplying the number of spots

# roll one die
roll_die <- function(times = 1) {
  die <- 1:6
  sample(die, times, replace = TRUE)
}


# roll a pair of dice
roll_pair <- function() {
  roll_die(2)
}

# sum of spots
sum_rolls <- function(times = 1) {
  sum(roll_die(times))
}

# product of numbers
prod_rolls <- function(times = 1) {
  prod(roll_die(times))
}

# check whether 'x' is multiple of 'num'
is_multiple <- function(x, num) {
  x %% num == 0
}

# find the y-max value for ylim in barplot()
find_ymax <- function(x, num) {
  if (is_multiple(x, num)) {
    return(max(x))
  } else {
    return(num * ((x %/% num) + 1))
  }
}

# reps <- 100
# total_points <- sapply(rep(2, reps), sum_rolls)
# prop_points <- 100 * table(total_points) / reps
# barplot(prop_points, las = 1, 
#         space = 0, ylim = c(0, 30),
#         main = sprintf("%s Repetitions", reps))




# function that adds spots to a given result
add_rolls <- function(given) {
  results <- rep(0, length(given) * 6)
  aux <- 1
  for (i in 1:length(given)) {
    for (j in 1:6) {
      results[aux] <- given[i] + j
      aux <- aux + 1
    }
  }
  results
}

# function that computes theoretical probabilities
# for the addition of spots when rolling "k" dice
sum_spots <- function(num_dice) {
  # just one die
  if (num_dice == 1) {
    outcomes <- table(1:6) / (6^num_dice)
  } else {
    # two or more dice
    current <- 1:6
    for (k in 2:num_dice) {
      current <- add_rolls(current)
    }
    outcomes <- table(current) / (6^num_dice)
  }
  outcomes
}

# sum_spots(1)
# sum_spots(2)
# sum_spots(3)



