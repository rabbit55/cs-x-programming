rm(list = ls())
library(rvest)
library(xml2)

url <- "https://www.ptt.cc/bbs/Baseball/index.html"
res <- read_html(url)
# Parse the content and extract the titles
raw.titles <- res %>% html_nodes("div.title")

# Extract link
nba.article.link <- raw.titles %>% html_node("a") %>% html_attr('href')

# Extract article
nba.article.title <- raw.titles %>% html_text()

# Create dataframe
nba.df <- data.frame(nba.article.title, nba.article.link)

# Set df's colnames
nba.df.col.names <- c("title", "link")
colnames(nba.df) <- nba.df.col.names