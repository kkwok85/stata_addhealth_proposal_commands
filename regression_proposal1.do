

* H4LM11  currently_work_10_hrs
* H4LM12 num_jobs_10_hrs
* H4LM13 total_hrs/week_job




rename H4LM19 hrs_work_week
rename H4DA8 times_walk_exercise_week
rename H4DA6 times_gym_strength_training_week
rename H4DA1 hrs_watch_tv_week
rename H4DA22 hrs_surf_net_week
rename H4DA23 hrs_play_computer_week



rename H4DA20 access_computer
rename H4DA21 email_account
rename H4DA19 own_computer
rename H4DA9 typical_week




rename H4PE34 personality_gut_feeling
rename H4PE36 personality_not_thought_future
rename H4IR11 interviewer_remark


* control variables:
* BIO_SEX4
* H4EC3 can be put later


rename H4OD1Y year_of_birth
rename H4IR4 observed_race
rename H4ED2 highest_level_edu
rename H4EC1 household_income
rename H4EC2 personal_earnings
rename H4EC4 house_bought
rename H4EC5 mortgage
rename H4EC6 loan_for_house
rename H4EC7 asset_value
rename H4EC8 public_assistant

global control_variables "BIO_SEX4 year_of_birth observed_race highest_level_edu household_income personal_earnings mortgage loan_for_house asset_value public_assistant"

global dep_variables "hrs_work_week times_walk_exercise_week times_gym_strength_training_week hrs_watch_tv_week hrs_surf_net_week hrs_play_computer_week"

global definition "personality_not_thought_future personality_gut_feeling interviewer_remark" 






tab interviewer_remark
tab personality_not_thought_future
tab personality_gut_feeling


sum ///
hrs_work_week ///
times_walk_exercise_week /// 
times_gym_strength_training_week ///
hrs_watch_tv_week ///
hrs_surf_net_week ///
hrs_play_computer_week ///
own_computer ///
typical_week ///
$control_variables ///
interviewer_remark ///
personality_not_thought_future ///
personality_gut_feeling, separator(0) 



foreach variable2 in $dep_variables {
	twoway ///
	histogram `variable2' if (personality_not_thought_future==1) , bfcolor(none) blcolor(blue) percent || ///
	histogram `variable2' if (personality_not_thought_future==2) ,  bfcolor(none) blcolor(red) percent || ///
	histogram `variable2' if (personality_not_thought_future==3) ,  bfcolor(none) blcolor(black) percent || ///
	histogram `variable2' if (personality_not_thought_future==4) ,  bfcolor(none) blcolor(yellow) percent || ///
	histogram `variable2' if (personality_not_thought_future==5) ,  bfcolor(none) blcolor(green) percent  ///
	legend(order(1 "Strongly agree" 2 "Agree" 3 "Neutral" 4 "Disagree" 5 "Strongly disagree")) title("`variable2'")  xtitle(Time)
	graph export graph`variable2'.pdf, replace
}


foreach variable2 in $dep_variables {
	twoway ///
	histogram `variable2' if (personality_gut_feeling==1) , bfcolor(none) blcolor(blue) percent || ///
	histogram `variable2' if (personality_gut_feeling==2) ,  bfcolor(none) blcolor(red) percent || ///
	histogram `variable2' if (personality_gut_feeling==3) ,  bfcolor(none) blcolor(black) percent || ///
	histogram `variable2' if (personality_gut_feeling==4) ,  bfcolor(none) blcolor(yellow) percent || ///
	histogram `variable2' if (personality_gut_feeling==5) ,  bfcolor(none) blcolor(green) percent  ///
	legend(order(1 "Strongly agree" 2 "Agree" 3 "Neutral" 4 "Disagree" 5 "Strongly disagree")) title("`variable2'")  xtitle(Time)
	graph export graph1`variable2'_m2.pdf, replace
}


foreach variable2 in $dep_variables {
	twoway ///
	histogram `variable2' if (interviewer_remark==0), bfcolor(none) blcolor(blue) percent || ///
	histogram `variable2' if (interviewer_remark==1) ,  bfcolor(none) blcolor(red) percent ///
	legend(order(1 "Patient Agent" 2 "Impatient Agent")) title("`variable2'")  xtitle(Time)
	graph export graph1`variable2'_m3.pdf, replace
}






foreach dep in $definition {

	reg hrs_surf_net_week `dep' own_computer $control_variables
	outreg2 using result`dep', title(Result_with_measure:`dep') bdec(4) ctitle(hrs_surf_net_week) word replace	
	reg hrs_play_computer_week `dep' own_computer $control_variables
	outreg2 using result`dep', title(Result_with_measure:`dep') bdec(4) ctitle(hrs_play_computer_week) word append
	reg hrs_watch_tv_week `dep' $control_variables
	outreg2 using result`dep', title(Result_with_measure:`dep') bdec(4) ctitle(hrs_watch_tv_week) word append
	reg times_gym_strength_training_week `dep' typical_week $control_variables
	outreg2 using result`dep', title(Result_with_measure:`dep') bdec(4) ctitle(times_gym_strength_training_week) word append	
	reg times_walk_exercise_week `dep' typical_week $control_variables 
	outreg2 using result`dep', title(Result_with_measure:`dep') bdec(4) ctitle(times_walk_exercise_week) word append		
	reg hrs_work_week `dep' $control_variables
	outreg2 using result`dep', title(Result_with_measure:`dep') bdec(4) ctitle(hrs_work_week) word append		

}


