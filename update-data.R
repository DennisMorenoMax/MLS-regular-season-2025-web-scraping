library(httr)
library(jsonlite)
library(dplyr)
library(readr)
library(rvest)

team_id <- "MLS-SEA-0001K9"
stat_types <- c("general", "passing", "attacking", "defending")

get_stats <- function(stat){
  url <- paste0(
    "https://www.mlssoccer.com/stats/clubs/#season=",
    team_id,
    "&statType=",
    stat
  )

  message("Downloading: ", stat)

  res <- GET(url)
  stop_for_status(res)

  json <- content(res, "text", encoding = "UTF-8")
  data <- fromJSON(json)$data

  # Extract table from JSON
  df <- data$rows |> as.data.frame()
  
  return(df)
}

# Loop and save one CSV per tab
for (stat in stat_types) {
  df <- get_stats(stat)
  outfile <- paste0("mls_", stat, "_stats.csv")
  write_csv(df, outfile)
  message("Saved: ", outfile)
}
