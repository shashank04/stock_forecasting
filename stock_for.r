library(quantmod)
library(forecast)
getSymbols(Company)
write.zoo(Company, file="Company.csv", sep=",")
company=read.csv("Company.csv",header = T)/#taking the input
head(company)
company.ts=ts(rev(company[,]),start=c(2014,8),freq=3)#quarterly
company.ts
company=data.frame(closing=company.ts,lclosing=log(company.ts))
save(company,file="company.df.RData")
plot(company$closing,main = "company stock prices",lwd=2,
     sub="august 2014 to april 2016",ylab="closing price")
company.stl=stl(company$close,s.window="periodic")
plot(company.stl,main="stock decomposition")
company.f=forecast(company.stl,method="arima",h=12,level=95)#using arima
plot(company.f,ylab = "stock price",xlab = "year",sub="forecast")
