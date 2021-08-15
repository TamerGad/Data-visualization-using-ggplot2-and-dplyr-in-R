
###########################################################
###########################################################

## Data Visualization using ggplot2 and dplyr in R

###########################################################

###########################################################
## Task One: Import packages & dataset 
## In this task, we will load the required package and dataset
## into the R workspace. Also, we will explore the dataset
###########################################################

## 1.1: Load the required packages
install.packages("ggplot2")
library(gapminder)
library(dplyr)
library(ggplot2)

## 1.2: Look at the gapminder dataset
gapminder

## 1.3: Create a subset of gapminder data set.
## Create gapminder_1957
gapminder_1957 <- gapminder %>%
  filter(year == 1957)
gapminder_1957

###########################################################
## Task Two: Scatterplots
## In this task, we will use dplyr to manipulate
## the data set and plot a scatterplot using ggplot2
###########################################################

## 2.1: Plot a scatterplot pop on the x-axis and lifeExp on the y-axis
ggplot(gapminder_1957,aes(x = pop, y = lifeExp)) +
  geom_point()

## 2.2: Change to put pop on the x-axis and gdpPercap on the y-axis
ggplot(gapminder_1957,aes(x = pop, y = gdpPercap)) + 
  geom_point()

## 2.3 (Ex.): Create a scatter plot with gdpPercap on the x-axis 
## and lifeExp on the y-axis
ggplot(gapminder_1957, aes(x = gdpPercap, y = lifeExp)) +
  geom_point()


## Adding log Scales

## 2.4: Change this plot to put the x-axis on a log scale
ggplot(gapminder_1957,aes(x = pop, y = lifeExp)) +
  geom_point() +
  scale_x_log10()


