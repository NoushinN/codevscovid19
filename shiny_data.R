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
# here we sunthesiste a data set using default methods of syn()
vars <- c("weight", "height", "englang", "sport", "nofriend")
syn <- SD2011[, vars]

# rename column names
syn <- syn %>%
  rename(supply = weight, quantity_on_hand = height, 
         status = englang, delivered = sport, 
         supply_score = nofriend) 

# add a new column for product-ids 
syn$units <- paste0(sample(1:5000, replace= FALSE))
syn <- syn[,c(6, 2:5)]

# add product names/labels
prods <- c("respirators", "ventilators", "masks", "ppe", "biologics", 
           "sanitizers", "diagnostics", "oxygen_tanks", "visors", "vaccines")
syn$product_name <- rep(prods, 500)


# add month column to the data 
# repeat to the length of columns in data
syn$month <- paste0(sample(1:10, replace = FALSE))

# remove NA's
syn <- syn %>%
  na.omit() %>%
  mutate(supply_score = abs(supply_score))

# build time
dates <- sample(seq(as.POSIXct('2020-01-01'), as.POSIXct('2020-06-01'), by = "sec"), 4909)

# Create an xts object called data_xts
data_xts <- xts(syn, order.by = dates) 
data_xts <- as.data.table(data_xts, keep.rownames = TRUE)

# write out the data table
write_csv(data_xts, here::here("codevscovid_supply_demand", "synthetic_data.csv"))

# -------------------------------------------------------------------------

# remake the dataframe
data_xts$product_name <- factor(data_xts$product_name) 
data_xts$product_id <- as.numeric(data_xts$product_name)

# select chosen columns
data_xts <- as.data.frame(data_xts) 

data_xts_new <- data_xts %>%
  select(product_id, month, units, product_name, supply_score, quantity_on_hand) 

# write out the data table
write_csv(data_xts_new, here::here("codevscovid_supply_demand", "synthetic_data_new.csv"))

# -------------------------------------------------------------------------
          
