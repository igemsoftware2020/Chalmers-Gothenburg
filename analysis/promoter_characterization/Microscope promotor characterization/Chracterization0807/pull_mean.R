#function to pull mean columns from Fiji .csv files

pull_mean <- function(sample) {
  sample_df <- as.data.frame(sample)
  mean_sample <- sample_df %>% select(starts_with("Mean"))
}
