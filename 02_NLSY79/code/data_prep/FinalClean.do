clear all
pause on
set more off
set matsize 5000

*Set Ben's Path
cd $projdir

use NLSY79_Temp1.dta, replace

ren * x*
ren xCASEID1979 IndID
drop if IndID == -4

foreach v of varlist xPREVEMP* {
	di substr("`v'",1,8)
	*di substr("`v'",13,-1)
	di substr("`v'",9,4)
	*describe `v'
	local pt_one = substr("`v'",1,8)
	local pt_two = substr("`v'",13,5)
	local pt_three = substr("`v'",9,4)
	ren `v' xPREVEMP`pt_two'`pt_three'
}

foreach v of varlist x* {
	local stubs `"`stubs' `=substr("`v'",1,length("`v'")-4)'"'
	local vl`=substr("`v'",1,length("`v'")-4)' : variable label `v'
}

local uniquestubs: list uniq stubs

reshape long "`uniquestubs'", i(IndID) j(year)

foreach s of local uniquestubs {
    label var `s' "`vl`s''"
}




foreach v of varlist xOCCALL* {
	replace `v' = 0 if `v' == -4 & year < 1994
	gen `v'1993 = `v' if year < 1994
	gen `v'1994 = `v' if year > 1993
	gen `v'00 = `v' if year > 2004
}

replace xOCCALLEMP01 = xCPSOCC70 if year < 1994
gen xOCCALLEMP0170 = xOCCALLEMP01 if year < 2004

gen occ = xOCCALLEMP01 if xOCCALLEMP01 > 0 & xOCCALLEMP01 !=.


replace xINDALLEMP01 = xCPSIND70 if year < 1994
gen xINDALLEMP0170 = xINDALLEMP01 if year < 2004
gen ind = xINDALLEMP01 if xINDALLEMP01 > 0 & xINDALLEMP01 !=.


foreach v of varlist xQ8* {
	gen `v'_vs = (`v' == -4 & `v' != .)
	gen `v'_missing = (`v' == -5 & `v' != .)
	replace `v' = 0 if `v' == -4
}

foreach v of varlist xMIL* {
	replace `v' = 0 if `v' == -4
}


foreach v of varlist x* {
	replace `v' = . if `v' < 0
}




cd $projdir
save tempNLSYFinal_1.dta, replace

cd $projdir
use tempNLSYFinal_1.dta, clear

ren xSAMPWEIGHT longweight

drop if longweight == 0 | longweight == .

by IndID: generate ncount = _n

ren xAGEATINT Age
sort IndID Age
by IndID: replace longweight = longweight[_N]
replace longweight = longweight/100

cd "../..//online_extracts/sept17/SlopeAFQTWeights"
merge m:1 IndID using SlopeAFQTWeights.dta
drop _merge
replace slpafqtweight = slpafqtweight/100

cd $projdir
gen xQES52A018393 = xCPSQES52A if inrange(year,1983,1993)

/*Generate Hours Worked Variable */
gen HrsWrked = xWKSWKPCY*xQES52A01 if xQES52A01 > 0 & xQES52A01 != . & xWKSWKPCY > 0 & xWKSWKPCY != .
replace HrsWrked = xWKSWKPCY*xQES52A018393 if xQES52A018393 > 0 & xQES52A018393 != . & xWKSWKPCY > 0 & xWKSWKPCY != . & inrange(year,1983,1993)
replace HrsWrked = HrsWrked + xWKSWKPCY*xQES52A02 if xQES52A02 > 0 & xQES52A02 != . & xWKSWKPCY > 0 & xWKSWKPCY != .
replace HrsWrked = HrsWrked + xWKSWKPCY*xQES52A03 if xQES52A03 > 0 & xQES52A03 != . & xWKSWKPCY > 0 & xWKSWKPCY != .
replace HrsWrked = HrsWrked + xWKSWKPCY*xQES52A04 if xQES52A04 > 0 & xQES52A04 != . & xWKSWKPCY > 0 & xWKSWKPCY != .
replace HrsWrked = HrsWrked + xWKSWKPCY*xQES52A05 if xQES52A05 > 0 & xQES52A05 != . & xWKSWKPCY > 0 & xWKSWKPCY != .