foreach dep in $definition {

	reg hrs_surf_net_week `dep' 
	outreg2 using result`dep'_noc, title(Result_with_measure:`dep') bdec(4) ctitle(hrs_surf_net_week) word replace	
	reg hrs_play_computer_week `dep' 
	outreg2 using result`dep'_noc, title(Result_with_measure:`dep') bdec(4) ctitle(hrs_play_computer_week) word append
	reg hrs_watch_tv_week `dep' 
	outreg2 using result`dep'_noc, title(Result_with_measure:`dep') bdec(4) ctitle(hrs_watch_tv_week) word append
	reg times_gym_strength_training_week `dep' 
	outreg2 using result`dep'_noc, title(Result_with_measure:`dep') bdec(4) ctitle(times_gym_strength_training_week) word append	
	reg times_walk_exercise_week `dep' 
	outreg2 using result`dep'_noc, title(Result_with_measure:`dep') bdec(4) ctitle(times_walk_exercise_week) word append		
	reg hrs_work_week `dep' 
	outreg2 using result`dep'_noc, title(Result_with_measure:`dep') bdec(4) ctitle(hrs_work_week) word append		

}


















use "C:\Users\Julian.Julian-PC\Desktop\ICPSR_21600\DS0001\trial.dta", clear

merge 1:1 AID using "C:\Users\Julian.Julian-PC\Desktop\ICPSR_21600_w4\DS0023\trial.dta"

H1NM4 S13Q4


reg hrs_surf_net_week personality_not_thought_future own_computer $control_variables  H1RM1 H1RF1 S11 S17 H4TR1
reg hrs_play_computer_week personality_not_thought_future own_computer $control_variables H1RM1 H1RF1 S11 S17 H4TR1
reg hrs_watch_tv_week personality_not_thought_future own_computer $control_variables H1RM1 H1RF1 S11 S17 H4TR1
reg times_gym_strength_training_week personality_not_thought_future typical_week own_computer $control_variables H1RM1 H1RF1 S11 S17 H4TR1
reg times_walk_exercise_week personality_not_thought_future typical_week own_computer $control_variables H1RM1 H1RF1 S11 S17 H4TR1
reg hrs_work_week personality_not_thought_future own_computer $control_variables H1RM1 H1RF1 S11 S17 H4TR1


reg hrs_surf_net_week i.personality_not_thought_future own_computer typical_week $control_variables  H1RM1 H1RF1 S11 S17 H4TR1
reg hrs_play_computer_week i.personality_not_thought_future own_computer typical_week $control_variables H1RM1 H1RF1 S11 S17 H4TR1
reg hrs_watch_tv_week i.personality_not_thought_future own_computer typical_week $control_variables H1RM1 H1RF1 S11 S17 H4TR1
reg times_gym_strength_training_week i.personality_not_thought_future typical_week own_computer $control_variables H1RM1 H1RF1 S11 S17 H4TR1
reg times_walk_exercise_week i.personality_not_thought_future typical_week own_computer typical_week $control_variables H1RM1 H1RF1 S11 S17 H4TR1
reg hrs_work_week i.personality_not_thought_future own_computer typical_week $control_variables H1RM1 H1RF1 S11 S17 H4TR1


reg hrs_surf_net_week personality_not_thought_future##own_computer $control_variables  H1RM1 H1RF1 S11 S17 H4TR1
reg hrs_play_computer_week personality_not_thought_future##own_computer $control_variables H1RM1 H1RF1 S11 S17 H4TR1
reg hrs_watch_tv_week personality_not_thought_future##own_computer $control_variables H1RM1 H1RF1 S11 S17 H4TR1
reg times_gym_strength_training_week personality_not_thought_future##own_computer typical_week own_computer $control_variables H1RM1 H1RF1 S11 S17 H4TR1
reg times_walk_exercise_week personality_not_thought_future##own_computer typical_week own_computer $control_variables H1RM1 H1RF1 S11 S17 H4TR1
reg hrs_work_week personality_not_thought_future##own_computer $control_variables H1RM1 H1RF1 S11 S17 H4TR1



