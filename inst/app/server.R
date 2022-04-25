#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(zip)

# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {
    
    outputDir <- "www"
    
    ###Add a csv file to the www directory
    observeEvent(input$addcsv, {
        session$sendCustomMessage(type = 'testmessage',
                                  message = 'Thank you for clicking')
        # write.csv(x = mtcars,file = paste0('~/zip-shiny/zipper/www/mtcars',input$number,'.csv'))
        fileName <- paste0('mtcars',input$number,'.csv')
        # Write the data to a temporary file locally
        # filePath <- file.path(tempdir(), fileName)
        write.csv(
            x = mtcars,
            file = file.path(outputDir, fileName), 
            row.names = FALSE, quote = TRUE
        )
        #write.csv(x = mtcars,file = paste0('./www/mtcars',input$number,'.csv'))
    })
    
    ###Delete a file from the www directory
    observeEvent(input$deletecsv,{
        fileName <- paste0('./www/mtcars',input$number,'.csv')
        file.remove(fileName)
    })
    
    filelistcsv <- reactive({fs <- list.files(path = './www',all.files = T,full.names = T,recursive = T)
    return(fs)
    })
    
    output$files_list <- renderText({
        filelistcsv()
        # print(getwd())
        # print(filelistcsv)
        
    })
        
        
        
        output$downloadData <- downloadHandler(
            filename = function() {
                paste("output", "zip", sep=".")
            },
            content = function(fname) {
                # fs <- c()
                # tmpdir <- tempdir()
                # setwd(tempdir())
                file_names <- list.files(path = './www',all.files = T,full.names = T,recursive = T)
                fs <- c(file_names)
                # for (i in c(1,2,3,4,5)) {
                #     path <- paste0("sample_", i, ".csv")
                #     fs <- c(fs, path)
                #     write(i*2, path)
                # }
                zip::zipr(zipfile=fname, files=file_names)
            },
            contentType = "application/zip"
        )
    }
)
