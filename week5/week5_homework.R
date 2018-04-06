
library(NLP)
library(readtext)
library(tm)
library(jiebaR)
library(jiebaRD)

page <- readtext("*.txt", encoding = "big5")
docs <- Corpus(VectorSource(page$text))
docnum = length(page)

mixseg = worker()
Alltoken = list()
Allfreq = list()
for( c in 1:docnum )
{
  token = list(jiebaR::segment(docs[[c]]$content, mixseg))
  Alltoken = append(Alltoken, token)
  # 3. word frequency
  freq = list(as.data.frame(table(token)))
  Allfreq = append(Allfreq, freq)
}

NewDataFrame = merge(Allfreq[[1]], Allfreq[[2]], by="token")

