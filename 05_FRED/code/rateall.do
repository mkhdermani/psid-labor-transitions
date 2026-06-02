*===============================================================================
* rateall.do
*-------------------------------------------------------------------------------
* Project : PSID_SHELF  (RA work for Sepahsalari)
* Author  : Mohsen Khalili
* Purpose : Overlay the FRED labour-flow rates against the computed E/U/I
*           transition rates and export one comparison plot per flow.
*
* Requires: a time-series dataset (tsset) already in memory containing the
*           *_rate (FRED) and tr_*_to_* (computed) series used below.
* Output  : 05_FRED/output/<flow>.png
*===============================================================================

global out "D:/PSID_SHELF/05_FRED/output"

twoway (tsline ui_rate) (tsline tr_unemp_to_inac)
graph export "${out}/ui.png", as(png) name("Graph") replace

twoway (tsline iu_rate) (tsline tr_inac_to_unemp)
graph export "${out}/iu.png", as(png) name("Graph") replace

twoway (tsline ie_rate) (tsline tr_inac_to_emp)
graph export "${out}/ie.png", as(png) name("Graph") replace

twoway (tsline ei_rate) (tsline tr_emp_to_inac)
graph export "${out}/ei.png", as(png) name("Graph") replace

twoway (tsline eu_rate) (tsline tr_emp_to_unemp)
graph export "${out}/eu.png", as(png) name("Graph") replace

twoway (tsline ue_rate) (tsline tr_unemp_to_emp)
graph export "${out}/ue.png", as(png) name("Graph") replace
