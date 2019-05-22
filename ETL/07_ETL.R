# Download pages to be compared


library(here)
library(rvest)
library(WikipediaR)
library(tidyverse)

pages <- tribble(~domain, ~title, ~URL,

                 'en',
                 '2017 Catalan independence referendum',
                 'https://en.wikipedia.org/wiki/2017_Catalan_independence_referendum',
                 
                 'es',
                 'Referéndum de independencia de Cataluña de 2017',
                 'https://es.wikipedia.org/wiki/Refer%C3%A9ndum_de_independencia_de_Catalu%C3%B1a_de_2017',

                 'ca',
                 'Referèndum sobre la independència de Catalunya',
                 'https://ca.wikipedia.org/wiki/Refer%C3%A8ndum_sobre_la_independ%C3%A8ncia_de_Catalunya',
                 
                 'eu',
                 'Kataluniaren independentziarako 2017ko erreferenduma',
                 'https://eu.wikipedia.org/wiki/Kataluniaren_independentziarako_2017ko_erreferenduma',
                 
                 'pt',
                 'Referendo sobre a independência da Catalunha em 2017',
                 'https://pt.wikipedia.org/wiki/Referendo_sobre_a_independ%C3%AAncia_da_Catalunha_em_2017',
                 
                 'eo',
                 'Referendumo pri sendependiĝo de Katalunio en 2017',
                 'https://eo.wikipedia.org/wiki/Referendumo_pri_sendependi%C4%9Do_de_Katalunio_en_2017',
                 'fr',
                 "Référendum de 2017 sur l'indépendance de la Catalogne",
                 'https://fr.wikipedia.org/wiki/R%C3%A9f%C3%A9rendum_de_2017_sur_l%27ind%C3%A9pendance_de_la_Catalogne',
                 
                 'gl',
                 'Referendo sobre a independencia de Cataluña de 2017',
                 'https://gl.wikipedia.org/wiki/Referendo_sobre_a_independencia_de_Catalu%C3%B1a_de_2017',
                 
                 'sco',
                 'Catalan unthirldom referendum, 2017',
                 'https://sco.wikipedia.org/wiki/Catalan_unthirldom_referendum,_2017'
                 )


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
