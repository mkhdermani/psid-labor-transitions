*===============================================================================
* cps_transition.do   (CPS-SHIMER)
*-------------------------------------------------------------------------------
* Project : PSID_SHELF
* Author  : Mohsen Khalili
* Purpose : Plot the CPS E/U/I transition rates computed with Shimer's (2012)
*           method and export one PNG per flow (EU, UE, EI, IE, UI, IU).
* Input   : shimer.dta   (CPS transition rates, Shimer adjustment, by year)
* Output  : <flow>_shimer.png  in 04_CPS/CPS-SHIMER/
*===============================================================================

clear

* Read the Shimer-method CPS transition-rate file
use "shimer.dta", clear

* Plot the time series of transition rates and save each graph as PNG
local path "D:\PSID_SHELF\04_CPS\CPS-SHIMER\"
graph twoway line eu_shimer year_formatted, title("Transition Rate: Employment to Unemployment") ///
     ytitle("Transition Rate") xtitle("Year") 
graph export "`path'eu_shimer.png", replace

graph twoway line ue_shimer year_formatted, title("Transition Rate: Unemployment to Employment") ///
     ytitle("Transition Rate") xtitle("Year") 
graph export "`path'ue_shimer.png", replace

graph twoway line ei_shimer year_formatted, title("Transition Rate: Employment to Inactivity") ///
     ytitle("Transition Rate") xtitle("Year") 
graph export "`path'ei_shimer.png", replace

graph twoway line ie_shimer year_formatted, title("Transition Rate: Inactivity to Employment") ///
     ytitle("Transition Rate") xtitle("Year") 
graph export "`path'ie_shimer.png", replace

graph twoway line ui_shimer year_formatted, title("Transition Rate: Unemployment to Inactivity") ///
     ytitle("Transition Rate") xtitle("Year") 
graph export "`path'ui_shimer.png", replace

graph twoway line iu_shimer year_formatted, title("Transition Rate: Inactivity to Unemployment") ///
     ytitle("Transition Rate") xtitle("Year") 
graph export "`path'iu_shimer.png", replace