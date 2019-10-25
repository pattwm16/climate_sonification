# Visualization of Climate Data
library(tidyverse)
library(naniar)
library(ggpubr)

# read in climate data
climate_dat <- read.csv('GLB.Ts+dSST.csv', header = TRUE)
climate_dat <- replace_with_na(climate_dat, replace = list(SON = '***',
                                                           MAM = '***',
                                                           DJF = '***',
                                                           JJA = '***'))

# line/scatter plot of climate data (June-July-August)
jja <- ggplot(climate_dat, aes(x=Year, y=as.double(JJA))) +
  geom_line() +
  geom_point() +
  geom_smooth(method = "loess") +
  #ggtitle("Global Mean Temperature (1880-2019)") +
  ylab("Mean Temperature Change over JJA") +
  theme_classic()

# line/scatter plot of climate data (Sept-Oct-Nov)
son <- ggplot(climate_dat, aes(x=Year, y=as.double(SON)))+
  geom_line() +
  geom_point() +
  geom_smooth(method = "loess") +
  #ggtitle("Global Mean Temperature (1880-2019)") +
  ylab("Mean Temperature Change over SON") +
  theme_classic()

djf <- ggplot(climate_dat, aes(x=Year, y=as.double(DJF)))+
  geom_line() +
  geom_point() +
  geom_smooth(method = "loess") +
  #ggtitle("Global Mean Temperature (1880-2019)") +
  ylab("Mean Temperature Change over DJF") +
  theme_classic()

mam <- ggplot(climate_dat, aes(x=Year, y=as.double(MAM)))+
  geom_line() +
  geom_point() +
  geom_smooth(method = "loess") +
  #ggtitle("Global Mean Temperature (1880-2019)") +
  ylab("Mean Temperature Change over MAM") +
  theme_classic()

figure <- ggarrange(jja, son, djf, mam, 
          labels = c("A", "B", "C", "D"),
          ncol = 2, nrow = 2)

annotate_figure(figure,
                top = text_grob("Global Mean Temperature (1880-2019)", face = "bold", size = 18),
                bottom = text_grob("Data source: \n NASA GISS",
                                   hjust = 1, x = 1, face = "italic", size = 10))

