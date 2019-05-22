# Download pages to be compared


library(here)
library(rvest)
library(WikipediaR)
library(tidyverse)
source(here('pages_for_analysis.R'))


pages <- pages_for_analysis

wikiPages <- lapply(1:nrow(pages),function(x){
  myURL <- pages$URL[x]
  cat(x,': reading from', myURL, '\n')
  
  GET(myURL)
})

saveRDS(wikiPages, file=here::here('data/wikiPages_Catalonia_referendum.RDS'))

#Now get the contribution

myContribs <- lapply(1:nrow(pages),function(x){
  myTitle <- pages$title[x]
  myDomain <- pages$domain[x]
  cat(x, myTitle, '\n')
  tmp <- contribs(domain = myDomain, page = myTitle, rvprop = 'ids|timestamp|user|userid|size')
  df <-  tmp$contribs
  df$pageId <- tmp$page['_idx']
  df$domain <- myDomain
  df
}) %>% bind_rows()

saveRDS(myContribs, file=here::here('data/wikiPages_Catalonia_referendum_contribs.RDS'))
