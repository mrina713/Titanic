pie_chart <- function( train, metric ) {
  if(metric == 'Age') {
    as.data.frame(train) %>%
      group_by(age_group) %>%
      summarise_(count = ~n()) %>%
      plot_ly(labels = ~age_group, values = ~count) %>%
      add_pie(hole = 0.5) %>%
      layout(title = "Donut charts using Plotly",  showlegend = T,
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  }
  else {
    if(metric == 'Fare') {
      as.data.frame(train) %>%
        group_by(Pclass) %>%
        summarise_(count = ~n()) %>%
        plot_ly(labels = ~Pclass, values = ~count) %>%
        add_pie(hole = 0.5) %>%
        layout(title = "Donut charts using Plotly",  showlegend = T,
               xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
               yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    } else { ggplot() } 
  }
  
  
}