## 2.5 (Ex.): Scatter plot comparing pop and gdpPercap,
## with both axes on a log scale
ggplot(gapminder_1957,aes(x = pop, y = gdpPercap)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10()


###########################################################
## Task Three: Additional Aesthetics: Color & Size Aesthetics
## In this task, we will add additional aesthetics like 
## color and size to the scatterplot
###########################################################

## 3.1: Scatter plot comparing pop and lifeExp, 
## with color representing continent
ggplot(gapminder_1957,aes(x = pop, y = lifeExp, color = continent)) +
  geom_point() +
  scale_x_log10()

## Size Aesthetics
## 3.2: Add the size aesthetic to represent a country's gdpPercap
ggplot(gapminder_1957,aes(x = pop, y = lifeExp, 
                          color = continent, size = gdpPercap)) +
  geom_point() +
  scale_x_log10()

###########################################################
## Task Four: Facetting
## In this task, we will add facet to plot multiple plots 
## on one page
###########################################################

## 4.1: Scatter plot comparing pop and lifeExp, faceted by continent
ggplot(gapminder_1957, aes(x = pop, y = lifeExp)) +
  geom_point() + 
  scale_x_log10() +
  facet_wrap(~continent)


## 4.2: Scatter plot comparing gdpPercap and lifeExp, with color 
## representing continent and size representing population, faceted by year
ggplot(gapminder, aes(x = gdpPercap , y = lifeExp, 
                           color = continent, size = pop)) +
  geom_point() + 
  scale_x_log10() +
  facet_wrap(~year)


###########################################################
## Task Five: Visualizing summarized data: Scatterplots
## In this task, we will use the summarise verb to get summaries
## of the data set and visualize it using ggplot2
###########################################################

## 5.1: Create a variable by_year that gets the median life expectancy
## for each year
by_year <- gapminder %>%
  group_by(year) %>%
  summarise(medianlifeExp = median(lifeExp))


## 5.2: Create a scatter plot showing the change in medianLifeExp over time
ggplot(by_year, aes(x = year, y = medianlifeExp)) + 
  geom_point() + 
  expand_limits(y = 0)



## 5.3: Summarize medianGdpPercap within each continent within each year: 
## by_year_continent

by_year_continent <- gapminder %>%
  group_by(year, continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

## 5.4: Plot the change in medianGdpPercap in each continent over time
ggplot(by_year_continent, aes(x = year, y = medianGdpPercap,
                              color = continent)) + 
  geom_point() + 
  expand_limits(y = 0)

## 5.5: Summarize the median GDP and median life expectancy
## per continent in 2007
by_continent_2007 <- gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarize(medianLifeExp = median(lifeExp),
            medianGdpPercap = median(gdpPercap))

## 5.6: Use a scatter plot to compare the median GDP 
## and median life expectancy
ggplot(by_continent_2007, aes(x = medianGdpPercap , y = medianLifeExp,
                              color = continent)) +
  geom_point() +
  expand_limits(y=0)
  


###########################################################
## Task Six: Visualizing summarized data: Line plots
## In this task, we will visualise summarized data to get
## trends using the line plots
###########################################################

## 6.1: Summarize the median gdpPercap by year,
## then save it as by_year
by_year <- gapminder %>%
  group_by(year) %>%
  summarize(medianGdpPercap = median(gdpPercap))

## 6.2: Create a line plot showing the change in medianGdpPercap over time
ggplot(by_year, aes(x = year, y = medianGdpPercap )) +
  geom_line() + 
  expand_limits(y = 0)


## 6.3: Summarize the median gdpPercap by year & continent,
## save as by_year_continent
by_year_continent <- gapminder %>%
  group_by(year, continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

## 6.4: Create a line plot showing the change in 
## medianGdpPercap by continent over time

ggplot(by_year_continent, aes(x = year, y = medianGdpPercap,
                              color = continent)) +
  geom_line() + 
  expand_limits(y = 0)

###########################################################
## Task Seven: Visualizing summarized data: Bar Plots
## In this task, we will visualise summarized data
## using bar plots
###########################################################

## 7.1: Summarize the median gdpPercap by continent in 1957
by_continent <- gapminder %>%
  filter(year == 1957) %>%
  group_by(continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

## 7.2: Create a bar plot showing medianGdp by continent
ggplot(by_continent, aes(x = continent, y = medianGdpPercap )) +
  geom_col()

## 7.3: Visualizing GDP per capita by country in Oceania
## Filter for observations in the Oceania continent in 1957
oceania_1957 <- gapminder %>%
  filter(continent == "Oceania", year == 1957)

## 7.4: Create a bar plot of gdpPercap by country
ggplot(oceania_1957, aes(x = country, y = gdpPercap )) +
  geom_col()


###########################################################
## Task Eight: Visualizing summarized data: Histograms
## In this task, we will visualise summarized data
## using histograms
###########################################################

## 8.1: Filter the dataset for the year 1957. Create a new column called
## pop_by_mil. Save this in a new variable called gapminder_1957
gapminder_1957 <- gapminder %>%
  filter(year == 1957) %>%
  mutate(pop_my_mil = pop/1000000)

## 8.2: Create a histogram of population (pop_by_mil)
ggplot(gapminder_1957, aes(x = pop_my_mil)) + 
  geom_histogram(bins = 50)

## 8.3: Recreate the gapminder_1957 and filter for the year 1957 only

gapminder_1957 <- gapminder %>%
  filter(year == 1957)

## 8.4: Create a histogram of population (pop), with x on a log scale
ggplot(gapminder_1957, aes(x = pop)) + 
  geom_histogram() +
  scale_x_log10()


###########################################################
## Task Nine: Visualizing summarized data: Boxplots
## In this task, we will visualise summarized data
## using boxplots
###########################################################

## 9.1: Create the gapminder_1957 and filter for the year 1957 only
gapminder_1957 <- gapminder %>%
  filter(year == 1957)

## 9.2: Create a boxplot comparing gdpPercap among continents
ggplot(gapminder_1957, aes(x = continent, y = gdpPercap)) + 
  geom_boxplot() + 
  scale_y_log10()


## 9.3: Add a title to this graph: 
## "Comparing GDP per capita across continents"
ggplot(gapminder_1957, aes(x = continent, y = gdpPercap)) + 
  geom_boxplot() + 
  scale_y_log10() +
  ggtitle("Comparing GDP Per Capita across Continents")


