# Author: Yuan Huang
# This file downloads my jawbone sleep / activity data automatically from
# Google Spreadsheet

library(dplyr)
library(tidyr)
library(rvest)
library(lubridate)

setwd("~/Documents/MyJawboneUP/")

activity_url <- "https://docs.google.com/spreadsheets/d/1tN9t7Npu120wuuSzBvCimSnEzxEpwFb0XkFb0JoiP-Q/pubhtml"
sleep_url <- "https://docs.google.com/spreadsheets/d/1N-4-Xv0t-3kTzCjq5zD4aqTe2S-y_x5BJAFU48ZpCqQ/pubhtml"

load_gss <- function(url) {
  df <- url %>%
    html() %>%
    html_table() %>%
    .[[1]] %>%
    data.frame()
  
  colnames(df) <- df[1,]
  df <- df[-c(1),-c(1)]
  return(df)
}

activity <- load_gss(activity_url)
sleep <- load_gss(sleep_url)

activity$Date <- mdy(activity$DateOfActivity)
sleep$AwokeAt <- mdy_hm(sleep$AwokeAt)
sleep$FellAsleepAt <- mdy_hm(sleep$FellAsleepAt)
sleep$Date <- sleep$AwokeAt

save(activity, file = "acitivity.Rda")
save(sleep, file = "sleep.Rda")