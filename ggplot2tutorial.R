#Data Visualisation using ggplot2

#Following provides a quick, explained cheat-sheet
#for creating commonly used data visualisations with 
#ggplot2.

#Based on following tutorial: 
# http://r-statistics.co/ggplot2-Tutorial-With-R.html

#First load ggplot2:

library(ggplot2)

##################################################################################################
##################################################################################################
##Cross-Sectional data: Scatter-Plot
##################################################################################################
##################################################################################################

p <- ggplot() + 

#Want Scatter-plot:
  
geom_point(data = diamonds
           , aes(x=carat, y=price, color=factor(cut))) +
  
#Note: color of points will vary according to categories defined by cut.
# function 'factor' converts into categorical data.
  
#Specify Labels:
  
labs(  title = "Cross-Section: Price vs Carat"
     , x = "Carat"
     , y = "Price") +

#Adjust Fonts:  

theme(plot.title = element_text(size=15, face =  "italic")
      , axis.title = element_text(size=11, face = "bold")
      , legend.title = element_text(size=11, face = "bold")
      , legend.text = element_text(size=11, face="italic")) +
  
  scale_color_discrete(name="Cut of Diamonds") +

#Note: Would use scale_color_continuous if cut had been a continuous variable.
  
#Following splits diagram into a series of scatter-plots. The rows relate to different 
#colours, and the columns to different cuts.

facet_wrap(color ~ cut) 

#Display Result:

p

##################################################################################################
##Cross-Sectional data: Bar Chart
##################################################################################################

p.bar <- ggplot() +

#Want bar chart that gives frequencies for different cuts. For each cut, the proportion of 
#different colours is given:
  
  geom_bar(data = diamonds, aes(factor(cut), fill = color), position = position_dodge() ) +

#Note: if remove position = position_dodge(), then will get stacked
  # bar-charts. 
  
#Labels:
  
  labs(title = "Number of Diamonds \n In Each Cut"
       , y = "Frequency", x = "Cut") +
  
#To aid interpretation, white background with grey lines:
  
  theme(panel.background = element_rect(fill = 'white')
       , panel.grid.major = element_line(color = 'grey')) +
  
  scale_fill_discrete(name = "Colour of \n Diamonds") +
  
#Horizontal not vertical bar chart desired:
  coord_flip()

#Display Result:

p.bar

##################################################################################################
##Time-Series Data
##################################################################################################

#First need to convert economics into a data frame:

economics <- data.frame(economics)

#Can do a plot with multiple lines by using layering.
#First layer is pce over time:

p.line <- ggplot() +
  geom_line(data = economics
            , aes(x = date, y = pce, color = "pce")) +
  
#Second layer is unemployment over time:
  geom_line(data=economics
            , aes(x = date, y = unemploy, color = "Unemployment")) +
  
#The above assigned strings to the colours associated with each variable.
#scale_color_manual allows us to set the colours associated with these strings:
  
  scale_color_manual("Legend"
                     , breaks = c("pce", "Unemployment")
                     , values=c("blue","red")) +
#To focus on recent data:

  #Following will zoom, and not delete data:
  coord_cartesian(xlim = as.Date(c("1990-01-01","2015-04-01")))

  #Following will delete data:
  #xlim(as.Date(c("1990-01-01","2015-04-01")))

#Note: need to convert range into same format as the x-axis. Use ylim
#to affect the y-axis.

#To display diagram:

p.line