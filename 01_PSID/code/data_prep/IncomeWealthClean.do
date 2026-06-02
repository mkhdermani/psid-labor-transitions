clear all
pause on
set more off

*Set Ben's Path
cd "$projdir"

use PanelReshaped, clear
	
sort IndID Age

by IndID: egen temp1 = max(IndCluster)
by IndID: egen temp2 = max(IndStratum)

by IndID: replace IndCluster = temp1
by IndID: replace IndStratum = temp2

drop temp1 temp2

svyset IndCluster [pweight = Weight_Long], strata(IndStratum) singleunit(certainty)

*Drop observations based on the reported Age variable:
	drop if ID==0 // Means that the individual was not part of that year's PSID
	drop if Age==0 // Inap. Individual from core sample who was born or moved in after the 1968 interview or individual from Immigrant or Latino samples
	drop if Age==999 // NA/DK
	
	/*	These are used to replicate Solon's results, but not necessary yet to drop observations where AgeOfHead is unavailable.
	drop if S1==0 // Wild Code
	drop if S1==99 // NA/DK
	drop if S1==98 // DK
	drop if S1==.
	drop if S1==999 // NA; DK
	*/
	
{ //Generate Total Family Income Variable
	*Trim the Total Family Income variable.
        *Chadwick and Solon (2002) exclude families whose income is non-positive
        drop if NomFamInc<=0 //151 observations deleted.
        
        *Lee and Solon (2009) exclude income observations imputed by "major assignments"
        *keep if FamIncMajorAssignment==0 | FamIncMajorAssignment==.
        *drop FamIncMajorAssignment
		
	*Deal with top-coding of Total Family Income
	bysort year: sum NomFamInc
	*1967 has no issue
	*1968 has no issue
	*1969 has no issue
	gen wagestopcoded = .
	gen faminctopcoded = .
	replace wagestopcoded = (NomLabInc==99999&inrange(year,1970,1982))
	replace wagestopcoded = (NomLabInc==999999&inrange(year,1983,1992))
	replace wagestopcoded = (NomLabInc==9999999&inrange(year,1993,1994))
	replace wagestopcoded = (NomLabInc==9999999&inrange(year,1999,2015))
	drop if NomLabInc==9999999&inrange(year,1990,1998)
	replace faminctopcoded = (NomFamInc==99999&inrange(year,1970,1978))
	gen intinctopcoded = .
	replace intinctopcoded = (FINC518 >= 999999) if FINC518~=.
	replace intinctopcoded = (FINC508 >= 999999) if FINC508~=.
	replace intinctopcoded = (FINC393 >= 999999) if FINC393~=.
	replace intinctopcoded = (FINC406 >= 99999) if FINC406~=.&inrange(year,1976,.)
	*replace FINC518 = . if FINC518 >= 999998
	*replace FINC508 = . if FINC508 >= 999998
	*replace FINC406 = . if FINC406 >= 999999&inrange(year,1976,.)
	*1979 has no issue
	*1980 has no issue
	*1981 has no issue
	*1982 has no issue
	*1983 has no issue
	*1984 has no issue
	*1985 has no issue
	*1986 has no issue
	*1987 has no issue
	*1988 has no issue
	*1989 has no issue
	*1990 has no issue
	*1991 has no issue
	*1992 has no issue
	*drop if year==1993 & NomFamInc==9999999 // Latino VARample family
	*drop if year==1994 & NomFamInc==9999999 // Latino VARample family
	replace FWOR398 = . if FWOR398 == 99.99 & year < 1993
	replace FWOR398 = . if FWOR398 == 9999.00 | FWOR398 == 9998.00 | (FWOR398 == 9999.99 & year >= 1993)
	*1995 has no issue
	*1996 has no issue
	*1997 has no issue
	*1999 has no issue
	*2001 has no issue
	*2003 has no issue
	*2005 has no issue
	*2007 has no issue
	*2009 has no issue
	
	*Correcting labor Income
	ren FINC465 NomLabTotInc
	replace NomLabInc = NomLabTotInc if inrange(year,1968, 1969)
	
	*Must do the same thing for wealth
	gen wealthtopcoded = .
	gen wealthbottomcoded = .
	gen liqwealthtopcoded = .
	gen liqwealthbottomcoded = .
	gen savingstopcoded = .
	gen stockstopcoded = .
	gen stocksbottomcoded = .
	gen othdebttopcoded = .
	replace wealthtopcoded = (TotalWealth==999999999&inrange(year,1984,2015))
	replace wealthbottomcoded = (TotalWealth==-99999999&inrange(year,1984,2015))
	replace liqwealthtopcoded = (TotalLiquidWealth==999999999&inrange(year,1984,2015))
	replace liqwealthbottomcoded = (TotalLiquidWealth==-99999999&inrange(year,1984,2015))
	replace savingstopcoded = (StocksAmt==999999999&inrange(year,1984,2015))
	replace stockstopcoded = (StocksAmt==999999999&inrange(year,1984,2015))
	replace stocksbottomcoded = (StocksAmt==-99999999&inrange(year,1984,2015))
	replace othdebttopcoded = (StocksAmt==999999999&inrange(year,1984,2015))
	
	gen NetFinWealth = StocksAmt + CheckingAmt - OtherDebtAmt
	
	gen TransFromRel = HeadTransFromRel if year <1993
	replace TransFromRel = HeadTransFromRel93On if year >= 1993

	gen TransFromRelBrkted = TransFromRel if year < 1976

	*Convert Total Family Income into 1967 $'s, and drop if RLabInc<100 or RLabInc>150,000
		/*	Recall reported income in the 1968 survey is income earned in 1967
			Therefore 1968 income does not need to be adjusted.
			I have made sure that I am converting income reported in 1969, which was
			income received in 1968 using the correct CPI-U deflator (i.e. converting 1968 to 1967 $'s).
			I have done this one year pull-back for all years when calculating the deflators. */
			
	gen IntIncEst =	NomFamTaxInc - NomLabTotInc - NomSpouseLabInc
	gen IntInc = FINC406 if inrange(year,1976,1983)
	replace IntInc = FINC393 if inrange(year,1984,1992)
	replace IntInc = (FINC518 + FINC508) if year > 1992
	
	gen RLabInc = .
	gen RTransInc = .
	gen RWage = .
	gen RFamInc = .
	gen RLabTotInc = .
	gen RWealth = . 
	gen RLiqWealth = .
	gen RFinWealth = .
	gen RLabIncEst = FWOR876*FWOR398
	gen RTransFromRel = .
	gen RIntInc = .
	gen RIntIncEst = .
	cpigen
	
	replace cpiu = 1.37380381644 if year == 2015

	replace RFamInc = NomFamInc/cpiu
	replace RLabTotInc = NomLabTotInc/cpiu
	replace RLabInc = NomLabInc/cpiu
	replace RTransInc = NomTotalTransInc/cpiu
	replace RWage = FWOR398/cpiu
	replace RWealth=TotalWealth/cpiu
	replace RLiqWealth=TotalLiquidWealth/cpiu
	replace RFinWealth=NetFinWealth/cpiu
	replace RLabIncEst = RLabIncEst/cpiu
	replace RTransFromRel = TransFromRel/cpiu if year >=1976
	replace RIntInc = IntInc/cpiu
	replace RIntIncEst = IntIncEst/cpiu
			
			
	**Convert base year 2000 to base year 2011
			
	replace RFinWealth= RFinWealth*1.304
	replace RWealth= RWealth*1.304
	replace RLiqWealth= RLiqWealth*1.304
	replace RWage = RWage*1.304
	replace RLabInc = RLabInc*1.304
	replace RTransInc = RTransInc*1.304
	replace RFamInc = RFamInc*1.304
	replace RLabTotInc = RLabTotInc*1.304
	replace RLabIncEst = RLabIncEst*1.304
	replace RTransFromRel = RTransFromRel*1.304
	replace RIntInc = RIntInc*1.304
	replace RIntIncEst = RIntIncEst*1.304
	
	replace TransFromRelBrkted = 0 if TransFromRel == 0 & year >= 1976
	replace TransFromRelBrkted = 1 if inrange(TransFromRel,1,499) & year >= 1976
	replace TransFromRelBrkted = 2 if inrange(TransFromRel,500,999) & year >= 1976
	replace TransFromRelBrkted = 3 if inrange(TransFromRel,1000,1999) & year >= 1976
	replace TransFromRelBrkted = 4 if inrange(TransFromRel,2000,2999) & year >= 1976
	replace TransFromRelBrkted = 5 if inrange(TransFromRel,3000,4999) & year >= 1976
	replace TransFromRelBrkted = 6 if inrange(TransFromRel,5000,7499) & year >= 1976
	replace TransFromRelBrkted = 7 if inrange(TransFromRel,7500,9999) & year >= 1976
	replace TransFromRelBrkted = 8 if inrange(TransFromRel,10000,.) & year >= 1976
	replace TransFromRelBrkted = 9 if TransFromRel == . & year >= 1976
	
	gen RIntIncBkted = FINC406 if inrange(year,.,1975)
	replace RIntInc = 0 if RIntIncBkted==0 & inrange(IntIncEst,.,0) & inrange(year,.,1975) & RIntInc == .
	replace RIntInc = RIntIncEst if RIntIncBkted==1 & inrange(IntIncEst,1,499) & inrange(year,.,1975) & RIntInc == .
	replace RIntInc = (1*1.304)/cpiu if RIntIncBkted==1 & inrange(IntIncEst,.,1) & inrange(year,.,1975) & RIntInc == .
	replace RIntInc = (499*1.304)/cpiu if RIntIncBkted==1 & inrange(IntIncEst,499,.) & inrange(year,.,1975) & RIntInc == .
	replace RIntInc = RIntIncEst if RIntIncBkted==2 & inrange(IntIncEst,500,999) & inrange(year,.,1975) & RIntInc == .
	replace RIntInc = (500*1.304)/cpiu if RIntIncBkted==2 & inrange(IntIncEst,.,500) & inrange(year,.,1975) & RIntInc == .
	replace RIntInc = (999*1.304)/cpiu if RIntIncBkted==2 & inrange(IntIncEst,999,.) & inrange(year,.,1975) & RIntInc == .
	replace RIntInc = RIntIncEst if RIntIncBkted==3 & inrange(IntIncEst,1000,1999) & inrange(year,.,1975) & RIntInc == .
	replace RIntInc = (1000*1.304)/cpiu if RIntIncBkted==3 & inrange(IntIncEst,.,1000) & inrange(year,.,1975) & RIntInc == .
	replace RIntInc = (1999*1.304)/cpiu if RIntIncBkted==3 & inrange(IntIncEst,1999,.) & inrange(year,.,1975) & RIntInc == .
	replace RIntInc = RIntIncEst if RIntIncBkted==4 & inrange(IntIncEst,2000,2999) & inrange(year,.,1975) & RIntInc == .
	replace RIntInc = (2000*1.304)/cpiu if RIntIncBkted==4 & inrange(IntIncEst,.,2000) & inrange(year,.,1975) & RIntInc == .
	replace RIntInc = (2999*1.304)/cpiu if RIntIncBkted==4 & inrange(IntIncEst,2999,.) & inrange(year,.,1975) & RIntInc == .
	replace RIntInc = RIntIncEst if RIntIncBkted==5 & inrange(IntIncEst,3000,4999) & inrange(year,.,1975) & RIntInc == .
	replace RIntInc = (3000*1.304)/cpiu if RIntIncBkted==5 & inrange(IntIncEst,.,3000) & inrange(year,.,1975) & RIntInc == .
	replace RIntInc = (4999*1.304)/cpiu if RIntIncBkted==5 & inrange(IntIncEst,4999,.) & inrange(year,.,1975) & RIntInc == .
	replace RIntInc = RIntIncEst if RIntIncBkted==6 & inrange(IntIncEst,5000,7499) & inrange(year,.,1975) & RIntInc == .
	replace RIntInc = (5000*1.304)/cpiu if RIntIncBkted==6 & inrange(IntIncEst,.,5000) & inrange(year,.,1975) & RIntInc == .
	replace RIntInc = (7499*1.304)/cpiu if RIntIncBkted==6 & inrange(IntIncEst,7499,.) & inrange(year,.,1975) & RIntInc == .
	replace RIntInc = RIntIncEst if RIntIncBkted==7 & inrange(IntIncEst,7500,9999) & inrange(year,.,1975) & RIntInc == .
	replace RIntInc = (7500*1.304)/cpiu if RIntIncBkted==7 & inrange(IntIncEst,.,7500) & inrange(year,.,1975) & RIntInc == .
	replace RIntInc = (9999*1.304)/cpiu if RIntIncBkted==7 & inrange(IntIncEst,9999,.) & inrange(year,.,1975) & RIntInc == .
	replace RIntInc = RIntIncEst if RIntIncBkted==8 & inrange(IntIncEst,10000,.) & inrange(year,.,1975) & RIntInc == .
	replace RIntInc = (10000*1.304)/cpiu if RIntIncBkted==8 & inrange(IntIncEst,.,10000) & inrange(year,.,1975) & RIntInc == .
	replace RIntInc = . if RIntIncBkted==9 & inrange(year,.,1975) & RIntInc == .
	
	gen RTransFromRelBkted = FINC406 if inrange(year,.,1975)
	replace RTransFromRel = 0 if RTransFromRelBkted==0  & inrange(year,.,1975) & RTransFromRel == .
	replace RTransFromRel = (250*1.304)/cpiu if RTransFromRelBkted==1  & inrange(year,.,1975) & RTransFromRel == .
	replace RTransFromRel = (750*1.304)/cpiu if RTransFromRelBkted==2  & inrange(year,.,1975) & RTransFromRel == .
	replace RTransFromRel = (1500*1.304)/cpiu if RTransFromRelBkted==3  & inrange(year,.,1975) & RTransFromRel == .
	replace RTransFromRel = (2500*1.304)/cpiu if RTransFromRelBkted==4  & inrange(year,.,1975) & RTransFromRel == .
	replace RTransFromRel = (4000*1.304)/cpiu if RTransFromRelBkted==5  & inrange(year,.,1975) & RTransFromRel == .
	replace RTransFromRel = (6250*1.304)/cpiu if RTransFromRelBkted==6 & inrange(year,.,1975) & RTransFromRel == .
	replace RTransFromRel = (8250*1.304)/cpiu if RTransFromRelBkted==7 & inrange(year,.,1975) & RTransFromRel == .
	replace RTransFromRel = (10000*1.304)/cpiu if RTransFromRelBkted==8 & inrange(year,.,1975) & RTransFromRel == .
	replace RTransFromRel = . if RTransFromRelBkted==9 & inrange(year,.,1975) & RTransFromRel == .
	
	drop cpi cpiu
			
			
*			drop if RLabInc<100 | RLabInc>300000
	*drop if RIntInc < 0
	
	gen LRWage=ln(RWage) if RWage>0 & RWage !=.
	gen LRLabInc=ln(RLabInc) if RLabInc>0 & RLabInc !=.
	gen LRLabTotInc=ln(RLabTotInc) if RLabTotInc>0 & RLabTotInc !=.

replace OtherDebtAmt = . if OtherDebtAmt >= 999997 & OtherDebtAmt != . & year <= 1989
replace OtherDebtAmt = . if OtherDebtAmt >= 9999998 & OtherDebtAmt != . & year == 1994
replace OtherDebtAmt = . if OtherDebtAmt > 999999997 & OtherDebtAmt != . & year >= 1999


gen WageACC = (FINC991!=0)
replace WageACC = 0 if inrange(year,1968,1969) & FWOR398 != 99.99
replace WageACC = 1 if inrange(year,1968,1969) & FWOR398 == 99.99

label define ACCVars ///
	0 "Not Imputed" ///
	1 "Imputed" 
*label values FinWealthACC ACCVars
*label values WealthACC ACCVars
*label values LiqWealthACC ACCVars
label values WageACC ACCVars


label define TransInc_yn ///
	1 "Received Transfer Income" ///
	5 "Did not Receive Transfer Income" ///
	9 "NA"
label values TransInc_yn TransInc_yn



label define TransFromRelBrkted ///
	0 "None" ///
	1 "1-499" ///
	2 "500-999" ///
	3 "1000-1999" ///
	4 "2000-2999" ///
	5 "3000-4999" ///
	6 "5000-7499" ///
	7 "7500-9999" ///
	8 "10000 or more" ///
	9 "Na"
label values TransFromRelBrkted TransFromRelBrkted



sort year ID

by year ID: egen RFamWealth = total(RWealth)
by year ID: egen RFamLiqWealth = total(RLiqWealth)
by year ID: egen RFamFinWealth = total(RFinWealth)

sort IndID Age

replace RFamWealth = . if RWealth == .
replace RFamLiqWealth = . if RLiqWealth == .
replace RFamFinWealth = . if RFinWealth == .

sort IndID Age

gen ExternalWealth = RFamWealth - RWealth
gen ExternalLiqWealth = RFamLiqWealth - RLiqWealth
gen ExternalFinWealth = RFamFinWealth - RFinWealth

gen RWealthPerPerson = RWealth/NumFam

replace TransInc_yn = 0 if TransInc_yn == 5
replace TransInc_yn = 9 if TransInc_yn == . | TransInc_yn == 8

svy: reg RTransFromRel year if year >= 1976
gen RTransFromRelStat = RTransFromRel + _b[year]*(1976 - year) if year >= 1976 & TransFromRel!=.
replace RTransFromRelStat = 0 if RTransFromRelStat < 0 & TransFromRel!=. & year >= 1976
replace RTransFromRelStat = 0 if TransInc_yn == 0 & RTransFromRelStat == . & year >=1976

replace TransFromRelBrkted = 0 if RTransFromRelStat == 0 & year >= 1976
replace TransFromRelBrkted = 1 if inrange(RTransFromRelStat,1,499) & year >= 1976
replace TransFromRelBrkted = 2 if inrange(RTransFromRelStat,500,999) & year >= 1976
replace TransFromRelBrkted = 3 if inrange(RTransFromRelStat,1000,1999) & year >= 1976
replace TransFromRelBrkted = 4 if inrange(RTransFromRelStat,2000,2999) & year >= 1976
replace TransFromRelBrkted = 5 if inrange(RTransFromRelStat,3000,4999) & year >= 1976
replace TransFromRelBrkted = 6 if inrange(RTransFromRelStat,5000,7499) & year >= 1976
replace TransFromRelBrkted = 7 if inrange(RTransFromRelStat,7500,9999) & year >= 1976
replace TransFromRelBrkted = 8 if inrange(RTransFromRelStat,10000,.) & year >= 1976
replace TransFromRelBrkted = 9 if RTransFromRelStat == . & year >= 1975 & TransInc_yn == .
replace TransFromRelBrkted = 9 if RTransFromRelStat == . & year >= 1975 & TransInc_yn == 1
replace TransFromRelBrkted = 0 if RTransFromRelStat == . & year >= 1975 & TransInc_yn == 0

}				


cd "$tmpdir"
save temp1, replace
