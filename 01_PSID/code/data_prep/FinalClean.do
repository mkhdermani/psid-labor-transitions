clear all
pause on
set more off


cd "$tmpdir"

use temp3, clear

svyset IndCluster [pweight = Weight_Long], strata(IndStratum) singleunit(certainty)
sort IndID Age

ologit RWealth_pctile i.Race i.TransInc_yn Age i.TransFromRelBrkted i.HouseStat NumFam i.HeadFathersEd MaxYrsSchool i.ChildhdECStat i.year RIntInc  if subpopNoJob == 1 [pweight=longweight]
qui: predict RWealth_pctile_predicted
ologit RLiqWealth_pctile i.Race i.TransInc_yn Age i.TransFromRelBrkted i.HouseStat NumFam i.HeadFathersEd MaxYrsSchool i.ChildhdECStat i.year RIntInc  if subpopNoJob == 1 [pweight=longweight]
qui: predict RLiqWealth_pctile_predicted
ologit RFinWealth_pctile i.Race i.TransInc_yn Age i.TransFromRelBrkted i.HouseStat NumFam i.HeadFathersEd MaxYrsSchool i.ChildhdECStat i.year RIntInc  if subpopNoJob == 1 [pweight=longweight]
qui: predict RFinWealth_pctile_predicted

rowranks RWealth_pctile_predicted1-RWealth_pctile_predicted5, gen(Wlth_sort1-Wlth_sort5) descending
rowranks RLiqWealth_pctile_predicted1-RLiqWealth_pctile_predicted5, gen(LiqWlth_sort1-LiqWlth_sort5) descending

rowranks RFinWealth_pctile_predicted1-RFinWealth_pctile_predicted5, gen(FinWlth_sort1-FinWlth_sort5) descending

gen RWealth_pctile_predicted = Wlth_sort1 if subpopNoJobNoObs == 1
gen RWealth_pctile_second = Wlth_sort2 if subpopNoJobNoObs == 1
gen RLiqWealth_pctile_predicted = LiqWlth_sort1 if subpopNoJobNoObs == 1
gen RLiqWealth_pctile_second = LiqWlth_sort2 if subpopNoJobNoObs == 1


gen RFinWealth_pctile_predicted = FinWlth_sort1 if subpopNoJobNoObs == 1
gen RFinWealth_pctile_second = FinWlth_sort2 if subpopNoJobNoObs == 1

drop *Wlth_sort*

ologit RWealth_qtile i.Race i.TransInc_yn Age i.TransFromRelBrkted i.HouseStat NumFam i.HeadFathersEd MaxYrsSchool i.ChildhdECStat i.year RIntInc  if subpopNoJob == 1 [pweight=longweight]
qui: predict RWealth_qtile_predicted
ologit RLiqWealth_qtile i.Race i.TransInc_yn Age i.TransFromRelBrkted i.HouseStat NumFam i.HeadFathersEd MaxYrsSchool i.ChildhdECStat i.year RIntInc  if subpopNoJob == 1 [pweight=longweight]
qui: predict RLiqWealth_qtile_predicted
ologit RFinWealth_qtile i.Race i.TransInc_yn Age i.TransFromRelBrkted i.HouseStat NumFam i.HeadFathersEd MaxYrsSchool i.ChildhdECStat i.year RIntInc  if subpopNoJob == 1 [pweight=longweight]
qui: predict RFinWealth_qtile_predicted

rowranks RWealth_qtile_predicted1-RWealth_qtile_predicted4, gen(Wlth_sort1-Wlth_sort4) descending
rowranks RLiqWealth_qtile_predicted1-RLiqWealth_qtile_predicted4, gen(LiqWlth_sort1-LiqWlth_sort4) descending

rowranks RFinWealth_qtile_predicted1-RFinWealth_qtile_predicted4, gen(FinWlth_sort1-FinWlth_sort4) descending

gen RWealth_qtile_predicted = Wlth_sort1 if subpopNoJobNoObs == 1
gen RWealth_qtile_second = Wlth_sort2 if subpopNoJobNoObs == 1
gen RLiqWealth_qtile_predicted = LiqWlth_sort1 if subpopNoJobNoObs == 1
gen RLiqWealth_qtile_second = LiqWlth_sort2 if subpopNoJobNoObs == 1


gen RFinWealth_qtile_predicted = FinWlth_sort1 if subpopNoJobNoObs == 1
gen RFinWealth_qtile_second = FinWlth_sort2 if subpopNoJobNoObs == 1

