train <- fread("Data/train.csv", stringsAsFactors= TRUE)
int_to_factor <- which(rapply( train, is.integer) )[-1]
train[ , int_to_factor] <- train[ , lapply(.SD, factor), .SDcols=int_to_factor]
train[ , age_group := as.factor(ifelse(Age < 12, "child", ifelse( Age < 18, "teenager", ifelse (Age < 65, "adult", "senior") ) )) , ]
mean_train <- ddply(train, .(Survived), numcolwise(mean, na.rm= T))
metric_hist <- names(mean_train[-1])
