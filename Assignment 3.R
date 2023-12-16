library(readr)
#Part 1
wish_items <- read_csv('https://myxavier-my.sharepoint.com/:x:/g/personal/delffso_xavier_edu/EY7nT0JhnOFAsLS9nBs8gxkBm58cgbu0bkKJDd3RCmyMmQ?download=1')
#Question One: Are more items sold if the price is lower?

#This dataset contains the amount of units sold of a particular item as well 
#as the price they are sold for. I will use those variables to make graph that 
#shows the average number of units of an item sold based on price.

wish_items %>% ggplot(aes(x = price, y = units_sold)) + 
  geom_bar(stat = "summary",fun = mean) + xlim(0,15) + ylim(0,20000) +
   labs(title = "Average # of Items Sold by Price",
         x = "Price",
         y = "Average # of Items Sold")
#The bars on the left are higher than the bars on the right for the most part
#which would be evidence to support the claim that more units of an item sell
#when they are priced lower. 

#Question Two: Do items that are shipped to more countries have a higher rating
# than those that are shipped to less?

#This question interests me because if an item is shipped to more countries, it
#is probably somewhat popular and ratings are often based on the quality of the
#item, so we could infer that higher-rated items are higher-quality. To 
#investigate this, I will plot the average rating of an item by the number of 
#countries the item is shipped to. 

wish_items %>% ggplot(aes(x = countries_shipped_to, y = rating)) + 
  geom_bar(stat = "summary",fun = mean) +
  labs(title = "Average Rating by Number of Countries Shipped to",
       x = "Number of Countries Shipped to ",
       y = "Average Rating") 
#From this graph it is clear that most items weren't shipped to over 75 
#countries, and it is also clear that there is no significant difference in
#rating among the number of countries shipped to, so the answer to my question 
#is no.

#Question Three: What is the most common rating on an item?

#On wish.com, you can rate something 1-5 stars. The data set contains the number 
#of each star rating per item, so I will graph these values to see a 
#distribution of each rating.

#Create a vector that records the total count of each rating level
rateVector <- c(sum(wish_items$rating_one_count, na.rm = TRUE), 
                sum(wish_items$rating_two_count, na.rm = TRUE),
                sum(wish_items$rating_three_count, na.rm = TRUE),
                sum(wish_items$rating_four_count,na.rm = TRUE),
                sum(wish_items$rating_five_count, na.rm = TRUE))
#Create a vector that records a label for each rating
rateLabel <- as.factor(c("One Star", "Two Star", "Three Star", 
                         "Four Star", "Five Star"))
#Create a data frame with both new vectors
rateFrame <- data.frame(rateLabel, rateVector)

#Put the ratings in order
rateLevels <- factor(c("One Star", "Two Star", "Three Star", 
                "Four Star", "Five Star"))
#Set the levels of each rating in correct order
levels(rateFrame$rateLabel) <- rateLevels

rateFrame %>%  ggplot(aes(x = rateLabel, y = rateVector)) + geom_bar(stat = 
                                                     "summary")
#The bar for one star has the highest count which means it is the most common
#rate given to an item. This makes sense because wish.com sells very cheap items
#that are not usually the best quality.

# Part 2
netflix <- read_csv("https://myxavier-my.sharepoint.com/:x:/g/personal/ramseys3_xavier_edu/ETz6TxS5rIJGikMyO0SyANYB8MorD04qKYCLTp3ZyxOztA?download=1")

#Question One: Has the average runtime of movies changed over time?

#The dataset contains information on both shows and movies on Netflix, so I will
#filter for movies, plot the average runtime (length of movie) by year and look
#for trends.

netflix %>% filter(type == "MOVIE") %>% ggplot(aes(x = release_year,
                                                   y = runtime)) + 
geom_point(stat = "summary", fun = mean) +
  labs(title = "Average Runtime by Release Year",
       x = "Release Year",
       y = "Average Runtime")

# As time goes on, the average runtime for the most part decreases. This could
# be used as evidence to support the claim that newer movies are shorter than
# older movies.

#Question Two: Is there much of a difference between IMBD ratings 
#and TMDB ratings? 

#IMDB and TMDB are both community run websites that rate movies and tv shows,
#however, IMDb is more commonly used. To see how similar the ratings are, for
#each movie or show I will find the difference between each rating and then plot
#the differences in a histogram

ratingDiff <- netflix$imdb_score - netflix$tmdb_score
ggplot() + geom_histogram(aes(x = ratingDiff)) +
  labs(title = "Difference in IMDb Rating and TMDb rating",
       x = "Difference",
       y = "Count")

#The tallest bar in the histogram is right around zero, and most other high bars
#are close to zero, so this would support the hypothesis that there isn't a 
#strong difference between IMDB ratings and TMDB ratings.

#Question 3: Are shows and media most popular when marketed toward younger 
#audiences or older audiences? 

#To answer this question I will use the tmdb popularity ratings and the age 
#ratings of the movies and shows in the dataset

#Find the unique age ratings in the column age_certification
unique(netflix$age_certification)
#Create a vector of age ratings in order
ageLevels <- factor(c("TV-Y", "TV-Y7", "TV-G", "G", "PG", "TV-PG","PG-13",
                      "TV-14","R",
              "NC-17","TV-MA"))
#Create a new column to record the age certification as a factor
netflixFactor <- 
  netflix %>% filter(!is.na(age_certification)) %>% mutate(age_rating = 
                              factor(age_certification)) 
#Set the levels of each rating in the right order
levels(netflixFactor$age_rating) <- ageLevels

#Plot tmdb popularity rating by age rating
netflixFactor %>% filter(!is.na(release_year)) %>% 
  ggplot(aes(x = age_rating, y = tmdb_popularity)) +
  geom_bar(stat = "summary", fun = mean) +
  labs(title = "Average TMDb Popularity Rating by Age Rating",
       x = "Age Rating",
       y = "Average TMDb Popularity Score")
  
#From looking at the graph, most of the higher bars are to the left of TV-PG,
#meaning that the most popular shows and movies are marketed toward all ages,
#with or without parental guidance. This would be evidence to support the claim
#that movies and shows for younger audiences are more popular than those for
#older audiences, which makes sense because they are accessible to a wider 
#variety of viewers.
