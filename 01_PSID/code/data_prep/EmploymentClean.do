clear all
pause on
set more off

*Set Ben's Path
cd "$tmpdir"
use temp2, replace

keep if RelToHead == 1 | RelToHead == 10

replace HeadEmpStat = 8 if HeadEmpStat == 6 & year < 1976
replace HeadEmpStat = 7 if HeadEmpStat == 5 & year < 1976
replace HeadEmpStat = 6 if HeadEmpStat == 4 & year < 1976
replace HeadEmpStat = 4 if HeadEmpStat == 3 & year < 1976
replace HeadEmpStat = 3 if HeadEmpStat == 2 & year < 1976

gen IntMth = .
replace IntMth = 3 if inrange(year,1968,1979) & (FSURIN002==1|FSURIN002==2)
replace IntMth = 4 if inrange(year,1968,1979) & (FSURIN002==3|FSURIN002==4)
replace IntMth = 5 if inrange(year,1968,1979) & (FSURIN002==5|FSURIN002==6)
replace IntMth = 6 if (inrange(year,1968,1970) & (FSURIN002==7|FSURIN002==8))|(inrange(year,1971,1979) & FSURIN002==7)
replace IntMth = 7 if inrange(year,1971,1979) & FSURIN002==8
replace IntMth = floor(FSURIN002/100) if inrange(year,1980,1996) & FSURIN002 ~= 9999
replace IntMth = FSURIN049 if inrange(year,1997,2015)

label define HeadEmpStat ///
	1 "Working Now (Pre-1976 included Temporary Layoffs)" ///
	2 "Temporarily Layed off" ///
	3 "Looking for Work, Unemployed" ///
	4 "Retired (Pre-1976 included Permanently Disabled)" ///
	5 "Permanently Disabled" ///
	6 "Housewife" ///
	7 "Student" ///
	8 "Other" ///
	9 "Na;DK"
label values HeadEmpStat HeadEmpStat

label define EmpStat ///
	1 "Working Now" ///
	2 "Temporarily Layed off" ///
	3 "Looking for Work, Unemployed" ///
	4 "Retired" ///
	5 "Permanently Disabled" ///
	6 "Housewife" ///
	7 "Student" ///
	8 "Other" ///
	9 "Na;DK"
label values EmpStat EmpStat

gen EverTraining = .
replace EverTraining = 0 if FEDU186 != .
sort IndID Age
by IndID: replace EverTraining = 1 if FEDU186[_n-1] == 1 & IndID==IndID[_n-1]

gen EverTrainingAll = .
sort IndID Age
replace EverTrainingAll = 0 if FEDU186 != . & year >= 1985
replace EverTrainingAll = 1 if FEDU186==1 & year>=1985
/* by IndID: replace HadTraining = 1 if (FEDU186 == 1 & FEDU186[_n-1] == 0) & IndID==IndID[_n-1] & year>=1985 */

ren FEDU186 HadTraining
replace HadTraining = 5 if HadTraining == 0 & year == 1968



label define TrainingInd ///
	1 "Yes, trained outside of school" ///
	5 "None other than school" ///
	9 "NA" ///
	0 "No change from previous"
label values HadTraining TrainingInd
label values EverTraining TrainingInd
label values EverTrainingAll TrainingInd

gen TrainingOrg1 = FEDU062 if year <= 1984
gen TrainingOrg2 = FEDU063 if year <= 1984

label define TrainingOrg ///
	1 "Gov't subsidized, non-military" ///
	2 "Job-specific, vocational-type training" ///
	3 "Company-specific, on-the-job training" ///
	7 "Other" ///
	8 "Vague, unclear" ///
	9 "NA, DK" ///
	0 "Inap., no other training or more than 6 yrs school"
label values TrainingOrg1 TrainingOrg
label values TrainingOrg2 TrainingOrg

