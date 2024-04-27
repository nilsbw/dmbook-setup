# This script installs the necessary packages for the exercises in 
# Weidmann, Nils B. "Data Management for Social Scientists"
# It is provided for replication purposes. If you use the renv
# project environment as described in the instructions, you 
# do NOT need to run this code.

install.packages("DBI", type="binary", dependencies = c("Depends", "Imports", "LinkingTo"))
install.packages("RPostgres", type="binary", dependencies = c("Depends", "Imports", "LinkingTo"))
install.packages("doBy", type="binary", dependencies = c("Depends", "Imports", "LinkingTo"))
install.packages("readr", type="binary", dependencies = c("Depends", "Imports", "LinkingTo"))
install.packages("readxl", type="binary", dependencies = c("Depends", "Imports", "LinkingTo"))
install.packages("haven", type="binary", dependencies = c("Depends", "Imports", "LinkingTo"))
install.packages("labelled", type="binary", dependencies = c("Depends", "Imports", "LinkingTo"))
install.packages("tidyverse", type="binary", dependencies = c("Depends", "Imports", "LinkingTo"))
install.packages("countrycode", type="binary", dependencies = c("Depends", "Imports", "LinkingTo"))
install.packages("sf", type="binary", dependencies = c("Depends", "Imports", "LinkingTo"))
install.packages("readtext", type="binary", dependencies = c("Depends", "Imports", "LinkingTo"))
install.packages("quanteda", type="binary", dependencies = c("Depends", "Imports", "LinkingTo"))
install.packages("igraph", type="binary", dependencies = c("Depends", "Imports", "LinkingTo"))
install.packages("stringdist", type="binary", dependencies = c("Depends", "Imports", "LinkingTo")) # Required for exercises Chapter 12

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
library("stringdist")



