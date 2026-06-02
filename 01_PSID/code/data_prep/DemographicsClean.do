clear all
pause on
set more off

*Set Ben's Path
cd "$tmpdir"
use temp1, clear
drop if year < 1000
bysort IndID: gen obs=_N

svyset IndCluster [pweight = Weight_Long], strata(IndStratum) singleunit(center)

gen ID1968_temp = ID if year == 1968
*bysort IndID: egen ID1968 = max(ID1968_temp)

by IndID: egen FirstPanelAge = min(Age)

sort IndID year
by IndID: gen longweight = Weight_Long[_N]
egen minweight = min(longweight) if longweight >0 & longweight !=.
gen freqweight = ceil(longweight/minweight)


sort IndID year

* Clean Schooling data
	replace YrsSchool=. if YrsSchool==0 // Inap.
	replace YrsSchool=. if YrsSchool==98 // DK
	replace YrsSchool=. if YrsSchool==99 // NA
	bysort IndID: egen MaxYrsSchool=max(YrsSchool)

gen FamInc = RLabInc if Age < 31 & RelToHead != 1 & RelToHead != 10 & RelToHead != 2 & RelToHead != 20
bysort IndID: egen FamIncChild = max(FamInc)
gen AgeWhenTemp = Age if FamIncChild == FamInc
bysort IndID: egen AgeWhen = min(AgeWhen)

*ren VAR043 HouseStat

label define HouseStat ///
	1 "Owns or has Mortgage" ///
	5 "Rents" ///
	8 "NA;Neither"
label values HouseStat HouseStat

ren FPAR133 HeadFathersEd
ren FPAR134 HeadMothersEd
ren FPAR139 WifeFathersEd
ren FPAR140 WifeMothersEd

replace HeadFathersEd = 9 if HeadFathersEd == 99
replace HeadFathersEd = 9 if HeadFathersEd == 98
replace HeadFathersEd = 9 if HeadFathersEd == .
replace HeadFathersEd = 9 if HeadFathersEd == 12
replace HeadMothersEd = 9 if HeadMothersEd == 99
replace HeadMothersEd = 9 if HeadMothersEd == 98
replace HeadMothersEd = 9 if HeadMothersEd == .
replace HeadMothersEd = 9 if HeadMothersEd == 12
replace WifeFathersEd = 9 if WifeFathersEd == 99
replace WifeFathersEd = 9 if WifeFathersEd == 98
replace WifeFathersEd = 9 if WifeFathersEd == .
replace WifeFathersEd = 9 if WifeFathersEd == 12
replace WifeMothersEd = 9 if WifeMothersEd == 99
replace WifeMothersEd = 9 if WifeMothersEd == 98
replace WifeMothersEd = 9 if WifeMothersEd == .
replace WifeMothersEd = 9 if WifeMothersEd == 12

label define EdLabs ///
	1 "Grades 0-5, or DK/Couldn't Read or Write" ///
	2 "Grades 6-8, or DK/Could Read and Write" ///
	3 "9-11, some HS, no Degree" ///
	4 "12, HS Degree" ///
	5 "5, HS Degree plus non-academic training" ///
	6 "Some College, no Degree" ///
	7 "College Degree" ///
	8 "College Degree plus Advanced Degree" ///
	9 "Na;DK" ///
	0 "Inap.: Parent Not Around"
label values HeadFathersEd EdLabs
label values HeadMothersEd EdLabs
label values WifeFathersEd EdLabs
label values WifeMothersEd EdLabs

gen EdLvls = 0 if MaxYrsSchool != .
replace EdLvls = 1 if MaxYrsSchool == 12
replace EdLvls = 2 if inrange(MaxYrsSchool,13,15)
replace EdLvls = 3 if MaxYrsSchool == 16
replace EdLvls = 4 if inrange(MaxYrsSchool,17,.)

label define EdLvlLabs ///
	0 "Some HS or less" ///
	1 "HS Degree" ///
	2 "Some College, no Degree" ///
	3 "College Degree" ///
	4 "Graduate Experience" ///
	
label values EdLvls EdLvlLabs

sort IndID Age
by IndID: egen ChildhdECStat = median(HeadChildhoodECStat)
by IndID: gen ChildhdECStatFirst = HeadChildhoodECStat[1]
by IndID: gen ChildhdECStatLast = HeadChildhoodECStat[_N]

*ren HeadChildhoodECStat ChildhdECStat
replace ChildhdECStat = 9 if ChildhdECStat == 0 | ChildhdECStat == 8
replace ChildhdECStat = . if ChildhdECStat != 1 & ChildhdECStat != 3 & ChildhdECStat != 5 & ChildhdECStat != 9
replace ChildhdECStatFirst = 9 if ChildhdECStatFirst == 0 | ChildhdECStatFirst == 8
replace ChildhdECStatLast = 9 if ChildhdECStatLast == 0 | ChildhdECStatLast == 8

label define ChildhdECStat ///
	1 "Poor" ///
	3 "Average, it Varied" ///
	5 "Well off" ///
	9 "Na;DK" 
label values ChildhdECStat ChildhdECStat
label values ChildhdECStatFirst ChildhdECStatFirst
label values ChildhdECStatLast ChildhdECStatLast

sort IndID Age
replace YrsSchool = MaxYrsSchool if YrsSchool[_n-1] == MaxYrsSchool & missing(YrsSchool)
replace YrsSchool = YrsSchool[_n-1] if IndID == IndID[_n-1] & IndID == IndID[_n+1] & YrsSchool[_n-1] == YrsSchool[_n+1] & YrsSchool[_n-1] != .
replace YrsSchool = YrsSchool[_n-1] + year - year[_n-1] if IndID == IndID[_n-1] & IndID == IndID[_n+1] & YrsSchool[_n+1] == (year[_n+1] - year[_n-1] + YrsSchool[_n-1]) & missing(YrsSchool)

sort IndID Age
by IndID: gen StillInSchool = (YrsSchool[_n+1] >= YrsSchool + 1 & IndID == IndID[_n+1])

gen State = CurrentState
*gen MarDum = (VAR003 == 1)

sort IndID Age
replace Age = Age[_n-1] + year - year[_n-1] if IndID == IndID[_n-1] & Age == .
/* sort IndID Age */
/* replace year = year[_n-1] + 1 if IndID == IndID[_n-1] & year[_n-1] < 1995 */
/* replace year = year[_n-1] + 2 if IndID == IndID[_n-1] & year[_n-1] >= 1995 */
sort IndID Age
replace CurrentState = CurrentState[_n-1] if CurrentState[_n+1] == CurrentState[_n-1] & IndID == IndID[_n-1] & IndID == IndID[_n+1] & CurrentState == .
sort IndID Age
by IndID: egen racetemp = max(Race)
replace Race = racetemp if Race == .


cd "$tmpdir"
save temp2, replace

