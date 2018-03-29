library(httr)

token  = "EAACEdEose0cBALZC69q7N0BhHAgRam00ZAQdGm2ecI8gePH5dWC2a4vhVSpc9CHwXltEn6f4K6UheLVmdV18bEy8SkSyxpRCVvCEAnsEoMj3OveOUw2nqsnzjsLoANNZAHWOd8ek5oqrTD7Uoxa0vbn6EoodZAiqRlUW1WZAONMCXvxeZCZAnpfFmI0m88D3cAZD"
prefex = "https://graph.facebook.com/v2.12/kikuChen/posts?access_token="
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