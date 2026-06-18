*===============================================================================
* transition.do   (NLSY79 — weekly)
*-------------------------------------------------------------------------------
* Project : PSID_SHELF
* Author  : Mohsen Khalili
* Purpose : Build WEEKLY Employment / Unemployment / Inactivity (E/U/I)
*           transition rates for the NLSY79 (1979) cohort.
*           Steps: tidy the weekly STATUS_WK_* status array -> set the person
*           panel with tsset -> compare each week's status to the previous week
*           -> aggregate weighted transition counts into rates.
* Input   : weekly.dta   (NLSY79 weekly labour-force-status array)
* Output  : weekly transition-rate series / graphs (see 02_NLSY79/output)
*===============================================================================

clear

* Read the NLSY79 weekly employment-status file
use "weekly.dta", clear

// List all variables
ds
// Rename variables by removing "_XRND" suffix
foreach var of varlist STATUS_WK_NUM0000_XRND - STATUS_WK_NUM2296_XRND {
    local newname : subinstr local var "_XRND" "", all
    rename `var' `newname'
}
// Confirm that variable names have been changed
ds

// List all variables
ds
// Rename variables by removing "_XRND" suffix
foreach var of varlist STATUS_WK_NUM0000 - STATUS_WK_NUM2296 {
    local newname : subinstr local var "NUM" "", all
    rename `var' `newname'
}
// Confirm that variable names have been changed
ds

//rename
forval i = 0/2296 {
    local oldvar STATUS_WK_`=string(`i', "%04.0f")'
    local newvar STATUS_WK_`i'

    rename (`oldvar') (`newvar')
}


// Reshape the data from wide to long format
//reshape long STATUS_WK_ , i(CASEID_1979) j(Week)

* Sort data by household ID, year, and month
sort CASEID_1979 date

* Identify the panel and time variables using tsset
tsset CASEID_1979 date

* Create a lagged variable for employment status within each household
by CASEID_1979: gen STATUS_WK_LAG = STATUS_WK[_n-1] if _n > 1

egen sum_weight_lag_emp = total(weight) if (STATUS_WK_LAG >= 100 & STATUS_WK_LAG <= 2915) | STATUS_WK_LAG == 3 | STATUS_WK_LAG == 7, by(Week)

egen sum_weight_lag_unemp = total(weight) if STATUS_WK_LAG == 2 | STATUS_WK_LAG == 4, by(Week)

egen sum_weight_lag_inac = total(weight) if STATUS_WK_LAG == 5, by(Week)

* Create transition variables
gen emp_to_unemp = ( (STATUS_WK_LAG >= 100 & STATUS_WK_LAG <= 2915) | STATUS_WK_LAG == 3 | STATUS_WK_LAG == 7 ) & (STATUS_WK == 2 | STATUS_WK == 4)

gen unemp_to_emp = (STATUS_WK_LAG == 2 | STATUS_WK_LAG == 4) & ( (STATUS_WK >= 100 & STATUS_WK <= 2915) | STATUS_WK == 3 | STATUS_WK == 7 )

gen emp_to_inac = ( (STATUS_WK_LAG >= 100 & STATUS_WK_LAG <= 2915) | STATUS_WK_LAG == 3 | STATUS_WK_LAG == 7 ) & (STATUS_WK == 5)

gen inac_to_emp = (STATUS_WK_LAG == 5) & ( (STATUS_WK >= 100 & STATUS_WK <= 2915) | STATUS_WK == 3 | STATUS_WK == 7 )

gen unemp_to_inac = (STATUS_WK_LAG == 2 | STATUS_WK_LAG == 4) & (STATUS_WK == 5)

gen inac_to_unemp = (STATUS_WK_LAG == 5) & (STATUS_WK == 2 | STATUS_WK == 4)


