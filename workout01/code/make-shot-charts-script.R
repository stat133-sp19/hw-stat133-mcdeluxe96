#title: "shot charts"
#description: "here we create short charts
#input(s): "informations of five nba players"
#output: "short charts of five nba players"

klay_scatterplot <- ggplot(data = klay) +
  geom_point(aes(x = x, y = y, color = shot_made_flag))
klay_scatterplot

x <- c("grid", "jpeg", "ggplot2")
lapply(x, library, character.only = TRUE)

## upload court image
court_file <- "~/Desktop/STAT_133/workout01/images/nba-court.jpg"

court_image <- rasterGrob(
  readJPEG(court_file),
  width = unit(1, "npc"),
  height = unit(1, "npc"))


## gen and save players' image
klay_shot_chart <- ggplot(data = klay) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') +
  theme_minimal()
ggsave('~/Desktop/STAT_133/workout01/images/klay-thompson-shot-chart.pdf', height = 5, width = 6.5)

andre_shot_chart <- ggplot(data = andre) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Iguododala (2016 season)') +
  theme_minimal()
ggsave('~/Desktop/STAT_133/workout01/images/andre-iguodala-shot-chart.pdf', height = 5, width = 6.5)

curry_shot_chart <- ggplot(data = curry) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Steph Curry (2016 season)') +
  theme_minimal()
ggsave('~/Desktop/STAT_133/workout01/images/steph-curry-shot-chart.pdf', height = 5, width = 6.5)

kevin_shot_chart <- ggplot(data = kevin) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin Durant (2016 season)') +
  theme_minimal()
ggsave('~/Desktop/STAT_133/workout01/images/kevin-durant-shot-chart.pdf', height = 5, width = 6.5)

draymond_shot_chart <- ggplot(data = draymond) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Draymond Green (2016 season)') +
  theme_minimal()
ggsave('~/Desktop/STAT_133/workout01/images/draymond-green-shot-chart.pdf', height = 5, width = 6.5)



## all players' shots in facet mode
ggplot(data = binded_data) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  theme_minimal() +
  facet_wrap(~ name)
ggsave('~/Desktop/STAT_133/workout01/images/gsw-shot-charts.pdf', height = 7, width = 8)
