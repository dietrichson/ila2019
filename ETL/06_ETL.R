# Rince and repeat 04 and 05 for the languages in question
# 


library(here)
library(rvest)
library(WikipediaR)
library(tidyverse)


myDomains <- c('en','es','ca','eo','pt','gl','eu')
myrvprops <- 'ids|timestamp|user|userid|size'
sample_size = 1000L
  
for (myDomain in myDomains){

  contribs_filename <- str_glue('data/sample_1000_contributions_{myDomain}.RDS')
  i <- 1
  myContribs <- lapply(1:sample_size, function(x){
    myURL <- stringr::str_glue('https://{myDomain}.wikipedia.org/wiki/Special:Random')
    cat(i,":",x,'reading from', myURL,'\n')

    GET(myURL) %>% content %>% html_nodes('title') %>% html_text()->myTitle
    myTitle <- str_replace(myTitle, ' (-|–).*','')
    cat("Extracting from ",myTitle,'\n')
    tmp <- contribs(domain = myDomain, page = myTitle,rvprop = myrvprops)
    df <-  tmp$contribs
    df$pageId <- tmp$page['_idx']
    df$domain <- myDomain
    i <<- i + 1
    df
  }) %>% bind_rows()
  
  
  cat("Saving to:",contribs_filename,'\n')
  saveRDS(myContribs,here::here(contribs_filename))
}