* Calculate sum of weights for transitions by Week
egen sum_weight_emp_to_unemp = total(weight * emp_to_unemp), by(Week)
egen sum_weight_unemp_to_emp = total(weight * unemp_to_emp), by(Week)
egen sum_weight_emp_to_inac = total(weight * emp_to_inac), by(Week)
egen sum_weight_inac_to_emp = total(weight * inac_to_emp), by(Week)
egen sum_weight_unemp_to_inac = total(weight * unemp_to_inac), by(Week)
egen sum_weight_inac_to_unemp = total(weight * inac_to_unemp), by(Week)

* Calculate transition rates with weights
gen tr_emp_to_unemp = - ln(1 - (sum_weight_emp_to_unemp / sum_weight_lag_emp))
gen tr_unemp_to_emp = - ln(1 - (sum_weight_unemp_to_emp / sum_weight_lag_unemp))
gen tr_emp_to_inac = - ln(1 - (sum_weight_emp_to_inac / sum_weight_lag_emp))
gen tr_inac_to_emp = - ln(1 - (sum_weight_inac_to_emp / sum_weight_lag_inac))
gen tr_unemp_to_inac = - ln(1 - (sum_weight_unemp_to_inac / sum_weight_lag_unemp))
gen tr_inac_to_unemp = - ln(1 - (sum_weight_inac_to_unemp / sum_weight_lag_inac))

local path "D:\PSID_SHELF\02_NLSY79\code\weekly\"

* Plot Transition Rate: Employment to Unemployment
tsline tr_emp_to_unemp_quarter_mean, ///
       title("Transition Rate: Employment to Unemployment") ///
       xtitle("Year") ytitle("Mean Transition Rate") ///
       legend(off)

* Save the plot
graph export "`path'tr_emp_to_unemp_quarterly.png", replace

* Plot Transition Rate: Unemployment to Employment
tsline tr_unemp_to_emp_quarter_mean, ///
       title("Transition Rate: Unemployment to Employment") ///
       xtitle("Year") ytitle("Mean Transition Rate") ///
       legend(off)

* Save the plot
graph export "`path'tr_unemp_to_emp_quarterly.png", replace

* Plot Transition Rate: Employment to Inactivity
tsline tr_emp_to_inac_quarter_mean, ///
       title("Transition Rate: Employment to Inactivity") ///
       xtitle("Year") ytitle("Mean Transition Rate") ///
       legend(off)

* Save the plot
graph export "`path'tr_emp_to_inac_quarterly.png", replace

* Plot Transition Rate: Inactivity to Employment
tsline tr_inac_to_emp_quarter_mean, ///
       title("Transition Rate: Inactivity to Employment") ///
       xtitle("Year") ytitle("Mean Transition Rate") ///
       legend(off)

* Save the plot
graph export "`path'tr_inac_to_emp_quarterly.png", replace

* Plot Transition Rate: Unemployment to Inactivity
tsline tr_unemp_to_inac_quarter_mean, ///
       title("Transition Rate: Unemployment to Inactivity") ///
       xtitle("Year") ytitle("Mean Transition Rate") ///
       legend(off)

* Save the plot
graph export "`path'tr_unemp_to_inac_quarterly.png", replace

* Plot Transition Rate: Inactivity to Unemployment
tsline tr_inac_to_unemp_quarter_mean, ///
       title("Transition Rate: Inactivity to Unemployment") ///
       xtitle("Year") ytitle("Mean Transition Rate") ///
       legend(off)

* Save the plot
graph export "`path'tr_inac_to_unemp_quarterly.png", replace

***********************************************************

* Convert the week variable into a Stata date format
gen date = mdy(1, 1, 1977) + 7 * Week

* Extract the year and month components from the date
format date %td
gen year = year(date)
gen month = month(date)

* Format year and month as a single variable
gen year_month = ym(year, month)

* Drop the intermediate variables if not needed
drop date year month

***********************************************************

