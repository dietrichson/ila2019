# Script to download random wikipedia pages
# This script downloads random pages based on a vector of
# page_id. The idea is to check that "randomPage" is indeed random.

library(here)
library(tidyverse)
library(WikipediaR)
library(WikipediR)
library(parallel)

file_name <- here('data/sample_WP_algo_500.RDS')
set.seed(42)

#RandomPages <- random_page("en","wikipedia", limit=1000)
myPageIds <- lapply(RandomPages,function(x)x$pageid) %>% unlist
i <- 1
myContribs <- lapply(myPageIds,function(x){
  cat(i,":",x,'\n')
  i <<- i+1
  tryCatch({
   tmp <- contribs(page=x)
    if(is.null(tmp$contribs)){
      return(NULL)
    }
    df <- tmp$contribs
    df$pageId <- x
    df
  }, error = function (e){
    return (NULL)
  })
})
  
  #myContribs <- c(myContribs,myContribs2) #this was a patch, don't reuse
  myContribs <- bind_rows(myContribs)
  
  
  saveRDS(myContribs,file_name)
  saveRDS(RandomPages, file=here('data/RandomPages_500_en.RDS'))
  nrow(myContribs)/myContribs$pageId %>% unique %>% length() %>% print

  
  
  
  