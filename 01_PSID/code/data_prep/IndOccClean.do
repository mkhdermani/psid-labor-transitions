clear all
pause on
set more off
set matsize 10000
set maxvar 32767
set emptycells drop


*Set Ben's Path


/* use SHCBC_PSIDFinal.dta, replace */

cd "$progdir"
cd ".."
use cw_ind1980_ind1990ddx, clear
/* ren ind1990ddx MainInd */
cd "$projdir"
sort ind1990ddx
save convInd1990to1980.dta, replace
cd "$progdir"
cd ".."
use cw_ind2000_ind1990ddx, clear
ren ind2000 MainInd
cd "$projdir"
sort MainInd
save convInd2000to1990.dta, replace


use PSIDFullPanel_Final.dta, replace

ren FWOR445 MainOcc1DigitBefore03
ren FWOR1034 MainOcc3DigitBefore03
ren FWOR447 MainOcc3DigitAfter03

*ren FWOR974 MainInd1DigitBefore03
ren FWOR974 MainInd3DigitBefore03
ren FWOR980 MainInd3DigitAfter03

gen MainOcc = .
replace MainOcc = MainOcc3DigitBefore03 if inrange(year,1980,2001)
replace MainOcc = MainOcc3DigitAfter03 if inrange(year,2003,2017)

gen MainInd = .
replace MainInd = MainInd3DigitBefore03 if inrange(year,1980,2001)
replace MainInd = MainInd3DigitAfter03 if inrange(year,2003,2017)


** convert 1970s industry code to 1980s

gen ind1980Cens2digit = .
replace ind1980Cens2digit = 1 if inrange(MainInd,17,28) & inrange(year,1968,2001) /* Aggriculture, Forestry, and Fisheries */
replace ind1980Cens2digit = 2 if inrange(MainInd,47,57) & inrange(year,1968,2001) /* Mining */
replace ind1980Cens2digit = 3 if inrange(MainInd,67,77) & inrange(year,1968,2001) /* Construction */
replace ind1980Cens2digit = 4 if (inrange(MainInd,268,398)|inrange(MainInd,107,259)) & inrange(year,1968,2001) /* Manufacturing */
replace ind1980Cens2digit = 5 if (inrange(MainInd,407,479)|MainInd==907) & inrange(year,1968,2001)  /* Transportation */
replace ind1980Cens2digit = 6 if inrange(MainInd,507,698) & inrange(year,1968,2001) /* Wholesale Trade */
replace ind1980Cens2digit = 7 if inrange(MainInd,707,718) & inrange(year,1968,2001) /* Finance, Insurance, and Real Estate */
replace ind1980Cens2digit = 8 if inrange(MainInd,727,759) & inrange(year,1968,2001) /* Business and Repair Services */
replace ind1980Cens2digit = 9 if inrange(MainInd,769,798) & inrange(year,1968,2001) /* Personal Services */
replace ind1980Cens2digit = 10 if (inrange(MainInd,807,809)|MainInd==408) & inrange(year,1968,2001) /* Entertainment and Recreation Services */
replace ind1980Cens2digit = 11 if inrange(MainInd,828,897) & inrange(year,1968,2001) /* Professional and Related Services */
replace ind1980Cens2digit = 12 if inrange(MainInd,917,937) & inrange(year,1968,2001) /* Public Administration */

replace ind1980Cens2digit = 1 if inrange(MainInd,17,29) & inrange(year,2002,2017) /* Aggriculture, Forestry, and Fisheries */
replace ind1980Cens2digit = 2 if inrange(MainInd,37,49) & inrange(year,2002,2017) /* Mining */
replace ind1980Cens2digit = 3 if MainInd==77 & inrange(year,2002,2017) /* Construction */
replace ind1980Cens2digit = 4 if (inrange(MainInd,107,399)|inrange(MainInd,647,678)) & inrange(year,2002,2017) /* Manufacturing */
replace ind1980Cens2digit = 5 if (inrange(MainInd,607,639)|inrange(MainInd,57,69)) & inrange(year,2002,2017)  /* Transportation */
replace ind1980Cens2digit = 6 if inrange(MainInd,407,579) & inrange(year,2002,2017) /* Wholesale Trade */
replace ind1980Cens2digit = 7 if inrange(MainInd,687,719) & inrange(year,2002,2017) /* Finance, Insurance, and Real Estate */
replace ind1980Cens2digit = 8 if (inrange(MainInd,877,888)|inrange(MainInd,758,779)|MainInd==747) & inrange(year,2002,2017) /* Business and Repair Services */
replace ind1980Cens2digit = 9 if inrange(MainInd,897,929) & inrange(year,2002,2017) /* Personal Services */
replace ind1980Cens2digit = 10 if inrange(MainInd,856,869) & inrange(year,2002,2017) /* Entertainment and Recreation Services */
replace ind1980Cens2digit = 11 if (inrange(MainInd,786,847)|inrange(MainInd,727,749)) & inrange(year,2002,2017) /* Professional and Related Services */
replace ind1980Cens2digit = 12 if inrange(MainInd,937,959) & inrange(year,2002,2017) /* Public Administration */