clear
use fed.dta
gen mydate_numeric = date(date, "YMD")
drop date
rename mydate_numeric date
merge 1:m date using "D:\PSID_SHELF\02_NLSY79\code\weekly\month_sabook.dta"
format date %td
tsset CASEID_1979 date
* Compare employment_rate by EMP and unemployment_rate by UNRATE
graph twoway (tsline employment_rate, color(blue) legend(label(1 "Employment Rate (NLSY)"))) ///
             (tsline EMP, color(red) legend(label(2 "Employment Rate (FED)"))), ///
    title("Comparison of Employment Rate") ///
    ytitle("Percentage (%)") xtitle("Month") 
graph export "D:\PSID_SHELF\02_NLSY79\code\weekly\employment_rate_vs_EMP.png", replace

* Compare unemployment_rate by UNRATE
graph twoway (tsline unemployment_rate, color(blue) legend(label(1 "Unemployment Rate (NLSY)"))) ///
             (tsline UNRATE, color(red)legend(label(2 "Unemployment Rate (FED)"))), ///
    title("Comparison of Unemployment Rate") ///
    ytitle("Percentage (%)") xtitle("Month") 
graph export "D:\PSID_SHELF\02_NLSY79\code\weekly\unemployment_rate_vs_UNRATE.png", replace

* Compare CIVPART by employment_rate
graph twoway (tsline CIVPART, color(blue)legend(label(1 "Inactivity Rate (NLSY)"))) ///
             (tsline participation_rate, color(red)legend(label(2 "Inactivity Rate(FED)"))), ///
    title("Comparison of Inactivity Rate") ///
    ytitle("Percentage (%)") xtitle("Month") 
graph export "D:\PSID_SHELF\02_NLSY79\code\weekly\CIVPART_vs_participationy_rate.png", replace



***********************************************************

* Calculate weekly mean for tr_emp_to_unemp
egen tr_emp_to_unemp_week_mean = mean(tr_emp_to_unemp), by(month year)

* Calculate weekly mean for tr_unemp_to_emp
egen tr_unemp_to_emp_week_mean = mean(tr_unemp_to_emp), by(month year)

* Calculate weekly mean for tr_emp_to_inac
egen tr_emp_to_inac_week_mean = mean(tr_emp_to_inac), by(month year)

* Calculate weekly mean for tr_inac_to_emp
egen tr_inac_to_emp_week_mean = mean(tr_inac_to_emp), by(month year)

* Calculate weekly mean for tr_unemp_to_inac
egen tr_unemp_to_inac_week_mean = mean(tr_unemp_to_inac), by(month year)

* Calculate weekly mean for tr_inac_to_unemp
egen tr_inac_to_unemp_week_mean = mean(tr_inac_to_unemp), by(month year)

* Plot and save transition rate graphs for weekly means
graph twoway tsline tr_emp_to_unemp_week_mean, title("Transition Rate: Employment to Unemployment") ///
     ytitle("Transition Rate") xtitle("Year") 
graph export "`path'tr_emp_to_unemp_week_mean.png", replace

graph twoway tsline tr_unemp_to_emp_week_mean, title("Transition Rate: Unemployment to Employment") ///
     ytitle("Transition Rate") xtitle("Year") 
graph export "`path'tr_unemp_to_emp_week_mean.png", replace

graph twoway tsline tr_emp_to_inac_week_mean, title("Transition Rate: Employment to Inactivity") ///
     ytitle("Transition Rate") xtitle("Year") 
graph export "`path'tr_emp_to_inac_week_mean.png", replace

graph twoway tsline tr_inac_to_emp_week_mean, title("Transition Rate: Inactivity to Employment") ///
     ytitle("Transition Rate") xtitle("Year") 
graph export "`path'tr_inac_to_emp_week_mean.png", replace

graph twoway tsline tr_unemp_to_inac_week_mean, title("Transition Rate: Unemployment to Inactivity") ///
     ytitle("Transition Rate") xtitle("Year") 
graph export "`path'tr_unemp_to_inac_week_mean.png", replace

