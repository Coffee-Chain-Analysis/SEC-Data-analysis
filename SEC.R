library(tidyverse)

cik_name_lookup<-read_tsv("data/cik_name_lookup.txt")
companies<-read_tsv("data/companies.txt")
companies_filings<-read_tsv("data/company_filings.txt")
company_info<-read_csv("data/company_info.txt",)
company_names<-read_tsv("data/company_names.txt")
company_locations<-read_tsv("data/company_locations.txt")
company_relations<- read_tsv("data/company_relations.txt")
filers<- read_tsv("data/filers.txt")
meta<-read_tsv("data/meta.txt")
relationships<-read_tsv("data/relationships.txt")
sic_codes<-read_tsv("data/sic_codes.txt")
sic_sectors<-read_tsv("data/sic_sectors.txt")
un_countries<-read_tsv("data/un_countries.txt")
un_country_aliases<-read_tsv("data/un_country_aliases.txt")
un_country_subdivisions<-read_tsv("data/un_country_subdivisions.txt")
cw_id_name_lookup<-read_tsv("data/cw_id_lookup.txt")
filings<-read_tsv("data/filings.txt")
filings_lookup<-read_tsv("data/filings_lookup.txt")


looking<-filings %>% 
  filter(company_name=="STARBUCKS CORP",type=='10-Q') %>% 
  arrange(year,quarter)

companies_filings_stabucks<-companies_filings %>% 
  filter(cik==829224)

relationships<-relationships %>% 
  arrange(company_name)