ren xNETWORTH Wealth
ren xSAMPLESEX Sex_temp
bysort IndID: egen Sex = min(Sex_temp)
drop Sex_temp

drop if year == 1995 | year == 1997 | year == 1999 | year == 2001 | year == 2003 | year == 2005 | year == 2007 | year == 2009 | year == 2011
replace Age = Age[_n-1] + year - year[_n-1] if Age[_n-1] != . & IndID[_n] == IndID[_n-1] & Age == .

cpigen

ren xQ135TRUNC Inc_Trunc
gen RInc_Trunc = Inc_Trunc/cpiu
replace RInc_Trunc = RInc_Trunc*1.304
ren xQ135TRUNCREVISED Inc_Truncrevised
gen RInc_Truncrevised = Inc_Truncrevised/cpiu
replace RInc_Truncrevised = RInc_Truncrevised*1.304
ren xQ135 Inc_Unadjusted
gen RInc_Unadjusted = Inc_Unadjusted/cpiu
replace RInc_Unadjusted = Inc_Unadjusted*1.304
ren xHRP1 Wage
gen RWage = (Wage/100)/cpiu
replace RWage = RWage*1.304
gen RInc = RInc_Trunc
replace RInc = RInc_Truncrevised if RInc == .
replace RInc = RInc_Unadjusted if RInc == .
gen RWealth = Wealth/cpiu
replace RWealth = RWealth*1.304

gen LRInc = log(RInc)
gen LRWage = log(RWage)

ren xWKSWKPCY WksWrked
ren xWKSUNACCTPCY WksMissing
ren xMILWKPCY WksMil
ren xWKSNWMISSL WksFullMissing
ren xWKSUEMPPCY WksUnemp
ren xWKSOLFPCY WksOOLF

sort IndID Age
by IndID: gen JobNumChange = xJOBSNUM - xJOBSNUM[_n-1] if xJOBSNUM~=. & xJOBSNUM[_n-1]~=. & WksUnemp == 0 & IndID == IndID[_n-1]

gen ReasJobLoss = xQES23A01
replace ReasJobLoss = 0 if ReasJobLoss == . & WksWrked > 0 & WksWrked != .

gen J2U = (ReasJobLoss>0 & ReasJobLoss!=.)


/* sort IndID Age */
/* gen JobLoss = . */
/* replace JobLoss = 0 if WksWrked > 0 & WksWrked[_n-1] > 0 & WksWrked != . & WksWrked[_n-1] != . & IndID==IndID[_n-1] */
/* by IndID: replace JobLoss = 1 if WksUnemp > 0 & WksUnemp!= . & WksWrked[_n-1] > 0 & WksWrked[_n-1] != . & IndID == IndID[_n-1] */
/* replace JobLoss = 0 if WksWrked > 0 & WksWrked != . & WksUnemp == 0 & WksOOLF == 0 & JobLoss != 1 */


sort IndID Age
by IndID: gen J2J = (xJOBSNUM > xJOBSNUM[_n-1] & xJOBSNUM~=. & xJOBSNUM[_n-1]~=.) if WksUnemp == 0 & IndID == IndID[_n-1]

sort IndID Age
by IndID: gen J2JEst = (xJOBSNUM > xJOBSNUM[_n-1] & xJOBSNUM~=. & xJOBSNUM[_n-1]~=.) if WksUnemp == 0 & WksUnemp[_n-1] == 0 & WksOOLF == 0 & WksOOLF[_n-1] == 0 & IndID == IndID[_n-1]