label define ind19802digit 1 "Agriculture, Forestry, and Fisheries" 2 "Mining" 3 "Construction" 4 "Manufacturing" 5 "Transportation" 6 "Wholesale Trade" 7 "Finance, Insurance, and Real Estate" 8 "Business and Repair Services" 9 "Personal Services" 10 "Entertainment and Recreation Services" 11 "Professional and Related Services" 12 "Public Administration"
label values ind1980Cens2digit ind19802digit

gen occ1980Cens2digit = .
replace occ1980Cens2digit = 1 if (inrange(MainOcc,201,245)|MainOcc==1|MainOcc==195|inrange(MainOcc,450,452)) & inrange(year,1968,2001) /* Executive Administrative and Managerial Occupations */
replace occ1980Cens2digit = 2 if (inrange(MainOcc,2,194)|MainOcc==425|MainOcc==923) & inrange(year,1968,2001) /* Professional Specialty Occupations */
replace occ1980Cens2digit = 3 if (inrange(MainOcc,80,83)|MainOcc==85|MainOcc==22|inrange(MainOcc,150,173)|MainOcc==3|MainOcc==926) & inrange(year,1968,2001) /* Technicians and Related Support Occupations */
replace occ1980Cens2digit = 4 if (inrange(MainOcc,260,285)|MainOcc==310|MainOcc==314) & inrange(year,1968,2001) /* Sales Occupations */
replace occ1980Cens2digit = 5 if (inrange(MainOcc,301,395) & MainOcc!=310&MainOcc!=314) & inrange(year,1968,2001) /* Administrative Support Occupations, Including Clerical */
replace occ1980Cens2digit = 6 if inrange(MainOcc,980,984) & inrange(year,1968,2001) /* Private Hoursehold Occupations */
replace occ1980Cens2digit = 7 if inrange(MainOcc,960,965) & inrange(year,1968,2001) /* Protective Service Occupations */
replace occ1980Cens2digit = 8 if (inrange(MainOcc,901,954)|MainOcc==84) & MainOcc!=923 & MainOcc!=926 & inrange(year,1968,2001) /* Service Occupations, Except Protective and Household */
replace occ1980Cens2digit = 9 if inrange(MainOcc,801,802) & inrange(year,1968,2001) /* Farm Operators and Managers */
replace occ1980Cens2digit = 10 if inrange(MainOcc,821,824) & inrange(year,1968,2001) /* Other Agricultural and Related Occupations */
replace occ1980Cens2digit = 11 if MainOcc==761 & inrange(year,1968,2001) /* Forestry and Logging Occupations  (|MainOcc==450) */
replace occ1980Cens2digit = 12 if MainOcc==752 & inrange(year,1968,2001) /* Fishers, Hunters and Trappers (|MainOcc==701)*/
replace occ1980Cens2digit = 13 if (inrange(MainOcc,470,495)|MainOcc==403|MainOcc==433|MainOcc==516|inrange(MainOcc,552,553)) & inrange(year,1968,2001)  /* Mechanics and Repairers */
replace occ1980Cens2digit = 14 if (inrange(MainOcc,401,600)|MainOcc==441|MainOcc==571)&!(inrange(MainOcc,470,495)|MainOcc==403|MainOcc==433|MainOcc==516|inrange(MainOcc,552,553)|inrange(MainOcc,450,452)|MainOcc==425) & inrange(year,1968,2001)  /* Construction Trades */
replace occ1980Cens2digit = 15 if inrange(MainOcc,601,695) & inrange(year,1968,2001) /* Machine Operators, Assemblers and Inspectors */
replace occ1980Cens2digit = 16 if (inrange(MainOcc,701,715)|MainOcc==221|MainOcc==226) & inrange(year,1968,2001) /* Transportation and Material Moving Occupations */
replace occ1980Cens2digit = 17 if (inrange(MainOcc,740,785) & MainOcc!=761 & MainOcc!=752) & inrange(year,1968,2001) /* Laborers, Except Farm */
/* replace occ1980Cens2digit = 18 if MainOcc==231|MainOcc==245 & inrange(year,1968,2001) /\* Sales Managers *\/ */
replace occ1980Cens2digit = -1 if MainOcc==999 & inrange(year,1968,2001) /* Na; DK */
replace occ1980Cens2digit = -2 if MainOcc==0 & inrange(year,1968,2001) /* Inap. */


