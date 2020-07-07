library(tidyverse)
library(sf)
library(ISOcodes)
library(countrycode)

# This file documents the generation of the data files for the exercises in 
# Weidmann, Nils B. "Data Management for Social Scientists"

# create directory for raw files
dir.create(file.path("raw"), showWarnings = FALSE)

### Chapter 04

# Kristian Gleditsch capital distances data
dir.create(file.path("raw", "ksg-capital-distances"), showWarnings = FALSE)
download.file("http://ksgleditsch.com/data/capdist.csv", file.path("raw", "ksg-capital-distances", "capdist.csv"))
capdist <- read_csv(file.path("raw", "ksg-capital-distances", "capdist.csv")) %>% filter(numa == 2)
capdist$kmdist <- round(1.01 * capdist$kmdist, 2) # add decimals
capdist$midist <- round(1.01 * capdist$midist, 2) # add decimals
write_delim(capdist, file.path("ch04", "csv-example.csv"), delim = "," )
capdist_comma <- format(as.data.frame(capdist), decimal.mark=",")
write_delim(capdist_comma, file.path("ch04", "csv-example-semicolon.csv"), delim = ";" )
capdist$capnamea <- "Washington, DC"
write_delim(capdist, file.path("ch04", "csv-example-quotes.csv"), delim = "," )

# Dreher, Sturm and Vreeland (2009) UN Security Council data
dir.create(file.path("raw", "dreher-unsc-membership"), showWarnings = FALSE)
download.file("http://www.axel-dreher.de/UNSCdata.xls", file.path("raw", "dreher-unsc-membership", "UNSCdata.xls"))
file.copy(file.path("raw", "dreher-unsc-membership", "UNSCdata.xls"), file.path("ch04", "unsc-membership.xls"))

# Polo (2020) terrorism targets data
dir.create(file.path("raw", "polo-terrorism"), showWarnings = FALSE)
download.file("https://www.prio.org/utility/DownloadFile.ashx?id=144&type=replicationfile", file.path("raw", "terrorism-targets.zip"))
unzip(file.path("raw", "terrorism-targets.zip"), exdir=file.path("raw", "polo-terrorism"))
unlink(file.path("raw", "terrorism-targets.zip"))
file.copy(file.path("raw", "polo-terrorism", "PoloJPR_Main_repdata.dta"), file.path("ch04", "terrorism-targets.dta"))

# Worlds of Journalism national-level aggregates
dir.create(file.path("raw", "worlds-of-journalism"), showWarnings = FALSE)
download.file("https://worldsofjournalism.org/wp-content/uploads/2020/01/WJS-2012-16-aggregated.zip", file.path("raw", "journalism.zip"))
unzip(file.path("raw", "journalism.zip"), exdir=file.path("raw", "worlds-of-journalism"))
unlink(file.path("raw", "journalism.zip"))
file.copy(file.path("raw", "worlds-of-journalism", "WJS 2012-16 aggregated.sav"), file.path("ch04", "journalism.sav"))

# Barbera (2015) world leader Twitter data 
dir.create(file.path("raw", "barbera-twitter"), showWarnings = FALSE)
download.file("https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/26589/LLYTFB", file.path("raw", "barbera-twitter", "elites-data.RData"))
file.copy(file.path("raw", "barbera-twitter", "elites-data.RData"), file.path("ch04", "leaders-twitter.RData"))


### Chapter 05

# G-Econ dataset
dir.create(file.path("raw", "g-econ"), showWarnings = FALSE)
download.file("https://gecon.yale.edu/sites/default/files/files/Gecon40_post_final.xls", file.path("raw", "g-econ", "Gecon40_post_final.xls"))
file.copy(file.path("raw", "g-econ", "Gecon40_post_final.xls"), file.path("ch05", "g-econ.xls"))


### Chapter 06

# US inquality estimates from the World Inequality Database (https://wid.world/data/)
iso2letter <- ISO_3166_1$Alpha_2
dir.create(file.path("raw", "wid"), showWarnings = FALSE)
tmp <- tempdir()
download.file("https://wid.world/bulk_download/wid_all_data.zip", file.path(tmp, "wid.zip"))
unzip(file.path(tmp, "wid.zip"), exdir=tmp)
for (file in list.files(tmp, "^WID_data")) {
  country <- file %>% str_replace("WID_data_", "") %>% str_replace(".csv", "")
  if (country %in% iso2letter) {
    file.copy(file.path(tmp, file), file.path("raw", "wid", file))
  }
}
inequality <- read_delim(file.path("raw", "wid", "WID_data_US.csv"), delim=";") %>% filter(variable == "sptincj992" & percentile == "p90p100")
write_delim(inequality, file.path("ch06", "us-inequality.csv"), delim = "," )
unlink(tmp, recursive = TRUE)


