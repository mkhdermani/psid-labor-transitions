clear all
pause on
set more off
set matsize 5000

*Set Ben's Path
cd "$projdir"

local calcmargins = 1
local saveresults = 1


use NLSY79_Cleaned_Final.dta, replace
