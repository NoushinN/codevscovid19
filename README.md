# CodevsCovid19 Zürich Hackathon (March 28-30, 2020)
### Simulation of hospital supply and demand for COVID19 

This project was developed as part of a hackathon for COVID19. 

#### Usage
The repo consists of three main R scripts: **(1) setup**,  **(2) simulation data**, and **(3) shiny data**. The libraries needed to run the simulation are housed in `setup.R` script.   
The `simulation.R` script, in turn, synthesizes a hypothetical supply and demand dataset for essential items needed during COVID19 pandemic. This was developed in phase I of the project and after further discussions, we decided to make a dashboard based on real product needs. The `shiny_data.R` script houses a simulation data for shiny app development. The shiny app code is housed in the `codevscovid_supply_demand` folder consisting of `server` and `ui` R scripts. 

#### Minimum viable product(s)

The [app](https://nnabavi.shinyapps.io/codevscovid19_supply_demand/) is a simulation of an inventory management system to forecast future (next month's) unit demands and to calculate safety stocks and reorder points.  

Our team's final software product, connecting solidarity `co-sol` can be found [here](https://devpost.com/software/co-sol).

#### Future work
Additional improvements to this project can be made by adding regions and geographies to the simulated data and additional machine learning algorithms (e.g. TF) to determine priority of incoming demands and score them to make recommendations. 

#### Contributing to this project
Please make a pull request or file an issue in this repo for suggestions and/or advice.

#### Acknowledgements
Thank you to the talented and inspiring team members who participated in the CodevsCovid19 Zürich Hackathon (Supply and Demand Team). Special thanks to Michael Lew for stimulating discussions.  
