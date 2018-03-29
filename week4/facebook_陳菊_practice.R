library(httr)

token  = "EAACEdEose0cBAHdX2m1JxTAzCCkH6wkOw9z3kJTBGfhuo6tkA2dI0DoQ9EMe44b1dqxHYqWZCZCYeZADzUiCyE6DoUZAEeNC50batIFfbiJsLKfsq9ceNlnNgZA6rEtAR3wjNc8zRE1d3oEeh5TJqmidL8WWkjL9112EVdwR0vKxCTMmUP9R1iuFCOxKX1ZANl7cBzH0T1KQZDZD"
prefex = "https://graph.facebook.com/v2.12/https://www.facebook.com/kikuChen/?access_token="
url    = paste0(prefex, token)
res    = httr::GET(url)
posts  = content(res)
# res = POST("https://graph.facebook.com/v2.12/me/feed",
#            body=list(message=sprintf("[TEST Posting Message] %s At %s","httr ด๚ธี",Sys.time()),
#                      access_token=token))
# postId = content(res)$id
# 
# 
# url = sprintf("https://graph.facebook.com/v2.12/%s?access_token=%s", postId, token)
# res = DELETE(url)
# content(res)