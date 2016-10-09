################# ~~~~~~~~~~~~~~~~~ ######## ~~~~~~~~~~~~~~~~~ #################
##                                                                            ##
##                        Data Science Capstone Project                       ##
##                                                                            ##            
##                        Marcia Lazo                                         ##
##                                                                            ##
################# ~~~~~~~~~~~~~~~~~ ######## ~~~~~~~~~~~~~~~~~ #################

suppressPackageStartupMessages(c(
        library(shinythemes),
        library(shiny),
        library(tm),
        library(stringr),
        library(markdown),
        library(stylo)))

source("./cleanAndPredict.R")


shinyServer(function(input, output) {
        
   wordPrediction <- reactive({
                text <- input$text
                input <- cleanInput(text)
                #wordCount <- length(textInput)
                wordPrediction <- PredNextTerm(input)})
        wordPrediction
        output$predictedWord <- renderPrint(wordPrediction())
        #output$predictedWord <- renderPrint(wordPrediction())
        output$yourText <- renderText({ input$text }, quoted = FALSE)
}
)