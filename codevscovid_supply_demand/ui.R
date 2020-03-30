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

options(shiny.sanitize.errors = TRUE)
# -------------------------------------------------------------------------
library(shiny)

shinyUI(fluidPage(
    
    headerPanel(span("CodevsCovid19: Inventory Management System for COVID-19", style = "color:blue")),br(),
    
    
    selectInput(inputId = "product_id", label = h4("Select Product:"),
                c("biologics" = 1,
                  "diagnostics" = 2,
                  "masks" = 3,
                  "oxygen_tanks" = 4,
                  "ppe" = 5,
                  "respirators" = 6,
                  "diagnostics"= 7,
                  "vaccines" = 8,
                  "ventilators" = 9,
                  "visors" = 10)), br(),
    
    titlePanel(h3(textOutput("product_text"))), br(),
    
    sidebarPanel(
        radioButtons("method", h4( "Forecast Technique: ", style = "color:blue"),
                     c("Naive" = "naive",
                       "Moving Average" = "ma",
                       "Exponential Smoothing" = "es")), 
        br(),
        
        h4("Calculation", style = "color:blue"), br(),
        
        strong(textOutput("lead_time")),br(),
        
        strong(textOutput("safety_stock")),br(),
        
        strong(textOutput("reorder_point")),br(),
        class = 'leftAlign'
    ),
    
    sidebarPanel(
        plotOutput("product_plot"),
        width = 8,
        class = 'leftAlign'
    ),
    
    
    mainPanel(
        tags$style(type="text/css",
                   ".shiny-output-error { visibility: hidden; }",
                   ".shiny-output-error:before { visibility: hidden; }"),
        
        tabsetPanel(type = "tabs", 
                    tabPanel("Forecast",
                             strong("Naive"),verbatimTextOutput("forecast_naive_output"),
                             strong("Moving Average"),verbatimTextOutput("forecast_sma_output"),
                             strong("Exponential Smoothing"),verbatimTextOutput("forecast_es_output")
                    ), 
                    tabPanel("Error rates", 
                             strong("Naive"),verbatimTextOutput("forecast_naive_accuracy"),
                             strong("Moving Average"), verbatimTextOutput("forecast_sma_accuracy"),
                             strong("Exponential Smoothing"), verbatimTextOutput("forecast_es_accuracy")
                    ), 
                    tabPanel("Plots", 
                             plotOutput("naive_plot"),
                             plotOutput("sma_plot"),
                             plotOutput("es_plot"),
                             class = 'rightAlign'), 
                    tabPanel("Data",
                             dataTableOutput("product_dataHead")
                    )
                    
        )
    )
)
)