drop *Wlth_sort*

ologit RWealth_med i.Race i.TransInc_yn Age i.TransFromRelBrkted i.HouseStat NumFam i.HeadFathersEd MaxYrsSchool i.ChildhdECStat i.year RIntInc  if subpopNoJob == 1 [pweight=longweight]
qui: predict RWealth_med_predicted
ologit RLiqWealth_med i.Race i.TransInc_yn Age i.TransFromRelBrkted i.HouseStat NumFam i.HeadFathersEd MaxYrsSchool i.ChildhdECStat i.year RIntInc  if subpopNoJob == 1 [pweight=longweight]
qui: predict RLiqWealth_med_predicted
ologit RFinWealth_med i.Race i.TransInc_yn Age i.TransFromRelBrkted i.HouseStat NumFam i.HeadFathersEd MaxYrsSchool i.ChildhdECStat i.year RIntInc  if subpopNoJob == 1 [pweight=longweight]
qui: predict RFinWealth_med_predicted

rowranks RWealth_med_predicted1-RWealth_med_predicted2, gen(Wlth_sort1-Wlth_sort2) descending
rowranks RLiqWealth_med_predicted1-RLiqWealth_med_predicted2, gen(LiqWlth_sort1-LiqWlth_sort2) descending

rowranks RFinWealth_med_predicted1-RFinWealth_med_predicted2, gen(FinWlth_sort1-FinWlth_sort2) descending

gen RWealth_med_predicted = Wlth_sort1 if subpopNoJobNoObs == 1
gen RWealth_med_second = Wlth_sort2 if subpopNoJobNoObs == 1
gen RLiqWealth_med_predicted = LiqWlth_sort1 if subpopNoJobNoObs == 1
gen RLiqWealth_med_second = LiqWlth_sort2 if subpopNoJobNoObs == 1


gen RFinWealth_med_predicted = FinWlth_sort1 if subpopNoJobNoObs == 1
gen RFinWealth_med_second = FinWlth_sort2 if subpopNoJobNoObs == 1

drop *Wlth_sort*

gen RWealth_pctileOLogit = RWealth_pctile if subpopNoJob == 1
gen RLiqWealth_pctileOLogit = RLiqWealth_pctile if subpopNoJob == 1
gen RFinWealth_pctileOLogit = RFinWealth_pctile if subpopNoJob == 1
gen RWealth_qtileOLogit = RWealth_qtile if subpopNoJob == 1
gen RLiqWealth_qtileOLogit = RLiqWealth_qtile if subpopNoJob == 1
gen RFinWealth_qtileOLogit = RFinWealth_qtile if subpopNoJob == 1
gen RWealth_medOLogit = RWealth_med if subpopNoJob == 1
gen RLiqWealth_medOLogit = RLiqWealth_med if subpopNoJob == 1
gen RFinWealth_medOLogit = RFinWealth_med if subpopNoJob == 1

replace RWealth_pctileOLogit = RWealth_pctile_predicted if RWealth_pctileOLogit==.&RWealth_pctile_predicted!=.
replace RLiqWealth_pctileOLogit = RLiqWealth_pctile_predicted if RLiqWealth_pctileOLogit==.&RLiqWealth_pctile_predicted!=.

replace RFinWealth_pctileOLogit = RFinWealth_pctile_predicted if RFinWealth_pctileOLogit==.&RFinWealth_pctile_predicted!=.

replace RWealth_qtileOLogit = RWealth_qtile_predicted if RWealth_qtileOLogit==.&RWealth_qtile_predicted!=.
replace RLiqWealth_qtileOLogit = RLiqWealth_qtile_predicted if RLiqWealth_qtileOLogit==.&RLiqWealth_qtile_predicted!=.

replace RFinWealth_qtileOLogit = RFinWealth_qtile_predicted if RFinWealth_qtileOLogit==.&RFinWealth_qtile_predicted!=.

replace RWealth_qtileOLogit = RWealth_qtile_predicted if RWealth_qtileOLogit==.&RWealth_qtile_predicted!=.
replace RLiqWealth_qtileOLogit = RLiqWealth_qtile_predicted if RLiqWealth_qtileOLogit==.&RLiqWealth_qtile_predicted!=.

replace RFinWealth_qtileOLogit = RFinWealth_qtile_predicted if RFinWealth_qtileOLogit==.&RFinWealth_qtile_predicted!=.

