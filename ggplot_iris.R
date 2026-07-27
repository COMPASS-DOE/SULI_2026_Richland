library(tidyverse)

ggplot(data = iris,
       aes(x = Sepal.Length,
           y = Sepal.Width))+
  geom_line(color = "#0D5091", linewidth = 1)+
  geom_point(color = "#F54927", size = 2)
  

ggplot(data = iris,
       aes(x = Species,
           y = Sepal.Width))+
  geom_point(fill = "#F54927", size = 5, alpha = 1,
             color = "black",
             shape = 23)


ggplot(data = iris,
       aes(x = Species,
           y = Sepal.Width,
           color = Species))+
  geom_point()


ggplot(data = iris,
       aes(x = Sepal.Length,
           y = Sepal.Width,
           color = Species))+
  geom_line(color = "black")+
geom_point()+
  facet_wrap(~Species)
