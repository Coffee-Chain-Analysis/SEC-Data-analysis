library(tidyverse)
library(robotstxt)
library(xml2)

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

companies_filings_restaurant<-companies_filings %>% 
  filter(cik==829224|cik==1357204 ) %>% 
  arrange(cik)
 
filename=c()
for(item in companies_filings_restaurant$form_10k_url){
  f<-read_delim(item,delim = "\\s",col_names = "Data")
  f<-f %>% 
  filter(grepl("<FILENAME>",Data)) %>% 
  # select(Data) %>% 
  head(1) %>%  
  str_remove("<FILENAME>")
  filename<-c(filename,f)
}

companies_filings_restaurant<- companies_filings_restaurant %>% 
  mutate(htmlfile=filename)

c<-companies_filings_restaurant %>%  
  select(form_10k_url) %>% 
  mutate(form_10k_url=str_replace_all(form_10k_url,".txt","")) %>% 
  mutate(form_10k_url= str_remove_all(form_10k_url,"-")) %>% 
  mutate(form_10k_url= paste0(form_10k_url,"/",companies_filings_restaurant$htmlfile))

c<-c %>% 
  rename(reportsLink=form_10k_url)

cfr<- companies_filings_restaurant

cfr<-cbind(cfr,c)

write_csv(cfr,"reports.csv")
