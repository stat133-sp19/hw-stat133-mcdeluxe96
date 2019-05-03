library(devtools)
# 1.1) Private Checker Functions

# test if an input prob is a valid probability value (i.e. 0 ≤ p ≤ 1)
check_prob <- function(prob) {
  if (prob > 1) {
    stop("p has to be a number betwen 0 and 1")
  } 
  if (prob < -1) {
    stop("p has to be a number betwen 0 and 1")
  } 
  if (!is.numeric(prob)) {
    stop("invalid prob value")
  }
  TRUE
}

# test if an input trials is a valid value for number of trials (i.e. n is a non-negative integer)
check_trials <- function(trials) {
  if (trials >= 0) {
    return (TRUE)
  } else {
    stop("invalid trials value")
  }
}

#  test if an input success is a valid value for number of successes (i.e. 0 ≤ k ≤ n)
check_success <- function(success, trials) {
  success <- success <= trials
  if (all(success)) {
    return (TRUE)
  } else {
    stop("invalid success value")
  }
}

# 1.2) Private Auxiliary Functions

aux_mean <- function(trials, prob) {
  mean = trials*prob
  return(mean)
}

aux_variance <- function(trials, prob) {
  var = aux_mean(trials, prob)*(1-prob)
  return(var)
}

aux_mode <- function(trials, prob) {
  mode = floor(trials*prob + prob)
  return(mode)
}

aux_skewness <- function(trials, prob) {
  skewness = (1-2*prob)/((trials*prob*(1-prob))**(1/2))
  return(skewness)
}

aux_kurtosis <- function(trials, prob) {
  kurtosis = (1-(6*prob*(1-prob)))/(trials*prob*(1-prob))
  return(kurtosis)
}

# 1.3) Function bin_choose()

#' @title Factorial
#' @description calculates the number of combinations in which k successes can occur in n trials
#' @param n denotes trials
#' @param k denotes succeses
#' @return the factorial of "n chooses k"
#' @export
#' @examples
#' bin1 <- bin_choose()
#' 


bin_choose <- function(n, k) {
  if (k>n) {
    stop("k cannot be greater than n")
  }
  bin = factorial(n)/(factorial(k)*factorial(n-k))
  return(bin)
}

# 1.4) Function bin_probability()

#' @title Probability
#' @description finds a probability given values of trials, success, and probability
#' @param trials denotes trials
#' @param success denotes succeses
#' @param prob denotes probability of success
#' @return the probability ranging 0 to 1
#' @export
#' @examples
#' bin2 <- bin_probability()
#' 
#' 

bin_probability <- function(success, trials, prob) {
  if (check_success(success, trials) != TRUE) {
    stop("invalid success value")
  }
  if (check_trials(trials) != TRUE) {
    stop("invalid trials value")
  }
  if (check_prob(prob) != TRUE) {
    stop("invalid prob value")
  }
  probability = bin_choose(trials,success)*(prob^success)*((1-prob)**(trials-success))
  return(probability)
}

# 1.5) Function bin_distribution()

#' @title Probability Distribution
#' @description finds a probability distribution given values of trials, success, and probability
#' @param trials denotes trials
#' @param prob denotes probability of success
#' @return a table of each probability given each value of success
#' @export
#' @examples
#' 
#'  bin5 <- bin_distribution()
#' 

bin_distribution <- function(trials, prob) {
  bin <- c()
  aloha <- c()
  
  for (i in 0:trials) {
    bin = bin_probability(i,trials,prob)
    aloha[i+1] = bin
  }
  asd = data.frame(success = 0:i,probability = aloha)
  class(asd) <-  c("bindis",
                   "data.frame")
  return(asd)
}
bin_distribution(trials = 5, prob = 0.5)



#' @export
plot.bindis <- function(bindis) {
  ggplot(data = bindis, mapping = aes(x = success, y = probability)) +
    geom_bar(stat = "identity")
}

