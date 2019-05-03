### Binomial Distribution
The Binomial distribution is perhaps the most famous probability distribution among discrete
random variables. This is the theoretical probability model that we use when calculating
probabilities about the number of successes in a fixed number of random trials performed
under identical conditions (assuming a constant probability of success on each trial).

### Motivation
I come up with the idea to illustrate the concept famously used so that everyone can use it!

### Installation

development version from GitHub:
> #install.packages("devtools") 

install "cointoss" (without vignettes)
>devtools::install_github("gastonstat/cointoss")

install "cointoss" (with vignettes)
> devtools::install_github("gastonstat/cointoss", build_vignettes = TRUE)

### Functions
* bin_choose()
– bin_probability()
– bin_distribution(); and plot.bindis()
– bin_cumulative(); and plot.bincum()
– bin_var(); and print.binvar(), summary.binvar(), print.summary.binvar()
– bin_mean(), bin_variance(), bin_mode(), bin_skewness(), bin_kurtosis()