sort IndID Age
by IndID: gen ChangeFirmEst = (xTENURE1[_n] < xTENURE1[_n-1] & xTENURE1[_n] != . & xTENURE1[_n-1] != . & IndID[_n] == IndID[_n-1])
by IndID: gen ChangeFirm = (xPREVEMPJOB01[_n-1] != 1 & xPREVEMPJOB01[_n-1] != . & IndID[_n] == IndID[_n-1])
gen E2U = (ChangeFirm==1&(WksUnemp|WksOOLF>0) & WksUnemp!=. & WksOOLF != . & ChangeFirm != .)
gen E2E = (ChangeFirm == 1 & WksUnemp == 0 & WksOOLF == 0)

/*Interesting Variables that aren't Useful Here*/
*drop xTENURE1 xTENURE2 xTENURE3 xTENURE4 xTENURE5 xJOBSNUM xPREVEMPJOB01 xPREVEMPJOB02 xPREVEMPJOB03 xPREVEMPJOB04 xPREVEMPJOB05
drop xSCHOOL3B xWOW4 xWOWOCC xEXP1 xEXPOCC xEXP1A xEXPOCC2
drop xTRN2 xQ8171 xQ8172 xTRN4 xCOWALLEMP1 xEXP3 xQ8314 xQ819

replace xQ83102 = 0 if xQ83102 ==. & xQ83101 !=.
replace xQ83103 = 0 if xQ83103 ==. & xQ83101 !=.
replace xQ83104 = 0 if xQ83104 ==. & xQ83101 !=.
replace xQ8312 = 0 if xQ8312 ==. & xQ8311 !=.
replace xQ8313 = 0 if xQ8313 ==. & xQ8311 !=.

gen TrainingHrsWkly = xQ83101 + xQ83102 + xQ83103 + xQ83104
replace TrainingHrsWkly = xQ8311 + xQ8312 + xQ8313 if TrainingHrsWkly == .

replace xQ831A02 = 0 if xQ831A02 ==. & xQ831A01 !=.
replace xQ831A03 = 0 if xQ831A03 ==. & xQ831A01 !=.
replace xQ831A04 = 0 if xQ831A04 ==. & xQ831A01 !=.

gen TrainingHrsWklyOTJ = xQ831A01 + xQ831A02 + xQ831A03 + xQ831A04
gen PctTrainOTJ = TrainingHrsWklyOTJ/TrainingHrsWkly

ren xAFQT3 AFQT
replace AFQT = AFQT/1000
gen AFQT_missing = (AFQT == .)
bysort IndID: egen AFQT_temp = min(AFQT)
replace AFQT = AFQT_temp if AFQT == .
drop AFQT_temp

cd $projdir
save tempNLSYFinal_2.dta, replace

cd $projdir
use tempNLSYFinal_2.dta, clear

ren xHGC YrsSchool
sort IndID Age
by IndID: gen maxschooltemp = YrsSchool[1]
replace maxschooltemp = YrsSchool[_n+1] if YrsSchool[_n+1] > maxschooltemp & IndID[_n+1] == IndID
replace YrsSchool = maxschooltemp if YrsSchool == .
by IndID: replace YrsSchool = ceil((YrsSchool[_n-1] + YrsSchool[_n+1])/2) if YrsSchool > YrsSchool[_n+1] & IndID == IndID[_n+1] & IndID==IndID[_n-1] & YrsSchool != .
by IndID: replace YrsSchool = YrsSchool[_n-1] if IndID == IndID[_n-1] & IndID == IndID[_n+1] & YrsSchool[_n-1] == YrsSchool[_n+1] & YrsSchool[_n-1] != .
by IndID: replace YrsSchool = YrsSchool[_n-1] + year - year[_n-1] if IndID == IndID[_n-1] & IndID == IndID[_n+1] & YrsSchool[_n+1] == (year[_n+1] - year[_n-1] + YrsSchool[_n-1]) & missing(YrsSchool)
by IndID: replace YrsSchool = YrsSchool[_n+1] if IndID == IndID[1] & YrsSchool[_n+1] == YrsSchool[_n+2] & YrsSchool == .
by IndID: egen MaxYrsSchool = max(YrsSchool)
replace YrsSchool = MaxYrsSchool if YrsSchool[_n-1] == MaxYrsSchool & missing(YrsSchool)


