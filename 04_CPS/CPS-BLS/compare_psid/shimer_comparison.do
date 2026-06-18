*===============================================================================
* shimer_comparison.do   (CPS-BLS / compare_psid)
*-------------------------------------------------------------------------------
* Project : PSID_SHELF
* Author  : Mohsen Khalili
* Purpose : Aggregate the monthly CPS transition rates (tr_EU, tr_UE, tr_IE,
*           tr_EI, tr_IU, tr_UI) to QUARTERLY means and plot them, so they can
*           be compared against the PSID series on the same time scale.
* Input   : panel_cps.dta   (monthly CPS labour-force flows / transition rates)
* Output  : quarterly transition-rate plots
*===============================================================================

clear
use panel_cps.dta

destring year, replace

gen quarter = .

replace quarter = 1 if inlist(month, "Jan", "Feb", "Mar")
replace quarter = 2 if inlist(month, "Apr", "May", "Jun")
replace quarter = 3 if inlist(month, "Jul", "Aug", "Sep")
replace quarter = 4 if inlist(month, "Oct", "Nov", "Dec")

format quarter %9.0g 


foreach var in  EU UE IE EI IU UI{
    egen tr_`var'_quarter_mean = mean(tr_`var'), by(quarter year)
}

sort date_num

tsset date_num

local plot_export ///
    title("Transition Rate: $1 to $2") ///
    xtitle("Year") ytitle("Mean Transition Rate") ///
    legend(label(1 "Quarterly Mean"))

foreach var in EU UE IE EI IU UI {
    tsline tr_`var'_quarter_mean, `plot_export(`var',`var')'
    graph export "tr_`var'_quarterly.png", replace
}

merge m:m year quarter using "D:\PSID_SHELF\04_CPS\CPS-SHIMER\shimer.dta"

keep if _merge == 3



foreach var in  eu ue ie ei iu ui * {
  rename `var'_shimer `=strupper("`var'")'_shimer
}



local plot_export ///
    title("Transition Rate: $1 to $2") ///
    xtitle("Year") ytitle("Mean Transition Rate") ///
    legend(order(1 "CPS" 2 "SHIMER"))

foreach var in EU UE IE EI IU UI {
    tsline tr_`var'_quarter_mean `var'_shimer, `plot_export("`var'","`var'")'
    graph export "tr_`var'_compare.png", replace
}


