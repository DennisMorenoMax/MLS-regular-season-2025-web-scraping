library(httr)
library(jsonlite)
library(dplyr)
library(tidyr)
library(readr)

get_mls_data <- function() {
  url <- "https://stats-api.mlssoccer.com/statistics/clubs/competitions/MLS-COM-000001/seasons/MLS-SEA-0001K9?per_page=50"
  
  res <- httr::GET(url)
  stop_for_status(res)
  
  data <- jsonlite::fromJSON(content(res, "text"))
  
  season_info <- as_tibble(data$stats_info)
  team_stats   <- as_tibble(data$team_statistics)
  
  list(season_info = season_info, team_stats = team_stats)
}

expand_lists <- function(df) {
  repeat {
    list_cols <- names(df)[sapply(df, function(x) is.list(x) || is.matrix(x))]
    if (length(list_cols) == 0) break
    
    for (col in list_cols) {
      df <- df %>% unnest_wider(all_of(col), names_sep = paste0("_", col))
    }
  }
  return(df)
}

# Fetch both tables
mls <- get_mls_data()

# Expand nested columns
season_info_expanded <- expand_lists(mls$season_info)
team_stats_expanded  <- expand_lists(mls$team_stats)

# Attach season info to every team row
team_stats_with_info <- team_stats_expanded %>%
  mutate(
    competition   = season_info_expanded$competition,
    competition_id= season_info_expanded$competition_id,
    season        = season_info_expanded$season,
    season_id     = season_info_expanded$season_id,
    match_day     = season_info_expanded$match_day,
    match_day_id  = season_info_expanded$match_day_id
  )

# Extract season year for filenames
season_year <- season_info_expanded$season

# Write CSVs with year in the filename
write_csv(season_info_expanded, paste0("mls_season_", season_year, "_info.csv"))
write_csv(team_stats_with_info, paste0("mls_", season_year, "_team_stats.csv"))