sort IndID Age
by IndID: gen StillInSchool = (YrsSchool[_n+1] >= YrsSchool + 1 & IndID == IndID[_n+1])

gen Race = xSAMPLERACE78SCRN

gen Married = (xMARSTATKEY == 1)
gen HasBeenMarried = Married[_n-1] if Married[_n-1] > Married & Married != . & IndID[_n] == IndID[_n-1]

gen Emp = (RInc>9500&HrsWrked>=520&HrsWrked<=5820&RInc!=.&HrsWrked!=.)
gen EmpHVY = ((RInc>=9500&HrsWrked>=520&HrsWrked<=5820&RInc!=.&HrsWrked!=.)|(RInc>=4750&HrsWrked>260&HrsWrked<=5820&RInc!=.&HrsWrked!=.&Age<=30))

sort IndID Age
by IndID: gen StartJob = (Emp==1&Emp[_n-1]!=1&Emp!=.&IndID==IndID[_n-1])
by IndID: gen StartJobHVY = (EmpHVY==1&EmpHVY[_n-1]!=1&EmpHVY!=.&IndID==IndID[_n-1])
gen YrsSchoolJobStart = YrsSchool if StartJob == 1
gen YrsSchoolJobStartHVY = YrsSchool if StartJobHVY == 1
gen AgeStartJob = Age if StartJob == 1
gen AgeStartJobHVY = Age if StartJobHVY == 1
by IndID: egen FirstJobAge = min(AgeStartJob)
by IndID: egen FirstJobAgeHVY = min(AgeStartJobHVY)
by IndID: egen FirstJobYrsSchool = min(YrsSchoolJobStart)
by IndID: egen FirstJobYrsSchoolHVY = min(YrsSchoolJobStartHVY)
gen ThirtyYearsExp = FirstJobAge + 30 if FirstJobAge != .

gen subpopNoJobNoObs = (Age <= FirstJobAgeHVY & Age <= 30 & Sex == 1 & StillInSchool == 0)
gen subpopNoJobNoObsAll = (Age <= FirstJobAgeHVY & Age <= 30 & StillInSchool == 0)

gen RWealth_pctile = .
gen RWealth_qtile = .
gen RWealth_med = .
gen lastwlth = RWealth if subpopNoJobNoObsAll == 1
sort IndID Age
by IndID: egen lastage = max(cond(lastwlth!=., Age, .))
by IndID: replace lastwlth = . if Age != lastage
egen rank = rank(lastwlth) if subpopNoJobNoObsAll == 1, unique
qui: xtile temp = rank if subpopNoJobNoObsAll == 1 [pweight=floor(longweight)], nq(5)
replace RWealth_pctile = temp if lastwlth != . & subpopNoJobNoObsAll == 1
drop rank temp
egen rank = rank(lastwlth) if subpopNoJobNoObsAll == 1, unique
qui: xtile temp = rank if subpopNoJobNoObsAll == 1 [pweight=floor(longweight)], nq(4)
replace RWealth_qtile = temp if lastwlth != . & subpopNoJobNoObsAll == 1
drop rank temp
egen rank = rank(lastwlth) if subpopNoJobNoObsAll == 1, unique
qui: xtile temp = rank if subpopNoJobNoObsAll == 1 [pweight=floor(longweight)], nq(2)
replace RWealth_med = temp if lastwlth != . & subpopNoJobNoObsAll == 1
drop rank temp

cd $projdir
save tempNLSY_Final_3, replace

/*Start classifying into quantiles*/
cd $projdir
use tempNLSY_Final_3, replace

sort IndID Age
by IndID: gen sameJob = (J2J == 0 & WksUnemp == 0 & WksUnemp[_n-1] == 0 & WksOOLF == 0 & WksOOLF[_n-1] == 0 & IndID == IndID[_n-1])

tab RWealth_qtile, sum(RWealth)
tab RWealth_qtile MaxYrsSchool, col

