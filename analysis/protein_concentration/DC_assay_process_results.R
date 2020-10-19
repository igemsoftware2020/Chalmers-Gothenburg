#Script to calculate concentrations from Lawry assay 
rm(list=ls())

#library(dplyr)
library(tidyverse)
#library(ggplot2)
library(reshape2)

#set working directory
setwd("/Users/leti/Desktop/iGEM/analysis/protein_concentration/")
calibration_table <- read_csv2("Results Lowry Assay A1toA4 13_08.csv")
colnames(calibration_table)<-c('Sample', 'OD', 'Dilution', 'Concentration')

standard_data <- subset(calibration_table, Sample == "BSA", c("Concentration", "OD"))

#make plot for standard curve x - concentration y - absorbance
standard_curve <- ggplot(calibration_table, aes(Concentration, OD)) + #fill colors the plots according to the variable (samples)
  geom_point() +
  geom_smooth(method="lm") #print regression line
print(standard_curve)

linear_model <- lm(Concentration ~ OD, data=standard_data) #do the actual regression 
print(linear_model)

#formula -> concentration = intercept + (od_model * OD)

summary(linear_model) #see if the "model" is significant. Look at p-value < 0.05. 

#do regression on the data for dilution 1:8 - modify according to what dilution you have 
sub_concentration_8 <- subset(calibration_table, Dilution == "8", c("Sample", "OD"))
concentration_8 <- data.frame(sub_concentration_8$OD)
colnames(concentration_8)<-("OD")

predicted_concentrations_8 <- predict(linear_model, concentration_8) #predict concentration for our samples based on the linear model we just built
print(predicted_concentrations_8)

vector <- t(predicted_concentrations_8)
concentrations_vector<- t(vector)

for (i in 1:(length(concentrations_vector))){
  concentrations_vector[i] = concentrations_vector[i] * 8
}


calibration_table$Concentration[6:9] <- rbind(concentrations_vector)

#do regression on the data for dilution 1:20 
#sub_concentration_20 <- subset(calibration_table, Dilution == "20", c("Sample", "OD"))
#concentration_20 <- data.frame(sub_concentration_20$OD)
#colnames(concentration_20)<-("OD")

#predicted_concentrations_20 <- predict(linear_model, concentration_20) #predict concentration for our samples based on the linear model we just built
#print(predicted_concentrations_20) #we cannot use these concentrations since they are outside the linear range


concentrations_subset <- subset(calibration_table, Dilution == "8", c("Concentration", "OD"))

print(plot_concentrations)

plot_concentrations <- ggplot(standard_data, aes(Concentration, OD)) + #fill colors the plots according to the variable (samples)
  geom_point() +
  geom_smooth(method="lm") + #print regression line
  geom_point(data = concentrations_subset, aes(Concentration, OD), color='green') 
  
print(plot_concentrations)



