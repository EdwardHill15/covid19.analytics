=====================================
# how to get data from github Our World in data (OWID)
# https://github.com/owid/covid-19-data
=====================================
  
url <- "https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/owid-covid-data.csv"
df <- read.csv(url)
