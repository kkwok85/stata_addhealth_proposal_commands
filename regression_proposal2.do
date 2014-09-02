
set maxvar 32767

use "C:\Users\Julian.Julian-PC\Desktop\ICPSR_21600_w2\DS0003\trial_w2", clear


* change this remember to change file name

merge 1:1 AID using "C:\Users\Julian.Julian-PC\Desktop\ICPSR_21600_w4\DS0023\trial_w4.dta", gen(merge_w2_w4)
merge 1:1 AID using "C:\Users\Julian.Julian-PC\Desktop\ICPSR_21600\DS0001\trial_w1.dta", gen(merge_w1_w2_w4)



rename H2PF35 thought_for_future
rename H2PF20 well_coordinated

rename H2RF7 dad_work_hrs_per_week
rename H2RF8 dad_work_home_outside
rename H2RF12 dad_home_when_return


rename H2RM7 mom_work_hrs_per_week
rename H2RM8 mom_work_home_outside
rename H2RM12 mom_home_when_return


* controls:
rename H1RM1 mom_edu_level
rename H1RF1 dad_edu_level

rename H2RM4 mom_occupation
rename H2RF4 dad_occupation


rename PA55 family_income
rename H4OD1Y year_of_birth
rename H4IR4 observed_race



gen dropout = 0 if H4ED1 == 1
replace dropout = 1 if H4ED1 != 1 & H4ED1 !=.



global control_variables "BIO_SEX2 year_of_birth observed_race mom_edu_level dad_edu_level mom_occupation dad_occupation family_income"



drop if mom_home_when_return == 6 | dad_home_when_return == 6








tab dropout

tab dad_work_hrs_per_week
tab dad_home_when_return
tab mom_work_hrs_per_week
tab mom_home_when_return
tab thought_for_future
tab well_coordinated




sum dropout dad_work_hrs_per_week dad_home_when_return mom_work_hrs_per_week mom_home_when_return thought_for_future well_coordinated $control_variables, separator(0)







reg dropout i.thought_for_future dad_work_hrs_per_week   dad_work_home_outside dad_home_when_return  mom_work_hrs_per_week mom_work_home_outside mom_home_when_return $control_variables
outreg2 using result_future, title(Result wtih independent variable: thought_for_future ) bdec(4) ctitle(dropout) word replace	




reg dropout i.thought_for_future##c.dad_work_hrs_per_week   dad_work_home_outside dad_home_when_return  mom_work_hrs_per_week mom_work_home_outside mom_home_when_return $control_variables
outreg2 using result_future, title(Result wtih independent variable: thought_for_future ) bdec(4) ctitle(dropout) word append	

reg dropout i.thought_for_future##c.mom_work_hrs_per_week   dad_work_home_outside dad_home_when_return  dad_work_hrs_per_week mom_work_home_outside mom_home_when_return $control_variables
outreg2 using result_future, title(Result wtih independent variable: thought_for_future ) bdec(4) ctitle(dropout) word append  

reg dropout i.thought_for_future##i.dad_home_when_return   dad_work_home_outside dad_work_hrs_per_week  mom_work_hrs_per_week mom_work_home_outside mom_home_when_return $control_variables
outreg2 using result_future, title(Result wtih independent variable: thought_for_future ) bdec(4) ctitle(dropout) word append	


reg dropout i.thought_for_future##i.mom_home_when_return   dad_work_home_outside mom_work_hrs_per_week  dad_work_hrs_per_week mom_work_home_outside  dad_home_when_return $control_variables
outreg2 using result_future, title(Result wtih independent variable: thought_for_future ) bdec(4) ctitle(dropout) word append	



reg dropout i.well_coordinated dad_work_hrs_per_week   dad_work_home_outside dad_home_when_return  mom_work_hrs_per_week mom_work_home_outside mom_home_when_return $control_variables
outreg2 using result_well_coordinated, title(Result wtih independent variable: well_coordinated) bdec(4) ctitle(dropout) word replace 


reg dropout i.well_coordinated##c.dad_work_hrs_per_week   dad_work_home_outside dad_home_when_return  mom_work_hrs_per_week mom_work_home_outside mom_home_when_return $control_variables
outreg2 using result_well_coordinated, title(Result wtih independent variable: well_coordinated) bdec(4) ctitle(dropout) word append 

reg dropout i.well_coordinated##c.mom_work_hrs_per_week   dad_work_home_outside dad_home_when_return  dad_work_hrs_per_week mom_work_home_outside mom_home_when_return $control_variables
outreg2 using result_well_coordinated, title(Result wtih independent variable: well_coordinated) bdec(4) ctitle(dropout) word append 
	


reg dropout i.well_coordinated##i.dad_home_when_return   dad_work_home_outside dad_work_hrs_per_week  mom_work_hrs_per_week mom_work_home_outside mom_home_when_return $control_variables
outreg2 using result_well_coordinated, title(Result wtih independent variable: well_coordinated) bdec(4) ctitle(dropout) word append 
	

reg dropout i.well_coordinated##i.mom_home_when_return   dad_work_home_outside mom_work_hrs_per_week  dad_work_hrs_per_week mom_work_home_outside mom_home_when_return $control_variables
outreg2 using result_well_coordinated, title(Result wtih independent variable: well_coordinated) bdec(4) ctitle(dropout) word append 





reg H2ED13 thought_for_future  dad_work_home_outside mom_work_hrs_per_week  dad_work_hrs_per_week mom_work_home_outside  dad_home_when_return $control_variables

reg H2ED13 well_coordinated  dad_work_home_outside mom_work_hrs_per_week  dad_work_hrs_per_week mom_work_home_outside  dad_home_when_return $control_variables


