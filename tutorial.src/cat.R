## ----eval=FALSE, tidy=FALSE---------------------------------------------------
## Data[,c("item1",
##         "item2",
##         "item3",
##         "item4")] <-
##     lapply(Data[,c("item1",
##                    "item2",
##                    "item3",
##                    "item4")], ordered)


## ----eval=FALSE, tidy=FALSE---------------------------------------------------
## fit <- cfa(myModel, data = myData,
##            ordered = c("item1","item2",
##                        "item3","item4"))

