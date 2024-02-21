# Packages
#install.packages(c("shiny", "shinydashboard", "dplyr", "DT", "readxl", "ggplot2", "plotly", "ggtext", "ggcorrplot", "reshape2"))
#library(shiny)
library(shinydashboard)
library(dplyr)
library(DT)
library(readxl)
library(ggplot2)
library(plotly)
library(ggtext)
library(ggcorrplot)
library(reshape2)

#Global 
#setwd("E:/RTSM/Dashboard/New folder")
data = read_excel("data_crime_women.xls")
data = data[-29, ]
data = data[-38, ]
data = data[-37, ]
data <- mutate_all(data, funs(ifelse(. == "NA", NA, .)))

#Converting required columns to numeric
numeric_columns = c("Rape - 2015","Rape - 2016","Assaults (molestation) - 2015","Assaults (molestation) - 2016","Murder (women) - 2015","Murder (women) - 2016",
                    "2014 - Cases registered","2014 - Total rape Cases","2015 - Cases registered","2016 - Cases registered")  
data = data %>%
  mutate_at(vars(numeric_columns), as.numeric)


#structure
data %>% 
  str()

#Summary
data %>% 
  summary()



#Choices for input 
choices1 = data %>% 
  select(-'State/UT') %>% 
  names()


#Assigning statenames
State = data[["State/UT"]]

# Anova Tests

#CR
CR1 = data$`2014 - Cases registered`
CR2 = data$`2015 - Cases registered`
CR3 = data$`2016 - Cases registered`


arrest_data_CR <- data.frame(
  State = State,
  Arrests_2014 = CR1,
  Arrests_2015 = CR2,
  Arrests_2016 = CR3
)

arrest_data_long1 <- melt(arrest_data_CR, id.vars = "State", variable.name = "Year", value.name = "Arrests")

# Fit repeated measures ANOVA
model_CR <- aov(Arrests ~ Year + Error(State / Year), data = arrest_data_long1)


#Assaults
Assault1 = data$`Assaults (molestation) - 2015`
Assault2 = data$`Assaults (molestation) - 2016`



arrest_data_Assault <- data.frame(
  State = State,
  Arrests_2015 = Assault1,
  Arrests_2016 = Assault2
)

arrest_data_long2 <- melt(arrest_data_Assault, id.vars = "State", variable.name = "Year", value.name = "Arrests")

# Fit repeated measures ANOVA
model_Assault <- aov(Arrests ~ Year + Error(State / Year), data = arrest_data_long2)

#Murder
Murder1 = data$`Murder (women) - 2015`
Murder2 = data$`Murder (women) - 2016`



arrest_data_Murder <- data.frame(
  State = State,
  Arrests_2015 = Murder1,
  Arrests_2016 = Murder2
)

arrest_data_long3 <- melt(arrest_data_Murder, id.vars = "State", variable.name = "Year", value.name = "Arrests")

# Fit repeated measures ANOVA
model_Murder <- aov(Arrests ~ Year + Error(State / Year), data = arrest_data_long3)

#rape
Rape2 = data$`Rape - 2015`
Rape3 = data$`Rape - 2016`
Rape1 = data$`2014 - Total rape Cases`



arrest_data_Rape <- data.frame(
  State = State,
  Arrests_2014 = Rape1,
  Arrests_2015 = Rape2,
  Arrests_2016 = Rape3
)

arrest_data_long4 <- melt(arrest_data_Rape, id.vars = "State", variable.name = "Year", value.name = "Arrests")

# Fit repeated measures ANOVA
model_Rape <- aov(Arrests ~ Year + Error(State / Year), data = arrest_data_long4)

# #PAR
# PAR1 = data$`2019 - PAR`
# PAR2 = data$`2020 - PAR`
# PAR3 = data$`2021 - PAR`
# 
# 
# arrest_data_PAR <- data.frame(
#   State = State,
#   Arrests_2019 = PAR1,
#   Arrests_2020 = PAR2,
#   Arrests_2021 = PAR3
# )
# 
# arrest_data_long4 <- melt(arrest_data_PAR, id.vars = "State", variable.name = "Year", value.name = "Arrests")
# 
# # Fit repeated measures ANOVA
# model_PAR <- aov(Arrests ~ Year + Error(State / Year), data = arrest_data_long4)
# 
# #PCS
# PCS1 = data$`2019 - PCS`
# PCS2 = data$`2020 - PCS`
# PCS3 = data$`2021 - PCS`
# 
# 
# arrest_data_PCS <- data.frame(
#   State = State,
#   Arrests_2019 = PCS1,
#   Arrests_2020 = PCS2,
#   Arrests_2021 = PCS3
# )
# 
# arrest_data_long5 <- melt(arrest_data_PCS, id.vars = "State", variable.name = "Year", value.name = "Arrests")
# 
# # Fit repeated measures ANOVA
# model_PCS <- aov(Arrests ~ Year + Error(State / Year), data = arrest_data_long5)
# 
# #PCV
# PCV1 = data$`2019 - PCV`
# PCV2 = data$`2020 - PCV`
# PCV3 = data$`2021 - PCV`
# 
# 
# arrest_data_PCV <- data.frame(
#   State = State,
#   Arrests_2019 = PCV1,
#   Arrests_2020 = PCV2,
#   Arrests_2021 = PCV3
# )
# 
# arrest_data_long6 <- melt(arrest_data_PCV, id.vars = "State", variable.name = "Year", value.name = "Arrests")
# 
# # Fit repeated measures ANOVA
# model_PCV <- aov(Arrests ~ Year + Error(State / Year), data = arrest_data_long6)
