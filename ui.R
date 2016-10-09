## Data Science Capstone Project
## Marcia Lazo

suppressPackageStartupMessages(c(
        library(stylo),
        library(shinythemes),
        library(shiny),
        library(tm),
        library(stringr),
        library(markdown)
        ))

shinyUI(navbarPage("Coursera Data Science Capstone", 
#shinyUI(fluidPage("Coursera Data Science Capstone",                    
                   theme = shinytheme("Spacelab"),
                   
############################### ~~~~~~~~1~~~~~~~~ ##############################  
## Tab 1 - Prediction

tabPanel("Predicting the Next Word",
         #tabPanel("Plot",
                  sidebarLayout(
                    sidebarPanel(
                      tags$div(textInput("text", 
                                         label = h3("Enter your text here then hit enter on your keyboard:"),
                                         value = ),
                               tags$span(style="color:blue",("This app is designed to predict words in English only. Please be patient. It is a little slow")),
                               br()
                    )),
                    mainPanel(
                      h4("The predicted next word:"),
                      tags$span(style="color:darkred",
                                tags$strong(tags$h3(textOutput("predictedWord")))),
                      br(),
                      tags$hr(),
                      h4("You entered:"),
                      tags$em(tags$h4(textOutput("yourText"))
                    )
                  )
         )), 


############################### ~~~~~~~~2~~~~~~~~ ##############################
## Tab 2 - About 

tabPanel("About",
# Application title
#mainPanel(

fluidRow(
  column(8, offset = 2,
  #tags$div(
  #br()
  tags$p("To use this application enter a phrase in the box that says `Enter your text here then hit enter on your keyboard:`. Then hit enter and wait
    to see the predicted next word. You can delete your phrase, shorted it, or add to it and hit enter to see new results.")
  )
),
br(),
fluidRow(
  column(8, offset = 2,
  tags$p("This Shiny application is designed to predict the next word that comes after the words you have typed in, much like happens whey you
type in a search in a search engine for example. It breaks up the phrase you type in into words. The sequence of words is called an n-gram. Two words
form a bigram, 3 form a trigram, etc. The application then uses an N-Gram back off model to predict the next word. 
The way the model was built is this: First data from news, twitter and blogs were loaded and cleaned. Then a sample of the data was extracted. I used 2% of 
the original data. The data is broken up into 1-grams, bi-grams, tri-grams and quad-grams. For each of these n-gram samples the frequency of each ngram is calculated. The 
n-grams are then sorted from the most frequent to the least frequent occurences. That means that the sequence of n words that appears the most frequently among 
all sets of n words from all of the data appears at the top of the list.

Now, assuming you have entered a phrase of 3 or more words the phrase that you have entered is cleaned up (removes apostrophes, numbers, punctuation and turned into lower case)
broken up into a sequence of words and the results are compared to the quadgrams. If the phrase is found in the first three words of a quadgram the next
word that is predicted is the final word of the quadgram. If that fails, or if you entered a phrase that is only two words long, the same process is repeated using the final two words
of your phrase and comparing them to the first two words of a trigram. Again, if successful, the next word predicted would be the last word of the trigram.
If that fails, or if you have only entered one word a similar process is used. 
Finally, if all else fails, the most frequently occuring single word in the set of initial documents is presented as the predicted next word"
))
)
)
))


