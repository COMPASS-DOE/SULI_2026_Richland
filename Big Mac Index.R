library(tidyverse)

big_mac <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-12-22/big-mac.csv')

ggplot(big_mac,
       aes(x=date, y=gdp_raw))
