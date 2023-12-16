# Load packages

library(tidyverse)
library(rvest)
library(httr)
library(magrittr)

# Set user agent and read in html
set_config(user_agent("<delffso@xavier.edu>; +https://www.xavier.edu/business-analytics-program"))

ulta_url <- 
  "https://www.ulta.com/shop/makeup/lips?sort=best_sellers"

ulta_html <- 
  read_html(ulta_url)

# While trying to collect the brand names for each product featured in the 
# best sellers list, if a product is listed at a discounted price, the original
# price is read the same as the brand name. So to only see the brand names, 
# we must remove this span from the html.
ulta_html %>% 
  html_elements("div.ProductCard") %>% 
  html_elements(
"span.Text-ds.Text-ds--body-2.Text-ds--left.Text-ds--neutral-600.Text-ds--line-through"
) %>% 
xml2::xml_remove()

# Now we take the brand name because it will show how many 
# of Kylie's lip products are Ulta's best sellers.
brand_name <- 
  ulta_html %>% 
  html_elements("div.ProductCard") %>% 
  html_elements(
"span.Text-ds.Text-ds--body-2.Text-ds--left.Text-ds--neutral-600") %>% 
  html_text2()
# Take product rating to see how well rated Kylie's products are compared to 
# those of other brands.
product_rating <- 
  ulta_html %>% 
  html_elements("div.ProductCard") %>%
  html_elements("div.ProductCard__content") %>% 
  html_elements("div.ReviewStarsCard") %>% 
  html_elements("span.sr-only") %>% 
  html_text2()
# Take product name to see which of Kylie's products are best selling
product_name <- 
  ulta_html %>% 
  html_elements("div.ProductCard") %>%
  html_elements("span.ProductCard__product") %>%
  html_elements("span.Text-ds.Text-ds--body-2.Text-ds--left") %>%
  html_text2()
# Put into one data frame and export
ulta_df <- 
  data.frame(brand_name, product_name, product_rating)
write.csv(ulta_df, file = "~/ultaDf.csv", row.names = FALSE)




