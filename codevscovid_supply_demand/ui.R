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

shinyUI(fluidPage(
    
    headerPanel(span("Inventory Management System", style = "color:blue")),br(),
    
    
    selectInput(inputId = "product_id", label = h4("Select Product:"),
                c("Washington Berry Juice" = 1,
                  "Washington Mango Drink" = 2,
                  "Washington Strawberry Drink" = 3,
                  "Washington Cream Soda" = 4,
                  "Washington Diet Soda" = 5,
                  "Washington Cola" = 6,
                  "Washington Diet Cola"= 7,
                  "Washington Orange Juice" = 8,
                  "Washington Cranberry Juice" = 9)), br(),
    
    
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