replace occ1980Cens2digit = 1 if (inrange(MainOcc,1,95)|MainOcc==401|MainOcc==430|MainOcc==900|MainOcc==666) & inrange(year,2002,2017) /* Executive Administrative and Managerial Occupations */
replace occ1980Cens2digit = 2 if inrange(MainOcc,100,326) & inrange(year,2002,2017) /* Professional Specialty Occupations */
replace occ1980Cens2digit = 3 if (inrange(MainOcc,330,365)|inrange(MainOcc,155,156)) & inrange(year,2002,2017) /* Technicians and Related Support Occupations */
replace occ1980Cens2digit = 4 if inrange(MainOcc,470,496) & inrange(year,2002,2017) /* Sales Occupations */
replace occ1980Cens2digit = 5 if (inrange(MainOcc,500,593)|MainOcc==483|MainOcc==54|MainOcc==254) & inrange(year,2002,2017) /* Administrative Support Occupations, Including Clerical */
replace occ1980Cens2digit = 6 if inrange(MainOcc,460,469) & inrange(year,2002,2017) /* Private Hoursehold Occupations */
replace occ1980Cens2digit = 7 if inrange(MainOcc,370,395) & inrange(year,2002,2017) /* Protective Service Occupations */
replace occ1980Cens2digit = 8 if (inrange(MainOcc,400,459)|inrange(MainOcc,360,365)|MainOcc==422) & MainOcc!=430 & MainOcc!=401 & inrange(year,2002,2017) /* Service Occupations, Except Protective and Household */
replace occ1980Cens2digit = 9 if (MainOcc==602|inrange(MainOcc,20,21)) & inrange(year,2002,2017) /* Farm Operators and Managers */
replace occ1980Cens2digit = 10 if (MainOcc==600|MainOcc==605|MainOcc==425|MainOcc==434|MainOcc==435|MainOcc==421) & inrange(year,2002,2017) /* Other Agricultural and Related Occupations */
replace occ1980Cens2digit = 11 if inrange(MainOcc,612,613) & inrange(year,2002,2017) /* Forestry and Logging Occupations */
replace occ1980Cens2digit = 12 if inrange(MainOcc,610,611) & inrange(year,2002,2017) /* Fishers, Hunters and Trappers */
replace occ1980Cens2digit = 13 if (inrange(MainOcc,700,785)|MainOcc==670) & inrange(year,2002,2017) /* Mechanics and Repairers */
replace occ1980Cens2digit = 14 if (inrange(MainOcc,620,699)|MainOcc==741|MainOcc==713|MainOcc==770|MainOcc==772|MainOcc==803|MainOcc==352|inrange(MainOcc,860,863)|MainOcc==874|inrange(MainOcc,781,781)|MainOcc==784|inrange(MainOcc,850,852)|MainOcc==816|MainOcc==813|MainOcc==835|inrange(MainOcc,844,845)|MainOcc==876|MainOcc==806) & inrange(year,2002,2017) /* Construction Trades */
replace occ1980Cens2digit = 15 if (inrange(MainOcc,790,899)|inrange(MainOcc,771,775)|inrange(MainOcc,630,632)&!(inrange(MainOcc,620,699)|MainOcc==741|MainOcc==713|MainOcc==770|MainOcc==772|MainOcc==803|MainOcc==352|inrange(MainOcc,860,863)|MainOcc==874|inrange(MainOcc,781,781)|MainOcc==784|inrange(MainOcc,850,852)|MainOcc==816|MainOcc==813|MainOcc==835|inrange(MainOcc,844,845)|MainOcc==876|MainOcc==806)) & inrange(year,2002,2017) /* Machine Operators, Assemblers and Inspectors */
replace occ1980Cens2digit = 16 if (inrange(MainOcc,901,975)|MainOcc==632) & inrange(year,2002,2017) /* Transportation and Material Moving Occupations */

