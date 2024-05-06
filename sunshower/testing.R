devtools::load_all()

data(all_data, package = "sunshower")

devtools::document()

devtools::build()

?create_usa_grid
?timeser
?map_predictions

devtools::test()

View(all_data)
install.packages("fields")
library(fields)


library(ggplot2)
library(RColorBrewer)
library(GpGp)

View(df)

devtools::check()

usa_grid <- create_usa_grid(resolution = 1)
data5 <- df %>% filter(LST_DATE == "2023-03-01")
prediction_value <- data5$T_DAILY_MEAN
grid_pred <- grid_prediction(usa_grid, data5, prediction_value)
grid_pred
