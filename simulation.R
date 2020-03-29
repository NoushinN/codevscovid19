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

# CREATE A SIMULATION DATA AND RUN FORECASTING MODELS
# Create the dates object as an index for your xts object
dates <- seq(as.Date("2020-01-20"), length = 180, by = "days")

# generate a random matrix to represent supplies and demands
dat <- as.data.frame(matrix(rexp(900, rate=.1), ncol=5)) %>%
  rename(supplier_a = V1, supplier_b = V2, demand_a = V3, demand_b = V4, demand_c = V5)
dat$region_id <- seq(length = 180)

# Create an xts object called data_xts
data_xts <- xts(dat, order.by = dates) 

# -------------------------------------------------------------------------

# SUPPLIES
# Create the individual region suppliers as their own objects
dat_1 <- data_xts[,"supplier_a"]
dat_2 <- data_xts[,"supplier_b"]

# Sum the region suppliers together
supplies <- dat_1 + dat_2 

# Plot the metropolitan region total suppliers
plot(supplies)

# DEMANDS
# Create the individual region demands as their own objects
dat_3 <- data_xts[,"demand_a"]
dat_4 <- data_xts[,"demand_b"]
dat_5 <- data_xts[,"demand_c"]

# Sum the region demands together
demands <- dat_3 + dat_4 + dat_5

# Plot the metropolitan region total demands
plot(demands)

# -------------------------------------------------------------------------

# visualize plots
s_d <- merge(supplies, demands) %>%
  rename(supplier_a = supply, demand_a = demand)

# autoplot
autoplot(s_d, geom = "point")


# Multiple line plot
s_d_dat <- as.data.table(s_d, keep.rownames = TRUE)

ggplot(s_d_dat) + 
  geom_point(aes(x = index, y = supplier_a), size = 1, color = "red") +
  geom_point(aes(x = index, y = demand_a), size = 1, color = "blue") 

ggplot(s_d_dat) + 
  geom_line(aes(x = index, y = supplier_a), size = 0.5, color = "red") +
  geom_line(aes(x = index, y = demand_a), size = 0.5, color = "blue") +
  labs(x = "Time", y = "Counts", 
       title = "supplies and demands",
       subtitle = "supplies in red, demands in blue") 

  
# smoothing method
ggplot(s_d_dat, aes(supplier_a, demand_a)) +
  geom_point() +
  geom_smooth(method = "loess") +
  labs(x = "Supplies", y = "Demands", 
       title = "correlation between supplies and demands",
       subtitle = "Loess smooth model") 


ggplot(s_d_dat, aes(supplier_a, demand_a)) +
  geom_point() +
  labs(x = "Supplies", y = "Demands", 
       title = "Correlation between supplies and demands",
       subtitle = "linear regression model") +
  geom_smooth(method = "lm", formula = y ~ poly(x, 3), se = FALSE)


# -------------------------------------------------------------------------

# ARIMA modeling
# Split the data into training and validation
data_xts_supplies <- supplies[index(supplies) >= "2020-01-20"]
data_xts_demands <- demands[index(demands) >= "2020-01-20"]

# Use auto.arima() function for metropolitan supplier_a
dat_model_demands <- auto.arima(ts(data_xts_demands[,1]))
dat_model_supplies <- auto.arima(ts(data_xts_supplies[,1]))

par(mfrow=c(2,1))
autoplot(dat_model_demands)
autoplot(dat_model_supplies)

ggfortify::ggtsdiag(dat_model_demands) + 
  labs(subtitle = "arima results for demands")

ggfortify::ggtsdiag(dat_model_supplies) + 
  labs(subtitle = "arima results for supplies")

# -------------------------------------------------------------------------

# FORECASTING
# Forecast based on the first 180 days of 2020
forecast_dat_d <- forecast(dat_model_demands, h = 180)
forecast_dat_s <- forecast(dat_model_supplies, h = 180)


# Plot this forecast
autoplot(forecast_dat_d)
plot(forecast_dat_d)
autoplot(forecast_dat_s)
plot(forecast_dat_s)

# Convert to numeric for ease
for_dat_d <- as.numeric(forecast_dat_d$mean)
for_dat_s <- as.numeric(forecast_dat_s$mean)

# Calculate the MAE
MAE <- mean(abs(for_dat_d - for_dat_s))

# Calculate the MAPE
MAPE <- 100*mean(abs((for_dat_d - for_dat_s)/for_dat_s))

# Print to see how good your forecast is!
print(MAE)
print(MAPE)

# -------------------------------------------------------------------------

# Convert the forecast model to an xts objects
for_dates <- seq(as.Date("2020-01-20"), length = 180, by = "days")
forecast_dat_xts_d <- xts(forecast_dat_d$mean, order.by = for_dates)
forecast_dat_xts_s <- xts(forecast_dat_s$mean, order.by = for_dates)

# Plot the demand/supply data set
par(mfrow=c(2,1))
plot(data_xts_demands, main = 'Forecast Comparison - demands', ylim = c(0, 150))
plot(data_xts_supplies, main = 'Forecast Comparison - supplies', ylim = c(0, 150))


# Overlay the forecasts
par(mfrow=c(2,1))
lines(data_xts_demands, col = "red")
lines(data_xts_supplies, col = "blue")


# Convert the limits to xts objects
lower <- xts(forecast_dat_d$lower[,2], order.by = for_dates)
upper <- xts(forecast_dat_s$upper[,2], order.by = for_dates)

# Adding confidence intervals of forecast to plot
par(mfrow=c(2,1))
lines(lower, col = "blue", lty = "dashed")
lines(upper, col = "blue", lty = "dashed")




