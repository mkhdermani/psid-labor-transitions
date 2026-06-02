clear
set more off, permanently
set maxvar 20000, permanently

*NOTE: ALL THIS FILE DOES IS TAKE PSID RAW FILES AND SAVE THEM AS STATA DATASETS

*Set Ben's Path
/* cd "C:\Users\Ben\Dropbox\Research\Household Wealth and Life-Cycle Inequality\Data\PSID\Data" */

cd "$datadir"

*Load and rename all the family files as PSID_`year'.
	*From 1968-1996, the PSID was yearly.
	forvalues year=1968/1996 {
		cd ..
		cd "do_files"
		do FAM`year'
		cd ..
		cd ..
		cd "$datadir"
		save PSID_`year'.dta, replace
		}
		
	*From 1997-2011, the PSID was bi-yearly.
	forvalues year=1997(2)2015 {
		cd ..
		cd "do_files"
		do FAM`year'
		cd ..
		cd ..
		cd "$datadir"
		save PSID_`year'.dta, replace
		}

*Load and rename the cross-year individual file as PSID_Individual
		cd ..
		cd "do_files"
		do IND2015ER
		cd ..
		cd ..
		cd "$datadir"
		save PSID_Individual, replace
		
*Lead and rename the wealth supplemental files
	foreach year in 1984 1989 1994 1999 2001 2003 2005 2007 {
		cd ..
		cd "do_files"
		do WLTH`year'.do
		cd ..
		cd ..
		cd "$datadir"
		save WLTH_`year'.dta, replace
		}

		
	

/* *Load and rename the Childhood and Adoption History file as CAH_Individual
		cd ..
		cd "do_files"
		do CAH85_11
		cd ..
		cd ..
		cd "Data"
		save CAH85_11, replace */
		

		
/* *Load and rename the FIMS for Siblings
		cd ..
		cd "do_files"
		do fim4910_sib_0
		cd ..
		cd "Data"
		save SIBLINGS, replace */