sort IndID Age
by IndID: replace RWealth_pctile = RWealth_pctile[_n-1] if missing(RWealth_pctile)
by IndID: replace RWealth_pctile = RWealth_pctile[_N]
by IndID: replace RWealth_qtile = RWealth_qtile[_n-1] if missing(RWealth_qtile)
by IndID: replace RWealth_qtile = RWealth_qtile[_N]
by IndID: replace RWealth_med = RWealth_med[_n-1] if missing(RWealth_med)
by IndID: replace RWealth_med = RWealth_med[_N]

qui: xtile RWealthCurrent_pctile = RWealth if EmpHVY == 1 [pweight=floor(longweight)], nq(5)
qui: xtile RWealthCurrent_qtile = RWealth if EmpHVY == 1 [pweight=floor(longweight)], nq(4)
qui: xtile RWealthCurrent_med = RWealth if EmpHVY == 1 [pweight=floor(longweight)], nq(2)
sort IndID Age
by IndID: replace RWealthCurrent_pctile = RWealthCurrent_pctile[_n-1] if missing(RWealthCurrent_pctile)
by IndID: replace RWealthCurrent_qtile = RWealthCurrent_qtile[_n-1] if missing(RWealthCurrent_qtile)
by IndID: replace RWealthCurrent_med = RWealthCurrent_med[_n-1] if missing(RWealthCurrent_med)

qui: xtile RIncCurrent_pctile = RInc if EmpHVY == 1 [pweight=floor(longweight)], nq(5)
qui: xtile RIncCurrent_qtile = RInc if EmpHVY == 1 [pweight=floor(longweight)], nq(4)
qui: xtile RIncCurrent_med = RInc if EmpHVY == 1 [pweight=floor(longweight)], nq(2)

gen AFQT_pctile = .
replace AFQT_pctile = 1 if inrange(AFQT,0,20)
replace AFQT_pctile = 2 if inrange(AFQT,20,40)
replace AFQT_pctile = 3 if inrange(AFQT,40,60)
replace AFQT_pctile = 4 if inrange(AFQT,60,80)
replace AFQT_pctile = 5 if inrange(AFQT,80,100)

gen AFQT_qtile = .
replace AFQT_qtile = 1 if inrange(AFQT,0,25)
replace AFQT_qtile = 2 if inrange(AFQT,25,50)
replace AFQT_qtile = 3 if inrange(AFQT,50,75)
replace AFQT_qtile = 4 if inrange(AFQT,75,100)

gen AFQT_med = .
replace AFQT_med = 1 if inrange(AFQT,0,50)
replace AFQT_med = 2 if inrange(AFQT,50,100)

gen EmpBin = (WksWrked > 0 & WksWrked!=.)

ren xURBANRURAL UrbanRural
ren xSMSARES SMSA
ren xREGION Region

replace SMSA = SMSA - 1 if year >= 2000
replace UrbanRural = . if UrbanRural == .

sort IndID Age
replace Age = Age[_n-1] + year - year[_n-1] if IndID == IndID[_n-1] & Age == .
/*sort IndID Age
replace year = year[_n-1] + 1 if IndID == IndID[_n-1] & year[_n-1] < 1995
replace year = year[_n-1] + 2 if IndID == IndID[_n-1] & year[_n-1] >= 1995*/
sort IndID Age
replace UrbanRural = UrbanRural[_n-1] if UrbanRural[_n+1] == UrbanRural[_n-1] & IndID == IndID[_n-1] & IndID == IndID[_n+1] & UrbanRural == .
replace UrbanRural = 2 if UrbanRural == .
sort IndID Age
replace SMSA = SMSA[_n-1] if SMSA[_n+1] == SMSA[_n-1] & IndID == IndID[_n-1] & IndID == IndID[_n+1] & SMSA == .
sort IndID Age
replace Region = Region[_n-1] if Region[_n+1] == Region[_n-1] & IndID == IndID[_n-1] & IndID == IndID[_n+1] & Region == .
sort IndID Age
by IndID: egen racetemp = max(Race)
replace Race = racetemp if Race == .