replace occ1980Cens2digit = 17 if (MainOcc==425|MainOcc==626|MainOcc==660|MainOcc==562|inrange(MainOcc,961,964)) & inrange(year,2002,2017) /* Laborers, Except Farm */
/* replace occ1980Cens2digit = 18 if inrange(MainOcc,470,471) & inrange(year,2002,2017) /\* Sales Occupations *\/ */
replace occ1980Cens2digit = -1 if MainOcc==999 & inrange(year,2002,2017) /* Na; DK */
/* replace occ1980Cens2digit = -2 if MainOcc==615 & inrange(year,2002,2017) /\* Na; DK *\/ */
replace occ1980Cens2digit = -2 if MainOcc==0 & inrange(year,2002,2017) /* Inap. */


/* replace occ1980Cens2digit = 17 if (MainOcc==425)|inrange(MainOcc,610,613)|MainOcc==626|MainOcc==660|MainOcc==676|inrange(MainOcc,692,694)|MainOcc==562|inrange(MainOcc,961,964)) &!inrange(MainOcc,610,613) & inrange(year,2002,2017) /\* Laborers, Except Farm *\/ */


* Looks okay: Exec. Admin, Admin Support, Service Occs, Machine Ops, 
* Looks Wrong: Professional Spec., Tech & Support, Sales, HH Occs, Protect Occs, Other Ag, Mechanics, Construct., Transport., Laborers, Mechanics

* Construction is stealing from 1, 13
* Machine Operators is stealing from 13, 14
* Transportation is stealing from 14
* Laborers is stealing from 16, 14, 5, 8


label define occ19802digit 1 "Executive Administrative and Managerial Occupations" 2 "Professional Specialty Occupations" 3 "Technicians and Related Support Occupations" 4 "Sales Occupations" 5 "Administrative Support Occupations, Including Clerical" 6 "Private Hoursehold Occupations" 7 "Protective Service Occupations" 8 "Service Occupations, Except Protective and Household" 9 "Farm Operators and Managers" 10 "Other Agricultural and Related Occupations" 11 "Forestry and Logging Occupations" 12 "Fishers, Hunters and Trappers" 13 "Mechanics and Repairers" 14 "Construction Trades" 15 "Machine Operators, Assemblers and Inspectors" 16 "Transportation and Material Moving Occupations" 17 "Laborers, Except Farm" -1 "Na; DK" -2 "Inap."

/* label define occ19802digit 1 "Agriculture, Forestry, and Fisheries" 2 "Mining" 3 "Construction" 4 "Manufacturing" 5 "Transportation" 6 "Wholesale Trade" 7 "Finance, Insurance, and Real Estate" 8 "Business and Repair Services" 9 "Personal Services" 10 "Entertainment and Recreation Services" 11 "Professional and Related Services" 12 "Public Administration" */
label values occ1980Cens2digit occ19802digit

save PSIDFullPanel_Final, replace

/* replace occ1980Cens2digit = 5 if inrange(MainOcc,700,785)|MainOcc==670|MainOcc==844|inrange(MinOcc,850,855)|MainOcc==803|MainOcc==806|MainOcc==813 & inrange(year,2002,2017) /\* Mechanics and Repairers *\/ */

/* replace occ1980Cens2digit = 6 if inrange(MainOcc,790,899)|inrange(MainOcc,771,775)|inrange(MainOcc,630,632) & inrange(year,2002,2017) /\* Machine Operators, Assemblers and Inspectors *\/ */
/* replace occ1980Cens2digit = 7 if inrange(MainOcc,900,975) & inrange(year,2002,2017) /\* Transportation and Material Moving Occupations *\/ */
/* replace occ1980Cens2digit = 8 if inrange(MainOcc,423,425)|inrange(MainOcc,434,455)|inrange(MainOcc,610,613)|MainOcc==623|MainOcc==660|MainOcc==676|inrange(MainOcc,692,694) & inrange(year,2002,2017) /\* Laborers, Except Farm *\/ */



