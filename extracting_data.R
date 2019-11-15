library(tidyverse)
library(rvest)
library(xml2)
library(robotstxt)
reports<-read_csv("reports.csv")

reports<- reports %>% 
  filter(year>2011) %>% 
  mutate(filing_date=as.Date(filing_date,"%Y-%m-%d"))

starbucks<-reports %>% 
  filter(cik==829224) 

dunkin<-reports%>% 
  filter(cik==1357204)%>% 
  group_by(year)

write_csv(starbucks,"starbucks.csv")

write_csv(dunkin,"dunkin.csv")
#manunally removed all addendums and ready's the forms

