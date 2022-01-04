# Code: Cumulative distribution function
# Define x as male heights from the dslabs heights dataset:
  
library(tidyverse)
library(dslabs)
data(heights)
x <- heights %>% filter(sex=="Male") %>% pull(height)

# Given a vector x, we can define a function for computing the CDF of x using:
  
F <- function(a) mean(x <= a)
1 - F(70)    # probability of male taller than 70 inches

library(Quandl)
quandldata = Quandl("NSE/OIL", start_date="2013-01-01", type="ts")
plot(quandldata[,1])
# Quandl.database.bulk_download_to_file("ZEA", "./ZEA.zip")

mydata = Quandl("ECB/BLS_Q_U2_ALL_TOIL_B_TCR_F3_ST_S_BWF3")
Quandl.api_key("sqWWxGfThfzLsmyptXgy")
mydata %>% ggplot(aes(Date , mydata$`Unit described in title`))+geom_line()

countries = c("ESP", "DEU","GBR", "USA","PRT", "ITA", "IRE")

name <- function(x) {
  paste(paste("ODA/",x,sep = ""), "_LUR",sep = "")
}

datalist = list()
for (i in countries) {
  names = sapply (i, name)
  dat <- as.data.frame(Quandl(names))
  dat$country <- i  # keep track of which iteration produced it
  datalist[[i]] <- dat
}

comb <- dplyr::bind_rows(datalist)
year= format(as.Date(comb$Date, format="%d/%m/%Y"),"%Y")
comb %>% 
  filter(year<2019 & country %in% c("ESP","GBR","USA") ) %>%
  ggplot(aes(Date , Value, color=country))+
  geom_line() + 
  geom_text(aes(label= Value), size=3, hjust = 1, vjust=1)+
  scale_x_date(breaks = scales::pretty_breaks(n = 30))+   
  scale_y_continuous(trans = "log10",  breaks = scales::pretty_breaks(n = 20))+
  ggtitle("Unemployment")+  
  theme(        plot.title = element_text(hjust = 0.5)) + 
  labs(x="", y = "")  + theme_clean()


#GDP
name <- function(x) {
  paste(paste("ODA/",x,sep = ""), "_NGDPDPC",sep = "")
}

datalist = list()
for (i in countries) {
  names = sapply (i, name)
  dat <- as.data.frame(Quandl(names))
  dat$country <- i  # keep track of which iteration produced it
  datalist[[i]] <- dat
}
comb2 <- dplyr::bind_rows(datalist)
year= format(as.Date(comb2$Date, format="%d/%m/%Y"),"%Y")

comb2 %>% 
  filter(year<2020 & country %in% c("ESP","ITA","PRT", "GBR") ) %>%
  ggplot(aes(Date , Value, color=country))+
  geom_line() + 
  geom_text(aes(label= Value), size=2, hjust = 1, vjust=1)+
  scale_x_date(breaks = scales::pretty_breaks(n = 30))+   
  scale_y_continuous(trans = "sqrt",  breaks = scales::pretty_breaks(n = 20))+
  # theme(legend.position = "none",plot.title = element_text(hjust = 0.5)) +
  ggtitle("GDP per Capita at Current Prices, USD")+  
  theme(plot.title = element_text(hjust = 0.5)) + 
  labs(x="", y = "")  + theme_clean()

#gross debt

name <- function(x) {
  paste(paste("ODA/",x,sep = ""), "_GGXWDG_NGDP",sep = "")
}

datalist = list()
for (i in countries) {
  names = sapply (i, name)
  dat <- as.data.frame(Quandl(names))
  dat$country <- i  # keep track of which iteration produced it
  datalist[[i]] <- dat
}
comb3 <- dplyr::bind_rows(datalist)
year= format(as.Date(comb3$Date, format="%d/%m/%Y"),"%Y")

comb3 %>% 
  filter(year < "2020"  ) %>%
  ggplot(aes(Date , Value, color=country))+
  geom_line() + 
  geom_text(aes(label= Value), size=2, hjust = 1, vjust=1)+
  scale_x_date(breaks = scales::pretty_breaks(n = 30))+   
  scale_y_continuous(trans = "sqrt",  breaks = scales::pretty_breaks(n = 20))+
  # theme(legend.position = "none",plot.title = element_text(hjust = 0.5)) +
  ggtitle("General Government Gross Debt, % of GDP")+  
  theme(
    # legend.position = "none",
    plot.title = element_text(hjust = 0.5)) + 
  labs(x="", y = "")  + theme_clean()

#inflation

name <- function(x) {
  paste(paste("ODA/",x,sep = ""), "_PCPI",sep = "")
}

datalist = list()
for (i in countries) {
  names = sapply (i, name)
  dat <- as.data.frame(Quandl(names))
  dat$country <- i  # keep track of which iteration produced it
  datalist[[i]] <- dat
}
comb4 <- dplyr::bind_rows(datalist)
year= format(as.Date(comb4$Date, format="%d/%m/%Y"),"%Y")

comb4 %>% 
  filter(year < 2020 & country %in% c("ESP", "ITA","GBR", "DEU") ) %>%
  ggplot(aes(Date , Value, color=country))+
  geom_line() + 
  geom_text(aes(label= Value), size=2, hjust = 1, vjust=1)+
  scale_x_date(breaks = scales::pretty_breaks(n = 30))+   
  scale_y_continuous(trans = "sqrt",  breaks = scales::pretty_breaks(n = 20))+
  # theme(legend.position = "none",plot.title = element_text(hjust = 0.5)) +
  ggtitle("General Government Gross Debt, % of GDP")+  
  theme(
    # legend.position = "none",
    plot.title = element_text(hjust = 0.5)) + 
  labs(x="", y = "")  + theme_clean()