/* replace occ1980Cens2digit = 3 if inrange(MainOcc,480,496) & inrange(year,2002,2017) /\* Sales Workers *\/ */
/* replace occ1980Cens2digit = 4 if inrange(MainOcc,472,474)|inrange(MainOcc,500,593) & inrange(year,2002,2017) /\* Clerical and Kindred Workers *\/ */
/* replace occ1980Cens2digit = 5 if inrange(MainOcc,621,785)|MainOcc==601|MainOcc==844|inrange(MinOcc,850,855)|MainOcc==803|MainOcc==806|MainOcc==813 & inrange(year,2002,2017)  /\* Craftsmen and Kindred Workers *\/ */
/* replace occ1980Cens2digit = 6 if inrange(MainOcc,790,843)|inrange(MainOcc,630,632) & inrange(year,2002,2017) /\* Operatives, Except Transport *\/ */
/* replace occ1980Cens2digit = 7 if inrange(MainOcc,900,975) & inrange(year,2002,2017) /\* Transport Equipment Operatives *\/ */
/* replace occ1980Cens2digit = 8 if inrange(MainOcc,423,425)|inrange(MainOcc,434,455)|inrange(MainOcc,610,613)|MainOcc==623|MainOcc==660|MainOcc==676|inrange(MainOcc,692,694) & inrange(year,2002,2017) /\* Laborers, Except Farm *\/ */
/* replace occ1980Cens2digit = 9 if MainOcc==600 & inrange(year,2002,2017) /\* Farmers and Farm Managers *\/ */
/* replace occ1980Cens2digit = 10 if inrange(MainOcc,602,605) & inrange(year,2002,2017) /\* Farm Laborers and Farm Foremen *\/ */
/* replace occ1980Cens2digit = 11 if inrange(MainOcc,330,416)|MainOcc==422 & inrange(year,2002,2017) /\* Service workers, Except Private Hourshold *\/ */
/* replace occ1980Cens2digit = 12 if inrange(MainOcc,460,469) & inrange(year,2002,2017) /\* Private Hoursehold Workers *\/ */
/* replace occ1980Cens2digit = -1 if MainOcc==999 & inrange(year,2002,2017) /\* Na; DK *\/ */
/* replace occ1980Cens2digit = -2 if MainOcc==615 & inrange(year,2002,2017) /\* Na; DK *\/ */
/* replace occ1980Cens2digit = -2 if MainOcc==0 & inrange(year,2002,2017) /\* Inap. *\/ */



/* replace occ1980Cens2digit = 1 if inrange(MainOcc,80,365)|MainOcc==612|inrange(MainOcc,903,904)|inrange(MainOcc,920,923)|MainOcc==933 & inrange(year,2002,2017) /\* Professional, Technical, and Kindred Workers *\/ */
/* replace occ1980Cens2digit = 2 if inrange(MainOcc,1,73)|MainOcc==500|inrange(MainOcc,470,471)|inrange(MainOcc,420,421)|inrange(MainOcc,430,432)|MainOcc==620|MainOcc==900|MainOcc==931 & inrange(year,2002,2017) /\* Managers and Administrators, Except Farm *\/ */
/* replace occ1980Cens2digit = 3 if inrange(MainOcc,480,496) & inrange(year,2002,2017) /\* Sales Workers *\/ */
/* replace occ1980Cens2digit = 4 if inrange(MainOcc,472,474)|inrange(MainOcc,500,593) & inrange(year,2002,2017) /\* Clerical and Kindred Workers *\/ */
/* replace occ1980Cens2digit = 5 if inrange(MainOcc,621,785)|MainOcc==601|MainOcc==844|inrange(MinOcc,850,855)|MainOcc==803|MainOcc==806|MainOcc==813 & inrange(year,2002,2017)  /\* Craftsmen and Kindred Workers *\/ */
/* replace occ1980Cens2digit = 6 if inrange(MainOcc,790,843)|inrange(MainOcc,630,632) & inrange(year,2002,2017) /\* Operatives, Except Transport *\/ */
/* replace occ1980Cens2digit = 7 if inrange(MainOcc,900,975) & inrange(year,2002,2017) /\* Transport Equipment Operatives *\/ */
/* replace occ1980Cens2digit = 8 if inrange(MainOcc,423,425)|inrange(MainOcc,434,455)|inrange(MainOcc,610,613)|MainOcc==623|MainOcc==660|MainOcc==676|inrange(MainOcc,692,694) & inrange(year,2002,2017) /\* Laborers, Except Farm *\/ */
/* replace occ1980Cens2digit = 9 if MainOcc==600 & inrange(year,2002,2017) /\* Farmers and Farm Managers *\/ */
/* replace occ1980Cens2digit = 10 if inrange(MainOcc,602,605) & inrange(year,2002,2017) /\* Farm Laborers and Farm Foremen *\/ */
/* replace occ1980Cens2digit = 11 if inrange(MainOcc,330,416)|MainOcc==422 & inrange(year,2002,2017) /\* Service workers, Except Private Hourshold *\/ */
/* replace occ1980Cens2digit = 12 if inrange(MainOcc,460,469) & inrange(year,2002,2017) /\* Private Hoursehold Workers *\/ */
/* replace occ1980Cens2digit = -1 if MainOcc==999 & inrange(year,2002,2017) /\* Na; DK *\/ */
/* replace occ1980Cens2digit = -2 if MainOcc==615 & inrange(year,2002,2017) /\* Na; DK *\/ */
/* replace occ1980Cens2digit = -2 if MainOcc==0 & inrange(year,2002,2017) /\* Inap. *\/ */





