clear all
pause on
set more off
set matsize 5000

*Set Ben's Path
cd "$projdir"

local calcmargins = 1
local saveresults = 1


use NLSY79_Cleaned_Final.dta, replace


gen subsetMain = (Sex == 1 &((Age > 30 & RInc >= 9500 & HrsWrked >= 520 & HrsWrked <= 5280)|(Age<= 30 & RInc >= 4750 & HrsWrked >= 260 & HrsWrked <= 5280)) & RInc != . & inrange(Age, 25, 54) & StillInSchool == 0)

reg LRIncHVY_3 c.Age##i.AFQT_pctile i.year i.Region i.Race i.EdLvls [pweight = longweight] if subsetMain == 1, cluster(Region)
