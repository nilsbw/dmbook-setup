library(tidyverse)
library(sf)

# This file documents the generation of the data files for the exercises in 
# Weidmann, Nils B. "Data Management for Social Scientists"

# For readers of this book, there is no need to run this file, since the 
# required data files can be obtained directly from the repository at
# https://github.com/nilsbw/dmbook-exercises

# This script downloads each dataset to a subfolder in the "raw" directory. 
# See the code below for the locations of the original files 
# and the subfolders where they are stored locally.
# Many datasets are modified for pedagocial purposes. See the code below 
# for the modifications applied to the data.

# create directory for raw files
dir.create(file.path("raw"), showWarnings = FALSE)

### Chapter 04
dir.create(file.path("ch04"), showWarnings = FALSE)

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
download.file("http://www.axel-dreher.de/UNSCdata.xls", file.path("raw", "dreher-unsc-membership", "unsc-membership.xls"))
file.copy(file.path("raw", "dreher-unsc-membership", "unsc-membership.xls"), file.path("ch04", "unsc-membership.xls"))

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
download.file("https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/26589/LLYTFB", file.path("raw", "barbera-twitter", "leaders-twitter.RData"))
file.copy(file.path("raw", "barbera-twitter", "leaders-twitter.RData"), file.path("ch04", "leaders-twitter.RData"))


### Chapter 05
dir.create(file.path("ch05"), showWarnings = FALSE)

# G-Econ dataset
dir.create(file.path("raw", "g-econ"), showWarnings = FALSE)
download.file("https://gecon.yale.edu/sites/default/files/files/Gecon40_post_final.xls", file.path("raw", "g-econ", "g-econ-v4.xls"))
file.copy(file.path("raw", "g-econ", "g-econ-v4.xls"), file.path("ch05", "g-econ-v4.xls"))


### Chapter 06
dir.create(file.path("ch06"), showWarnings = FALSE)

# US inquality estimates from the World Inequality Database (https://wid.world/data/)
dir.create(file.path("raw", "wid"), showWarnings = FALSE)
tmp <- tempdir()
download.file("https://wid.world/bulk_download/wid_all_data.zip", file.path(tmp, "wid.zip"))
unzip(file.path(tmp, "wid.zip"), exdir=tmp)
file.copy(file.path(tmp, "WID_data_US.csv"), file.path("raw", "wid", "us-inequality.csv"))
inequality <- read_delim(file.path("raw", "wid", "us-inequality.csv"), delim=";") %>% filter(variable == "sptincj992" & percentile == "p90p100")
write_delim(inequality, file.path("ch06", "us-inequality.csv"), delim = "," )


# US GDP estimates from the Federal Reserve Bank of St. Louis (https://fred.stlouisfed.org/series/A939RX0Q048SBEA)
dir.create(file.path("raw", "gdp-us"), showWarnings = FALSE)
download.file("https://fred.stlouisfed.org/graph/fredgraph.csv?id=A939RX0Q048SBEA&scale=left&cosd=1947-01-01&coed=2019-10-01&line_color=%234572a7&link_values=false&line_style=solid&mark_type=none&mw=3&lw=2&ost=-99999&oet=99999&mma=0&fml=a&fq=Quarterly&fam=avg&fgst=lin&fgsnd=2009-06-01&line_index=1&transformation=lin&vintage_date=2020-03-26&revision_date=2020-03-26&nd=1947-01-01", file.path("raw", "gdp-us", "us-gdp-pc.csv"))
file.copy(file.path("raw", "gdp-us", "us-gdp-pc.csv"), file.path("ch06", "us-gdp-pc.csv"))


## Chapter 23-tidyverse ----
file.copy(file.path("raw_data", "wid", "WID_p90p100.csv"),
          file.path("data", "ch08", "WID_p90p100.csv"))

file.copy(file.path("raw_data", "polity", "p4v2017.xls"),
          file.path("data", "ch08", "p4v2017.xls"))

file.copy(file.path("raw_data", "wid", "WID_p90p100_wide.csv"),
          file.path("data", "ch08", "WID_p90p100_wide.csv"))

