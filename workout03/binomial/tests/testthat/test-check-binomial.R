
context("Checkers") 

test_that("check_prob values are between 0 to 1", {
  
  expect_error(check_prob(-123))
  expect_error(check_prob(123))
  expect_true(check_prob(0.5))
})

test_that("check_trials values are greater than -1", {
  
  expect_error(check_trials(-5))
  expect_error(check_trials(-4))
  expect_true(check_trials(3))
})

test_that("check_success success cannot be greater than trials", {
  
  expect_error(check_success(5,3))
  expect_error(check_success(5,-2))
  expect_true(check_success(3,3))
})

test_that("aux_mean has the right numbers", {
  
  expect_error(aux_mean(10,"2"))
  expect_error(aux_mean("c",-2))
  expect_error(aux_mean("2",3))
})

test_that("aux_variance has the right numbers", {
  
  expect_error(aux_variance(10,"2"))
  expect_error(aux_variance("c",-2))
  expect_error(aux_variance("2",3))
})

test_that("aux_mode has the right numbers", {
  
  expect_error(aux_mode(10,"2"))
  expect_error(aux_mode("c",-2))
  expect_error(aux_mode("2",3))
})

test_that("aux_skewness has the right numbers", {
  
  expect_error(aux_skewness(10,"2"))
  expect_error(aux_skewness("c",-2))
  expect_error(aux_skewness("2",3))
})

test_that("aux_kurtosis has the right numbers", {
  
  expect_error(aux_kurtosis(10,"2"))
  expect_error(aux_kurtosis("c",-2))
  expect_error(aux_kurtosis("2",3))
})

context("Binomials") 

test_that("bin_choose: k cannot be greater than n", {
  
  expect_error(bin_choose(10,12))
  expect_error(bin_choose(10,"12"))
  expect_error(bin_choose("12",3))
  
})

test_that("bin_probability: they have reasonable values", {
  
  expect_error(bin_probability(13,12,0.2))
  expect_error(bin_probability(10,-12,0.2))
  expect_error(bin_probability(1,8,3))
  
})

test_that("bin_distribution: they have reasonable values", {
  
  expect_error(bin_distribution(13,12,0.2))
  expect_error(bin_distribution(10,-12,0.2))
  expect_error(bin_distribution(1,8,3))
  
})

test_that("bin_cumulative: they have reasonable values", {
  
  expect_error(bin_cumulative(13,12,0.2))
  expect_error(bin_cumulative(10,-12,0.2))
  expect_error(bin_cumulative(1,8,3))
  
})