graph twoway tsline tr_inac_to_unemp_week_mean, title("Transition Rate: Inactivity to Unemployment") ///
     ytitle("Transition Rate") xtitle("Year") 
graph export "`path'tr_inac_to_unemp_week_mean.png", replace


***********************************************************

gen quarter = qofd(date)

egen tr_emp_to_unemp_quarter_mean = mean(tr_emp_to_unemp), by(year quarter)
egen tr_unemp_to_emp_quarter_mean = mean(tr_unemp_to_emp), by(year quarter)
egen tr_emp_to_inac_quarter_mean = mean(tr_emp_to_inac), by(year quarter)
egen tr_inac_to_emp_quarter_mean = mean(tr_inac_to_emp), by(year quarter)
egen tr_unemp_to_inac_quarter_mean = mean(tr_unemp_to_inac), by(year quarter)
egen tr_inac_to_unemp_quarter_mean = mean(tr_inac_to_unemp), by(year quarter)

* Plot Transition Rate: Employment to Unemployment and save
twoway (line tr_emp_to_unemp_quarter_mean year, ///
           title("Transition Rate: Employment to Unemployment") ///
           xtitle("Year") ytitle("Mean Transition Rate") ///
           legend(label(1 "Quarterly Mean")))

graph export "tr_emp_to_unemp_quarterly.png", replace

* Plot Transition Rate: Unemployment to Employment and save
twoway (line tr_unemp_to_emp_quarter_mean year, ///
           title("Transition Rate: Unemployment to Employment") ///
           xtitle("Year") ytitle("Mean Transition Rate") ///
           legend(label(1 "Quarterly Mean")))

graph export "tr_unemp_to_emp_quarterly.png", replace

* Plot Transition Rate: Employment to Inactivity and save
twoway (line tr_emp_to_inac_quarter_mean year, ///
           title("Transition Rate: Employment to Inactivity") ///
           xtitle("Year") ytitle("Mean Transition Rate") ///
           legend(label(1 "Quarterly Mean")))

graph export "tr_emp_to_inac_quarterly.png", replace

* Plot Transition Rate: Inactivity to Employment and save
twoway (line tr_inac_to_emp_quarter_mean year, ///
           title("Transition Rate: Inactivity to Employment") ///
           xtitle("Year") ytitle("Mean Transition Rate") ///
           legend(label(1 "Quarterly Mean")))

graph export "tr_inac_to_emp_quarterly.png", replace

* Plot Transition Rate: Unemployment to Inactivity and save
twoway (line tr_unemp_to_inac_quarter_mean year, ///
           title("Transition Rate: Unemployment to Inactivity") ///
           xtitle("Year") ytitle("Mean Transition Rate") ///
           legend(label(1 "Quarterly Mean")))

graph export "tr_unemp_to_inac_quarterly.png", replace

* Plot Transition Rate: Inactivity to Unemployment and save
twoway (line tr_inac_to_unemp_quarter_mean year, ///
           title("Transition Rate: Inactivity to Unemployment") ///
           xtitle("Year") ytitle("Mean Transition Rate") ///
           legend(label(1 "Quarterly Mean")))

graph export "tr_inac_to_unemp_quarterly.png", replace


***********************************************************


// Step 1: Load the dataset
use "D:/PSID_SHELF/02_NLSY79/code/weekly/nlsy_final.dta", clear

// Step 2: Calculate the sum of weights for employed individuals for each week of the month
egen sum_weight_emp_week = total(weight) if (STATUS_WK >= 100 & STATUS_WK <= 2915), by(year month Week)

// Step 3: Calculate the sum of weights for unemployed individuals for each week of the month
egen sum_weight_unemp_week = total(weight) if (STATUS_WK >= 2 & STATUS_WK <= 4), by(year month Week)

// Step 4: Calculate the sum of weights for individuals who are out of the labor force for each week of the month
egen sum_weight_inactivity_week = total(weight) if (STATUS_WK == 5 | STATUS_WK == 7), by(year month Week)

