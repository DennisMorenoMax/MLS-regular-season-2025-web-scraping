# MLS-regular-season-2025-web-scraping

A web-scraping pipeline built to collect, and export data for the 2025 Major League Soccer (MLS) regular season. This repository provides downloadable datasets and automated scripts to keep MLS season information and team statistics up to date.

📁 Repository Structure

MLS-regular-season-2025-web-scraping/

│

├── mls_season_2025_info.csv #Core season info (schedule, teams,match data, etc.)

├── mls_2025_team_stats.csv #Team-level statistics for the 2025 MLS season

├── update-data.R  #Web scraping & data-processing script

└── .github/workflows/  #Optional GitHub Actions automation

📝 Overview

This project scrapes authoritative MLS data sources to capture structured information about the 2025 regular season, including:

Team names & conference assignments

Match dates, locations, and opponents

Standings and team performance metrics

Additional season-level metadata

The script consolidates the scraped information into two clean CSV files suitable for analytics, dashboards, machine-learning models, and sports-data research.


🚀 How to Run

Clone the repository:

git clone https://github.com/DennisMorenoMax/MLS-regular-season-2025-web-scraping.git

cd MLS-regular-season-2025-web-scraping


Run the update script:

Rscript update-data.R


Output files will be saved (or updated) in the project root:

mls_season_2025_info.csv

mls_2025_team_stats.csv

📌 Features

✔ Automated web scraping of MLS 2025 season data

✔ Clean and standardized CSV outputs

✔ Ready for analytics, visualization, and modeling

✔ Easy to extend to future seasons

✔ Scripts designed for automation through GitHub Actions

🧠 Use Cases

You can use this dataset for:

📈 Statistical analysis of MLS 2025 team performance

🧮 Predictive modeling (e.g., match outcomes, team form)

📊 Dashboards & visualization projects

📚 Academic or sports-analytics research

⚽ Historical data archiving for future comparisons

🔄 Automation (Optional)

If you use GitHub Actions, scraping can be scheduled to run automatically.
The .github/workflows directory can contain cron-based automation—helpful for continuously updating the datasets without running the script manually.

🤝 Contributing

Have ideas, improvements, or feature requests?

Open an issue

Submit a pull request

Or reach out directly

All contributions are welcome!


🙌 Acknowledgments

Data provided from publicly accessible MLS resources

Built with R and the tidyverse ecosystem

Maintained by Dennis Moreno
