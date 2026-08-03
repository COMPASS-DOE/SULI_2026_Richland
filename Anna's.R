library(tidyverse)
install.packages("palmerpenguins")
library(palmerpenguins)

ggplot(data=penguins,
       aes(x=sex, y=flipper_length_mm, color=species))+
  geom_point(size=3, alpha=0.5)+
  facet_wrap(~island)+na.omit(penguins)+
  theme_minimal()



penguins_sum=
  penguins%>%
  group_by(species)%>%
  summarize(mean_len=mean(bill_length_mm, na.rm=T),
            mean_dep=mean(bill_depth_mm, na.rm=T),
            sd_len=sd(bill_length_mm,na.rm=T),
            sd_dep=sd(bill_depth_mm, na.rm=T))

ggplot(data=penguins)+
  geom_point(aes(x=bill_length_mm, y=bill_depth_mm,
                 color=species, size=body_mass_g),
             shape=16, alpha=0.2)+
  scale_color_manual(values=c("orange", "purple", "darkcyan"))+
  xlab("bill length (mm)")+
  ylab("bill depth (mm)")+
  annotate("text", label="ADELIE", x=34, y=20.25, color="orange", size=5, fontface="bold")+
  theme_classic()+
  annotate("text", label="CHINSTRAP", x=57, y=19, color="purple", size=5, fontface="bold")+
  theme_classic()+
  annotate("text", label="GENTOO", x=55.5, y=15, color="darkcyan", size=5, fontface="bold")+
  theme_classic()+

 geom_errorbar(data=penguins_sum,
               aes(xmin=mean_len-sd_len,
                   xmax=mean_len+sd_len,
                   y=mean_dep, color=species),
               size=1, width=.5)+
  geom_errorbar(data=penguins_sum,
                aes(ymin=mean_dep-sd_dep,
                    ymax=mean_dep+sd_dep,
                    x=mean_len, color=species),
                size=1, width=.5)+
  scale_y_continuous( breaks=seq(12, 24, 2))
  
                     