gen TrainingOrg11985On = FEDU062 if year > 1984
gen TrainingOrg21985On = FEDU063 if year > 1984

*ren VAR201 TrainingOrg1_1985
*ren VAR202 TrainingOrg2_1985
*ren VAR203 TrainingOrg3_1985

label define TrainingOrg2 ///
	1 "Vocational/trade school" ///
	2 "Community college/junior college" ///
	3 "Business school or financial institute" ///
	4 "Armed forces" ///
	5 "High school" ///
	6 "Hospital school" ///
	7 "Beauty school" ///
	8 "Policy/firefighter academy" ///
	9 "Gov't sponsored job training" ///
	10 "On-the-job training" ///
	11 "Religious institution" ///
	97 "Other" ///
	99 "NA, DK" ///
	0 "Inap., no other training or more than 6 yrs school"
label values TrainingOrg11985On TrainingOrg2
label values TrainingOrg21985On TrainingOrg2
*label values TrainingOrg3_1985 TrainingOrg2

ren FEDU155 CertYear1
ren FEDU156 CertYear2
ren FEDU157 CertYear3

replace CertYear1 = 9999 if CertYear1 == 99 & year <= 1992
replace CertYear1 = 9998 if CertYear1 == 98 & year <= 1992
replace CertYear1 = CertYear1 + 1900 if inrange(CertYear1,1,96) & year <= 1992

replace CertYear2 = 9999 if CertYear2 == 99 & year <= 1992
replace CertYear2 = 9998 if CertYear2 == 98 & year <= 1992
replace CertYear2 = CertYear2 + 1900 if inrange(CertYear2,1,96) & year <= 1992

replace CertYear3 = 9999 if CertYear3 == 99 & year <= 1992
replace CertYear3 = 9998 if CertYear3 == 98 & year <= 1992
replace CertYear3 = CertYear3 + 1900 if inrange(CertYear3,1,96) & year <= 1992



sort IndID year Age
by IndID: replace HadTraining = HadTraining[_n-1] if IndID==IndID[_n-1]&HadTraining~=1
sort IndID year Age
by IndID: replace HadTraining = HadTraining[_n-1] if IndID==IndID[_n-1]&HadTraining[_n-1]==1

replace CertYear1 = 0 if CertYear1 == 9998 | CertYear1 == 9999
replace CertYear2 = 0 if CertYear2 == 9998 | CertYear2 == 9999
replace CertYear3 = 0 if CertYear3 == 9998 | CertYear3 == 9999

sort IndID year Age
by IndID: egen CertYear1Temp = max(CertYear1)
sort IndID year Age
by IndID: egen CertYear2Temp = max(CertYear2)
sort IndID year Age
by IndID: egen CertYear3Temp = max(CertYear3)

gen RecdTraining1 = (CertYear1==year|CertYear1==(year-1)|CertYear2==year|CertYear2==(year-1)|CertYear3==year|CertYear3==(year-1))

gen RecdTraining2 = (CertYear1Temp==year|CertYear1Temp==(year-1)|CertYear2Temp==year|CertYear2Temp==(year-1)|CertYear3Temp==year|CertYear3Temp==(year-1))

/*Use different measurements of employment status*/
gen Emp = (RLabInc>9500&FWOR876>=520&FWOR876<=5820&RLabInc!=.&FWOR876!=.)

sort IndID year Age
by IndID: gen StartJob = (Emp==1&Emp[_n-1]!=1&Emp!=.&IndID==IndID[_n-1])

gen AgeStartJob = Age if StartJob == 1

