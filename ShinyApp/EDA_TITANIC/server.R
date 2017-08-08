#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plyr)
library(reshape2)
library("data.table")
library("DT")
library("shinythemes")
library("formattable")
library(plotly)
library("shinySignals")
#devtools::install_github("hadley/shinySignals")

setwd("~/Titanic/ShinyApp/EDA_TITANIC")
source("Functions/Hist.R")
source("Functions/Piechart.R")
source("General.R")


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Compute the summary of the variables
  output$summary <- renderPrint({
    summary(train[, -c("PassengerId", "Name", "Cabin", "Ticket")])
  })
  
  # Nice box-visualitzation of variables (boxes):
  num_people <- train[ , .N, ]
  num_survivors <- train[ Survived == 1, .N ,]
  survival_rate <- (num_survivors / num_users)
  
  output$num_people <- renderValueBox({
    valueBox(
      value = num_people,
      subtitle = "People in the Train Set",
      icon = icon("users"),
      color = "aqua"
    )
  })
  
  # Nice box-visualitzation of variables:
  output$num_survivors <- renderValueBox({
    valueBox(
      value = num_survivors,
      subtitle = "Survivors",
      icon = icon("child"),
      color = "green"
    )
  })
  # Nice box-visualitzation of variables:
  output$survival_rate <- renderValueBox({
    valueBox(
      value = percent(survival_rate, 0),
      subtitle = "Survival rate",
      icon = icon("area-chart"),
      color = "yellow"
    )
  })

  output$basic_hist_survived <- renderPlotly({
    gg_hist_survived(train, input$metric_hist, mean_train)
  })
  
  output$exp_title_survived <- renderText({
    paste(input$metric_hist, "  Relevance to Surviving \n") })

  output$basic_pie_chart <- renderPlotly({
    pie_chart(train, input$metric_hist)
  })
  
  
  output$barplot_rel_metrics <- renderPlotly({
      rel_metrics <- names(train)[c(3,5,7,8,12,13)]
  BAR_PLOTS <-   lapply(rel_metrics, function(x) {
    ggplotly( ggplot(train, aes_string(x, fill="Survived" )) + 
                geom_bar(position = 'dodge', stat="count") +
                theme(legend.title = element_blank(),
                      axis.title.y = element_blank(),
                      axis.text.y = element_text(size = rel(1.2))  ) +
                scale_fill_manual("legend", values =  c('lemonchiffon3','forestgreen'))
              ) } )
  for( i in c(1,4))
    s[[i]] <- subplot(BAR_PLOTS[[i]], BAR_PLOTS[[i+1]], BAR_PLOTS[[i+2]] ,  margin = c(0.05,0.02,0.8,0), titleX = T, titleY = T)
  
  subplot(s[[1]], s[[4]], nrows = 2, margin =0.08, titleX = T)
  })


  
    # # Density
    # ggplot(data = train, aes(x = metric, fill = Survived )) +
    #   ggtitle(paste("Density -", metric, "relevance to Surviving")) +
    #   geom_density(alpha = .5, na.rm=TRUE) +
    #   geom_vline(data = mean_train, aes(xintercept = mean_train[[metric]],  colour = Survived ),
    #              linetype="dashed", size=1)




})
