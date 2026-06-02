clear

import excel "PANEL_CPS.xlsx", sheet("Sheet2") firstrow
 



*RENAME
rename LNU02000000 Employment_Level
rename LNU07000000 EE
rename LNU07100000 UE
rename LNU07200000 IE
rename LNU07300000 ME
rename LNU03000000 Unemployment_Level
rename LNU07400000 EU
rename LNU07500000 UU
rename LNU07600000 IU
rename LNU07700000 MU
rename LNU05000000 Not_in_Labor_Force
rename LNU07800000 EI
rename LNU07900000 UI
rename LNU08000000 II
rename LNU08100000 MI
rename LNU08200000 EM
rename LNU08300000 UM
rename LNU08400000 IM





// Assuming YEAR_MONTH is a string variable containing dates in the format "jan1989"
gen month = substr(YEAR_MONTH, 1, 3) // Extracting the first three characters (month abbreviation)
gen year = substr(YEAR_MONTH, 4, .) // Extracting the remaining characters (year)

// Convert abbreviated month to numerical representation
gen date_str = month + year
gen date_num = monthly(date_str, "MY")

format %tmCCYY-NN date_num

* Sort the data by date_num
sort date_num

* Declare time series
tsset date_num

* Generate lagged variables for each labor market status
gen Employment_Level_lag = Employment_Level[_n-1] if _n > 1
gen Unemployment_Level_lag = Unemployment_Level[_n-1] if _n > 1
gen Not_in_Labor_Force_lag = Not_in_Labor_Force[_n-1] if _n > 1

* Calculate transition variables using log transformation
gen tr_EE = -ln(1 - (EE / Employment_Level_lag))
gen tr_UU = -ln(1 - (UU / Unemployment_Level_lag))
gen tr_II = -ln(1 - (II / Not_in_Labor_Force_lag))
gen tr_EU = -ln(1 - (EU / Employment_Level_lag))
gen tr_UE = -ln(1 - (UE / Unemployment_Level_lag))
gen tr_IE = -ln(1 - (IE / Employment_Level_lag))
gen tr_EI = -ln(1 - (EI / Employment_Level_lag))
gen tr_IU = -ln(1 - (IU / Not_in_Labor_Force_lag))
gen tr_UI = -ln(1 - (UI / Unemployment_Level_lag))

* Plot Transition Rate: Employment to Unemployment
tsline tr_EU  in 517/926, ///
       title("Transition Rate: Employment to Unemployment") ///
       xtitle("Year") ytitle("Transition Rate") ///
       legend(off)

* Save the plot
graph export "`path'tr_EU.png", replace

* Plot Transition Rate: Unemployment to Employment
tsline tr_UE  in 517/926, ///
       title("Transition Rate: Unemployment to Employment") ///
       xtitle("Year") ytitle("Transition Rate") ///
       legend(off)

* Save the plot
graph export "`path'tr_UE.png", replace

* Plot Transition Rate: Employment to Inactivity
tsline tr_EI  in 517/926, ///
       title("Transition Rate: Employment to Inactivity") ///
       xtitle("Year") ytitle("Transition Rate") ///
       legend(off)

* Save the plot
graph export "`path'tr_EI.png", replace

* Plot Transition Rate: Inactivity to Employment
tsline tr_IE  in 517/926, ///
       title("Transition Rate: Inactivity to Employment") ///
       xtitle("Year") ytitle("Transition Rate") ///
       legend(off)

* Save the plot
graph export "`path'tr_IE.png", replace

* Plot Transition Rate: Unemployment to Inactivity
tsline tr_UI  in 517/926, ///
       title("Transition Rate: Unemployment to Inactivity") ///
       xtitle("Year") ytitle("Transition Rate") ///
       legend(off)

* Save the plot
graph export "`path'tr_UI.png", replace

* Plot Transition Rate: Inactivity to Unemployment
tsline tr_IU  in 517/926, ///
       title("Transition Rate: Inactivity to Unemployment") ///
       xtitle("Year") ytitle("Transition Rate") ///
       legend(off)

* Save the plot
graph export "`path'tr_IU.png", replace

* Plot Transition Rate: Employment to Employment
tsline tr_EE  in 517/926, ///
       title("Transition Rate: Employment to Employment") ///
       xtitle("Year") ytitle("Transition Rate") ///
       legend(off)

* Save the plot
graph export "`path'tr_EE.png", replace

* Plot Transition Rate: Unemployment to Unemployment
tsline tr_UU  in 517/926, ///
       title("Transition Rate: Unemployment to Unemployment") ///
       xtitle("Year") ytitle("Transition Rate") ///
       legend(off)

