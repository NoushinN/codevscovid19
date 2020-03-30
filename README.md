# codevscovid19
Simulating hospital supply and demand for COVID19 

This project consists of two R scripts: **(1) setup** and **(2) simulation**    
The libraries needed to run the simulation are housed in `setup.R` script.   
The `simulation.R` script, in turn, synthesizes a hypothetical supply and demand dataset based on time and region. It then makes predictions for supply and demand in time using ARIMA model.

The [shiny app](https://nnabavi.shinyapps.io/codevscovid19_supply_demand/) is developed in the `codevscovid_supply_demand` folder consisting of `server` and `ui` codes. The app is a simulation of an Inventory Management System to forecast next month unit demands and to calculate safety stocks and reorder points.


