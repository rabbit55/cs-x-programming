library(NLP)
library(tm)
library(tmcn)
library(stringr)
library(jiebaRD)
library(jiebaR)

#輸入文本名稱，需要在文本開頭加入一行colname不然會讀錯
#ex:
# text
# 有位小朋友送來一個絨作的小熊。白絨作的面龐...
# 她說：“甚麼？我沒聽清楚，你說嫵媚？我還從...
# 我接著又說我看小熊多嫵媚，小熊看我應如是。”...
# 我是從來沒有眼對眼看到過熊的。所以熊的形象在...
Sys.setlocale("LC_ALL","Chinese")
text = read.csv(file = "林海音竊書記.txt",quote = "",na.strings="NA",sep = "\t", encoding="UTF-8", header = T)
text = as.character(text[,1])
data.corpus = Corpus(VectorSource(text))
data.corpus = tm_map(data.corpus, removePunctuation)
data.corpus = tm_map(data.corpus, removeNumbers)
# data.corpus = tm_map(data.corpus, function(word){gsub("[]","",word) })
mixseg = worker()

#注意字典的檔案格式以及命名
#Sys.setlocale("LC_ALL","Chinese")
library(readr)
keywords <- read_csv("字典字典.csv")
#keywords = read.csv("字典字典.csv",quote = "", sep = ",")
new_user_word(mixseg, as.matrix(keywords[keywords != ""]),)

jieba_tokenizer = function(d){
  unlist( segment(d[[1]], mixseg) )
}
seg = lapply(data.corpus, jieba_tokenizer)

count_token = function(d){
  as.data.frame(table(d))
}
tokens = lapply(seg, count_token)

#計算總字頻
len = length(seg)
TDM = tokens[[1]]
for( id in c(2:len) ){
  TDM = merge(TDM, tokens[[id]], by='d', all = TRUE)
  names(TDM) = c('d', 1:id)
}
TDM[is.na(TDM)] = 0

tf = rowSums(TDM[,2:(len+1)])
frq = data.frame(TDM$d , tf)

#依據字典，從frq裡面取出要觀察的單字
positive = keywords$正面情緒詞[keywords$正面情緒詞 != ""]
negative = keywords$負面情緒詞[keywords$負面情緒詞 != ""]
acknowledge = keywords$認知歷程詞[keywords$認知歷程詞 != ""]
friend = keywords$朋友詞[keywords$朋友詞 != ""]
sum(frq[frq$TDM.d %in% positive ,2]) / sum(frq[frq$TDM.d %in% negative ,2]) *100
sum(frq[frq$TDM.d %in% acknowledge ,2])/sum(frq[,2]) *100
sum(frq[frq$TDM.d %in% friend ,2])/sum(frq[,2]) *100

#抓人稱代名詞前後的情緒詞

target = keywords$人稱代名詞
target = as.character(target [target != ""])

count_pos = data.frame(matrix(ncol = 7,nrow = len))
names(count_pos) = target
count_neg = count_pos

for (i in c(1:len)){
  flag = target %in% seg[[i]]
  temp = tokens[[i]]
  count_pos[i,flag] = sum(temp[temp$d %in% positive,2 ])
  count_neg[i,flag] = sum(temp[temp$d %in% negative,2 ])
}
sum(!is.na(count_pos))
sum(!is.na(count_neg))