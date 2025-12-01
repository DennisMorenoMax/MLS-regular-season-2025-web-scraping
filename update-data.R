library(httr)
library(jsonlite)
library(dplyr)
library(readr)

# team ID from your link
team_id <- "MLS-SEA-0001K9"

# the 4 tabs you want
stat_types <- c("general", "passing", "attacking", "defending")

# loop through each tab and save a CSV
for (stat in stat_types) {
  
  # build API url
  url <- paste0("https://api.mlssoccer.com/stats/club/", team_id, "/", stat)
  
  message("Downloading: ", stat)
  
  # get JSON
  res <- httr::GET(url)
  json <- httr::content(res, "text", encoding = "UTF-8")
  
  # convert to dataframe
  df <- jsonlite::fromJSON(json)$data |> 
        as.data.frame()
  
  # output file name
  file_name <- paste0("mls_", stat, "_stats.csv")
  
  # write CSV
  write_csv(df, file_name)
  
  message("Saved: ", file_name)
}
