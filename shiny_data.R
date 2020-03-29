# Copyright 2020 Noushin Nabavi
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.

# declare-source ----------------------------------------------------------

if (!exists("setup_sourced")) source(here::here("setup.R"))

# -------------------------------------------------------------------------

# Create new data for shiny 
cols <- c("product_id", "product_name", "quantity_on_hand", "supply_time", "demand_time")


# here we sunthesiste a data set using default methods of syn()
vars <- c("weight", "height", "englang", "sport", "nofriend")
syn <- SD2011[, vars]

# rename column names
syn <- syn %>%
  rename(supply = weight, demand = height, 
         status = englang, delivered = sport, 
         quantity_on_hand = nofriend) 

# add a new column for product-ids 
syn$product_id <- paste0("s", sample(100000000:200000000, 5000, replace=TRUE))
syn <- syn[,c(6, 2:5)]

# add product names/labels
prods <- c("respirators", "ventilators", "masks", "ppe", "biologics", 
           "sanitizers", "diagnostics", "oxygen_tanks", "visors", "vaccines")
syn$product_name <- rep(prods, 500)


# add geo column to the data 
geo <- c("3", "6", "7", "8", "9", "10", "11", "12", "21", 
         "31", "41", "51", "61", "42", "63", "11", "2", "36",
         "41", "25")

# repeat to the length of columns in data
syn$geo <- rep(geo, 250)
syn <- syn %>%
  na.omit()

# build time
dates <- sample(seq(as.POSIXct('2020-01-01'), as.POSIXct('2021-01-01'), by = "sec"), 4909)

# Create an xts object called data_xts
data_xts <- xts(syn, order.by = dates) 
data_xts <- as.data.table(data_xts, keep.rownames = TRUE)

# -------------------------------------------------------------------------

# write out the data table
write_csv(data_xts, here::here("codevscovid_supply_demand", "synthetic_data.csv"))



          