gen MosPresEmp = .
replace MosPresEmp = HeadMosPresentEmp94Prior if inrange(year,1969,1993) & HeadMosPresentEmp94Prior ~= 999 & year ~= 1978
sort IndID year Age
by IndID: replace MosPresEmp = MosPresEmp[_n-1] + 12*(year - year[_n-1]) + (IntMth - IntMth[_n-1]) if year == 1978 & HeadMosPresentEmp94Prior == 0 & FWOR330 == 1 & IndID == IndID[_n-1]
replace MosPresEmp = HeadMosPresentEmp94Prior if year == 1978 & HeadMosPresentEmp94Prior ~= 999 & FWOR330 == 5 & year == 1978 & MosPresEmp == .
sort IndID year Age
by IndID: mipolate MosPresEmp Age if inrange(year,1969,1993), linear gen(temp1)
sort IndID year Age
by IndID: replace MosPresEmp = MosPresEmp[_n-1] + 12 + (IntMth - IntMth[_n-1]) if year == 1978 & HeadMosPresentEmp94Prior == 0 & MosPresEmp[_n-1] ~= 999 & FWOR2533 == 5 & MosPresEmp == . & IndID == IndID[_n-1]
by IndID: replace MosPresEmp = ceil(temp1) if year == 1978 & inrange(temp1,MosPresEmp[_n-1],MosPresEmp[_n+1]) & FWOR2533 == 5 & MosPresEmp == . & IndID == IndID[_n-1] & IndID == IndID[_n+1]
replace MosPresEmp = 0 if MosPresEmp == . & year == 1978
replace MosPresEmp = HeadMosPresentEmp94On + 12*HeadYearsPresentEmp if year>=1994 & (HeadMosPresentEmp94On<13&HeadMosPresentEmp94On~=.) & (Age - HeadYearsPresentEmp > 16) & HeadMosPresentEmp94On ~= 99 & HeadYearsPresentEmp ~= 99
replace MosPresEmp = HeadYearsPresentEmp if year>=1994 & (Age - HeadYearsPresentEmp <= 16)
drop temp1

sort IndID Age
by IndID: gen J2U = (Emp==0&Emp[_n-1]==1) if IndID == IndID[_n-1]

sort IndID year Age
by IndID: gen MosBeforeInt = 12*(year[_n+1] - year) + (IntMth[_n+1] - IntMth) if IndID == IndID[_n+1]

gen temp2 = MosPresEmp

gsort IndID -year -Age
by IndID: replace temp2 = temp2[_n-1] - MosBeforeInt + 1 if inrange(year,1968,1975) & temp2[_n-1] >= MosBeforeInt & temp2[_n-1] ~= .

gen temp1 = .
replace temp1 = 6 if HeadYearsPresentJobBkted == 1
replace temp1 = 16 if HeadYearsPresentJobBkted == 2
replace temp1 = 31 if HeadYearsPresentJobBkted == 3
replace temp1 = 78 if HeadYearsPresentJobBkted == 4
replace temp1 = 180 if HeadYearsPresentJobBkted == 5
replace temp1 = 240 if HeadYearsPresentJobBkted == 6
replace temp1 = 0 if HeadYearsPresentJobBkted == 0
replace temp1 = 3 if HeadMosPresentEmp94Prior == 1 & year == 1968
replace temp1 = 12 if HeadMosPresentEmp94Prior == 2 & year == 1968
replace temp1 = 31 if HeadMosPresentEmp94Prior == 3 & year == 1968
replace temp1 = 78 if HeadMosPresentEmp94Prior == 4 & year == 1968
replace temp1 = 180 if HeadMosPresentEmp94Prior == 5 & year == 1968
replace temp1 = 240 if HeadMosPresentEmp94Prior == 6 & year == 1968
replace temp1 = 0 if HeadMosPresentEmp94Prior == 0 & year == 1968

