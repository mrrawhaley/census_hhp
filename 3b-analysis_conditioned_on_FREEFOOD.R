# calculate relative risk of positive GAD-2 screening based on food sufficiency status
# AND free food status
# relative risk calculation reverses row order to match expected input for function
# (search Help for "RelRisk" for details)

  # free food

  GAD2_relative_risk_matrix_freefood <- with(filter(analysis, FREEFOOD_LABEL == "free food in past week"), table(CURFOODSUF_SUMMARY_STATUS, GAD2_STATUS)) %>%  
    Rev(1)
  
  GAD2_relative_risk_freefood <- with(filter(analysis, FREEFOOD_LABEL == "free food in past week"), as.numeric(table(CURFOODSUF_SUMMARY_STATUS, GAD2_STATUS))) %>% 
    matrix(nrow = 2) %>% 
    Rev(2) %>% 
    RelRisk(conf.level = 0.95)

  # no free food

  GAD2_relative_risk_matrix_no_freefood <- with(filter(analysis, FREEFOOD_LABEL == "no free food in past week"), table(CURFOODSUF_SUMMARY_STATUS, GAD2_STATUS)) %>%  
    Rev(1)
  
  GAD2_relative_risk_no_freefood <- with(filter(analysis, FREEFOOD_LABEL == "no free food in past week"), as.numeric(table(CURFOODSUF_SUMMARY_STATUS, GAD2_STATUS))) %>% 
    matrix(nrow = 2) %>% 
    Rev(2) %>% 
    RelRisk(conf.level = 0.95)

# calculate relative risk of positive PHQ-2 screening based on food sufficiency status
# relative risk calculation reverses row order to match expected input for function
# (search Help for "RelRisk" for details)

  # free food
  
  PHQ2_relative_risk_matrix_freefood <- with(filter(analysis, FREEFOOD_LABEL == "free food in past week"), table(CURFOODSUF_SUMMARY_STATUS, PHQ2_STATUS)) %>%  
    Rev(1)
  
  PHQ2_relative_risk_freefood <- with(filter(analysis, FREEFOOD_LABEL == "free food in past week"), as.numeric(table(CURFOODSUF_SUMMARY_STATUS, PHQ2_STATUS))) %>% 
    matrix(nrow = 2) %>% 
    Rev(2) %>% 
    RelRisk(conf.level = 0.95)

  # no free food
  
  PHQ2_relative_risk_matrix_no_freefood <- with(filter(analysis, FREEFOOD_LABEL == "no free food in past week"), table(CURFOODSUF_SUMMARY_STATUS, PHQ2_STATUS)) %>%  
    Rev(1)
  
  PHQ2_relative_risk_no_freefood <- with(filter(analysis, FREEFOOD_LABEL == "no free food in past week"), as.numeric(table(CURFOODSUF_SUMMARY_STATUS, PHQ2_STATUS))) %>% 
    matrix(nrow = 2) %>% 
    Rev(2) %>% 
    RelRisk(conf.level = 0.95)

# print results

GAD2_relative_risk_matrix_freefood
GAD2_relative_risk_freefood

GAD2_relative_risk_matrix_no_freefood
GAD2_relative_risk_no_freefood

PHQ2_relative_risk_matrix_freefood
PHQ2_relative_risk_freefood

PHQ2_relative_risk_matrix_no_freefood
PHQ2_relative_risk_no_freefood