// Step 5: Calculate the total weight for each week of the month
egen total_weight_week = total(weight), by(year month Week)

// Step 6: Calculate participation weight for each week of the month
egen participation_weight_week = total(weight) if (STATUS_WK >= 100 & STATUS_WK <= 2915 | STATUS_WK >= 2 & STATUS_WK <= 4), by(year month Week)

// Step 7: Calculate employment rate, unemployment rate, and participation rate for each week of the month
gen employment_rate_week = (sum_weight_emp_week / participation_weight_week) * 100
gen unemployment_rate_week = (sum_weight_unemp_week / participation_weight_week) * 100
gen participation_rate_week = (participation_weight_week / total_weight_week) * 100
gen inactivity_rate_week = (sum_weight_inactivity_week / total_weight_week) * 100

tsset CASEID_1979 date

duplicates drop inactivity_rate_week employment_rate_week unemployment_rate_week participation_rate_week,force

* Step 8: Plot each rate in a separate window and save as image files
graph twoway (tsline employment_rate_week), title("Employment Rate") ///
    ytitle("Employment Rate (%)") xtitle("Week") 
graph export "D:\PSID_SHELF\02_NLSY79\code\weekly\employment_rate_week.png", replace

graph twoway (tsline unemployment_rate_week), title("Unemployment Rate") ///
    ytitle("Unemployment Rate (%)") xtitle("Week") 
graph export "D:\PSID_SHELF\02_NLSY79\code\weekly\unemployment_rate_week.png", replace

graph twoway (tsline participation_rate_week), title("Participation Rate") ///
    ytitle("Participation Rate (%)") xtitle("Week")
graph export "D:\PSID_SHELF\02_NLSY79\code\weekly\participation_rate_week.png", replace

graph twoway (tsline employment_rate_week), title("Inactivity Rate") ///
    ytitle("Employment Rate (%)") xtitle("Week") 
graph export "D:\PSID_SHELF\02_NLSY79\code\weekly\inactivity_rate_week.png", replace

save month_sabook.dta,replace


use fed.dta
gen mydate_numeric = date(date, "YMD")
drop date
rename mydate_numeric date
merge 1:m date using "D:\PSID_SHELF\02_NLSY79\code\weekly\month_sabook.dta"
format date %td
tsset CASEID_1979 date
* Compare employment_rate by EMP and unemployment_rate by UNRATE
graph twoway (tsline employment_rate, color(blue) legend(label(1 "Employment Rate (NLSY)"))) ///
             (tsline EMP, color(red) legend(label(2 "Employment Rate (FED)"))), ///
    title("Comparison of Employment Rate") ///
    ytitle("Percentage (%)") xtitle("Month") 
graph export "D:\PSID_SHELF\02_NLSY79\code\weekly\employment_rate_vs_EMP.png", replace

* Compare unemployment_rate by UNRATE
graph twoway (tsline unemployment_rate, color(blue) legend(label(1 "Unemployment Rate (NLSY)"))) ///
             (tsline UNRATE, color(red)legend(label(2 "Unemployment Rate (FED)"))), ///
    title("Comparison of Unemployment Rate") ///
    ytitle("Percentage (%)") xtitle("Month") 
graph export "D:\PSID_SHELF\02_NLSY79\code\weekly\unemployment_rate_vs_UNRATE.png", replace

* Compare CIVPART by employment_rate
graph twoway (tsline CIVPART, color(blue)legend(label(1 "Inactivity Rate (NLSY)"))) ///
             (tsline participation_rate, color(red)legend(label(2 "Inactivity Rate(FED)"))), ///
    title("Comparison of Inactivity Rate") ///
    ytitle("Percentage (%)") xtitle("Month") 
graph export "D:\PSID_SHELF\02_NLSY79\code\weekly\CIVPART_vs_participationy_rate.png", replace

***********************************************************