# US GDP estimates from the Federal Reserve Bank of St. Louis (https://fred.stlouisfed.org/series/A939RX0Q048SBEA)
dir.create(file.path("raw", "gdp-us"), showWarnings = FALSE)
download.file("https://fred.stlouisfed.org/graph/fredgraph.csv?id=A939RX0Q048SBEA&scale=left&cosd=1947-01-01&coed=2019-10-01&line_color=%234572a7&link_values=false&line_style=solid&mark_type=none&mw=3&lw=2&ost=-99999&oet=99999&mma=0&fml=a&fq=Quarterly&fam=avg&fgst=lin&fgsnd=2009-06-01&line_index=1&transformation=lin&vintage_date=2020-03-26&revision_date=2020-03-26&nd=1947-01-01", file.path("raw", "gdp-us", "us-gdp-pc.csv"))
file.copy(file.path("raw", "gdp-us", "us-gdp-pc.csv"), file.path("ch06", "us-gdp-pc.csv"))


### Chapter 07

# Global inquality estimates from the World Inequality Database (https://wid.world/data/)
files <- list.files(file.path("raw", "wid"), "*.csv")
widfile <- read_delim(file.path("raw", "wid", files[1]), delim=";") %>% filter(variable == "sptincj992" & percentile == "p90p100") 
write_delim(widfile, file.path("ch07", "inequality.csv"), delim = ",")

for (file in files[-1]) {
  widfile <- read_delim(file.path("raw", "wid", file), delim=";") %>% filter(variable == "sptincj992" & percentile == "p90p100")
  write_delim(widfile, file.path("ch07", "inequality.csv"), delim = ",", append = T)
}

# Polity IV database
dir.create(file.path("raw", "polity"), showWarnings = FALSE)
download.file("http://www.systemicpeace.org/inscr/p4v2018.xls", file.path("raw", "polity", "p4v2018.xls"))
file.copy(file.path("raw", "polity", "p4v2018.xls"), file.path("ch07", "polity.xls"))

### Chapter 08

# Elections data from the ParlGov database (2018 Version)
dir.create(file.path("raw", "parlgov"), showWarnings = FALSE)
download.file("https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/F0YGNC/A1XJ4P", file.path("raw", "parlgov", "election.tab"))
read_delim(file.path("raw", "parlgov", "election.tab"), delim = "\t", escape_backslash = T, escape_double = F) %>% 
  filter(election_type == "parliament") %>% 
  filter(grepl("Europe", countrycode(country_name_short, "iso3c", "region")) | country_name_short == "CYP") %>%
  select(election_id, country_name, election_date, party_id, vote_share, seats, seats_total) %>% 
  write_csv(file.path("ch08", "elections.csv"))

### Chapter 09

# Parties data from the ParlGov database (2018 Version)
download.file("https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/F0YGNC/Q49NWO", file.path("raw", "parlgov", "party.tab"))

# fix countrycode() issue which puts Cyprus in the wrong region
read_delim(file.path("raw", "parlgov", "election.tab"), delim = "\t", escape_backslash = T, escape_double = F) %>% 
  filter(election_type == "parliament") %>% 
  filter(grepl("Europe", countrycode(country_name_short, "iso3c", "region")) | country_name_short == "CYP") %>%
  select(election_id, country_name, election_date, party_id, vote_share, seats, seats_total) %>% 
  write_csv(file.path("ch09", "elections.csv"))
read_delim(file.path("raw", "parlgov", "party.tab"), delim = "\t", escape_backslash = T, escape_double = F) %>% 
  filter(grepl("Europe", countrycode(country_name_short, "iso3c", "region")) | country_name_short == "CYP") %>%
  select(party_id, party_name_short, party_name_english, country_name, family_name) %>%
  write_csv(file.path("ch09", "parties.csv"))

# PopuList database (Version 2.0)
# Fix issue where party shows up twice (Poland, parlgov_id==2602)
library(readxl)
dir.create(file.path("raw", "popu-list"), showWarnings = FALSE)

