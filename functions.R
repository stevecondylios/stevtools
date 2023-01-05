
# Function that pastes from clipboard to an R object 
# and one that does the opposite 

# a <- system("pbpaste", intern = TRUE)








#### 
# Function that acts like ruby's _
i.e. an alias for .Last.value 
a <- .Last.value
a <- _








reload_package_github <- function(repo) {
  # This function allows you to really quickly/easily get the changes you made to an R package
  # from github into your current R session, without needing to restart the R session, mess around
  # with tarballs, or any other rigmarale
  
  # Based on ?devtools::install_github
  # e.g. "stevecondylios/RSeleniumHelpers"
  
  temp <- strsplit(repo, "/")
  
  user_name <- temp[[1]][1]
  package_name <- temp[[1]][2]
  
  tryCatch(detach(paste0("package:", package_name), unload=TRUE), error = function(e) {} )
  
  devtools::install_github(repo)
  pack <- package_name
  library(pack, character.only = TRUE)
  cat(paste(pack, "has been reloaded into R session"))
}



reload_package_github("stevecondylios/RSeleniumHelpers")





# When authoring a package, it's annoying to have to build it and reload it. Do it all in one function call!

barl <- function() {
  # barl: build and reload library 
  devtools::document(roclets = c('rd', 'collate', 'namespace'))
  devtools::build()
  install.packages("../dictionary_0.1.0.tar.gz", repos=NULL, type="source")
  library(dictionaRy)
}
# Now when you knit the readme, it will be using the new package version. 








# Infix for the opposite of %in% for more expressive code


'%not_in%' <- function(lhs, rhs) {
  !(lhs %in% rhs)
}


"b" %in% c("a", "b", "c")
"b" %not_in% c("a", "b", "c")








# Generate a time stamp

time_stamp <- function() {
  Sys.time() %>% strftime("%Y%m%d%H%M%S")
}

time_stamp()



























# Function to easily save a wordcloud, plotly or anything else that's html/js
# as a png for immediate use

save_html_as_png <- function(thing_to_save, file_name) {
  # This function takes a rendered (html/js) plot, saves it as an html file, 
  # then uses webshot to take a screenshot of it
  
  # file_name example: "myfile.png" or "/some/directory/myfile.png"
  # thing_to_save could be a wordcloud or plotly (anything html based)
  
  delay = 5 # This could be a function argument but is set here for now 
   
  library(webshot)
  library(htmlwidgets)
  
  tempd <- tempdir() 
  tempf <- paste0(tempfile(), ".html")
  
  saveWidget(thing_to_save, tempf, selfcontained = F)
  webshot(tempf, file_name, delay = delay, vwidth = 700, vheight=700)
  
}


# Example usage
save_html_as_png(wc, "scwc.png")
save_html_as_png(p2, "sc2.png")



### Example

# Make a wordcloud
# From: https://www.data-to-viz.com/graph/wordcloud.html

# Libraries
library(tidyverse)
library(hrbrthemes)
library(tm)
library(proustr)

# Load dataset from github
data <- read.table("https://raw.githubusercontent.com/holtzy/data_to_viz/master/Example_dataset/14_SeveralIndepLists.csv", header=TRUE) 
to_remove <- c("_|[0-9]|\\.|function|^id|script|var|div|null|typeof|opts|if|^r$|undefined|false|loaded|true|settimeout|eval|else|artist")
data <- data %>% filter(!grepl(to_remove, word)) %>% filter(!word %in% stopwords('fr')) %>% filter(!word %in% proust_stopwords()$word)

# The wordcloud 2 library is the best option for wordcloud in R
library(wordcloud2)

# prepare a list of word (50 most frequent)
mywords <- data %>%
  filter(artist=="nekfeu") %>%
  dplyr::select(word) %>%
  group_by(word) %>%
  summarize(freq=n()) %>%
  arrange(freq) %>%
  tail(30)

# Make the plot
wordcloud2(mywords,  minRotation = -pi/2, maxRotation = -pi/2,
         backgroundColor = "white", color="#69b3a2")

# Save it as an object
wc <- wordcloud2(mywords,  minRotation = -pi/2, maxRotation = -pi/2,
         backgroundColor = "white", color="#69b3a2")

# Save it as png
save_html_as_png(wc, "ssss.png")





















