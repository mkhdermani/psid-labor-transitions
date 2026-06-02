clear
set more off
set maxvar 20000

*Set Ben's Path
cd "$projdir"

*Copy and pasted text from FileStructure.pdf, from the PSID:
/*
First select individuals and variables from the cross-year individual file (remembering to retain all
relevant annual family Interview Number variables) and then match that data with the desired variables
from a single-year family file, matching on the appropriate annual family Interview Number variable,
using a one-to-many match.

Next, match the resulting file (which now contains one record for each individual with selected variables
from the cross-year individual file and the first family file) with a second family file matching on the
appropriate annual family Interview Number variable, using a one-to-many match.

Repeat with additional single-year family files until all required family data are obtained and merged
with the cross-year individual data, as the diagram below shows.
*/

*FIRST: Load 1968 Family File and merge it to the Cross-year Individual File
use FAMILY_1968_Small, clear
ren ID_1968 ID1968
merge 1:m ID1968 using Individual_Small, nogen
save FAMILY_INDIVIDUAL, replace

*SECOND: Merge the remaining Family Files 1969-2015 to FAMILY_INDIVIDUAL
forvalues t=1969/1996 {
	use FAMILY_`t'_Small, clear
	ren ID_`t' ID`t'
	merge 1:m ID`t' using FAMILY_INDIVIDUAL, nogen
	save FAMILY_INDIVIDUAL, replace
}

forvalues t=1997(2)2015 {
	use FAMILY_`t'_Small, clear
	ren ID_`t' ID`t'
	merge 1:m ID`t' using FAMILY_INDIVIDUAL, nogen
	save FAMILY_INDIVIDUAL, replace
}

*THIRD: Merge the Wealth Supplements, 1984, 1989, 1994, 1999, 2001, 2003, 2005, 2007.
	*Note: the Wealth Supplement variables for 2009 and 2011 are already loaded in the PSID Family Files for 2009, 2011, 2013, and 2015
	
global	years 	1984 1989 1994 1999 2001 2003 2005 2007

foreach y of global years {

cd "$datadir"
	global t=`y'
	use WLTH_`y', clear
	cd "$progdir/data_prep"
	ren S*01* ID`y'
	do WEALTH
	keep *`y'
		
cd "$projdir"
merge 1:m ID`y' using FAMILY_INDIVIDUAL, nogen
		save FAMILY_INDIVIDUAL, replace
}


cd "$projdir"		
		use FAMILY_INDIVIDUAL, clear

/*
*FOURTH: Merge the Childbirth and Adoption History File to FAMILY_INDIVIDUAL
cd "$datadir"
use CAH85_11, clear

	rename CAH9 ID1968
	rename CAH10 PersonNumber
	gen IndID = (ID1968*1000)+PersonNumber
	drop ID1968 PersonNumber
	drop if IndID==0
	drop if IndID==9999999
	keep if CAH1==1 // Birth Records only, no adoption records
	keep if CAH4==2 // Information from mother's only, not fathers or adoptive parents

cd "$projdir"
merge 1:m IndID using FAMILY_INDIVIDUAL
	order IndID
	sort IndID
	rename CAH8 BirthOrder
	replace BirthOrder=. if BirthOrder==99 
	drop _merge
	drop CAH*
*/
    cd "$projdir"	
save FAMILY_INDIVIDUAL, replace


