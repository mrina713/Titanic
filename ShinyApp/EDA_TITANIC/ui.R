library(shiny)
library(plyr)
library(reshape2)
library("data.table")
library("DT")
library("shinythemes")
library("formattable")
library(plotly)
library(shinydashboard)

setwd("~/Titanic/ShinyApp/EDA_TITANIC")

source("General.R")

sidebar <- dashboardSidebar(width = 300,
  sidebarMenu(
    menuItem(h4("Exploratory Data Analysis"), tabName = "BEDA", icon = icon("binoculars")),
    menuItem(h4("Widgets"), tabName = "widgets", icon = icon("th"))
  )
)

body <- dashboardBody(
  tabItems(
    tabItem( tabName = "BEDA",
             tabBox(width = 12,
               # Title can include an icon
               title = tagList(shiny::icon("stethoscope"), "Exploratory Data Analysis"),
               tabPanel("Overview",
                        fluidRow(
                          tags$head(tags$style(HTML("
                                                    #summary {
                                                    text-align: center;
                                                    font-size: 98%}
                                                    div.box-header {
                                                    text-align: center;
                                                    }
                                                    "))),
                          box( title = tags$p(style = "font-size: 26px; font-weight: bold;", "Variables Summary"),
                               verbatimTextOutput("summary"),
                               tags$p(style = "font-size: 26px; font-weight: bold; text-align: center;", "Survival distribution among variables"),
                               plotlyOutput("barplot_rel_metrics"),
                               width = 10,  solidHeader = TRUE, background = "navy") ,
                          
                          valueBoxOutput("num_people",    width = 2 ),
                          valueBoxOutput("num_survivors", width = 2 ),
                          valueBoxOutput("survival_rate", width = 2 )
                          )
               ),
               tabPanel("Detailed", 
                        fluidRow(
                          h3(textOutput("exp_title_survived")),
                          box(width = 6, solidHeader = TRUE, title = "Histogram" , status = "primary",
                              plotlyOutput("basic_hist_survived", height = 500)) ,
                          box(width = 4, plotlyOutput("basic_pie_chart", height = 500), solidHeader = TRUE, title = paste( metric_hist, "Pie Chart" ),
                              status = "primary"),
                          box(width = 2, status = "warning", collapsible = T,solidHeader = TRUE, title = "Filters",
                              radioButtons("metric_hist", "Metric:", choices = metric_hist, selected = "Age")) ))
             )
            
    ),
    
    tabItem(tabName = "widgets",
            h2("Widgets tab content")
    )
  )
)


# Define UI for application that draws a histogram
shinyUI(
  dashboardPage( skin = "purple",
                 
                 dashboardHeader(title = strong("SURVIVING TITANIC")),
                 sidebar,
                 body
  )
)
