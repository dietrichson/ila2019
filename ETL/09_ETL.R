library(tidyverse)
library(tidytext)
library(rvest)
library(here)
library(syuzhet)
myPages <- readRDS(here("data/wikiPages_catalonia_referendum.RDS"))
source("pages_for_analysis.R")
#Check order of the languages
#Check order of the languages
i <- 0
myDF <- lapply(myPages,function(x){
  myPage <- read_html(x)
  myPage %>% 
    html_node('title') %>% 
    html_text() -> title
  i <<- i+1
  tibble(i = i,title = title, domain=pages_for_analysis$domain[i])
}) %>% bind_rows()

myDF$language <- c("english","spanish","catalan","basque","portuguese","esperanto",
                   "french","galician","scots")

lapply(1:9,function(i){
  cat(i,"\n")
  myPage <- read_html(myPages[[i]])
  myPage %>% 
    html_node('title') %>% 
    html_text() -> title
  myPage %>%
    html_node("body") %>%
    html_text() -> body
  tmpDF <- tibble(title = title, domain=myDF$domain[i],text = body)
  tmpDF <- tmpDF %>% unnest_tokens(word,text,"words")
  tmpDF
}) %>% 
  bind_rows() -> myAnalysis
saveRDS(myAnalysis, here("data/wikipages_parsed_by_word.RDS"))