gen tempmin = .
replace tempmin = 1 if HeadYearsPresentJobBkted == 1
replace tempmin = 13 if HeadYearsPresentJobBkted == 2
replace tempmin = 20 if HeadYearsPresentJobBkted == 3
replace tempmin = 43 if HeadYearsPresentJobBkted == 4
replace tempmin = 121 if HeadYearsPresentJobBkted == 5
replace tempmin = 240 if HeadYearsPresentJobBkted == 6
replace tempmin = 0 if HeadYearsPresentJobBkted == 0
replace tempmin = 1 if HeadMosPresentEmp94Prior == 1 & year == 1968
replace tempmin = 7 if HeadMosPresentEmp94Prior == 2 & year == 1968
replace tempmin = 19 if HeadMosPresentEmp94Prior == 3 & year == 1968
replace tempmin = 43 if HeadMosPresentEmp94Prior == 4 & year == 1968
replace tempmin = 121 if HeadMosPresentEmp94Prior == 5 & year == 1968
replace tempmin = 240 if HeadMosPresentEmp94Prior == 6 & year == 1968
replace tempmin = 0 if HeadMosPresentEmp94Prior == 0 & year == 1968

gen tempmax = .
replace tempmax = 12 if HeadYearsPresentJobBkted == 1
replace tempmax = 19 if HeadYearsPresentJobBkted == 2
replace tempmax = 42 if HeadYearsPresentJobBkted == 3
replace tempmax = 120 if HeadYearsPresentJobBkted == 4
replace tempmax = 239 if HeadYearsPresentJobBkted == 5
replace tempmax = 999 if HeadYearsPresentJobBkted == 6
replace tempmax = 0 if HeadYearsPresentJobBkted == 0
replace tempmax = 6 if HeadMosPresentEmp94Prior == 1 & year == 1968
replace tempmax = 18 if HeadMosPresentEmp94Prior == 2 & year == 1968
replace tempmax = 42 if HeadMosPresentEmp94Prior == 3 & year == 1968
replace tempmax = 120 if HeadMosPresentEmp94Prior == 4 & year == 1968
replace tempmax = 239 if HeadMosPresentEmp94Prior == 5 & year == 1968
replace tempmax = 999 if HeadMosPresentEmp94Prior == 6 & year == 1968
replace tempmax = 0 if HeadMosPresentEmp94Prior == 0 & year == 1968

replace MosPresEmp = temp2 if inrange(temp2,tempmin,tempmax)
replace MosPresEmp = 0 if temp1 == 0 & inrange(year,1968,1975) & MosPresEmp == .

replace MosPresEmp = temp1 if inrange(year,1968,1975) & MosPresEmp == .
drop temp1

gen FirstYearPos = .
replace FirstYearPos = FWOR1958 if inrange(year,1988,2001) & inrange(FWOR1958,1900,2001)
replace FirstYearPos = 1900 + FWOR1958 if inrange(year,1988,2001) & inrange(FWOR1958,10,99)
replace FirstYearPos = . if FirstYearPos > year

gen FirstMosPos = .
replace FirstMosPos = FWOR1952 if inrange(year,1988,2001) & inrange(FWOR1952,1,12)
replace FirstMosPos = 2 if inrange(year,1988,2001) & FWOR1952 == 21
replace FirstMosPos = 5 if inrange(year,1988,2001) & FWOR1952 == 22
replace FirstMosPos = 8 if inrange(year,1988,2001) & FWOR1952 == 23
replace FirstMosPos = 11 if inrange(year,1988,2001) & FWOR1952 == 24

gen MosTenure = .
replace MosTenure = HeadMosPresentPos if inrange(year,1976,1987) & ((HeadMosPresentPos ~= 99&year==1976)|(HeadMosPresentPos ~= 999&inrange(year,1977,1988)))
sort IndID year Age
by IndID: replace MosTenure = MosTenure[_n+1] - MosBeforeInt if MosTenure == 98 & year == 1976 & MosTenure[_n+1] > 110 & MosTenure[_n+1] ~= . & IndID == IndID[_n+1]
replace MosTenure = MosPresEmp if HeadSamePosPresentEmp == 1 & inrange(year,1988,2001) & MosPresEmp ~= 999
replace MosTenure = 12*(year - FirstYearPos) - FirstMosPos + IntMth if MosTenure == . & FirstYearPos~=. & FirstMosPos ~= .

