#===============================================================================
# final.R   (NLSY79 - weekly)
#-------------------------------------------------------------------------------
# Project : PSID_SHELF
# Author  : Mohsen Khalili
# Purpose : Attach the correct NLSY79 yearly sampling weight (SAMPWEIGHT_<year>)
#           to every weekly observation, based on that observation's calendar
#           year, so the weekly E/U/I transition rates can be population-weighted.
# Input   : weekly_long_format_with_time_and_weights.dta
# Output  : the same panel with a single `weight` column added.
#===============================================================================

# Install and load the required libraries

library(dplyr)
library(haven)

library(lubridate)

# Read the Stata data file
weekly_long_format_with_time_and_weights <- read_dta("D:/PSID_SHELF/02_NLSY79/code/weekly/weekly_long_format_with_time_and_weights.dta")

# Create a new column "weight" based on the year and CASEID_1979
weekly_long_format_with_time_and_weights <- weekly_long_format_with_time_and_weights %>%
  group_by(CASEID_1979) %>%
  mutate(weight = case_when(
    year(as.Date(Time, format = "%d%b%Y")) == 1977 ~ SAMPWEIGHT_1979,
    year(as.Date(Time, format = "%d%b%Y")) == 1978 ~ SAMPWEIGHT_1979,
    year(as.Date(Time, format = "%d%b%Y")) == 1979 ~ SAMPWEIGHT_1979,
    year(as.Date(Time, format = "%d%b%Y")) == 1980 ~ SAMPWEIGHT_1980,
    year(as.Date(Time, format = "%d%b%Y")) == 1981 ~ SAMPWEIGHT_1981,
    year(as.Date(Time, format = "%d%b%Y")) == 1982 ~ SAMPWEIGHT_1982,
    year(as.Date(Time, format = "%d%b%Y")) == 1983 ~ SAMPWEIGHT_1983,
    year(as.Date(Time, format = "%d%b%Y")) == 1984 ~ SAMPWEIGHT_1984,
    year(as.Date(Time, format = "%d%b%Y")) == 1985 ~ SAMPWEIGHT_1985,
    year(as.Date(Time, format = "%d%b%Y")) == 1986 ~ SAMPWEIGHT_1986,
    year(as.Date(Time, format = "%d%b%Y")) == 1987 ~ SAMPWEIGHT_1987,
    year(as.Date(Time, format = "%d%b%Y")) == 1988 ~ SAMPWEIGHT_1988,
    year(as.Date(Time, format = "%d%b%Y")) == 1989 ~ SAMPWEIGHT_1989,
    year(as.Date(Time, format = "%d%b%Y")) == 1990 ~ SAMPWEIGHT_1990,
    year(as.Date(Time, format = "%d%b%Y")) == 1991 ~ SAMPWEIGHT_1991,
    year(as.Date(Time, format = "%d%b%Y")) == 1992 ~ SAMPWEIGHT_1992,
    year(as.Date(Time, format = "%d%b%Y")) == 1993 ~ SAMPWEIGHT_1993,
    year(as.Date(Time, format = "%d%b%Y")) == 1994 ~ SAMPWEIGHT_1994,
    year(as.Date(Time, format = "%d%b%Y")) == 1995 ~ SAMPWEIGHT_1994,
    year(as.Date(Time, format = "%d%b%Y")) == 1996 ~ SAMPWEIGHT_1996,
    year(as.Date(Time, format = "%d%b%Y")) == 1997 ~ SAMPWEIGHT_1996,
    year(as.Date(Time, format = "%d%b%Y")) == 1998 ~ SAMPWEIGHT_1998,
    year(as.Date(Time, format = "%d%b%Y")) == 1999 ~ SAMPWEIGHT_1998,
    year(as.Date(Time, format = "%d%b%Y")) == 2000 ~ SAMPWEIGHT_2000,
    year(as.Date(Time, format = "%d%b%Y")) == 2001 ~ SAMPWEIGHT_2000,
    year(as.Date(Time, format = "%d%b%Y")) == 2002 ~ SAMPWEIGHT_2002,
    year(as.Date(Time, format = "%d%b%Y")) == 2003 ~ SAMPWEIGHT_2002,
    year(as.Date(Time, format = "%d%b%Y")) == 2004 ~ SAMPWEIGHT_2004,
    year(as.Date(Time, format = "%d%b%Y")) == 2005 ~ SAMPWEIGHT_2004,
    year(as.Date(Time, format = "%d%b%Y")) == 2006 ~ SAMPWEIGHT_2006,
    year(as.Date(Time, format = "%d%b%Y")) == 2007 ~ SAMPWEIGHT_2006,
    year(as.Date(Time, format = "%d%b%Y")) == 2008 ~ SAMPWEIGHT_2008,
    year(as.Date(Time, format = "%d%b%Y")) == 2009 ~ SAMPWEIGHT_2008,
    year(as.Date(Time, format = "%d%b%Y")) == 2010 ~ SAMPWEIGHT_2010,
    year(as.Date(Time, format = "%d%b%Y")) == 2011 ~ SAMPWEIGHT_2010,
    year(as.Date(Time, format = "%d%b%Y")) == 2012 ~ SAMPWEIGHT_2012,
    year(as.Date(Time, format = "%d%b%Y")) == 2013 ~ SAMPWEIGHT_2012,
    year(as.Date(Time, format = "%d%b%Y")) == 2014 ~ SAMPWEIGHT_2014,
    year(as.Date(Time, format = "%d%b%Y")) == 2015 ~ SAMPWEIGHT_2014,
    year(as.Date(Time, format = "%d%b%Y")) == 2016 ~ SAMPWEIGHT_2016,
    year(as.Date(Time, format = "%d%b%Y")) == 2017 ~ SAMPWEIGHT_2016,
    year(as.Date(Time, format = "%d%b%Y")) == 2018 ~ SAMPWEIGHT_2018,
    year(as.Date(Time, format = "%d%b%Y")) == 2019 ~ SAMPWEIGHT_2018,
    year(as.Date(Time, format = "%d%b%Y")) == 2020 ~ SAMPWEIGHT_2020,
    TRUE ~ NA_real_  # Add a default value if none of the conditions are met
  ))


# View the modified data
head(weekly_long_format_with_time_and_weights)
