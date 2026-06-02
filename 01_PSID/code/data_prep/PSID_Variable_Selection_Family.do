clear all
set maxvar 32767
set matsize 11000
pause on

*Set Ben's Path
*Data here:
*cd "D:\data\PSID\PSID\Data"
*Output here:
*cd "D:\data\PSID\datasets\bcslci"

*Variables I want are:
	
	*FAMILY FILE
		*Interview: This is the yearly Family Interview number used to merge data
	
*****************************************************************
***BEGIN RENAMING AND KEEPING OF KEY VARIABLES IN FAMILY FILES***
*****************************************************************

******************************
***VARS EXTRACTION GUIDE******
***Expand to Explore**********
******************************
{
/*
	 VAR0		Interview
	 VAR1		AgeOfHead
	 VAR2		AgeOfWife
	 VAR3		HeadMaritalStatus
	 VAR4		HeadRace
	 VAR5		HeadSex
	 VAR6		HeadAdditionalTraining
	 VAR7		DependentsOutsideFU
	 VAR8		AmtPaidSupportDependentsOutsideFU
	 VAR9		MoreThanHalfSupportDependetnsOutsideFU
	 VAR10	NumberSupportedDependent
	 VAR11	FamCompChange
	 VAR12	FamCompChange
	 VAR13	SameHeadAsBefore
	 VAR14	NumberInFu
	 VAR15	NewWifeInFU
	 VAR16	WifeWantMoreChildren
	 VAR17	WifeWantMoreChildrenIsPregnant
	 VAR18	HeadWantMoreChildren
	 VAR19	HeadWantMoreChildrenIsWifePregnant
	 VAR20	WifeWantMoreChildrenNoChildren
	 VAR21	WifeWantMoreChildrenIsPregnantNoChildren
	 VAR22	HeadWantMoreChildrenNoChildren
	 VAR23	HeadWantMoreChildrenWifePregnantNoChildren
	 VAR24	HeadWantednessLastChild
	 VAR25	HeadPregnancyRightTimeLastChild
	 VAR26	WifeWantednessLastChild
	 VAR27	WifePregnancyRightTime
	 VAR28	WifeLastChildSameAsHeadLastChild
	 VAR29	HeadWantedness2ndYoungest
	 VAR30	WifeWantedness2Youngest
	 VAR31	Wife2ndYoungestSameHead2ndYoungest
	 VAR32	HeadWantednessFirsborn
	 VAR33	HeadPregnancyFirstbornRightTime
	 VAR34	WifeWantednessFirstborn
	 VAR35	WifePregnancyFirstbornRightTime
	 VAR36	WifeFirstbornSameHeadFirstBorn
	 VAR37	WifeAndNoChildren
	 VAR38	WifeOneOrMoreChildren
	 VAR39	HeadWifeNoChildren
	 VAR40	HeadWifeOneOrMoreChildren
	 VAR41	HeadWeeklyHrsHousework
	 VAR42	WifeWeeklyHrsHousework
	 VAR43	HousingStatus
	 VAR44	HouseValue
	 VAR45	HaveMortgage
	 VAR46	HouseValueAccuracyCode
	 VAR47	FamilyOwnBusiness
	 VAR48	TotalFamilyIncome
	 VAR49	HeadLaborIncome
	 VAR50	LumpSumTransfer
	 VAR51	LumpSumAmount
	 VAR52	TotalTransferIncome
	 VAR53	TaxableIncomeHeadAndWife
	 VAR54	TaxableIncomeOfAllEarnersNotHeadNotWife
	 VAR55	HeadLaborIncomeFromProfPractice
	 VAR56	HeadWagesSalaryAccuracyCode
	 VAR57	TransfersFromRelatives
	 VAR58	RegionLivingDuringInterview
	 VAR59	State
	 VAR60	HeadFathersEducation
	 VAR61	HeadMothersEducation
	 VAR62	WifeFathersEducation
	 VAR63	WifeMothersEducation
	 VAR64	HeadChildhoodEconomicSituation
	 VAR65	HeadReligion
	 VAR66	InterviewNumber1968
	 VAR67	SplitoffIndicator
	 VAR68	HHIdentificationNumber
	 VAR69	WhoWasRespondent
	 VAR70	HeadEmpStat
	 VAR71	HeadYrsWorkedSince18
	 VAR72	WifeYrsWorkedSince18
	 VAR73	HeadStillWorking
	 VAR74	WifeStillWorking
	 VAR75	TotalFamilyIncomeMajAssgn
	 VAR76	RaceOfHead
	 VAR77	RaceOfWife
	 VAR78	CurrentState
	 VAR79	EthOfHead
	 VAR80	EthOfWife
	 VAR81	YrsSchoolHead
	 VAR82	YrsSchoolHeadBracket
	 VAR83	YrsSchoolWife
	 VAR84	YrsSchoolWifeBracket
	 VAR85	TotalFamilyWealth


*/
}
******************************