gsort IndID -year -Age
by IndID: replace MosTenure = MosTenure[_n-1] - MosBeforeInt + 1 if inrange(year,1968,1975) & MosTenure[_n-1] > MosBeforeInt & MosTenure[_n-1] ~= . & IndID == IndID[_n-1]

sort IndID year Age
by IndID: mipolate MosTenure Age, linear gen(temp1)

sort IndID year Age
by IndID: replace MosTenure = ceil(temp1) if temp1>MosTenure[_n-1] & temp1<MosTenure[_n+1] & MosTenure == . & inrange(year,1969,2001) & IndID == IndID[_n-1]

drop temp1

replace MosTenure = 0 if MosPresEmp == 0 & inrange(year,1968,2001)

sort IndID Age

by IndID: egen FirstJobAge = min(AgeStartJob)
gen ThirtyYearsExp = FirstJobAge + 30 if FirstJobAge != .
by IndID: egen FirstJobAgeHVY = min(AgeStartJobHVY)
gen ThirtyYearsExpHVY = FirstJobAgeHVY + 30 if FirstJobAgeHVY != .

gen tempLastSchool = Age if EmpStat == 7 | YrsSchool < MaxYrsSchool & EmpStat != . & YrsSchool != . & MaxYrsSchool != . & Age <= FirstJobAge
sort IndID Age
by IndID: egen AgeLastSchool = max(tempLastSchool)
drop tempLastSchool

sort IndID Age
by IndID: gen RecdTraining3 = (HadTraining==1&HadTraining[_n-1]==5&IndID==IndID[_n-1]&IndID[_n-1]!=.)

gen RecdTraining = ((RecdTraining1==1|RecdTraining2==1|RecdTraining3==1)&year~=2009)
replace RecdTraining = 1 if (RecdTraining1 == 1 | RecdTraining2 == 1)& year == 2009

svyset IndCluster [pweight = longweight], strata(IndStratum) singleunit(certainty)

gen NewEmp = (inrange(MosPresEmp,1,12))

gen subpopNoJobNoObs = ((Age <= FirstJobAgeHVY &((Age > FirstPanelAge & FirstPanelAge != .)|NewEmp==1)|(Age < FirstJobAgeHVY)) & Age <= 30 & Sex == 1)
gen subpopNoJob = ((Age <= FirstJobAgeHVY &((Age > FirstPanelAge & FirstPanelAge != .)|NewEmp==1)|(Age < FirstJobAgeHVY))&((Age<=20&EdLvls==0)|(Age<=22&EdLvls==1)|(Age<=24&EdLvls==2)|(Age<=25&EdLvls==3)|(Age<=30&EdLvls==4)|(Age<=35&EdLvls==5))& Sex == 1 & EmpStat != 7)
gen subpopNoJob2 = ((Age <= FirstJobAgeHVY &((Age > FirstPanelAge & FirstPanelAge != .)|NewEmp==1)|(Age < FirstJobAgeHVY)) & Age <= 30)

gen subpopFirstJob = ((Age == FirstJobAgeHVY)|((Age > FirstPanelAge & FirstPanelAge != .)&NewEmp==1))

ren FWOR876 HrsWrked

svy, subpop(subpopNoJobNoObs): reg RWealth year
gen RWealthStat = RWealth + _b[year]*(2011-year) if RWealth != .
svy, subpop(subpopNoJobNoObs): reg RLiqWealth year
gen RLiqWealthStat = RLiqWealth + _b[year]*(2011-year) if RLiqWealth != .
svy, subpop(subpopNoJobNoObs): reg RFinWealth year
gen RFinWealthStat = RFinWealth + _b[year]*(2011-year) if RFinWealth != .

gen RWealth_pctile = .
gen RLiqWealth_pctile = .
gen RFinWealth_pctile = .

