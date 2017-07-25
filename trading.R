install.packages("quantstrat", repos="http://R-Forge.R-project.org")
install('quantmod')
library(quantmod)
library(quantstrat)

# Get SPY from Yahoo Finance ("yahoo")
getSymbols("SPY", from = "2000-01-01", to = "2017-05-30", src =  "yahoo", adjust = TRUE)

# Plot the closing price of SPY
plot(Cl(SPY))


lines(SMA(Cl(SPY), n = 200), col = "red")


# Load the quantstrat-package
library(quantstrat)

# Create initdate, from, and to charater strings
initdate <- "1999-01-01"
from <- "2003-01-01"
to <- "2015-12-31"

# Set the timezone to UTC
Sys.setenv(TZ = "UTC")

# Set the currency to USD 
currency("USD")


# Load the quantmod-package
library(quantmod)

# Retrieve SPY from yahoo
getSymbols("SPY", from = from, to = to, src = "yahoo", adjust = TRUE)

# Use the stock command to initialize SPY and set currency to USD
stock("SPY", currency = "USD")


# Define your trade size and initial equity
tradesize <- 100000
initeq <- 100000

# Define the names of your strategy, portfolio and account
strategy.st <- "firststrat"
portfolio.st <- "firststrat"
account.st <- "firststrat"

# Remove the existing strategy if it exists
rm.strat('firststrat')