## Chapter 30-rdbintro ----

### Read election result data and remove EP elections
read_csv(file.path("raw_data", "parlgov", "view_election.csv")) %>%
  filter(election_type == "parliament") %>% # European Parliament elections are "ep"
  select(election_id, country_name, election_date, party_id, vote_share, seats, seats_total) %>%
  semi_join(eu_countries, by = c("country_name" = "name")) %>%
  write_csv(file.path("data", "ch09", "parlgov_election.csv"), na = "")

## Chapter 31-rdbadvanced ----
### Read party data and select correct countries and columns
read_csv(file.path("raw_data", "parlgov", "view_party.csv")) %>%
  semi_join(eu_countries, by = c("country_name" = "name")) %>%
  select(party_id, party_name_short, party_name_english, country_name, family_name) %>%
  write_csv(file.path("data", "ch10", "parlgov_party.csv"))

source(file.path("raw_data","populist","recode_populist_to_parlgov.R"))

populist %>%
  rename(country = Country,
         party = Party,
         populist = Populist,
         far_right = `Far right`,
         far_left = `Far left`,
         eurosceptic = Eurosceptic) %>%
  filter(!is.na(party)) %>%
  write_csv(file.path("data", "ch10", "populist_parl-gov-compatible.csv"))

## Chapter 11 - Spatial Data ----
bm = st_read(file.path("raw_data", "bosnia_municipalities", "bosnia_1991.shp")) %>%
  select(Id, name)
st_write(bm, file.path("data", "ch11", "bosnia_1991.shp"))

### GED Data
read_delim(file.path("raw_data", "ucdp", "ged181.csv"), delim = ",") %>%
  filter(conflict_new_id %in% c(389,397, 451, 528, 4523, 4871)) %>%
  filter(where_prec==1) %>%
  select(id, date_start, latitude, longitude, best) %>%
  write_csv(file.path("data", "ch11", "ged181.csv"), na="NA")

## Chapter 12-textasdata ----
# fetch bbc-fulltext, unpack and copy to ch12 directory

## Chapter 13-networkdata ----

# COW Trade data
unlink(file.path("data", "ch13"), recursive = T)
dir.create(file.path("data", "ch13"))
download.file("https://correlatesofwar.org/data-sets/bilateral-trade/cow_trade_4.0/at_download/file", file.path("data", "ch13", "cow_trade_v4.zip"))
unzip(file.path("data", "ch13", "cow_trade_v4.zip"), exdir=file.path("data", "ch13"))
unlink(file.path("data", "ch13", "cow_trade_v4.zip"))
read_delim(file.path("data", "ch13", "COW_Trade_4.0", "Dyadic_COW_4.0.csv"), delim = ",") %>%
  filter(year >= 1870 & year <= 2014) %>%
  select(ccode1, ccode2, year, smoothflow1, smoothflow2, smoothtotrade) %>%
  write_csv(file.path("data", "ch13", "trade.csv"), na="NA")
unlink(file.path("data", "ch13", "COW_Trade_4.0"), recursive = T)
unlink(file.path("data", "ch13", "__MACOSX"), recursive=T)

# V-Dem data
download.file("http://v-dem.pol.gu.se/v9/Country_Year_V-Dem_Full+others_R_v9.zip", file.path("data", "ch13", "vdem-complete.zip"))
unzip(file.path("data", "ch13", "vdem-complete.zip"), exdir=file.path("data", "ch13"))
vdem <- readRDS(file.path("data", "ch13", "Country_Year_V-Dem_Full+others_R_v9", "V-Dem-CY-Full+Others-v9.rds"))
vdem %>%
  filter(year >= 1870 & year <= 2014) %>%
  select(country_name, year, COWcode, v2x_polyarchy, e_regiongeo, e_migdppc) %>%
  write_csv(file.path("data", "ch13", "vdem.csv"), na="NA")
unlink(file.path("data", "ch13", "Country_Year_V-Dem_Full+others_R_v9"), recursive=T)
unlink(file.path("data", "ch13", "vdem-complete.zip"))
unlink(file.path("data", "ch13", "__MACOSX"), recursive=T)

