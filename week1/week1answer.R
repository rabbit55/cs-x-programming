
iris
#原來直接打iris就可以跑出所有的資料!
dim(iris)
#新學的function，可以找出排數(挺方便的
head(iris)
#另一個function，找出前六項
tail(iris)
#找出後六項
str(iris)

summary(iris)

nums<-10:100
sample(nums,10)
#亂數
nums
#直接打亂數的代號就可以看出電腦亂數跑出來的結果
for(i in c(1:9)){
  for(j in c(1:9)){
    print(paste(i,"X",j,"=",i*j))
  }
}
#for loop 沒什麼問題
for(i in c(10:100)){
  if(i==66){
    print("太666666")
    break
  }
  else if(i>=50&&i%%2==0){
    print(paste("偶數並大於50",i))
  }
}
#break滿好用的

y<-100
if(y%%4==0&&y%%100!=0){
  print(paste(y,"yes"))
}else if(y%%400==0){
  print(paste(y,"yes"))
}else{
  print(paste(y,"no"))
}
#原來餘數是%%阿
#R有限定(換行)}else{(換行)，好麻煩
answer<-sample(0:9,4)
guess_count<-0
repeat{
  cat("請輸入四個不同的個位數字0~9")
  guess<-scan(nmax=4)
  a<-0
  b<-0
  for(i in 1:4){
    if(guess[i]==answer[i]){
      a<-a+1
    }else{
      for(j in 1:4){
        if(guess[i]==answer[j]){
          b <- b+1
        }
      }
    }
  }
  cat("A",a,"B",b)
  if(a==4){
    cat("***your guess is***", guess,"answer is correct",guess_count)
    break
  }else{
    guess_count <- guess_count + 1
    cat("***your guess is***", guess,"answer is wrong", guess_count)}
}
#cat 和 print到底有甚麼不一樣呢?看了網路上的資料，好像大概可以區分，ex:cat 可以直接印出字(要加"")，print要加paste等等
#但是我還沒完全搞懂，有時候自己寫程式，跳出error message，就換另一個function就對了XD
