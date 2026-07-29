library(tidyverse)

ggplot(data=penguins,
       aes(x=sex, y=flipper_len, color=species))+
  geom_point(size=3, alpha=0.5)+
  facet_wrap(~island)+na.omit(penguins)

ggplot(data=penguins,
       aes(x=bill_len, y=bill_dep, color=species, size=body_mass))+
  geom_point(shape=16, alpha=0.2)+
  scale_color_manual(values=c("orange", "purple", "darkcyan"))+
  xlab("bill length (mm)")+
  ylab("bill depth (mm)")+
  theme_classic()+
  theme(legend.position="bottom")
  geom_errorbar(aes(ymin=mean("species")-sd("species"), ymax=mean("species")+sd("species")), width=0.2)
 penguins_sum<-summary(penguins)
penguins_sum
