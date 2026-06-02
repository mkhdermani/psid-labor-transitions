*===============================================================================
* time.do
*-------------------------------------------------------------------------------
* Project : PSID_SHELF  (RA work for Sepahsalari)
* Author  : Mohsen Khalili
* Purpose : Build a daily date variable (date_ymd) from a decimal `date` variable
*           (year + month/100), then stamp the first row of each survey year with
*           1 January of that year. Saves the result as us_transition.dta.
*
* Requires: a dataset containing the variable `date` must already be in memory.
* Output  : 01_PSID/data/us_transition.dta
*
* Note    : Cleaned up from a console-log dump; the 23 hand-typed yearly
*           "replace ... in <row>" lines were replaced by the loop below.
*===============================================================================

* Split the decimal `date` (e.g. 1996.03) into calendar parts
gen year  = floor(date)
gen month = mod(date, 1) * 100
gen day   = 1

* Combine into a Stata daily date and display as DD/MM/YYYY
gen date_ymd = mdy(month, day, year)
format date_ymd %tdDD/NN/CCYY

* Stamp 1 January of each year on that year's first row.
* Rows are spaced 12 apart (monthly data): 1996 -> row 1, 2018 -> row 265.
forvalues y = 1996/2018 {
    local row = 1 + (`y' - 1996) * 12
    replace date_ymd = date("01jan`y'", "DMY") in `row'
}

save "D:/PSID_SHELF/01_PSID/data/us_transition.dta", replace
