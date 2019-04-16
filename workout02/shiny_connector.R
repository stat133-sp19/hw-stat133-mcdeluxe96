


install.packages('rsconnect')

rsconnect::setAccountInfo(name='amirhisham',
                          token='94C5C503417395C121BC38EFDB1D9EA6',
                          secret='F3XvI1OfVXTyjJIu6/6kwp7x/G54lYkbpMPsAN3N')


library(rsconnect)
rsconnect::deployApp('~/Desktop/STAT_133/amir_01/')


## https://amirhisham.shinyapps.io/amir_01/