* Clear existing data
clear

* Read CPS data file
use "cps.dta", clear

* Keep observations where cpsidv > 0 (uncomment if needed)
keep if cpsidv > 0

* Sort data by household ID, year, and month
sort year month cpsidv

* Create a time variable
gen time = date("01/" + string(month) + "/" + string(year), "DMY")
format time %td

* Identify and drop duplicate observations within panels
duplicates drop year month cpsidv, force

* Identify the panel and time variables using tsset
tsset cpsidv time

* Create a lagged variable for employment status within each household
by cpsidv: gen lag_emp_status_cps = empstat[_n-1] if _n > 1

* Calculate sum of weights for transitions by month
egen sum_weight_lag_unemp_cps = total(wtfinl) if lag_emp_status_cps >= 20 & lag_emp_status_cps <= 22, by(year month)
egen sum_weight_lag_emp_cps = total(wtfinl) if lag_emp_status_cps == 1 | lag_emp_status_cps == 10 | lag_emp_status_cps == 12, by(year month)
egen sum_weight_lag_inac_cps = total(wtfinl) if lag_emp_status_cps >= 30 & lag_emp_status_cps <= 36, by(year month)

* Create transition variables
gen emp_to_unemp_cps = (lag_emp_status_cps == 1 | lag_emp_status_cps == 10 | lag_emp_status_cps == 12) & (empstat >= 20 & empstat <= 22)

gen unemp_to_emp_cps = (lag_emp_status_cps >= 20 & lag_emp_status_cps <= 22) & (empstat == 1 | empstat == 10 | empstat == 12)

gen emp_to_inac_cps = (lag_emp_status_cps == 1 | lag_emp_status_cps == 10 | lag_emp_status_cps == 12) & (empstat >= 30 & empstat <= 36)

gen inac_to_emp_cps = (lag_emp_status_cps >= 30 & lag_emp_status_cps <= 36) & (empstat == 1 | empstat == 10 | empstat == 12)

gen unemp_to_inac_cps = (lag_emp_status_cps >= 20 & lag_emp_status_cps <= 22) & (empstat >= 30 & empstat <= 36)

gen inac_to_unemp_cps = (lag_emp_status_cps >= 30 & lag_emp_status_cps <= 36) & (empstat >= 20 & empstat <= 22)

* Calculate sum of weights for transitions by month
egen sum_weight_emp_to_unemp_cps = total(wtfinl * emp_to_unemp_cps), by(year month)
egen sum_weight_unemp_to_emp_cps = total(wtfinl * unemp_to_emp_cps), by(year month)
egen sum_weight_emp_to_inac_cps = total(wtfinl * emp_to_inac_cps), by(year month)
egen sum_weight_inac_to_emp_cps = total(wtfinl * inac_to_emp_cps), by(year month)
egen sum_weight_unemp_to_inac_cps = total(wtfinl * unemp_to_inac_cps), by(year month)
egen sum_weight_inac_to_unemp_cps = total(wtfinl * inac_to_unemp_cps), by(year month)

* Calculate transition rates with weights
gen tr_emp_to_unemp_cps = -ln(1 - (sum_weight_emp_to_unemp_cps / sum_weight_lag_emp_cps))
gen tr_unemp_to_emp_cps = -ln(1 - (sum_weight_unemp_to_emp_cps / sum_weight_lag_unemp_cps))
gen tr_emp_to_inac_cps = -ln(1 - (sum_weight_emp_to_inac_cps / sum_weight_lag_emp_cps))
gen tr_inac_to_emp_cps = -ln(1 - (sum_weight_inac_to_emp_cps / sum_weight_lag_inac_cps))
gen tr_unemp_to_inac_cps = -ln(1 - (sum_weight_unemp_to_inac_cps / sum_weight_lag_unemp_cps))
gen tr_inac_to_unemp_cps = -ln(1 - (sum_weight_inac_to_unemp_cps / sum_weight_lag_inac_cps))

duplicates drop tr_emp_to_unemp_cps tr_unemp_to_emp_cps tr_emp_to_inac_cps tr_inac_to_emp_cps tr_unemp_to_inac_cps tr_inac_to_unemp_cps, force

* Plot the time series of transition rates and save each graph as PNG
local path "D:\PSID_SHELF\04_CPS\CPS-MINE\"
graph twoway tsline tr_emp_to_unemp_cps, title("Transition Rate: Employment to Unemployment") ///
     ytitle("Transition Rate") xtitle("Year") 
graph export "`path'tr_emp_to_unemp_cps.png", replace

graph twoway tsline tr_unemp_to_emp_cps, title("Transition Rate: Unemployment to Employment") ///
     ytitle("Transition Rate") xtitle("Year") 
