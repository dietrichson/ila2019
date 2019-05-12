# Script to download random wikipedia pages


library(here)
library(tidyverse)
library(WikipediaR)
library(WikipediR)
library(parallel)

file_name <- here('data/sample_1000_test.RDS')
set.seed(42)
random_vec <- runif(1000,min = 10^3L , 10^6L) %>% round()
i <- 1
myContribs <- lapply(random_vec,function(x){
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
  
  nrow(myContribs)/myContribs$pageId %>% unique %>% length() %>% print

  
  
  
  