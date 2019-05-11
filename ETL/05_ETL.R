# Script to download contribution for random pages
# The pages were fetched in 04_ETL.R


library(here)
library(rvest)
library(WikipediaR)
library(tidyverse)
RandomPages <- readRDS(here::here('data/RandomPages_w_wikipedia_url_1000_en.RDS'))

i <- 1
myDomain <- 'en'
myContribs <- lapply(RandomPages,function(x){
 myTitle <-  x %>% content %>% html_nodes('title') %>% html_text
 str_replace(myTitle, '- Wikipedia','') -> myTitle
  cat(i, myTitle, '\n')
  tmp <- contribs(domain = myDomain, page = myTitle)
  i <<- i + 1
  df <-  tmp$contribs
  df$pageId <- tmp$page['_idx']
  df
}) %>% bind_rows()

saveRDS(myContribs,here::here("data/RandomPages_w_wikipedia_url_1000_en_contributions.RDS"),compress = FALSE)
  


  
  
  
  