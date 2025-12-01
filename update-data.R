library(httr)
library(jsonlite)
library(dplyr)
library(readr)

team_id <- "MLS-SEA-0001K9"
stat_types <- c("general", "passing", "attacking", "defending")

get_stats <- function(stat){
  url <- paste0("https://www.mlssoccer.com/api/stats/club/", team_id, "/", stat)

  message("Downloading: ", stat)

  res <- httr::GET(url)
  
  # stop if request failed
  stop_for_status(res)
  
  json <- content(res, "text", encoding = "UTF-8")

  df <- fromJSON(json)$data |> as.data.frame()
  return(df)
}

for (stat in stat_types) {
  df <- get_stats(stat)
  write_csv(df, paste0("mls_", stat, "_stats.csv"))
}
