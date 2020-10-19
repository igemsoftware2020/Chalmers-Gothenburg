#Script to analyze microscopy samples

#library(dplyr)
library(tidyverse)
#library(ggplot2)
library(reshape2)

#set working directory 
setwd("/Users/leti/Desktop/iGEM/analysis/promoter_characterization/Microscope promotor characterization/Chracterization0807/")
source("pull_mean.R")
source("substract_background.R")

#Process sample A 
mean_list_A = list()
files <- list.files(path="sampleA", pattern="*.csv", full.names=TRUE, recursive=FALSE)
for (i in 1:length(files)){
  t <- read.csv(files[i], header=TRUE,stringsAsFactors=FALSE) # load file
  only_mean <- pull_mean(t) #function pull_mean to only extract the mean from the .csv files
  mean_without_bg <- substract_background(only_mean) #function substract background to substract the background from each mean 
  mean_list_A <- rbind(mean_list_A, mean_without_bg) #append each data point to a list
}
colnames(mean_list_A) <- 'A'

#Process sample B
mean_list_B = list()
files <- list.files(path="sampleB", pattern="*.csv", full.names=TRUE, recursive=FALSE)
for (i in 1:length(files)){
  t <- read.csv(files[i], header=TRUE,stringsAsFactors=FALSE) # load file
  only_mean <- pull_mean(t)
  mean_without_bg <- substract_background(only_mean)
  mean_list_B <- rbind(mean_list_B, mean_without_bg)
}
colnames(mean_list_B) <- 'B'

#Process sample C
mean_list_C = list()
files <- list.files(path="sampleC", pattern="*.csv", full.names=TRUE, recursive=FALSE)
for (i in 1:length(files)){
  t <- read.csv(files[i], header=TRUE,stringsAsFactors=FALSE) # load file
  only_mean <- pull_mean(t)
  mean_without_bg <- substract_background(only_mean)
  mean_list_C <- rbind(mean_list_C, mean_without_bg)
}
colnames(mean_list_C) <- 'C'

##PLOTTING 
mean_list_A_m <- melt(mean_list_A) #transform data for A
mean_list_B_m <- melt(mean_list_B) #transform data for B 
mean_list_C_m <- melt(mean_list_C) #transform data for C

mean_list_promotors <- rbind(mean_list_A_m, mean_list_B_m, mean_list_C_m) #merge promotor data together
colnames(mean_list_promotors) <- c("Promotor", "Fluorescence")
promotor_bp <- ggplot(mean_list_promotors, aes(Promotor, Fluorescence, fill = Promotor)) + #fill colors the plots according to the variable (samples)
  geom_boxplot(notch = TRUE) + #if we do not want the square box
  scale_fill_manual(breaks = c("2", "1", "0.5"), 
                    values=c("red", "darkgreen", "blue")) +
  geom_jitter(shape=16, position=position_jitter(0.2)) #if we want to see the dots
  
print(promotor_bp)



#############################################
# MANUAL PROCESSING
#read the .csv files generated from Fiji and transform data into tables, for a sample (i.e. A3)
measurements_a3_1 <- read.csv(file = 'A3/measurements_a3_1.csv')
measurements_a3_2 <- read.csv(file = 'A3/measurements_a3_2.csv')
measurements_a3_3 <- read.csv(file = 'A3/measurements_a3_3.csv')
measurements_a3_4 <- read.csv(file = 'A3/measurements_a3_4.csv')
measurements_a3_5 <- read.csv(file = 'A3/measurements_a3_5.csv')

#head(measurements_a3_1) #check table

#get only the mean values for each subsample
mean_a3_1 <- pull_mean(measurements_a3_1)
mean_a3_2 <- pull_mean(measurements_a3_2)
mean_a3_3 <- pull_mean(measurements_a3_3)
mean_a3_4 <- pull_mean(measurements_a3_4)
mean_a3_5 <- pull_mean(measurements_a3_5)

#substract the background('Mean1') from the mean from all the other measurements. 
a3.1 <- substract_background(mean_a3_1)
colnames(a3_1) <- NULL#c('a3_1')
a3.2 <- substract_background(mean_a3_2)
colnames(a3_2) <- NULL #('a3_2')
a3.3 <- substract_background(mean_a3_3)
colnames(a3_3) <- NULL #c('a3_3')
a3.4 <- substract_background(mean_a3_4)
colnames(a3_4) <- NULL #c('a3_4')
a3.5 <- substract_background(mean_a3_5)
colnames(a3_5) <- NULL #c('a3_5')

#concatenate all the images for sample in one column. HERE WE MAY WANT TO PUT ALL SAMPLES FOR A PROMOTOR TOGETHER (ALL 'A')
a3 <- rbind(a3.1, a3.2, a3.3, a3.4, a3.5)
colnames(a3) <- 'Mean A3'

##PLOTTING 
#boxplot for A3
a3_m <- melt(a3)
A3_bp <- ggplot(a3_m, aes(variable, value)) + 
  geom_boxplot()
View(A3_bp)