sort IndID Age
by IndID: replace RWealth_pctileOLogit = RWealth_pctileOLogit[_n-1] if missing(RWealth_pctileOLogit)
by IndID: replace RLiqWealth_pctileOLogit = RLiqWealth_pctileOLogit[_n-1] if missing(RLiqWealth_pctileOLogit)
by IndID: replace RLiqWealth_medOLogit = RLiqWealth_medOLogit[_n-1] if missing(RLiqWealth_medOLogit)

by IndID: replace RFinWealth_pctileOLogit = RFinWealth_pctileOLogit[_n-1] if missing(RFinWealth_pctileOLogit)
by IndID: replace RWealth_pctileOLogit = RWealth_pctileOLogit[_N]
by IndID: replace RLiqWealth_pctileOLogit = RLiqWealth_pctileOLogit[_N]
by IndID: replace RLiqWealth_medOLogit = RLiqWealth_medOLogit[_N]
by IndID: replace RLiqWealth_qtileOLogit = RLiqWealth_qtileOLogit[_N]
by IndID: replace RFinWealth_pctileOLogit = RFinWealth_pctileOLogit[_N]



sort IndID Age

ologit RWealth_Presentpctile i.Race i.TransInc_yn Age i.TransFromRelBrkted i.HouseStat NumFam i.HeadFathersEd MaxYrsSchool i.ChildhdECStat i.year RIntInc [pweight=longweight]
qui: predict RWealth_Presentpctile_pred*
ologit RLiqWealth_Presentpctile i.Race i.TransInc_yn Age i.TransFromRelBrkted i.HouseStat NumFam i.HeadFathersEd MaxYrsSchool i.ChildhdECStat i.year RIntInc [pweight=longweight]
qui: predict RLiqWealth_Presentpctile_pred*
ologit RFinWealth_Presentpctile i.Race i.TransInc_yn Age i.TransFromRelBrkted i.HouseStat NumFam i.HeadFathersEd MaxYrsSchool i.ChildhdECStat i.year RIntInc [pweight=longweight]
qui: predict RFinWealth_Presentpctile_pred*

rowranks RWealth_Presentpctile_pred1-RWealth_Presentpctile_pred5, gen(Wlth_sort1-Wlth_sort5) descending
rowranks RLiqWealth_Presentpctile_pred1-RLiqWealth_Presentpctile_pred5, gen(LiqWlth_sort1-LiqWlth_sort5) descending
rowranks RFinWealth_Presentpctile_pred1-RFinWealth_Presentpctile_pred5, gen(FinWlth_sort1-FinWlth_sort5) descending

gen RWealth_Presentpctile_pred = Wlth_sort1
gen RWealth_Presentpctile_second = Wlth_sort2
gen RLiqWealth_Presentpctile_pred = LiqWlth_sort1
gen RLiqWealth_Presentpctile_second = LiqWlth_sort2
gen RFinWealth_Presentpctile_pred = FinWlth_sort1
gen RFinWealth_Presentpctile_second = FinWlth_sort2

drop *Wlth_sort*

gen RWealth_PresentpctileOLogit = RWealth_Presentpctile
gen RLiqWealth_PresentpctileOLogit = RLiqWealth_Presentpctile
gen RFinWealth_PresentpctileOLogit = RFinWealth_Presentpctile

replace RWealth_PresentpctileOLogit = RWealth_Presentpctile_pred if RWealth_PresentpctileOLogit==.&RWealth_Presentpctile_pred!=.
replace RLiqWealth_PresentpctileOLogit = RLiqWealth_Presentpctile_pred if RLiqWealth_PresentpctileOLogit==.&RLiqWealth_Presentpctile_pred!=.
replace RFinWealth_PresentpctileOLogit = RFinWealth_Presentpctile_pred if RFinWealth_PresentpctileOLogit==.&RFinWealth_Presentpctile_pred!=.



sort IndID Age
by IndID: replace LRWage_pctile = LRWage_pctile[_n-1] if missing(LRWage_pctile)
by IndID: replace LRLabInc_pctile = LRLabInc_pctile[_n-1] if missing(LRLabInc_pctile)
by IndID: replace LRWage_pctile = LRWage_pctile[_N]
by IndID: replace LRLabInc_pctile = LRLabInc_pctile[_N]

sort IndID Age
by IndID: gen IncGrowthRatio = RLabInc/RLabInc[_n - 1] if IndID == IndID[_n - 1] & EmpHVY == 1 & EmpHVY[_n - 1] == 1
gen HVYDrop = ((IncGrowthRatio > 20 | IncGrowthRatio < 1/20) & IncGrowthRatio != .)

