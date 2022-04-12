# This script installs the necessary packages for the exercises in 
# Weidmann, Nils B. "Data Management for Social Scientists"
# It is provided for replication purposes. If you use the renv
# project environment as described in the instructions, you 
# do NOT need to run this code.

install.packages("DBI", type="binary", dependencies = T)
install.packages("RPostgres", type="binary", dependencies = T)
install.packages("doBy", type="binary", dependencies = T)
install.packages("readr", type="binary", dependencies = T)
install.packages("readxl", type="binary", dependencies = T)
install.packages("haven", type="binary", dependencies = T)
install.packages("labelled", type="binary", dependencies = T)
install.packages("tidyverse", type="binary", dependencies = T)
install.packages("countrycode", type="binary", dependencies = T)
install.packages("sf", type="binary", dependencies = T)
install.packages("readtext", type="binary", dependencies = T)
install.packages("quanteda", type="binary", dependencies = T)
install.packages("igraph", type="binary", dependencies = T)


library("DBI")
library("RPostgres")
library("doBy")
library("readr")
library("readxl")
library("haven")
library("labelled")
library("tidyverse")
library("countrycode")
library("sf")
library("readtext")
library("quanteda")
library("igraph")



