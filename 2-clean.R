# create data frame for analysis

# build master data dictionary

data_dictionary <- list.files(pattern = "data.dictionary") %>% 
  lapply(read_xlsx) %>% 
  bind_rows
colnames(data_dictionary) <- data_dictionary[3,]
data_dictionary <- data_dictionary[-(1:3),] %>% 
  select(Variable) %>% 
  na.omit %>% 
  unique

# build master dataset for NV

data <- list.files(pattern = "puf.*csv") %>% 
  lapply(read.csv.sql, sql = "select WEEK, CURFOODSUF, FREEFOOD, ANXIOUS, WORRY, INTEREST, DOWN from file where EST_ST = 32", eol = "\n") %>% 
  bind_rows
closeAllConnections()

# create GAD-2 and PHQ-2 scores

data$GAD2_SCORE <- with(data, (ANXIOUS - 1) + (WORRY - 1))
data$PHQ2_SCORE <- with(data, (INTEREST - 1) + (DOWN - 1))

# create CURFOODSUF, GAD2_SCORE, PHQ2_SCORE, FREEFOOD labels

for (row in 1:length(data$CURFOODSUF)) {
  if (data$CURFOODSUF[row] < 0) {
    data$CURFOODSUF_SUMMARY_STATUS[row] <- NA
  } else if (data$CURFOODSUF[row] == 1) {
    data$CURFOODSUF_SUMMARY_STATUS[row] <- "food sufficient"
  } else {
    data$CURFOODSUF_SUMMARY_STATUS[row] <- "food insufficient"
  }
}

for (row in 1:length(data$CURFOODSUF)) {
  if (data$CURFOODSUF[row] < 0) {
    data$CURFOODSUF_DETAILED_STATUS[row] <- NA
  } else if (data$CURFOODSUF[row] == 1) {
    data$CURFOODSUF_DETAILED_STATUS[row] <- "Enough of the kinds of food (I/we) wanted to eat"
  } else if (data$CURFOODSUF[row] == 2) {
    data$CURFOODSUF_DETAILED_STATUS[row] <- "Enough, but not always the kinds of food (I/we) wanted to eat"
  } else if (data$CURFOODSUF[row] == 3) {
    data$CURFOODSUF_DETAILED_STATUS[row] <- "Sometimes not enough to eat"
  } else {
    data$CURFOODSUF_DETAILED_STATUS[row] <- "Often not enough to eat"
  }
}

for (row in 1:length(data$GAD2_SCORE)) {
  if (data$GAD2_SCORE[row] < 0) {
    data$GAD2_STATUS[row] <- NA
  } else if (data$GAD2_SCORE[row] < 3) {
    data$GAD2_STATUS[row] <- "GAD-2 -"
  } else {
    data$GAD2_STATUS[row] <- "GAD-2 +"
  }
}

for (row in 1:length(data$PHQ2_SCORE)) {
  if (data$PHQ2_SCORE[row] < 0) {
    data$PHQ2_STATUS[row] <- NA
  } else if (data$PHQ2_SCORE[row] < 3) {
    data$PHQ2_STATUS[row] <- "PHQ-2 -"
  } else {
    data$PHQ2_STATUS[row] <- "PHQ-2 +"
  }
}

for (row in 1:length(data$FREEFOOD)) {
  if (data$FREEFOOD[row] < 0) {
    data$FREEFOOD_LABEL[row] <- NA
  } else if (data$FREEFOOD[row] == 1) {
    data$FREEFOOD_LABEL[row] <- "free food in past week"
  } else {
    data$FREEFOOD_LABEL[row] <- "no free food in past week"
  }
}

# create table for analysis by dropping NAs

analysis <- drop_na(data)