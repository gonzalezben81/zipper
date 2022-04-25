#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    titlePanel(""),
    sidebarLayout(
        sidebarPanel(
            br(),
			wellPanel(
            numericInput(inputId = "number",label = "Number to add to csv file",value = 1,min = 1,max = 10000,step = 1)),
            br(),
            wellPanel(
            wellPanel(
            actionButton(inputId = "addcsv",label = "Add a csvile to the zip files")),
            br(),
            wellPanel(
            actionButton(inputId = "deletecsv",label = "Delete csv file from www folder"))
            ),
            br(),
            wellPanel(
                downloadButton("downloadData", label = "Download"),
            )
        ),
        mainPanel(h6("Sample download", align = "center"),
                  tags$head(tags$script(src = "message-handler.js")),
                  textOutput("files_list"))
    )
))