download.file("https://populistorg.files.wordpress.com/2020/02/populist-2.0.xlsx", file.path("raw", "popu-list", "populist-2.0.xlsx"))

read_excel(file.path("raw", "popu-list", "populist-2.0.xlsx")) %>% 
  filter(!(parlgov_id==2602 & party_name_short == "ZRP")) %>%
  select(parlgov_id, populist, farleft, farright) %>%
  filter(!is.na(parlgov_id)) %>%
  write_csv(file.path("ch09", "populist.csv"))

### Chapter 11

## Uppsala Geo-referenced Event Dataset (Version 18.1)
dir.create(file.path("raw", "ged"), showWarnings = FALSE)
tmp <- tempdir()
download.file("https://ucdp.uu.se/downloads/ged/ged191-csv.zip", file.path(tmp, "ged191-csv.zip"))
unzip(file.path(tmp, "ged191-csv.zip"), exdir=tmp)
file.copy(file.path(tmp, "ged191.csv"), file.path("raw", "ged", "ged191.csv"))
read_delim(file.path("raw", "ged", "ged191.csv"), delim = ",") %>%
  filter(conflict_new_id %in% c(389, 397, 451, 528, 4523, 4871)) %>%
  filter(where_prec==1) %>%
  select(id, date_start, latitude, longitude, best) %>%
  write_csv(file.path("ch11", "ged.csv"))
unlink(tmp, recursive = TRUE)


### Chapter 12

## EUSpeech dataset
library(zip)
dir.create(file.path("raw", "euspeech"), showWarnings = FALSE)
download.file("https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/GKABNU/XABKKH", file.path("raw", "euspeech", "supercorpus_unstemmed_V4.RData"))
load(file.path("raw", "euspeech", "supercorpus_unstemmed_V4.RData"))
docs <- corpus_unstemmed$documents
docs <- subset(docs, country=="European Parliament")
write_csv(docs, "speeches.csv")
zipr(file.path("ch12", "speeches.csv.zip"), "speeches.csv")


### Chapter 13

## COW Trade data
dir.create(file.path("raw", "cow-trade"), showWarnings = FALSE)
tmp <- tempdir()
download.file("https://correlatesofwar.org/data-sets/bilateral-trade/cow_trade_4.0/at_download/file", file.path(tmp, "cow_trade_v4.zip"))
unzip(file.path(tmp, "cow_trade_v4.zip"), exdir=tmp)
file.copy(file.path(tmp, "COW_Trade_4.0", "Dyadic_COW_4.0.csv"), file.path("raw", "cow-trade", "Dyadic_COW_4.0.csv"))
file.copy(file.path(tmp, "COW_Trade_4.0", "National_COW_4.0.csv"), file.path("raw", "cow-trade", "National_COW_4.0.csv"))
file.copy(file.path(tmp, "COW_Trade_4.0", "COW Trade Data Set Codebook.pdf"), file.path("raw", "cow-trade", "COW Trade Data Set Codebook.pdf"))
read_delim(file.path("raw", "cow-trade", "Dyadic_COW_4.0.csv"), delim = ",") %>%
  filter(year >= 1946 & year <= 2014) %>%
  select(ccode1, ccode2, year, smoothflow1, smoothflow2, smoothtotrade) %>%
  write_csv(gzfile(file.path("ch13", "trade.csv.gz")), na="NA")
unlink(tmp, recursive = TRUE)

# V-Dem data
dir.create(file.path("raw", "v-dem"), showWarnings = FALSE)
tmp <- tempdir()
download.file("http://v-dem.pol.gu.se/v9/Country_Year_V-Dem_Full+others_R_v9.zip", file.path(tmp, "vdem-complete.zip"))
unzip(file.path(tmp, "vdem-complete.zip"), exdir=tmp)
file.copy(file.path(tmp, "Country_Year_V-Dem_Full+others_R_v9", "V-Dem-CY-Full+Others-v9.rds"), file.path("raw", "v-dem", "V-Dem-CY-Full+Others-v9.rds"))
vdem <- readRDS(file.path("raw", "v-dem", "V-Dem-CY-Full+Others-v9.rds"))
vdem %>%
  filter(year >= 1946 & year <= 2014) %>%
  select(country_name, year, COWcode, v2x_polyarchy, e_regiongeo, e_migdppc) %>%
  write_csv(file.path("ch13", "vdem.csv"), na="NA")
unlink(tmp, recursive = TRUE)