graph export "`path'tr_unemp_to_emp_cps.png", replace

graph twoway tsline tr_emp_to_inac_cps, title("Transition Rate: Employment to Inactivity") ///
     ytitle("Transition Rate") xtitle("Year") 
graph export "`path'tr_emp_to_inac_cps.png", replace

graph twoway tsline tr_inac_to_emp_cps, title("Transition Rate: Inactivity to Employment") ///
     ytitle("Transition Rate") xtitle("Year") 
graph export "`path'tr_inac_to_emp_cps.png", replace

graph twoway tsline tr_unemp_to_inac_cps, title("Transition Rate: Unemployment to Inactivity") ///
     ytitle("Transition Rate") xtitle("Year") 
graph export "`path'tr_unemp_to_inac_cps.png", replace

graph twoway tsline tr_inac_to_unemp_cps, title("Transition Rate: Inactivity to Unemployment") ///
     ytitle("Transition Rate") xtitle("Year") 
graph export "`path'tr_inac_to_unemp_cps.png", replace
***********************************************************

tsset CASEID_1979 date


twoway (tsline tr_emp_to_unemp_cps, lcolor(blue) lpattern(solid) legend(label(1 "CPS"))) ///
       (tsline tr_emp_to_unemp_week_mean, lcolor(red) lpattern(solid) legend(label(2 "NLSY97"))), ///
       title("Comparison of Employment to Unemployment Transition Rates") ///
       ytitle("Transition Rate") xtitle("Date") ///
       legend(cols(1) pos(11)) ///
       name(emp_to_unemp_graph, replace)

local path "D:\PSID_SHELF\04_CPS\CPS-MINE\"
graph export "`path'comparison_emp_to_unemp_transition_rates.png", replace

twoway (tsline tr_unemp_to_emp_cps, lcolor(blue) lpattern(solid) legend(label(1 "CPS"))) ///
       (tsline tr_unemp_to_emp_week_mean, lcolor(red) lpattern(solid) legend(label(2 "NLSY97"))), ///
       title("Comparison of Unemployment to Employment Transition Rates") ///
       ytitle("Transition Rate") xtitle("Date") ///
       legend(cols(1) pos(11)) ///
       name(unemp_to_emp_graph, replace)

graph export "`path'comparison_unemp_to_emp_transition_rates.png", replace

twoway (tsline tr_emp_to_inac_cps, lcolor(blue) lpattern(solid) legend(label(1 "CPS"))) ///
       (tsline tr_emp_to_inac_week_mean, lcolor(red) lpattern(solid) legend(label(2 "NLSY97"))), ///
       title("Comparison of Employment to Inactivity Transition Rates") ///
       ytitle("Transition Rate") xtitle("Date") ///
       legend(cols(1) pos(11)) ///
       name(emp_to_inac_graph, replace)

graph export "`path'comparison_emp_to_inac_transition_rates.png", replace

twoway (tsline tr_inac_to_emp_cps, lcolor(blue) lpattern(solid) legend(label(1 "CPS"))) ///
       (tsline tr_inac_to_emp_week_mean, lcolor(red) lpattern(solid) legend(label(2 "NLSY97"))), ///
       title("Comparison of Inactivity to Employment Transition Rates") ///
       ytitle("Transition Rate") xtitle("Date") ///
       legend(cols(1) pos(11)) ///
       name(inac_to_emp_graph, replace)

graph export "`path'comparison_inac_to_emp_transition_rates.png", replace

twoway (tsline tr_unemp_to_inac_cps, lcolor(blue) lpattern(solid) legend(label(1 "CPS"))) ///
       (tsline tr_unemp_to_inac_week_mean, lcolor(red) lpattern(solid) legend(label(2 "NLSY97"))), ///
       title("Comparison of Unemployment to Inactivity Transition Rates") ///
       ytitle("Transition Rate") xtitle("Date") ///
       legend(cols(1) pos(11)) ///
       name(unemp_to_inac_graph, replace)

graph export "`path'comparison_unemp_to_inac_transition_rates.png", replace

twoway (tsline tr_inac_to_unemp_cps, lcolor(blue) lpattern(solid) legend(label(1 "CPS"))) ///
       (tsline tr_inac_to_unemp_week_mean, lcolor(red) lpattern(solid) legend(label(2 "NLSY97"))), ///
       title("Comparison of Inactivity to Unemployment Transition Rates") ///
       ytitle("Transition Rate") xtitle("Date") ///
       legend(cols(1) pos(11)) ///
       name(inac_to_unemp_graph, replace)

graph export "`path'comparison_inac_to_unemp_transition_rates.png", replace

