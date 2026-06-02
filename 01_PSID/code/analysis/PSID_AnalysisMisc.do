clear all
pause on
set more off
set matsize 5000

*Set Ben's Path
cd "$projdir"

local calcmargins = 1
local saveresults = 1

use PSIDFullPanel_Final.dta, replace

svyset IndCluster [pweight = longweight], strata(IndStratum) singleunit(certainty)

gen subsetMain = (((Age > 30 & RLabInc >= 4750 & HrsWrked >= 260 & HrsWrked <= 5820)|(Age<= 30 & RLabInc >= 4750 & HrsWrked >= 260 & HrsWrked <= 5820)) & RLabInc != . & HrsWrked != . & inrange(Age, 25, 65) & sex==1)


/*Life-Cycle Wage Variance Profile*/
reg LRLabInc_3 i.Age i.year i.CurrentState i.EdLvls i.Race HrsWrked if subsetMain==1 [pweight=longweight], cluster(CurrentState)
