
*===============================================================================
* psid_transition.do
*-------------------------------------------------------------------------------
* Project : PSID_SHELF
* Author  : Mohsen Khalili
* Purpose : Turn a raw PSID extract into a usable employment panel. First rename
*           the cryptic PSID variable codes (ER....) to readable names per wave
*           (age, sex, employment_status, labor_income, wages, wealth, weight),
*           then build Employment / Unemployment / Inactivity (E/U/I) transition
*           rates over time.
* Input   : a wide PSID extract in memory (raw ER... variables, 1997-2021 waves)
* Output  : labelled variables + E/U/I transition-rate series
*===============================================================================

rename ER10001 fam_release_1997
rename ER10002 fam_interview_1997
rename ER10009 age_1997
rename ER10010 sex_1997
rename ER10081 employment_status_1997
rename ER12080 labor_income_head_1997
rename ER12084 weight_1997
rename ER12196 wages_salaries_1997
rename ER12217 wage_rate_1997


rename ER13001 release_number_1999
rename ER13002 interview_id_1999
rename ER13010 age_1999
rename ER13011 sex_1999
rename ER13205 employment_status_1999
rename ER16463 labor_income_1999
rename ER16493 wages_salaries_1999
rename ER16514 wage_rate_1999
rename ER16518 weight_1999
rename S417 wealth_1999

rename ER17001 release_number_2001
rename ER17002 interview_id_2001
rename ER17013 age_2001
rename ER17014 sex_2001
rename ER17216 employment_status_2001
rename ER20394 fam_weight_2001
rename ER20425 wages_salaries_2001
rename ER20443 labor_income_2001
rename ER20451 wage_rate_2001
rename S517 wealth_2001

rename ER21001 release_number_2003
rename ER21002 interview_id_2003
rename ER21017 age_2003
rename ER21018 sex_2003
rename ER21123 employment_status_2003
rename ER23478 occupation_2003
rename ER23479 industry_2003
rename ER24116 labor_income_2003
rename ER24117 wages_2003
rename ER24137 wage_rate_2003
rename ER24179 weight_2003
rename S617 wealth_2003

rename ER25001 release_number_2005
rename ER25002 interview_id_2005
rename ER25017 age_2005
rename ER25018 sex_2005
rename ER25104 employment_status_2005
rename ER27446 occupation_2005
rename ER27447 industry_2005
rename ER27913 wages_salaries_2005
rename ER27931 labor_income_2005
rename ER28003 wage_rate_2005
rename ER28078 weight_2005
rename S717 wealth_2005

rename ER36001 release_number_2007
rename ER36002 interview_id_2007
rename ER36017 age_2007
rename ER36018 sex_2007
rename ER36109 employment_status_2007
rename ER40618 occupation_2007
rename ER40619 industry_2007
rename ER40903 wages_salaries_2007
rename ER40921 labor_income_2007
rename ER40993 wage_rate_2007
rename ER41069 weight_2007
rename S817 wealth_2007

rename ER42001 release_number_2009
rename ER42002 interview_id_2009
rename ER42017 age_2009
rename ER42018 sex_2009
rename ER42140 employment_status_2009
rename ER46596 occupation_2009
rename ER46597 industry_2009
rename ER46811 wages_salaries_2009
rename ER46829 labor_income_2009
rename ER46901 head_wage_rate_2009
rename ER46970 wealth_2009
rename ER47012 weight_2009

rename ER47301 release_number_2011
rename ER47302 interview_id_2011
rename ER47317 age_2011
rename ER47318 sex_2011
rename ER47448 employment_status_2011
rename ER51957 occupation_2011
rename ER51958 industry_2011
rename ER52219 wages_salaries_2011
rename ER52237 labor_income_2011
rename ER52309 wage_rate_2011
rename ER52394 wealth_2011
rename ER52436 weight_2011

rename ER53001 release_number_2013
rename ER53002 interview_id_2013
rename ER53017 age_2013
rename ER53018 sex__2013
rename ER53148 employment_status_2013
rename ER57713 occupation_2013
rename ER57714 industry_2013
rename ER58020 wages_salaries_2013
rename ER58038 labor_income_2013
rename ER58118 wage_rate_2013
rename ER58211 wealth_2013
rename ER58257 weight_2013


