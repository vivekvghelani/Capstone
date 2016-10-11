library(data.table)

df <- read.csv('Lightning Data.csv')
df[is.na(df)] <- 0
dT <- data.table(df)

#### SLE(Putting 1 instead of 0 in location count)
dfsle <- dT[Tariff.Cd == "ELE"]
dfsle1 <- dfsle[Loc.Ct == "0"]
dfsle1$Loc.Ct[dfsle1$Loc.Ct == 0] <- 1
head(dfsle1)
