Next Word Prediction
========================================================
author: Marcia Lazo 
date: October 2016
autosize: true
font-import: https://fonts.googleapis.com/css?family=Open+Sans+Condensed
font-family: 'Open+Sans+Condensed'

Summary - About the Project
========================================================
<small>This project was created for the Data Science Capstone, part of the Coursera Data Science specialization, presented by Johns Hopkins University (JHU). JHU worked with Swiftkey. Swiftkey is an application for mobile devices that predicts the next word that a user will type. 
The goal of this project is to create a next word prediction algorithm using the data provided by Swiftkey through Coursera, and to use that algorithm in an shiny application online where it can be tried out. 
</small>
Building the Model
========================================================
To build the model I first downloaded the three sets of data provided by Coursera. The data sets consist of Blogs, News and Twitter data.

I read the data in and cleaned it up, removing punctuation, numbers, any Twitter symbols such as @ and turned all of the data into lower case. I combined all of the data and randomly selected 2% of it. 

I created n-grams, including single words, bigrams, trigrams and quadgrams, determined the frequency of each of these grams in the data, sorted the ngrams by most to least frequent, and saved the data out to be used in the application.

Techniques used for Prediction
========================================================

1. Read in the input phrase, clean it up as was done with the sample data and count the number of words
2. At each step take the final n words, n = 3 or fewer, and compare them to the first n words in the n+1 size ngrams
  + if succesful return the final word from the most frequent matching ngram</small>
3. If step two fails take the final n-1 words from the phrase and compare them to the first n-1 words in the n size ngrams, returning the final word from the most frequent matching ngram
  + Repeat until a match is found, or
4. If no matches are found in any of the ngrams return the most frequent single word from the sample corpus.

Using the Shiny Application
========================================================
To use the shiny app enter a phrase in the box in the left panel where it says Enter your text here. Hit Enter on your keyboard
!["Shiny App Image"][id]
[id]: figures/myShinyAppImage2.png "My Shiny App"
Click on the "About" tab to read about the application

The app can be found here:
[my shiny app](https://mlazo.shinyapps.io/MLazoCapstoneFinalProj/)