gen EdLvls = .
replace EdLvls = 1 if inrange(MaxYrsSchool,.,11)
replace EdLvls = 2 if MaxYrsSchool == 12
replace EdLvls = 3 if inrange(MaxYrsSchool,13,15)
replace EdLvls = 4 if MaxYrsSchool == 16
replace EdLvls = 5 if inrange(MaxYrsSchool,17,.)

gen RIncHVY = RInc if (((Age > 30 & RInc >= 9500 & HrsWrked >= 520)|(Age<= 30 & RInc >= 4750 & HrsWrked >= 260)) & RInc != . & HrsWrked != . & StillInSchool == 0 & WksMil == 0)

sort IndID Age
rangestat (mean) RIncHVY_3 = RIncHVY, interval(Age -1 1) by(IndID)
gen LRIncHVY_3 = log(RIncHVY_3)
rangestat (mean) RInc_3 = RInc, interval(Age -1 1) by(IndID)
gen LRInc_3 = log(RInc_3)
rangestat (mean) RInc_Trunc_3 = RInc_Trunc, interval(Age -1 1) by(IndID)
gen LRInc_Trunc_3 = log(RInc_Trunc_3)
rangestat (mean) RInc_Truncrevised_3 = RInc_Truncrevised, interval(Age -1 1) by(IndID)
gen LRInc_Truncrevised_3 = log(RInc_Truncrevised_3)
rangestat (mean) RInc_Unadjusted_3 = RInc_Unadjusted, interval(Age -1 1) by(IndID)
gen LRInc_Unadjusted_3 = log(RInc_Unadjusted_3)
rangestat (mean) YrsSchool_3 = YrsSchool, interval(Age -1 1) by(IndID)

sort IndID Age
by IndID: gen IncGrowthRatio = RInc/RInc[_n - 1] if IndID == IndID[_n - 1] & EmpHVY == 1 & EmpHVY[_n - 1] == 1
gen HVYDrop = ((IncGrowthRatio > 20 | IncGrowthRatio < 1/20) & IncGrowthRatio != .)

sort IndID Age
by IndID: gen LRInc_Growth = (LRInc - LRInc[_n-1])/(Age - Age[_n-1]) if IndID == IndID[_n-1] & inrange(Age,Age[_n-1],Age[_n-1]+2)
by IndID: gen LRIncHVY_Growth = (LRIncHVY - LRIncHVY[_n-1])/(Age - Age[_n-1]) if IndID == IndID[_n-1] & inrange(Age,Age[_n-1],Age[_n-1]+2)
by IndID: gen LRIncHVY_3Growth = (LRIncHVY_3 - LRIncHVY_3[_n-1])/(Age - Age[_n-1]) if IndID == IndID[_n-1] & inrange(Age,Age[_n-1],Age[_n-1]+2)
by IndID: gen HrsWkred_Growth = (HrsWrked - HrsWrked[_n-1]) if IndID == IndID[_n-1] & inrange(Age,Age[_n-1],Age[_n-1]+2)


forval X = 1/10 {
	sort IndID Age
	rangestat (last) LRIncPrev`X' = LRInc, interval(Age . -`X') by(IndID)
	rangestat (last) HrsWrkedPrev`X' = HrsWrked, interval(Age . -`X') by(IndID)
	rangestat (last) EmpPrev`X' = Emp, interval(Age . -`X') by(IndID)
}

forval X = 1/20 {
	local Y = `X'+1
	sort IndID Age
	rangestat (last) LRInc`X' = LRInc, interval(Age . `Y') by(IndID)
	rangestat (last) HrsWrked`X' = HrsWrked, interval(Age . `Y') by(IndID)
	rangestat (last) Emp`X' = Emp, interval(Age . `Y') by(IndID)
	by IndID: gen LRIncGrowth`X' = (LRInc`X' - LRInc)
	by IndID: gen LRInc2YearGrowth`X' = (LRInc`X' - LRIncPrev1)
}


save NLSY79_Cleaned_Final.dta, replace
