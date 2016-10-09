## Coursera Data Science Capstone Project
## Marcia Lazo


suppressPackageStartupMessages(c(
        library(shinythemes),
        library(shiny),
        library(tm),
        library(stringr),
        library(markdown),
        library(stylo),
        library(dplyr)))

#The data was preprocessed using the code in prepareData.R, and then saved to file
#It is being loaded here. I used 2% of all of the data as my sample and created the
#n-grams from that 2%
uniData <- load(file="./data/ngram_sorted_1.RData")
unigrams = gramfreq
biData <- load(file="./data/ngram_sorted_2.RData")
bigrams = gramfreq
triData <- load(file="./data/ngram_sorted_3.RData")
trigrams = gramfreq
quadData <- load(file="./data/ngram_sorted_4.RData")
quadgrams = gramfreq

#This function is used to clean up the input text. The texts used to create the n-grams were all cleaned similarly ahead of time
#so this text needs to be cleaned as well to make sure that a fair comparison of words is done
cleanTheText<-function(text){
        
        clean <- tolower(text)
        clean <- removePunctuation(clean)
        clean <- removeNumbers(clean)
        clean <- str_replace_all(clean, "[^[:alnum:]]", " ")
        clean <- stripWhitespace(clean)

        return(clean)
}

#Using txt.to.word.ext from stylo. This package is good for English language tokenization
#It splits the text into words and leaves contractions such as don't untouched. It also leaves
#compound word constructs such as daughter-in-law intact as one "word"
cleanInput <- function(text){
        
        input <- cleanTheText(text)
        input <- txt.to.words.ext(input, language="English.all", preserve.case = TRUE)
        return(input)
}

PredNextTerm <- function(inStr)
{
  inStr <- unlist(strsplit(inStr, split=" "));
  inStrLen <- length(inStr);
  
  Found <- FALSE;
  predNxtTerm <- as.character("Nothing entered yet");
  if (inStrLen >= 3 & !Found)
  {
    # Take the input string and tokenize it, separating tokesn by a single space 
    input <- paste(inStr[(inStrLen-2):inStrLen], collapse=" ");
    searchStr <- paste("^",input, sep = "");
    #Find all instances where the final three words from the phrase are the first three words in a quadgram
    quadgramsTemp <- subset(quadgrams, grepl(searchStr, quadgrams[,1]))
    # Check to see if any matching records were found
    if ( length(quadgramsTemp[, 1]) > 1 )
    {
      predNxtTerm <- quadgramsTemp[1,1];
      Found <- TRUE;
    }
    quadgramsTemp <- NULL;
  }
  # if that failed find all instances where the final two words from the phrase are the first two words in a trigram
  if (inStrLen >= 2 & !Found){
    inStr1 <- paste(inStr[(inStrLen-1):inStrLen], collapse=" ");
    searchStr <- paste("^",inStr1, sep = ""); 
    trigramsTemp <- subset(trigrams, grepl(searchStr, trigrams[,1]))
    if ( length(trigramsTemp[, 1]) > 1 )
    {
      predNxtTerm <- trigramsTemp[1,1];
      Found <- TRUE;
    }
    trigramsTemp <- NULL;
  }
  # if that failed find all instances where the final (or only) word from the phrase is the first word in a bigram
  if (inStrLen >= 1 & !Found){
    inputStr <- inStr[inStrLen]
    searchStr <- paste("^", inputStr, sep = "")
    bigramsTemp <- subset(bigrams, grepl(searchStr, bigrams[, 1]))
    #print(bigramsTemp)
    # Check to see if any matching record returned
    if (length(bigramsTemp[, 1]) > 1)
    {
      predNxtTerm <- bigramsTemp[1, 1]
      Found <- TRUE
    }
    bigramsTemp <- NULL
  }
  if(!Found & inStrLen > 0)
  {
    predNxtTerm <- unigrams[1,1];
  }
  
  #nextTerm <- word(predNxtTerm, -1);
  print(predNxtTerm)
  if (inStrLen > 0){
    nextTerm <- word(predNxtTerm, -1);
    return(nextTerm)
  } else {
    nextTerm <- "";
    return(nextTerm);
  }
}