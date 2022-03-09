library(tidyverse)
# retrieve NYPD data
download.file(url = "https://data.cityofnewyork.us/resource/8h9b-rp9u.csv",
              destfile = "NYPD_Arrests_Data__Historic_.csv")
nypd_crimes = read.csv("NYPD_Arrests_Data__Historic_.csv")

# data subset with only necessary fields
nypd_crimes_n = select(nypd_crimes, -c("arrest_key", "pd_cd", "pd_desc", 
                                       "ky_cd", "law_code", 
                                       "arrest_boro", "arrest_precinct",
                                       "age_group", "perp_sex"))
# format arrest_date as usable date variable
dates = c(nypd_crimes_n$arrest_date)
nypd_crimes_n$arrest_date = as.Date(dates, format = "%Y-%m-%d")
nypd_crimes_n$year = format(nypd_crimes_n$date, "%Y")

# select entries that fit project analysis parameters (crimes between 2018 
#and 2019, misdemenors and violations)
nypd_crimes_w = filter(nypd_crimes_n, year >= 2018) %>%
  filter(law_cat_cd == "M" | law_cat_cd == "V")
  
  
