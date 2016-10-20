df <- read.csv('Lightning Data.csv',check.names=FALSE)

df$`Loc Ct` <- ifelse((df$`Loc Ct` == "" | df$`Loc Ct` == 0)
                              & (df$`Tariff Cd` == "ELE" | df$`Tariff Cd` == "ULE" |
                                   df$`Tariff Cd` == "ETL" | df$`Tariff Cd` == "UTL" |
                                   df$`Tariff Cd` == "ECL" | df$`Tariff Cd` == "UCL"),
                              1,df$`Loc Ct`)
df[is.na(df)] <- 0

# Only SLE Accounts(ELE,add (ULE)

dfsle <- df[df[, "Tariff Cd"] %in% c("ELE", "ULE"),]
dfsle <- as.data.frame(dfsle)

main <- read.csv("Master Sheet.csv", check.names = FALSE, header = TRUE)
main$type <- as.character(main$type)
mfile <- dfsle

for(i in seq_len(nrow(main)))
{
  mfile[, main$type[i]] <- main$SLE[i] * dfsle[, main$type[i]]
}

# Only SLS account
dfsls <- df[df[, "Tariff Cd"]  %in% c("ELS", "ULS"),] 
dfsls <- as.data.frame(dfsls)

mfile1 <- dfsls

for(i in seq_len(nrow(main)))
{
  mfile1[, main$type[i]] <- main$SLS[i] * dfsls[, main$type[i]]
}

# POL account
dfpol <- df[df[, "Tariff Cd"]  %in% c("EPL", "UPL"),] 
dfpol <- as.data.frame(dfpol)

mfile2 <- dfpol

for(i in seq_len(nrow(main)))
{
  mfile2[, main$type[i]] <- main$POL[i] * dfpol[, main$type[i]]
}

# TL account
dftl <- df[df[, "Tariff Cd"]  %in% c("ETL", "UTL"),] 
dftl <- as.data.frame(dftl)

mfile3 <- dftl

for(i in seq_len(nrow(main)))
{
  mfile3[, main$type[i]] <- main$TLCL[i] * dftl[, main$type[i]] * as.numeric(main$BURN[i])
}


# UAL ELP UCL ECL
dftlcl <- df[df[, "Tariff Cd"]  %in% c("ECL", "UCL"),]
