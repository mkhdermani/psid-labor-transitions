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

gen subsetHVY = (Sex == 1 &((Age > 30 & RLabInc >= 9500 & HrsWrked >= 520 & HrsWrked <= 5820)|(Age<= 30 & RLabInc >= 4750 & HrsWrked >= 260 & HrsWrked <= 5820)) & RLabInc != . & HrsWrked != . & inrange(Age, 24, 54)& RLiqWealth_pctileOLogit~=.&RLiqWealth_pctileOLogit~=.)

/*Life-Cycle Wage Profile (Average)*/
svy, subpop(subsetHVY): reg LRLabIncHVY_3 i.Age i.year i.EdLvls i.CurrentState i.Race HrsWrked

if `calcmargins' == 1{
    margins i.Age, subpop(if subsetHVY==1) predict(xb) atmeans post
    if `saveresults' == 1{
	cd "$modeldatadir"
        esttab using "./LifeCycleProfiles_AveragePSID.csv", not plain replace
        esttab e(V) using "./LifeCycleProfiles_AveragePSID_Weighting.csv", not plain replace
    }
}
