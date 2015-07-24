require(rvest)
require(dplyr)
require(magrittr)
require(tidyr)
require(ggplot2)

url2 <- "https://en.wikipedia.org/wiki/List_of_ATP_number_1_ranked_singles_players"
url3 <- "https://en.wikipedia.org/wiki/Roger_Federer"


data3 <- url2 %>%
  html() %>%
  html_nodes("table:nth-child(23) td:nth-child(1) :nth-child(1)") %>%
  .[[1]] %>%
  html_table()

Player_Name <- data.frame(do.call('rbind', strsplit(as.character(data3$Player),',',fixed=TRUE)))

data4 <- url3 %>%
  html() %>%
  html_nodes(".vcard") %>%
  .[[1]] %>%
  html_table(fill = T)