gen RLabIncHVY = RLabInc if (((Age > 30 & RLabInc >= 9500 & HrsWrked >= 520)|(Age<= 30 & RLabInc >= 4750 & HrsWrked >= 260)) & RLabInc != . & HrsWrked != .)

gen LRLabIncHVY = log(RLabIncHVY)

rangestat (mean) RLabIncHVY_3 = RLabIncHVY, interval(Age -1 1) by(IndID)
gen LRLabIncHVY_3 = log(RLabIncHVY_3)
rangestat (mean) RLabInc_3 = RLabInc, interval(Age -1 1) by(IndID)
gen LRLabInc_3 = log(RLabInc_3)
rangestat (mean) YrsSchool_3 = YrsSchool, interval(Age -1 1) by(IndID)

gen RWageHVY = RWage if (((Age > 30 & RLabInc >= 9500 & HrsWrked >= 520)|(Age<= 30 & RLabInc >= 4750 & HrsWrked >= 260)) & RLabInc != . & HrsWrked != .)

rangestat (mean) RWageHVY_3 = RWageHVY, interval(Age -1 1) by(IndID)
gen LRWageHVY_3 = log(RWageHVY_3)

sort IndID Age
by IndID: gen LRLabIncGrowth = (LRLabInc - LRLabInc[_n-1])/(Age - Age[_n-1]) if IndID == IndID[_n - 1] & (EmpHVY == 1 & EmpHVY[_n - 1] == 1) & inrange(Age,Age[_n-1]+1,Age[_n-1]+3) & LRLabInc~= . & LRLabInc[_n-1] ~= .
by IndID: gen LRLabIncGrowthHVY_3 = (LRLabIncHVY_3 - LRLabIncHVY_3[_n-1])/(Age - Age[_n-1]) if IndID == IndID[_n - 1] & (EmpHVY == 1 & EmpHVY[_n - 1] == 1) & inrange(Age,Age[_n-1]+1,Age[_n-1]+3) & LRLabIncHVY_3~= . & LRLabIncHVY_3[_n-1] ~= .

forval X = 1/10 {
	sort IndID Age
	by IndID: gen RLabIncPrev`X' = RLabInc[_n-`X'] if IndID==IndID[_n-`X']
	by IndID: gen LRLabIncPrev`X' = LRLabInc[_n-`X'] if IndID==IndID[_n-`X']
	by IndID: gen LRLabIncHVYPrev`X' = LRLabIncHVY[_n-`X'] if IndID==IndID[_n-`X']
	by IndID: gen HrsWrkedPrev`X' = HrsWrked[_n-`X'] if IndID==IndID[_n-`X']
	by IndID: gen EmpPrev`X' = Emp[_n-`X'] if IndID==IndID[_n-`X']
}


forval X = 1/20 {
	sort IndID Age
	by IndID: gen RLabInc`X' = RLabInc[_n+`X'] if IndID==IndID[_n+`X']
	by IndID: gen LRLabInc`X' = LRLabInc[_n+`X'] if IndID==IndID[_n+`X']
	by IndID: gen LRLabIncHVY`X' = LRLabIncHVY[_n+`X'] if IndID==IndID[_n+`X']
	by IndID: gen HrsWrked`X' = HrsWrked[_n+`X'] if IndID==IndID[_n+`X']
	by IndID: gen Emp`X' = Emp[_n+`X'] if IndID==IndID[_n+`X']
	by IndID: gen EmpAlt`X' = EmpAlt[_n+`X'] if IndID==IndID[_n+`X']
	by IndID: gen LRLabIncGrowth`X' = LRLabInc`X' - LRLabInc if IndID==IndID[_n+`X']
	by IndID: gen LRLabIncGrowthHVY`X' = LRLabIncHVY`X' - LRLabIncHVY if IndID==IndID[_n+`X']
	by IndID: gen LRLabInc2YearGrowth`X' = LRLabInc`X' - LRLabIncPrev1 if IndID==IndID[_n+`X']
	by IndID: gen RLiqWealth`X' = RLiqWealth[_n+`X'] if IndID==IndID[_n+`X']
        by IndID: gen RLiqWealthChange`X' = RLiqWealth`X' - RLiqWealth if IndID==IndID[_n+`X'] & RLiqWealth!=.
}


cd "$projdir"
save PSIDFullPanel_Final.dta, replace
