clear

* Read CPS data file
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

* Assuming your existing variable is named "Week" and your panel identifier is "id"
* Set the starting date
gen start_date = daily("25 Dec 1977", "DMY")

* Calculate the date for each panel observation
gen date_variable = start_date + Week * 7

* Extract year and month for each observation
gen year_variable = year(date_variable)
gen month_variable = month(date_variable)

* Drop the intermediate variables if needed
drop start_date date_variable

* Extract year and month
gen year_variable = year(date_variable)
gen month_variable = month(date_variable)

// Reshape the data from wide to long format
//reshape long STATUS_WK_ , i(CASEID_1979) j(Week)

* Sort data by household ID, year, and month
sort CASEID_1979 Time

* Identify the panel and time variables using tsset
tsset CASEID_1979 Time

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

* Set the path for saving PNG files
local path "D:\PSID_SHELF\02_NLSY79\code\weekly\"

* Plot and save transition rate graphs
graph twoway tsline tr_emp_to_unemp, title("Transition Rate: Employment to Unemployment") ///
     ytitle("Transition Rate") xtitle("Year") 
graph export "`path'tr_emp_to_unemp.png", replace

graph twoway tsline tr_unemp_to_emp, title("Transition Rate: Unemployment to Employment") ///
     ytitle("Transition Rate") xtitle("Year") 
graph export "`path'tr_unemp_to_emp.png", replace

graph twoway tsline tr_emp_to_inac, title("Transition Rate: Employment to Inactivity") ///
     ytitle("Transition Rate") xtitle("Year") 
graph export "`path'tr_emp_to_inac.png", replace

graph twoway tsline tr_inac_to_emp, title("Transition Rate: Inactivity to Employment") ///
     ytitle("Transition Rate") xtitle("Year") 
graph export "`path'tr_inac_to_emp.png", replace

graph twoway tsline tr_unemp_to_inac, title("Transition Rate: Unemployment to Inactivity") ///
     ytitle("Transition Rate") xtitle("Year") 
graph export "`path'tr_unemp_to_inac.png", replace

graph twoway tsline tr_inac_to_unemp, title("Transition Rate: Inactivity to Unemployment") ///
     ytitle("Transition Rate") xtitle("Year") 
graph export "`path'tr_inac_to_unemp.png", replace

save transition_nlsy.dta
