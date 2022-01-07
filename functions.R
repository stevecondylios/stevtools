
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








# Infox for the opposite of %in% for more expressive code


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




