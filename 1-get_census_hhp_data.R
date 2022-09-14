## https://vbaliga.github.io/verify-that-r-packages-are-installed-and-loaded/
## If a package is installed, it will be loaded. If any 
## are not, the missing package(s) will be installed 
## from CRAN and then loaded.

## First specify the packages of interest
packages = c("tidyverse", "stringr", "readxl", "sqldf", "DescTools")

## Now load or install & load all
package.check <- lapply(
  packages,
  FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
      library(x, character.only = TRUE)
    }
  }
)

# set working directory

setwd(choose.dir(caption = "Set working directory"))

# download ZIP files

zip_links <- "zip_links.csv"
zip_list <- read.csv(zip_links)

for (file in zip_list$Links) {
  download.file(file, str_extract(file, "HPS.*zip"))
}

# extract data dictionary and data file from ZIP files

for (zip_file in list.files(pattern = "HPS.*zip")) {
  zip_contents <- unzip(zip_file, list = TRUE)
  unzip(zip_file, files = zip_contents[[1]][1:2])
}