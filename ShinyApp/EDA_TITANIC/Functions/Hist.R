gg_hist_survived <- function(train, metric, mean_train) {

  # Histogram

ggplot(data = train, aes_string(x = metric, fill = "Survived" )) +
  ylab("Survivors") +
  geom_histogram(binwidth = 15, position = "identity", alpha = .5, na.rm=TRUE) +
  geom_vline(data = mean_train, aes(xintercept = mean_train[[metric]],  colour = Survived),
             linetype="dashed", size=1) 
}