# 1.6) Function bin_cumulative()

#' @title Cumulative Distribution
#' @description create a cumulative probability distribution
#' @param trials denotes trials
#' @param prob denotes prob of  succeses
#' @return the factorial of "n chooses k"
#' @export
#' @examples
#' bin6 <- bin_cumulative()
#' 
#' 


bin_cumulative <- function(trials, prob) {
  n <-  trials
  aloha <- c()
  bindis <- c()
  bincum <- c()
  for (i in 0:n) {
    bindis = bin_probability(i, trials, prob)
    aloha[i+1] = bindis
    bincum[i+1] = sum(aloha)
  }
  modalities = data.frame(success = 0:n, probability = aloha, cumulative = bincum)
  class(modalities) <-  c("bincum",
                          "data.frame")
  return(modalities)
}

#' @export
plot.bindis <- function(bincum) {
  plot(bincum$success, bincum$cumulative, type = "l", xlab = "successes", ylab = "probability")
}

# 1.7) Function bin_variable()

#' @title trials and success
#' @description Creates an object of trials and success
#' @param trials denotes trials
#' @param succeses denotes succeses
#' @return values of trials and success
#' @export
#' @examples
#' bin7 <- bin_variable()
#' 
#' 

bin_variable <- function(trials, prob) {
  if (check_trials(trials) != TRUE) {
    stop("invalid trials value")
  }
  if (check_prob(prob) != TRUE) {
    stop("invalid prob value")
  }
  binvar = data.frame(trials = trials, prob = prob)
  class(binvar) <-  c("binvar",
                      "data.frame")
  binvar
}
#' Title
#'
#' @export
print.binvar <- function(binvar) {
  cat("Binomial variable")
  
  cat("\n\n", append = TRUE)
  cat("Parameters", append = TRUE)
  cat("\n - number of trials: ", binvar$trials, append = TRUE)
  cat("\n - prob of success : ", binvar$prob, "\n", append = TRUE)
}


#' Title
#'
#' @export
print.summary.binvar <- function(binvar) {
  mean <- aux_mean(binvar$trials, binvar$prob)
  variance <- aux_variance(binvar$trials, binvar$prob)
  mode <- aux_mode(binvar$trials, binvar$prob)
  skewness <- aux_skewness(binvar$trials, binvar$prob)
  kurtosis <- aux_kurtosis(binvar$trials, binvar$prob)
  
  cat("Summary variable")
  
  cat("\n\n", append = TRUE)
  cat("Parameters", append = TRUE)
  cat("\n - number of trials: ", binvar$trials, append = TRUE)
  cat("\n - prob of success : ", binvar$prob, "\n", append = TRUE)
  
  cat("\n\n", append = TRUE)
  cat("Measures", append = TRUE)
  cat("\n - mean: ", mean, append = TRUE)
  cat("\n - variance : ", variance, append = TRUE)
  cat("\n - mode: ", mode, append = TRUE)
  cat("\n - skewness: ", skewness, append = TRUE)
  cat("\n - kurtosis: ", kurtosis, "\n", append = TRUE)
}


# 1.8) Functions of measures

bin_mean <- function(trials, prob) {
  if (check_trials(trials) && check_prob(prob)) {
    return (aux_mean(trials, prob))
  }
}

bin_variance <- function(trials, prob) {
  if (check_trials(trials) && check_prob(prob)) {
    return (aux_variance(trials, prob))
  }
}

bin_mode <- function(trials, prob) {
  if (check_trials(trials) && check_prob(prob)) {
    return (aux_mode(trials, prob))
  }
}

bin_skewness <- function(trials, prob) {
  if (check_trials(trials) && check_prob(prob)) {
    return (aux_skewness(trials, prob))
  }
}

bin_kurtosis <- function(trials, prob) {
  if (check_trials(trials) && check_prob(prob)) {
    return (aux_kurtosis(trials, prob))
  }
}


