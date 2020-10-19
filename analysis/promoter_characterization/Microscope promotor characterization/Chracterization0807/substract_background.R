#function to substract the background
substract_background <- function(dataframe) {
  meanlist <- c() #generate an empty list 
  for (i in (1:length((dataframe)-2))) {
    mean <- dataframe[1,i+1] - dataframe[1,1] 
    meanlist <- c(meanlist, mean)  #add value to a list
  }
  meanlist <- as.data.frame(meanlist)
  return(meanlist)
   #mean_df <- data.frame(matrix(unlist(meanlist), nrow = length(meanlist), byrow = T))
}