*Pick the years that you want here:

*global	years 	1968 1969 1970 1971 1972 
				
*All PSID years are as follows below:
global	years 	1968 1969 1970 1971 1972 1973 1974 1975 1976 1977 ///
				1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 ///
				1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 ///
				1999 2001 2003 2005 2007 2009 2011 2013	2015

foreach y of global years {
	/* cd "E:\data\PSID\PSID\Data" */
	global t=`y'
        cd "$datadir"
	use PSID_`y', clear

        cd "$progdir/data_prep"
        * do ATTITUDESANDBEHAVIORS   // removed during cleanup: category had no selected variables
        * do CHILDREN   // removed during cleanup: category had no selected variables
        * do COGNITION   // removed during cleanup: category had no selected variables
        do DEMOGRAPHIC
        do EDUCATION
        do EXPENDITURES
        do FAMILYCOMPOSITION
        * do FAMILYPLANNING   // removed during cleanup: category had no selected variables
        do FINANCIALDISTRESS
        * do FOOD   // removed during cleanup: category had no selected variables
        * do FOODANDFOODSTAMPS   // removed during cleanup: category had no selected variables
        * do FUTUREPLANSANDEXPECTATIONS   // removed during cleanup: category had no selected variables
        * do HEALTHBEHAVIOR   // removed during cleanup: category had no selected variables
        * do HEALTHCAREUTILIZATION   // removed during cleanup: category had no selected variables
        * do HEALTHHISTORY   // removed during cleanup: category had no selected variables
        * do HEALTHINSURANCE   // removed during cleanup: category had no selected variables
        * do HEALTHSTATUS   // removed during cleanup: category had no selected variables
        do HOUSEWORK
        do HOUSING
        do INCOME
        * do INSTITUTIONALIZATION   // removed during cleanup: category had no selected variables
        * do INTERVIEWEROBSERVATIONS   // removed during cleanup: category had no selected variables
        * do LANGUAGE   // removed during cleanup: category had no selected variables
        do LOCATIONANDMOBILITY
        * do MEDIAUSE   // removed during cleanup: category had no selected variables
        * do NEIGHBORHOOD   // removed during cleanup: category had no selected variables
        * do NON-CASHASSISTANCE   // removed during cleanup: category had no selected variables
        do PARENTS
        * do PHILANTHROPICBEHAVIOR   // removed during cleanup: category had no selected variables
        * do PROBLEMBEHAVIOR   // removed during cleanup: category had no selected variables
        do RELIGION
        * do RETIREMENT   // removed during cleanup: category had no selected variables
        do SAMPLEWEIGHT
        * do SIBLINGS   // removed during cleanup: category had no selected variables
        do SURVEYINFORMATION
        * do TIMEUSE   // removed during cleanup: category had no selected variables
        * do VETERANSTATUS   // removed during cleanup: category had no selected variables
        do WEALTH
        do WORK
        
keep *`y'
/* cd "E:\data\PSID\datasets\bcslci" */
cd "$projdir"
save FAMILY_`y'_Small, replace
}