/* replace occ1980Cens2digit = 5 if inrange(MainOcc,401,600) & inrange(year,1968,2001)  /\* Administrative Support Occupatoins, Including Clerical *\/ */
/* replace occ1980Cens2digit = 6 if inrange(MainOcc,601,695) & inrange(year,1968,2001) /\* Private Household Occupatoins *\/ */
/* replace occ1980Cens2digit = 7 if inrange(MainOcc,701,715) & inrange(year,1968,2001) /\* Protective Service Occupations *\/ */
/* replace occ1980Cens2digit = 8 if inrange(MainOcc,740,785) & inrange(year,1968,2001) /\* Service Occupations, Except Protective and Household *\/ */
/* replace occ1980Cens2digit = 9 if inrange(MainOcc,801,802) & inrange(year,1968,2001) /\* Farm Operators and Managers *\/ */
/* replace occ1980Cens2digit = 10 if inrange(MainOcc,821,824) & inrange(year,1968,2001) /\* Other Agribultural and Related Occupations *\/ */
/* replace occ1980Cens2digit = 11 if inrange(MainOcc,901,965) & inrange(year,1968,2001) /\* Forestry and Logging Occupations *\/ */
/* replace occ1980Cens2digit = 12 if inrange(MainOcc,980,984) & inrange(year,1968,2001) /\* Fishers, Hunters and Trappers *\/ */
/* replace occ1980Cens2digit = 13 if inrange(MainOcc,980,984) & inrange(year,1968,2001) /\* Mechanics and Repairers *\/ */
/* replace occ1980Cens2digit = 14 if inrange(MainOcc,980,984) & inrange(year,1968,2001) /\* Construction Trades *\/ */
/* replace occ1980Cens2digit = 15 if inrange(MainOcc,980,984) & inrange(year,1968,2001) /\* Machine Operators, Assemblers and Inspectors *\/ */
/* replace occ1980Cens2digit = 16 if inrange(MainOcc,980,984) & inrange(year,1968,2001) /\* Transportation and Material Moving Occupations *\/ */
/* replace occ1980Cens2digit = 17 if inrange(MainOcc,980,984) & inrange(year,1968,2001) /\* Handlers, Equipment Cleaners, Helpers and Laborers *\/ */
/* replace occ1980Cens2digit = -1 if MainOcc==999 & inrange(year,1968,2001) /\* Na; DK *\/ */
/* replace occ1980Cens2digit = -2 if MainOcc==0 & inrange(year,1968,2001) /\* Inap. *\/ */


