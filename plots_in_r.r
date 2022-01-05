library(Quandl)
quandldata = Quandl("OECD/HEALTH_STAT_CICDINPN_NBMALEPH_ESP")
plot(quandldata[,])

countries = c("ESP", "DEU","GBR", "USA","PRT", "ITA")

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
  paste(paste("ODA/",x,sep = ""), "_PCPIPCH",sep = "")
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
  filter(year < 2020  ) %>%
  ggplot(aes(Date , Value, color=country))+
  geom_line() + 
  geom_text(aes(label= Value), size=2, hjust = 1, vjust=1)+
  scale_x_date(breaks = scales::pretty_breaks(n = 30))+   
  # scale_y_continuous(trans = "sqrt",  breaks = scales::pretty_breaks(n = 20))+
  # theme(legend.position = "none",plot.title = element_text(hjust = 0.5)) +
  ggtitle("Inflacion")+  
  theme(
    # legend.position = "none",
    plot.title = element_text(hjust = 0.5)) + 
  labs(x="", y = "")  + theme_clean()



# From Python -------------------------------------------------------------

nasdaq <- read_csv("~/nasdaq/nasdap.csv")
nasdaq$year= format(as.Date(nasdaq$Date, format="%d/%m/%Y"),"%Y")
as.numeric(nasdaq$year)
colnames(nasdaq)

nasdaq %>% filter(year < 2020) %>%
  ggplot(aes(Date,PCPIPCH) ) +
  geom_line()
+
  scale_x_discrete(breaks = scales::pretty_breaks(n = 30))+   
  scale_y_continuous(trans="log10",  breaks = scales::pretty_breaks(n = 30))


# OECD data ---------------------------------------------------------------
oecd <- read_csv("~/nasdaq/oecd.csv")
colnames(oecd)
oecd$year= format(as.Date(oecd$Date, format="%d/%m/%Y"),"%Y")
as.numeric(oecd$year)
oecd %>% filter(year >1984) %>% ggplot(aes(Date,LTHREACHOSPTHOSNOMBRENBESP )) + 
  # geom_line(size = 2, color = "red")+
  geom_line(mapping = aes(x = Date, y = LTHREACHOSPPUHONOMBRENBESP), stat = "identity", size = 2, color = "blue")+
  geom_line(mapping = aes(x = Date, y = LTHREACHOSPTHOSNOMBRENBESP-LTHREACHOSPPUHONOMBRENBESP), stat = "identity", size = 2, color = "grey")+
  scale_x_date(breaks = scales::pretty_breaks(n = 20))+
  scale_y_continuous(breaks = scales::pretty_breaks(n = 20))+
  ggtitle("Hopitales privados (gris) vs Hospitales publicos (rojo)")+  
  theme(  plot.title = element_text(hjust = 0.5)) + 
  labs(x="", y = "")  + theme_clean()

oecd %>% filter(year >2011) %>% ggplot(aes(Date,LTHREACRVNURINFYSALGDMTESP )) + 
  geom_line(size = 2, color = "red")+
  # geom_line(mapping = aes(x = Date, y = LTHREACHOSPPUHONOMBRENBESP), stat = "identity", size = 2, color = "blue")+
  # geom_line(mapping = aes(x = Date, y = LTHREACHOSPTHOSNOMBRENBESP-LTHREACHOSPPUHONOMBRENBESP), stat = "identity", size = 2, color = "grey")+
  scale_x_date(breaks = scales::pretty_breaks(n = 20))+
  scale_y_continuous(breaks = scales::pretty_breaks(n = 20))+
  ggtitle("remuneracion enfermos sobre el PIB")+  
  theme(  plot.title = element_text(hjust = 0.5)) + 
  labs(x="", y = "")  + theme_clean()
