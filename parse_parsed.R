library(tidyr)
library(dplyr)

rm(list = ls())
mydata = read.csv('output/parsed.csv', stringsAsFactors = FALSE,
                  colClasses = c('factor','character','character')) %>%
  mutate(
    datetime_p = as.POSIXct(datetime,format='%d/%b/%Y:%T %z'),
    year_p = strftime(datetime_p,'%Y'),
    month_p = strftime(datetime_p,'%m'),
    date_p = strftime(datetime_p,'%d')
    )

mysummary = mydata %>% select(year_p,month_p,date_p,ip) %>%
  group_by(year_p,month_p,date_p) %>%
  summarise(hits = n(), hits_unique_ip = n_distinct(ip))
