library(readr)
library(tidyverse)
library(lubridate)
df <- read_csv("C:/Users/kolan/Downloads/US_Regional_Sales_Data.csv")
View(df)
glimpse(df)

#converting column names into lower case
renaming <- tolower(colnames(df))
colnames(df) <- renaming

#this is lengthy but works
df$order_name <- df$ordernumber
df$ordernumber <- NULL

df$sales_channel <- df$`sales channel`
df$`sales channel` <- NULL

df$warehouse_code <- df$warehousecode
df$warehousecode <- NULL

df$procured_date <- df$procureddate
df$procureddate <- NULL

df$order_date <- df$orderdate
df$orderdate <- NULL

df$ship_date <- df$shipdate
df$shipdate <- NULL

df$delivery_date <- df$deliverydate
df$deliverydate <- NULL
#
df$currency_code <- df$currencycode
df$currencycode <- NULL

df$saleteam_id <- df$`_salesteamid`
df$`_salesteamid` <- NULL

df$customer_id <- df$`_customerid`
df$`_customerid` <- NULL

df$store_id <- df$`_storeid`
df$`_storeid` <- NULL

df$product_id <- df$`_productid`
df$`_productid` <- NULL

df$order_quantity <- df$`order quantity`
df$`order quantity` <- NULL

df$discount_applied <- df$`discount applied`
df$`discount applied` <- NULL

df$unit_cost($) <- df$unit_cost($)
df$unit_cost($) <- NULL

df$unit_price($) <- df$unit_price($)
df$unit_price($) <- NULL

colnames(df)[colnames(df) == "unit price($)"] <- "unit_price($)"

df$unit_price <- df$`unit price`
df$`unit price` <- NULL

# converting procured_date, order_date,  ship_date, delivery_date to date and time
glimpse(df) 

df <- df %>% mutate(procured_date = parse_date_time(procured_date, orders = "dmy"),
                    order_date = parse_date_time(order_date, orders = "dmy"),
                    ship_date = parse_date_time(ship_date, orders = "dmy"),
                    delivery_date = parse_date_time(delivery_date, orders = "dmy"))

view(df)

# converting salestteam_id, customer_id, store_id,product_id, order_quality to int

df <- df %>% mutate(saleteam_id=as.integer(saleteam_id),
                    customer_id=as.integer(customer_id),
                    store_id=as.integer(store_id),
                    product_id=as.integer(product_id),
                    order_quantity=as.integer(order_quantity))

#checking for any missing values

missing_data <- is.na(df)
count_missing <- sum(missing_data)
print(count_missing)

#checking for duplicate rows

duplicate_rows <- df[duplicated(df), ]
num_duplicated_rows <- nrow(duplicate_rows)
print(num_duplicated_rows)

#to verify the distinct rows

distinct_rows <- distinct(df)
num_distinct_rows <- nrow(distinct_rows)
print(num_distinct_rows)

dim(df)

library(writexl)
file_path <- file.path("C:/Users/kolan/Desktop/New folder/us_region_sales.xlsx")
write_xlsx(df, path = file_path)
