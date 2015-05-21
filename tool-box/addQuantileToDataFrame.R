addQuantileToDataFrame <- function(dataframe, quantileName, 
                                   columnToBreakOn, numberOfQuantiles=4){
  
  seqStep <- 1 / numberOfQuantiles 
  
  dataframe[[quantileName]] <- cut(dataframe[[columnToBreakOn]], 
    breaks=quantile(dataframe[[columnToBreakOn]], 
      seq(0,1,seqStep)))
  
  dataframe
}