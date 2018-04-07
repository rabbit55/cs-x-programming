
library(NLP)
library(readtext)
library(tm)
library(jiebaR)
library(jiebaRD)

#It took me a while to figure out which ½s½X to save the file, and I tried all types to find the right one.
page <- readtext("*.txt", encoding = "big5")
docs <- Corpus(VectorSource(page$text))
docnum = length(page)

mixseg = worker()
Alltoken = list()
Allfreq = list()
#listed all the words and phrases
for( c in 1:docnum )
{
  token = list(jiebaR::segment(docs[[c]]$content, mixseg))
  Alltoken = append(Alltoken, token)
  #use append function to get every words and phrases I need
  freq = list(as.data.frame(table(token)))
  Allfreq = append(Allfreq, freq)
  #use append function to get freqeuncy
}

NewDataFrame = merge(Allfreq[[1]], Allfreq[[2]], by="token")