rename ER60001 release_number_2015
rename ER60002 interview_id_2015
rename ER60017 age_2015
rename ER60018 sex_2015
rename ER60163 employment_status_2015
rename ER64873 occupation_2015
rename ER64874 industry_2015
rename ER65200 wages_salaries_2015
rename ER65216 labor_income_2015
rename ER65315 wage_rate_2015
rename ER65408 wealth_2015
rename ER65492 weight_2015


rename ER66001 release_number_2017
rename ER66002 interview_id_2017
rename ER66017 age_2017
rename ER66018 sex_2017
rename ER66164 employment_status_2017
rename ER70945 occupation_2017
rename ER70946 industry_2017
rename ER71277 wages_salaries_2017
rename ER71293 labor_income_2017
rename ER71392 wage_rate_2017
rename ER71485 wealth_2017
rename ER71570 weight_2017


rename ER72001 release_number_2019
rename ER72002 interview_id_2019
rename ER72017 age_2019
rename ER72018 sex_2019
rename ER72164 employment_status_2019
rename ER76963 occupation_2019
rename ER76964 industry_2019
rename ER77299 wages_salaries_2019
rename ER77315 labor_income_2019
rename ER77414 wage_rate_2019
rename ER77511 wealth_2019
rename ER77631 weight_2019


rename ER78001 release_number_2021
rename ER78002 interview_id_2021
rename ER78017 age_2021
rename ER78018 sex_2021
rename ER78167 employment_status_2021
rename ER81191 occupation_2021
rename ER81192 industry_2021
rename ER81626 wages_salaries_2021
rename ER81642 labor_income_2021
rename ER81741 wage_rate_2021
rename ER81838 wealth_2021
rename ER81958 weight_2021


rename ER13019 id_1997
rename ER17022 id_1999
rename ER21009 id_2001
rename ER25009 id_2003
rename ER36009 id_2005
rename ER42009 id_2007
rename ER47309 id_2009
rename ER53009 id_2011
rename ER60009 id_2013
rename ER66009 id_2015
rename ER72009 id_2017
rename ER78009 id_2019


rename sex__2013 sex_2013
rename interview_1997 interview_id_1997
rename release_1997 release_number_1997
rename fam_interview_1997 interview_1997
rename fam_release_1997 release_1997 
rename fam_weight_2001 weight_2001
rename head_wage_rate_2009 wage_rate_2009
rename wages_2003 wages_salaries_2003
rename labor_income_head_1997 labor_income_1997

// Generate an identifier variable
gen ID = _n

// Reshape from wide to long format
reshape long  sex_ age_ employment_status_ id_ industry_ interview_id_ labor_income_ occupation_ release_number_ sex_2013 wage_rate_ wages_salaries_ weight_, i(ID) j(year)

// Sort the dataset by id_ and year
sort ID year



***********************************************************
gen time = date("01/" + "Jan/" + string(year), "DMY")
format time %td

* Sort data by ID and year
sort ID time

* Create a lagged variable for employment_status within each ID
by ID: gen lag_emp_status = employment_status[_n-1] if _n > 1

* Calculate sum of weights for lag_employment_status = 3 by year
egen sum_weight_lag_unemp = total(weight_ * (lag_emp_status == 3)), by(year)

* Calculate sum of weights for lag_employment_status = 1 or 2 by year
egen sum_weight_lag_emp = total(weight_ * inlist(lag_emp_status, 1, 2)), by(year)

* Calculate sum of weights for lag_employment_status = 4 or 5 or 6 or 7 or 8 by year
egen sum_weight_lag_inac = total(weight_ * inlist(lag_emp_status, 4, 5, 6, 7, 8)), by(year)

* Create transition variables
gen emp_to_unemp = (lag_emp_status == 1 | lag_emp_status == 2) & (employment_status == 3)
gen unemp_to_emp = (lag_emp_status == 3) & inlist(employment_status, 1, 2)
gen emp_to_inac = (lag_emp_status == 1 | lag_emp_status == 2) & inlist(employment_status, 4, 5, 6, 7, 8)
gen inac_to_emp = inlist(lag_emp_status, 4, 5, 6, 7, 8) & inlist(employment_status, 1, 2)
gen unemp_to_inac = (lag_emp_status == 3) & inlist(employment_status, 4, 5, 6, 7, 8)
gen inac_to_unemp = inlist(lag_emp_status, 4, 5, 6, 7, 8) & (employment_status == 3)

