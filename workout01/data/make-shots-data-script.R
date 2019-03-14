---
#title: "data preparation"
#description: "clean the data"
#input(s): "informations of five nba players"
#output: "summaries of five nba players"
---
## upload csv files of each flayer
andre <- read.csv("~/Desktop/STAT_133/workout01/data/draymond-green.csv", stringsAsFactors = FALSE)
draymond <- read.csv("~/Desktop/STAT_133/workout01/data/draymond-green.csv", stringsAsFactors = FALSE)
kevin <- read.csv("~/Desktop/STAT_133/workout01/data/kevin-durant.csv", stringsAsFactors = FALSE)
klay <- read.csv("~/Desktop/STAT_133/workout01/data/klay-thompson.csv", stringsAsFactors = FALSE)
curry <- read.csv("~/Desktop/STAT_133/workout01/data/stephen-curry.csv", stringsAsFactors = FALSE)
## gen column names
andre$name <- "Andre Iguodala" 
draymond$name <- "Draymond Green" 
kevin$name <- "Kevin Durant" 
klay$name <- "Klay Thomson" 
curry$name <- "Steph Curry" 


## rename vectors in var shot_made_flag
andre$shot_made_flag[andre$shot_made_flag=="y"] <- "shot_yes"
andre$shot_made_flag[andre$shot_made_flag=="n"] <- "shot_no"

draymond$shot_made_flag[draymond$shot_made_flag=="y"] <- "shot_yes"
draymond$shot_made_flag[draymond$shot_made_flag=="n"] <- "shot_no"

kevin$shot_made_flag[kevin$shot_made_flag=="y"] <- "shot_yes"
kevin$shot_made_flag[kevin$shot_made_flag=="n"] <- "shot_no"

klay$shot_made_flag[klay$shot_made_flag=="y"] <- "shot_yes"
klay$shot_made_flag[klay$shot_made_flag=="n"] <- "shot_no"

curry$shot_made_flag[curry$shot_made_flag=="y"] <- "shot_yes"
curry$shot_made_flag[curry$shot_made_flag=="n"] <- "shot_no"

## add minute column
andre$minute <- andre$period*12 - andre$minutes_remaining   
draymond$minute <- draymond$period*12 - draymond$minutes_remaining      
kevin$minute <- kevin$period*12 - kevin$minutes_remaining      
klay$minute <- klay$period*12 - klay$minutes_remaining      
curry$minute <- curry$period*12 - curry$minutes_remaining

## output summaries of all players
setwd("~/Desktop/STAT_133/workout01/output")
sink('andre-iguodala-summary.txt')
summary(andre)
sink()
sink('kevin-durant-summary.txt')
summary(kevin)
sink()
sink('draymond-green-summary.txt')
summary(draymond)
sink()
sink('klay-thomson-summary.txt')
summary(klay)
sink()
sink('steph-curry-summary.txt')
summary(curry)
sink()

## bind all the files together forever ever after
binded_data <-  rbind(andre,curry,draymond,kevin,klay)

## export binded data into excel
setwd("~/Desktop/STAT_133/workout01/data")
write.csv(binded_data, "~/Desktop/STAT_133/workout01/data/shots-data.csv")

## summarize the binded data
sink('~/Desktop/STAT_133/workout01/output/shots-data-summary.txt')
summary(binded_data)
sink()

548