/* gen occ1980Cens2digit = . */
/* replace occ1980Cens2digit = 1 if inrange(MainOcc,1,195) & inrange(year,1968,2001) /\* Professional, Technical, and Kindred Workers *\/ */
/* replace occ1980Cens2digit = 2 if inrange(MainOcc,201,245) & inrange(year,1968,2001) /\* Managers and Administrators, Except Farm *\/ */
/* replace occ1980Cens2digit = 3 if inrange(MainOcc,260,285) & inrange(year,1968,2001) /\* Sales Workers *\/ */
/* replace occ1980Cens2digit = 4 if inrange(MainOcc,301,395) & inrange(year,1968,2001) /\* Clerical and Kindred Workers *\/ */
/* replace occ1980Cens2digit = 5 if inrange(MainOcc,401,600) & inrange(year,1968,2001)  /\* Craftsmen and Kindred Workers *\/ */
/* replace occ1980Cens2digit = 6 if inrange(MainOcc,601,695) & inrange(year,1968,2001) /\* Operatives, Except Transport *\/ */
/* replace occ1980Cens2digit = 7 if inrange(MainOcc,701,715) & inrange(year,1968,2001) /\* Transport Equipment Operatives *\/ */
/* replace occ1980Cens2digit = 8 if inrange(MainOcc,740,785) & inrange(year,1968,2001) /\* Laborers, Except Farm *\/ */
/* replace occ1980Cens2digit = 9 if inrange(MainOcc,801,802) & inrange(year,1968,2001) /\* Farmers and Farm Managers *\/ */
/* replace occ1980Cens2digit = 10 if inrange(MainOcc,821,824) & inrange(year,1968,2001) /\* Farm Laborers and Farm Foremen *\/ */
/* replace occ1980Cens2digit = 11 if inrange(MainOcc,901,965) & inrange(year,1968,2001) /\* Service workers, Except Private Hourshold *\/ */
/* replace occ1980Cens2digit = 12 if inrange(MainOcc,980,984) & inrange(year,1968,2001) /\* Private Hoursehold Workers *\/ */
/* replace occ1980Cens2digit = -1 if MainOcc==999 & inrange(year,1968,2001) /\* Na; DK *\/ */
/* replace occ1980Cens2digit = -2 if MainOcc==0 & inrange(year,1968,2001) /\* Inap. *\/ */





/* sort MainInd */
/* merge MainInd using convInd2000to1990.dta */
/* tab _merge */
/* drop _merge */

/* sort ind1990ddx */
/* merge ind1990ddx using convInd1990to1980.dta */
/* tab _merge */
/* drop _merge */

/* replace MainInd = ind1980 if inrange(year,2002,2017) */


/* replace ind1980Cens2digit = 21 if MainInd == 19 /\* Horticultural services *\/ */
/* replace ind1980Cens2digit = 30 if MainInd == 27 /\* Forestry *\/ */
/* replace ind1980Cens2digit = 31 if MainInd == 28 | MainInd == 18 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 40 if MainInd == 47 /\* Metal mining *\/ */
/* replace ind1980Cens2digit = 41 if MainInd == 48 /\* Coal mining *\/ */
/* replace ind1980Cens2digit = 42 if MainInd == 49 /\* Crude petroleum and nat. gas extract. *\/ */
/* replace ind1980Cens2digit = 50 if MainInd == 57 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 60 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 100 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 101 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 102 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 110 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 111 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 112 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 120 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 121 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 122 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 130 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 132 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 140 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 141 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 142 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 150 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 151 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 152 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 160 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 161 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 162 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 171 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 172 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 180 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 181 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 182 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 190 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 191 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 192 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 200 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 201 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 202 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 210 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 211 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 212 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 220 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 221 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 222 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 230 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 231 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 232 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 240 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 241 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 242 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 250 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 251 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 252 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 260 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 261 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 262 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 270 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 271 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 272 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 280 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 281 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 282 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 290 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 291 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 292 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 200 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 301 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 302 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 310 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 311 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 312 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 320 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 321 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 322 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 330 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 331 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 332 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 340 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 341 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 342 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 350 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 351 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 352 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 360 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 361 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 362 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 370 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 371 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 372 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 380 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 381 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 382 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 390 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 391 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 392 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 400 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 401 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 402 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 410 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 411 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 412 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 420 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 421 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 422 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 430 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 431 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 432 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 440 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 441 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 442 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 450 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 451 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 452 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 460 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 461 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 462 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 470 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 471 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 472 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 480 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 481 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 482 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 490 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 491 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 492 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 500 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 501 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 502 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 510 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 511 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 512 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 520 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 521 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 522 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 530 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 531 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 532 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 540 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 541 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 542 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 550 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 551 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 552 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 560 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 561 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 562 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 570 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 571 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 572 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 580 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 581 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 582 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 590 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 591 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 592 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 600 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 601 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 602 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 610 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 611 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 612 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 620 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 621 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 622 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 630 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 631 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 632 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 640 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 641 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 642 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 650 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 651 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 652 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 660 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 661 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 662 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 670 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 671 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 672 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 680 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 681 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 682 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 690 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 691 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 692 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 700 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 701 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 702 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 710 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 711 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 712 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 720 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 721 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 722 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 730 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 731 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 732 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 740 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 741 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 742 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 750 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 751 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 752 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 760 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 761 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 762 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 770 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 771 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 772 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 780 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 781 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 782 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 790 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 791 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 792 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 800 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 801 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 802 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 810 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 811 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 812 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 820 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 821 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 822 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 830 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 831 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 832 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 840 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 841 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 842 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 850 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 851 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 852 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 860 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 861 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 862 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 870 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 871 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 872 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 880 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 881 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 882 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 890 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 891 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 892 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 900 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 901 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 902 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 910 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 911 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 912 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 920 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 921 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 922 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 930 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 931 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens2digit = 932 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */


