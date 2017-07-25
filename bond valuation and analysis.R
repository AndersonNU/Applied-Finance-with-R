# An interactive session to learn hoW to evaluate bond values using R
# Create present value
pv <- 100

# Create r, which is interest rate
r <- 0.1

# Calculate future value after 1st yr
fv1 <- pv * (1 + r)

# Calculate future value after 2nd yr
fv2 <- pv*(1+r)*(1+r)

# Create vector of cash flows
cf <- c(5,5,5,5,105) 

# Convert to data frame
cf <- data.frame(cf)
cf

# Add column t to cf; t indicates the year in which cash flow is received
cf$t <- as.numeric(rownames(cf))

# Set the yield rate to be 0.06
yr <- 0.06

# Calculate pv_factor;this create a column of discount factors
cf$pv_factor <- 1 / (1 + 0.06)^cf$t

# Calculate pv
cf$pv <- cf$cf * cf$pv_factor

# Calculate the bond price, which is the summation of the present values of future cash flows
sum(cf$pv)


# Here I learn how to evalue the bond value through a function
# Create function
# p: par value; r: coupon rate; ttm: time to maturity; y: yield
bondprc <- function(p, r, ttm, y) {
  # rep returns a vector with value = p * r and times = ttm -1 
  cf <- c(rep(p * r, ttm - 1), p * (1 + r))
  cf <- data.frame(cf)
  cf$t <- as.numeric(rownames(cf))
  cf$pv_factor <- 1 / (1 + y)^cf$t
  cf$pv <- cf$cf * cf$pv_factor
  sum(cf$pv)
}

# Verify prior result
bondprc(100,0.05,5,0.06)

# Install and Load Quandl package
install.packages("Quandl")
library(Quandl)

# Obtain Moody's Baa index data
baa <- Quandl("MOODY/DBAAYLD")

# Identify 7/24/17 yield
baa_yield <- subset(baa, baa$DATE == "2017-07-24")

# Convert yield to decimals and view, since the data is in percentage
baa_yield <-baa_yield$DBAA *0.01
baa_yield

# Value bond with the following parameters
bondprc(p = 100, r =0.05, ttm =5, y = 0.0429)

# Plotting the Price/Yield Relationship
# Generate prc_yld
prc_yld <- seq(0.02, 0.4, 0.01)

# Convert prc_yld to data frame
prc_yld <- data.frame(prc_yld)

# Calculate bond price given different yields
for (i in 1:nrow(prc_yld)) {
  prc_yld$price[i] <- bondprc(100, 0.10, 20, prc_yld$prc_yld[i])  
}

# Plot P/YTM relationship. I can observe from the graph that bond price and yield has an inverse relationship
plot(prc_yld,prc_yld$price,
     type = "l",
     col = "blue",
     main = "Price/YTM Relationship")

# Load quantmod package
library(quantmod)
library(xts)
library(zoo)
# Obtain Treasury yield data
t10yr <- getSymbols(Symbols = "DGS10", src = "FRED", auto.assign = FALSE)
#t10yr
# Subset data
t10yr <- subset(t10yr["2006-01-01/2016-09-30"] )

# Plot yields
plot(x = index(t10yr),
     y = t10yr$DGS10,
     xlab = "Date",
     ylab = "Yield (%)",
     type = "l",
     col = "red",
     main = "10-Year US Treasury Yields")
