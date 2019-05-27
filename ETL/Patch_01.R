#Patch to dedupethe double download for French
library(here)
library(tidyverse)
file.name <- here("data/wikiPages_Catalonia_referendum_contribs_2.RDS")
myData <- readRDS(file.name)
myData2 <- 
  myData %>% filter(domain=='fr')
myData2 <- myData2 %>% filter(!duplicated(timestamp))
myData <- myData %>% filter(domain != 'fr')
myData <- bind_rows(myData,myData2)
saveRDS(myData,file.name)

