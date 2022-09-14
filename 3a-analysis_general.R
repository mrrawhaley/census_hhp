# calculate relative risk of positive GAD-2 screening based on food sufficiency status
# relative risk calculation reverses row order to match expected input for function
# (search Help for "RelRisk" for details)

GAD2_relative_risk_matrix <- with(analysis, table(CURFOODSUF_SUMMARY_STATUS, GAD2_STATUS)) %>%  
  Rev(1)

GAD2_relative_risk <- with(analysis, as.numeric(table(CURFOODSUF_SUMMARY_STATUS, GAD2_STATUS))) %>% 
  matrix(nrow = 2) %>% 
  Rev(2) %>% 
  RelRisk(conf.level = 0.95)

# calculate relative risk of positive PHQ-2 screening based on food sufficiency status
# relative risk calculation reverses row order to match expected input for function
# (search Help for "RelRisk" for details)

PHQ2_relative_risk_matrix <- with(analysis, table(CURFOODSUF_SUMMARY_STATUS, PHQ2_STATUS)) %>%  
  Rev(1)

PHQ2_relative_risk <- with(analysis, as.numeric(table(CURFOODSUF_SUMMARY_STATUS, PHQ2_STATUS))) %>% 
  matrix(nrow = 2) %>% 
  Rev(2) %>% 
  RelRisk(conf.level = 0.95)