egen rank = rank(RWealth), unique
qui: xtile temp = rank [pweight=longweight], nq(5)
replace RWealth_pctile = temp if RWealth != .
drop temp rank
egen rank = rank(RLiqWealth), unique
qui: xtile temp = rank [pweight=longweight], nq(5)
replace RLiqWealth_pctile = temp if RLiqWealth != .
drop temp rank
egen rank = rank(RFinWealth), unique
qui: xtile temp = rank [pweight=longweight], nq(5)
replace RFinWealth_pctile = temp if RFinWealth != .
drop temp rank

gen RWealth_Presentpctile = .
gen RLiqWealth_Presentpctile = .
gen RFinWealth_Presentpctile = .

egen rank = rank(RWealth), unique
qui: xtile temp = rank [pweight=longweight], nq(5)
replace RWealth_Presentpctile = temp if RWealth != .
drop temp rank
egen rank = rank(RLiqWealth), unique
qui: xtile temp = rank [pweight=longweight], nq(5)
replace RLiqWealth_Presentpctile = temp if RLiqWealth != .
drop temp rank
egen rank = rank(RFinWealth), unique
qui: xtile temp = rank [pweight=longweight], nq(5)
replace RFinWealth_Presentpctile = temp if RFinWealth != .
drop temp rank

gen RWealth_Presentqtile = .
gen RLiqWealth_Presentqtile = .
gen RFinWealth_Presentqtile = .

egen rank = rank(RWealth), unique
qui: xtile temp = rank [pweight=longweight], nq(4)
replace RWealth_Presentqtile = temp if RWealth != .
drop temp rank
egen rank = rank(RLiqWealth), unique
qui: xtile temp = rank [pweight=longweight], nq(4)
replace RLiqWealth_Presentqtile = temp if RLiqWealth != .
drop temp rank
egen rank = rank(RFinWealth), unique
qui: xtile temp = rank [pweight=longweight], nq(4)
replace RFinWealth_Presentqtile = temp if RFinWealth != .
drop temp rank

gen RWealth_qtile = .
gen RLiqWealth_qtile = .
gen RFinWealth_qtile = .

egen rank = rank(RWealth), unique
qui: xtile temp = rank [pweight=longweight], nq(4)
replace RWealth_qtile = temp if RWealth != .
drop temp rank
egen rank = rank(RLiqWealth), unique
qui: xtile temp = rank [pweight=longweight], nq(4)
replace RLiqWealth_qtile = temp if RLiqWealth != .
drop temp rank
egen rank = rank(RFinWealth), unique
qui: xtile temp = rank [pweight=longweight], nq(4)
replace RFinWealth_qtile = temp if RFinWealth != .
drop temp rank

gen RWealth_med = .
gen RLiqWealth_med = .
gen RFinWealth_med = .

egen rank = rank(RWealth), unique
qui: xtile temp = rank [pweight=longweight], nq(2)
replace RWealth_med = temp if RWealth != .
drop temp rank
egen rank = rank(RLiqWealth), unique
qui: xtile temp = rank [pweight=longweight], nq(2)
replace RLiqWealth_med = temp if RLiqWealth != .
drop temp rank
egen rank = rank(RFinWealth), unique
qui: xtile temp = rank [pweight=longweight], nq(2)
replace RFinWealth_med = temp if RFinWealth != .
drop temp rank

gen LRWage_pctile = .
gen LRLabInc_pctile = .

egen rank = rank(LRWage), unique
qui: xtile temp = rank [pweight=longweight], nq(5)
replace LRWage_pctile = temp if RWealth != .
drop temp rank
egen rank = rank(LRLabInc), unique
qui: xtile temp = rank [pweight=longweight], nq(5)
replace LRLabInc_pctile = temp if RLiqWealth != .
drop temp rank


cd "$tmpdir"
save temp3, replace
