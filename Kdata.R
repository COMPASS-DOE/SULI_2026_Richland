library(tidyverse)
library(dplyr)
library(ggplot2)
library(ggpmisc)

library(readxl)
Kdata <- read_excel("~/Copy of Kenton's Data.xlsx")


#Kdata2=Kdata minus empty columns
library(janitor)
Kdata2=Kdata |> 
  remove_empty("cols")
plot(Kdata2)


#Aggregates
ggplot(data=Kdata,
       aes(x= `total water stable aggregates 53um-6mm (g/g)`, y=`Water Stable 
           Aggregates MWD`, color=horizon))+
  geom_point()+
  geom_smooth(method="lm", se=F)+
  stat_poly_eq(aes(label = paste(after_stat(rr.label), 
                                 after_stat(p.value.label), 
                                 sep = "*\", \"*")), 
               formula = y ~ x)
   

#Porosity by plot
ggplot(data=Kdata,
       aes(x= `plot`, y=`Calculated porostiy (cm3/cm3)`, color=horizon))+
  geom_point(size=3)+
#how to do trend line, R^2, and P value
  geom_smooth(method="lm", se=F)+
  stat_poly_eq(aes(label = paste(after_stat(rr.label), 
                                 after_stat(p.value.label), 
                                 sep = "*\", \"*")), 
               formula = y ~ x)


#Minerals


#Dataset = Mineralogy. Just mineralogy data
Mineralogy<-select(Kdata, `Label ID`:horizon, Quartz, Albite, Microcline, Mica, 
                   Chlorite, Kaolinite)
names(Kdata)

#Dataset = Minerals. puts all of the minerals into one big column
Minerals=pivot_longer(Mineralogy, 4:9)

#Dataset= Minerals_summary. New column with means of each mineral for each plot
#and its horizons. 
Minerals_summary=
Minerals%>%
  group_by(plot, horizon, name)%>%
  summarize(mean=mean(value, na.rm=T))%>%
  mutate(name2=factor(name, levels = c("Quartz", "Mica", "Albite", "Microcline",
                                       "Kaolinite", "Chlorite")))%>%
  mutate(name3=factor(name, levels= c("Chlorite", "Kaolinite", "Microcline", 
                      "Albite", "Mica", "Quartz")))

#Plot 1. Shows amount of each mineral in each plot. At first, facet_wrapped it 
#by plot, but the data wasn't as interesting as I had hoped it would be. 
#Noticed that F4 is different, has higher quartz and lower Mica. Interesting to 
#compare next to the correlation graph of quartz and mica. Next step: make 
#stacked bar graph to show that everything roughly adds up to 100. 
ggplot(data=Minerals_summary,
       aes(x=name2, y=mean, color=plot, shape=horizon))+
  geom_point(size=4, alpha=.3)

#Plot 2. Shows the same data as plot 1 without the averages. 
ggplot(data=Minerals,
       aes(x=name, y=value, color=plot, shape=horizon))+
  geom_point()

#Plot 3. Correlation between Quartz and Mica across plots and horizons
ggplot(data=Mineralogy,
       aes(x=Quartz, y=Mica, color=plot, shape=horizon))+
  geom_point(size=3)
  

#Plot 4. Stacked bar plot. Switch order of minerals by changing name3 out for 
#name2. Note-the order of the colors will not change if you change the order of 
#the minerals.
ggplot(data=Minerals_summary,
       aes(x=plot, y=mean, fill=name3))+
  geom_bar(stat="identity")+
  scale_fill_manual(values=c("#859b7a","#b46737", "#4bb0a4", "#f0e3bf", 
                             "#876c42", "#d56e9c"))
  
  



