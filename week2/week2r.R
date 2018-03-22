library(httr)

url <- "https://ecshweb.pchome.com.tw/search/v3.3/all/results?q=tennis%20racket&page=1&sort=rnk/dc"
res = GET(url)
res_json = content(res)
cat(res_json)
#do.call(rbind,res_json$prods)
#View(data.frame(do.call(rbind,res_json$prods)))