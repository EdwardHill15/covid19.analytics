# Library
library(covid19.analytics)
library(dplyr)
library(prophet)
library(lubridate)
library(ggplot2)
head(tsc, 1)
# Data
tsc <- covid19.data(case = 'ts-confirmed')
head(tsc, 10)
tsc$Country.Region
View(tsc)
tsc <- tsc %>% filter(Country.Region == 'Netherlands')
tsc <- data.frame(t(tsc))
tsc <- cbind(rownames(tsc), data.frame(tsc, row.names = NULL))
colnames(tsc) <- c('Date', 'Confirmed')
tsc$Date <- ymd(tsc$Date)
tsc$Confirmed <- as.numeric(tsc$Confirmed)
View(tsc)
tsc <- tsc[-c(1:4),]
# Plot
qplot(Date, Confirmed, data = tsc)
ds <- tsc$Date
y <- tsc$Confirmed
df <- data.frame(ds, y)

# Forecasting
m <- prophet(df)
m$history
# Prediction
future <- make_future_dataframe(m, periods = 50)
forecast <- predict(m, future)

# Plot forecast
plot(m, forecast)
prophet_plot_components(m, forecast)
dyplot.prophet(m, forecast)
# Model performance
pred <- forecast$yhat[1:889]
actual <- m$history$y
plot(actual, pred)
abline(lm(pred~actual), col='red')
summary(lm(pred~actual))
