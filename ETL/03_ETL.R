# Script to download random wikipedia pages
# This script aims to identify whether it is a talkpage or an article

library(here)
library(tidyverse)
library(WikipediaR)
library(WikipediR)
library(parallel)
library(rvest)

file_name <- here::here('data/sample_1000_test.RDS')
myData <- readRDS(file_name)
myPageIds <- myData$pageId %>% unique
i <- 1
RandomPages <- lapply(myPageIds,function(x){
  myURL <- stringr::str_glue('https://en.wikipedia.org/?curid={x}')
  cat(i,":",x,'reading from', myURL,'\n')
  i <<- i+1
  GET(myURL)
})
  
saveRDS(RandomPages, file=here::here('data/RandomPages_729_en.RDS'))


  
  
  
  