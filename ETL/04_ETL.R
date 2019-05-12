# Script to download random wikipedia pages
# Download 1000 random pages using the wikipedia URL, not the API

library(here)
library(httr)


i <- 1
RandomPages <- lapply(1:1000,function(x){
  myURL <- stringr::str_glue('https://en.wikipedia.org/wiki/Special:Random')
  cat(i,":",x,'reading from', myURL,'\n')
  i <<- i+1
  GET(myURL)
})
  
saveRDS(RandomPages, file=here::here('data/RandomPages_w_wikipedia_url_1000_en.RDS'))


  
  
  
  