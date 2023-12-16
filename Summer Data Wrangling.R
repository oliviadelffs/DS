library(tidyverse)
library(dplyr)
library(readxl)
library(rmarkdown)
library(quarto)
# combine 3 cohorts
master <- bind_rows(
  master2020 %>% rename(reg_spring = `Registered for Spring 2021`,
                        reg_fall =`Registration Status for Fall 2021`,
                        com_res = `Commuter/Res`,
                        withdrawal_date = `Withdrawal Form Date`,
                        pell_vs_NonPell = `Pell vs. Non Pell`,
                        pell_Eligible = `Pell Eligibility`,
                        fall_Coaching_Appts = `Fall Success Coach Meetings`,
                        spring_Coaching_Appts = `Spring Success Coach Meetings`,
                        total_Coaching = `Total Coaching`,
                        gpa_spring = `Cumulative GPA After Spring`,
                        cred_hours_spring = `Earned Hours After Spring`,
                        gpa_fall = `Cumulative GPA After Fall`, 
                        cred_hours_fall = `Earned Hours After Fall`,
                        goa_fall = `CORE 101 fall grade`,
                        goa_spring = `CORE 102 Spring grade`,
                        major = `Major at Fall Census`,
                        spring_tutoring = `Spring Tutoring`,
                        fall_SI = `Fall SI`,
                        spring_SI = `Spring SI`) %>% 
    mutate(Year = 2020),
  master2021 %>% rename(reg_spring = `Registered Spring 2022`,
                        reg_fall =`Registration Status Fall 2022`,
                        com_res = `Commuter or Residenct`,
                        withdrawal_date = `Withdrawal Form Date`,
                        pell_vs_NonPell = `Pell Eligible vs. Non`,
                        pell_Eligible = `Pell Eligible`,
                        fall_Coaching_Appts = `Fall Coaching Appts`,
                        spring_Coaching_Appts = `Spring Coaching Appts`,
                        total_Coaching = `Total Coaching Appts`,
                        gpa_spring = `Cumulative GPA After Spring`,
                        cred_hours_spring = `Earned Hours After Spring`,
                        gpa_fall = `Cumulative GPA After Fall`,
                        cred_hours_fall = `Earned Hours After Fall`,
                        goa_fall = `Goa Fall`,
                        goa_spring = `Goa Spring`,
                        major = `Major at Fall Census`,
                        spring_tutoring = `Spring Tutoring`,
                        fall_SI = `Fall SI`,
                        spring_SI = `Spring SI`) %>% 
    mutate(Year = 2021),
  master2022 %>% rename(reg_spring = `Registered Spring 2023`,
                        reg_fall = `Reg Status Fall 2023`,
                        com_res = `Resident or Commuter (Fall 2022 Census)`,
                        withdrawal_date = `Withdrawal Form Received Date`,
                        pell_vs_NonPell = `Pell vs Non Pell`,
                        pell_Eligible = `Pell Eligible`,
                        fall_Coaching_Appts = `Fall Success Coaching Appts`,
                        spring_Coaching_Appts = `Spring Success Coaching Appts`,
                        total_Coaching = `Total Success Coaching Appts`,
                        gpa_spring = `Spring 2023 GPA`,
                        cred_hours_spring = `Spring 2023 GPA Credit Hours`,
                        gpa_fall = `Fall 2022 GPA`, 
                        cred_hours_fall = `Fall 2022 GPA Credit Hours`,
                        goa_fall = `Goa Grade - Fall 2022`,
                        goa_spring = `Goa Grade - Spring 2023`,
                        major = `Major at Fall 2022 Census`,
                        spring_tutoring = `Spring Tutoring Appts`,
                        fall_SI = `Fall SI Appts`,
                        spring_SI = `Spring SI Appts`) %>% 
    mutate(Year = 2022),
) %>% 
  mutate(pell_vs_NonPell = recode(pell_vs_NonPell, 'Non Pell Eligible' = 'Non Pell', 'Pell Eligible' = 'Pell'))

master$reg_spring <- as.factor(master$reg_spring)
master$reg_fall <- as.factor(master$reg_fall)
master$com_res <- as.factor(master$com_res)
master$pell_vs_NonPell <- as.factor(master$pell_vs_NonPell)
master$goa_fall <- as.factor(master$goa_fall)
master$goa_spring <- as.factor(master$goa_spring)
master$major <- as.factor(master$major)
master$Year <- as.factor(master$Year)