* Calculate sum of weights for transitions by year
egen sum_weight_emp_to_unemp_by_year = total(weight_ * emp_to_unemp), by(year)
egen sum_weight_unemp_to_emp_by_year = total(weight_ * unemp_to_emp), by(year)
egen sum_weight_emp_to_inac_by_year = total(weight_ * emp_to_inac), by(year)
egen sum_weight_inac_to_emp_by_year = total(weight_ * inac_to_emp), by(year)
egen sum_weight_unemp_to_inac_by_year = total(weight_ * unemp_to_inac), by(year)
egen sum_weight_inac_to_unemp_by_year = total(weight_ * inac_to_unemp), by(year)

* Calculate transition rates with weights
gen tr_emp_to_unemp = - ln(1 - (sum_weight_emp_to_unemp_by_year / sum_weight_lag_emp))
gen tr_unemp_to_emp = - ln(1 - (sum_weight_unemp_to_emp_by_year / sum_weight_lag_unemp))
gen tr_emp_to_inac = - ln(1 - (sum_weight_emp_to_inac_by_year / sum_weight_lag_emp))
gen tr_inac_to_emp = - ln(1 - (sum_weight_inac_to_emp_by_year / sum_weight_lag_inac))
gen tr_unemp_to_inac = - ln(1 - (sum_weight_unemp_to_inac_by_year / sum_weight_lag_unemp))
gen tr_inac_to_unemp = - ln(1 - (sum_weight_inac_to_unemp_by_year / sum_weight_lag_inac))

* Set time series data
tsset ID time

* Plot the time series of transition rates and save each graph as PNG
local path "D:\PSID_SHELF\01_PSID\"
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

*************************************************

egen weighted_sum_employe = total(weight_) if (employment_status == 1 | employment_status == 2) & age_ >= 15 , by(year)
egen weighted_sum_unemployed = total(weight_) if (employment_status == 3) & age_ >= 15 , by(year)
egen weighted_sum_inactive = total(weight_) if (employment_status >= 4 & employment_status <= 8) & age_ >= 15 , by(year)
egen weighted_sum_onactive = total(weight_) if (employment_status >= 1 & employment_status <= 3) & age_ >= 15 , by(year)
egen weighted_sum_total = total(weight_) if (employment_status >= 1 & employment_status <= 8) & age_ >= 15, by(year)

gen unemployed_rate = (weighted_sum_unemployed / weighted_sum_onactive) * 100
gen employment_rate = (weighted_sum_employe / weighted_sum_total) * 100
gen onactive_rate = (weighted_sum_onactive / weighted_sum_total) * 100
gen inactive_rate = (weighted_sum_inactive / weighted_sum_total) * 100


gen unemployed_rate_D = unemployed_rate - lfs_unemployment
gen employment_rate_D = employment_rate - employment_rate_lfs
gen inactive_rate_D   = inactive_rate   - inactivty_rate_lfs

***********************************************************

***********************************************************




* Calculate the count of employed individuals by year
egen employed_count = total(employment_ == 1), by(year)

* Calculate the count of unemployed individuals by year
egen unemployed_count = total(employment_ == 2 | employment_ == 3), by(year)

* Calculate the count of inactive individuals by year
egen inactivity_count = total(inlist(employment_, 4, 5, 6, 7, 8)), by(year)

* Calculate the count of active individuals by year
egen active_count = total(inlist(employment_, 1, 2, 3)), by(year)

* Calculate the total count of individuals  who is is in list of 1:8 by year
egen total_count = total(inlist(employment_, 1, 2, 3, 4, 5, 6, 7, 8)), by(year)

* Calculate the employment rate by year
gen employment_rate = (employed_count / active_count) * 100

* Calculate the unemployment rate by year
gen unemployment_rate = (unemployed_count / active_count) * 100

* Calculate the inactivity rate by year
gen inactivity_rate = (inactivity_count / total_count) * 100

* Calculate the activity rate by year
gen activity_rate = (active_count / total_count) * 100

***********************************************************
 twoway (line lfs_unemployment year) (line unemployed_rate year)
 
  twoway (line employment_rate_lfs year) (line employment_rate year)
 
 twoway (line onactive_rate year) (line labour_force_lfs year)
 
 twoway (line inactive_rate year) (line inactivty_rate_lfs year)

 
 
 **********************************************************
 
 
 
