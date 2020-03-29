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


# package-dependencies ----------------------------------------------------

# list libraries
packages <- c("data.table", "tidyverse", "ggpubr", "here", "purrr",
              "broom", "lubridate", "readr", "wesanderson", "broom",
              "tidytext", "readxl", "oddsratio", "epiR", "table1",
              "janitor", "xts", "forecast", "scales", "ggfortify")

# install libraries
lapply(packages, library, character.only = TRUE)

# source the setup script
.setup_sourced <- TRUE
