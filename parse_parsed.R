library(tidyr)
library(dplyr)

rm(list = ls())
mydata = read.csv('output/parsed.csv', stringsAsFactors = FALSE,
                  colClasses = c('factor','character','character')) %>%
  mutate(
    datetime_p = as.POSIXct(datetime,format='%d/%b/%Y:%T %z'),
    year_p = strftime(datetime_p,'%Y'),
    month_p = strftime(datetime_p,'%m'),
    date_p = strftime(datetime_p,'%d'),
    hour_p = strftime(datetime_p,'%H')
    )

mysummary_day = mydata %>% select(year_p,month_p,date_p,ip) %>%
  group_by(year_p,month_p,date_p) %>%
  summarise(hits = n(), hits_unique_ip = n_distinct(ip))

write.csv(mysummary_day,'output/summary_day.csv',row.names = FALSE)

mysummary_hour = mydata %>% select(year_p,month_p,date_p,hour_p,ip) %>%
  group_by(year_p,month_p,date_p,hour_p) %>%
  summarise(hits = n(), hits_unique_ip = n_distinct(ip)) %>% 
  arrange(year_p,month_p,date_p,hour_p)
  
write.csv(mysummary_hour,'output/summary_hour.csv',row.names = FALSE)