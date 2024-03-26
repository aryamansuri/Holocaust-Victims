#### Preamble ####
# Purpose: Creates the Shiny
# Author: Aryaman Suri
# Date: 26/03/24
# Contact: aryaman.suri@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(shiny)
library(ggplot2)
library(DT)

#read the cleaned data
holocaust_survivors_data <- read_csv("Data/analysis_data/cleaned_data.csv")

# UI
ui <- fluidPage(
  titlePanel("Auschwitz Victims by Religion"),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("religions",
                         label = "Select Religions",
                         choices = unique(holocaust_survivors_data$Religion),
                         selected = unique(holocaust_survivors_data$Religion)
      )
    ),
    mainPanel(
      plotOutput("victimPlot"),
      dataTableOutput("victimTable")
    )
  )
)

# Server
server <- function(input, output) {
  
  # Reactive subset of data based on user selection
  filteredData <- reactive({
    holocaust_survivors_data[holocaust_survivors_data$Religion %in% input$religions, ]
  })
  
  # Render interactive plot
  output$victimPlot <- renderPlot({
    ggplot(filteredData(), aes(x = Religion, y = n, fill = Religion)) +
      geom_bar(stat = "identity") +
      labs(title = "Auschwitz Victims by Religion",
           x = "Religion",
           y = "Number of Victims") +
      theme_minimal() +
      theme(legend.position = "none")  # Remove legend for interactive selection
  })
  
  # Render interactive table
  output$victimTable <- renderDataTable({
    filteredData()
  })
}

# Run the application
shinyApp(ui = ui, server = server)