library(NLP)
library(tm)
library(tmcn)
library(stringr)
library(jiebaRD)
library(jiebaR)

text = read.table(file = "散文.txt", encoding="big5")
text = text$V1
data.corpus = Corpus(VectorSource(text))
data.corpus = tm_map(data.corpus, removePunctuation)
data.corpus = tm_map(data.corpus, removeNumbers)
data.corpus = tm_map(data.corpus, function(word){gsub("[A-Z你我他們也又是]","",word) })
mixseg = worker()

jieba_tokenizer = function(d){
  unlist( segment(d[[1]], mixseg) )
}
seg = lapply(data.corpus, jieba_tokenizer)

count_token = function(d){
  as.data.frame(table(d))
}
tokens = lapply(seg, count_token)

len = length(seg)
TDM = tokens[[1]]
for( id in c(2:len) ){
  TDM = merge(TDM, tokens[[id]], by='d', all = TRUE)
  names(TDM) = c('d', 1:id)
}
TDM[is.na(TDM)] = 0

tf = rowSums(TDM[,2:len+1])
idfCal <- function(word_doc){ 
  log2( len / nnzero(word_doc) ) 
}
idf <- apply(as.matrix(TDM[,2:(len+1)]), 1, idfCal)

doc.tfidf <- TDM
token_len = length(idf)

tempY = matrix(rep(c(as.matrix(tf)), each = token_len), nrow = token_len)
tempX = matrix(rep(c(as.matrix(idf)), each = token_len), ncol = token_len, byrow = TRUE)
doc.tfidf[,2:(len+1)] <- (doc.tfidf[,2:(len+1)] / tempY) * tempX
for(id in c(2:len+1)){
  doc.tfidf[!is.finite(doc.tfidf[,id]) , id] = 0
}
stopLine = rowSums(doc.tfidf[,2:(len+1)])
delID = which(stopLine == 0)
doc.tfidf = doc.tfidf[-delID,]
TopWords = data.frame()
for( id in c(1:len) ){
  Max = order(doc.tfidf[,id+1], decreasing = TRUE)
  showResult = t(as.data.frame(doc.tfidf[Max[1:10],1]))
  TopWords = rbind(TopWords, showResult)
}
rownames(TopWords) = colnames(doc.tfidf)[2:(len+1)]
TopWords = droplevels(TopWords)