/* gen ind1980Cens = . */
/* replace ind1980Cens = 10 if MainInd == 17 /\* Agg prod, crops *\/ */
/* replace ind1980Cens = 20 if MainInd == 17 | MainInd == 18 | MainInd == 28 /\* Agg services *\/ */
/* replace ind1980Cens = 21 if MainInd == 19 /\* Horticultural services *\/ */
/* replace ind1980Cens = 30 if MainInd == 27 /\* Forestry *\/ */
/* replace ind1980Cens = 31 if MainInd == 28 | MainInd == 18 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 40 if MainInd == 47 /\* Metal mining *\/ */
/* replace ind1980Cens = 41 if MainInd == 48 /\* Coal mining *\/ */
/* replace ind1980Cens = 42 if MainInd == 49 /\* Crude petroleum and nat. gas extract. *\/ */
/* replace ind1980Cens = 50 if MainInd == 57 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 60 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 100 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 101 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 102 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 110 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 111 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 112 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 120 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 121 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 122 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 130 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 132 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 140 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 141 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 142 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 150 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 151 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 152 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 160 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 161 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 162 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 171 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 172 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 180 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 181 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 182 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 190 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 191 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 192 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 200 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 201 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 202 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 210 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 211 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 212 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 220 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 221 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 222 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 230 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 231 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 232 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 240 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 241 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 242 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 250 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 251 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 252 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 260 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 261 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 262 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 270 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 271 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 272 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 280 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 281 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 282 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 290 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 291 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 292 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 200 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 301 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 302 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 310 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 311 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 312 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 320 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 321 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 322 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 330 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 331 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 332 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 340 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 341 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 342 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 350 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 351 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 352 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 360 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 361 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 362 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 370 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 371 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 372 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 380 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 381 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 382 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 390 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 391 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 392 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 400 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 401 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 402 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 410 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 411 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 412 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 420 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 421 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 422 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 430 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 431 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 432 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 440 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 441 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 442 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 450 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 451 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 452 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 460 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 461 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 462 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 470 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 471 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 472 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 480 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 481 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 482 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 490 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 491 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 492 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 500 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 501 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 502 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 510 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 511 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 512 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 520 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 521 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 522 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 530 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 531 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 532 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 540 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 541 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 542 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 550 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 551 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 552 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 560 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 561 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 562 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 570 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 571 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 572 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 580 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 581 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 582 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 590 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 591 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 592 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 600 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 601 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 602 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 610 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 611 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 612 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 620 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 621 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 622 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 630 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 631 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 632 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 640 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 641 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 642 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 650 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 651 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 652 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 660 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 661 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 662 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 670 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 671 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 672 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 680 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 681 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 682 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 690 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 691 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 692 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 700 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 701 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 702 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 710 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 711 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 712 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 720 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 721 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 722 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 730 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 731 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 732 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 740 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 741 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 742 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 750 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 751 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 752 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 760 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 761 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 762 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 770 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 771 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 772 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 780 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 781 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 782 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 790 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 791 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 792 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 800 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 801 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 802 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 810 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 811 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 812 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 820 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 821 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 822 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 830 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 831 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 832 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 840 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 841 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 842 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 850 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 851 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 852 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 860 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 861 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 862 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 870 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 871 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 872 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 880 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 881 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 882 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 890 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 891 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 892 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 900 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 901 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 902 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 910 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 911 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 912 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 920 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 921 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 922 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 930 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 931 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */
/* replace ind1980Cens = 932 if MainInd == 47 /\* Fishing, hunting, and trapping *\/ */


