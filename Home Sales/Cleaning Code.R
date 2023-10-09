install.packages("readxl")
library(readxl)
library(tidyverse)
library(readr)
Cleaning<- read_excel("C:/Users/kolan/Downloads/Homes for Sale and Real Estate (1).xlsx")
View(Cleaning)
glimpse(Cleaning)
dim(Cleaning)
#converting char columns into integer 
Cleaning <- Cleaning %>% mutate(Beds=as.integer(Beds))
Cleaning <- Cleaning %>% mutate(Bath=as.integer(Bath),
                                Sq.Ft=as.integer(Sq.Ft))
#filtering data
dim(filtered_data)
glimpse(filtered_data)
filtered_data <- filtered_data %>% filter(!is.na(Bath))
filtered_data <- filtered_data %>% filter(!is.na(Address))
filtered_data <- filtered_data %>% filter(!is.na(Price))
filtered_data <- filtered_data %>% filter(!is.na(Description))
filtered_data <- filtered_data %>% filter(!is.na(Place))
filtered_data <- filtered_data %>% filter(!is.na(Beds))
filtered_data <- filtered_data %>% filter(!is.na(Bath))
filtered_data <- filtered_data %>% filter(!is.na(Sq.Ft))
filtered_data <- filtered_data %>% filter(!is.na(Website))

#to make things easy converting column names into lower case
new_columns <- tolower(colnames(filtered_data))
colnames(filtered_data)<- new_columns

#removing duplicate values
filtered_data <- distinct(filtered_data)
dim(filtered_data)
view(filtered_data)

#renaming price column name to $price
filtered_data <- filtered_data %>% rename('$price'=price)

#saving 
install.packages("writexl")  
library(writexl)
file_path <- file.path("C:", "Users", "kolan", "Downloads", "Home Sales.xlsx")
write_xlsx(filtered_data, path = file_path)