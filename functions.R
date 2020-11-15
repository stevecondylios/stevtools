
# Function that pastes from clipboard to an R object 
# and one that does the opposite 

# a <- system("pbpaste", intern = TRUE)

















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
  
}




reload_package_github("stevecondylios/RSeleniumHelpers")