* Save the plot
graph export "`path'tr_UU.png", replace

* Plot Transition Rate: Inactivity to Inactivity
tsline tr_II  in 517/926, ///
       title("Transition Rate: Inactivity to Inactivity") ///
       xtitle("Year") ytitle("Transition Rate") ///
       legend(off)

* Save the plot
graph export "`path'tr_II.png", replace


save panel_cps.dta,replace


* Merge CPS and NLSY79 data
merge 1:1 date_num using "D:\PSID_SHELF\04_CPS\CPS-BLS\NLSY79_SABOOK.dta", force

* Keep only matched observations
keep if _merge == 3


sort CASEID_1979 date_num
tsset CASEID_1979 date


* Plot Transition Rate: Employment to Unemployment (CPS) vs (NLSY79)
tsline tr_UE tr_unemp_to_emp_week_mean, ///
    title("Transition Rate: Employment to Unemployment (CPS vs NLSY79)") ///
    xtitle("Year") ytitle("Transition Rate") ///
    legend(order(1 "CPS" 2 "NLSY79")) ///
    graphregion(color(white))

* Save the plot
graph export "`path'tr_UE_comparison.png", replace


* Plot Transition Rate: Unemployment to Employment (CPS) vs (NLSY79)
tsline tr_EU tr_emp_to_unemp_week_mean, ///
    title("Transition Rate: Unemployment to Employment (CPS vs NLSY79)") ///
    xtitle("Year") ytitle("Transition Rate") ///
    legend(order(1 "CPS" 2 "NLSY79")) ///
    graphregion(color(white))

* Save the plot
graph export "`path'tr_EU_comparison.png", replace


* Plot Transition Rate: Unemployment to Inactivity (CPS) vs (NLSY79)
tsline tr_UI tr_inac_to_unemp_week_mean, ///
    title("Transition Rate: Unemployment to Inactivity (CPS vs NLSY79)") ///
    xtitle("Year") ytitle("Transition Rate") ///
    legend(order(1 "CPS" 2 "NLSY79")) ///
    graphregion(color(white))

* Save the plot
graph export "`path'tr_UI_comparison.png", replace


* Plot Transition Rate: Inactivity to Unemployment (CPS) vs (NLSY79)
tsline tr_IU tr_unemp_to_inac_week_mean, ///
    title("Transition Rate: Inactivity to Unemployment (CPS vs NLSY79)") ///
    xtitle("Year") ytitle("Transition Rate") ///
    legend(order(1 "CPS" 2 "NLSY79")) ///
    graphregion(color(white))

* Save the plot
graph export "`path'tr_IU_comparison.png", replace


* Plot Transition Rate: Employment to Inactivity (CPS) vs (NLSY79)
tsline tr_EI tr_inac_to_emp_week_mean, ///
    title("Transition Rate: Employment to Inactivity (CPS vs NLSY79)") ///
    xtitle("Year") ytitle("Transition Rate") ///
    legend(order(1 "CPS" 2 "NLSY79")) ///
    graphregion(color(white))

* Save the plot
graph export "`path'tr_EI_comparison.png", replace


* Plot Transition Rate: Inactivity to Employment (CPS) vs (NLSY79)
tsline tr_IE tr_emp_to_inac_week_mean, ///
    title("Transition Rate: Inactivity to Employment (CPS vs NLSY79)") ///
    xtitle("Year") ytitle("Transition Rate") ///
    legend(order(1 "CPS" 2 "NLSY79")) ///
    graphregion(color(white))

* Save the plot
graph export "`path'tr_IE_comparison.png", replace


* Plot Transition Rate: Unemployment to Unemployment (CPS) vs (NLSY79)
tsline tr_UU tr_unemp_to_unemp_week_mean, ///
    title("Transition Rate: Unemployment to Unemployment (CPS vs NLSY79)") ///
    xtitle("Year") ytitle("Transition Rate") ///
    legend(order(1 "CPS" 2 "NLSY79")) ///
    graphregion(color(white))

* Save the plot
graph export "`path'tr_UU_comparison.png", replace


* Plot Transition Rate: Inactivity to Inactivity (CPS) vs (NLSY79)
tsline tr_II tr_inac_to_inac_week_mean, ///
    title("Transition Rate: Inactivity to Inactivity (CPS vs NLSY79)") ///
    xtitle("Year") ytitle("Transition Rate") ///
    legend(order(1 "CPS" 2 "NLSY79")) ///
    graphregion(color(white))

* Save the plot
graph export "`path'tr_II_comparison.png", replace
