clear all
set maxvar 20000

*Variables I want are:
	*INDIVIDUAL FILE
		*Interview: This is the 1968 Family Interview number used to merge data later on
		*Age
		*Sex
		*Birth Month
		*Birth Year
		*--*Children Data:
			*Birth Month of First Child
			*Birth Year of First Child
			*Birth Month of Last Child
			*Birth Year of Last Child
			*Birth Month of Second Youngest Child
			*Birth Year of Second Youngest Child
			*Birth Month of Third Youngest Child
			*Birth Year of Third Youngest Child
			*Birth Month of Fourth Youngest Child
			*Birth Year of Fourth Youngest Child
			*Year Birth Info Last Updated
		*--*Marriage Data:
			*Year Marital Info Most Updated
			*--*First Marriage Info
				*Start Month of First Marriage
				*Start Year of First Marriage
				*End Month of First Marriage
				*End Year of First Marriage
				*Month of Separation of First Marriage
				*Year of Separation of First Marriage
				*Status of First Marriage
			*--*Most Recent Marriage Info
				*Start Month of Most Recent Marriage
				*Start year of most recent marriage
				*End month of most recent marriage
				*End year of most recent marriage
				*Month of separation of most recent marriage
				*Year of separation of Most recent marriage
				*Status of Most Recent Marriage
				*Last known marital status/status of last marriage
			*Total number of marriages
		*Years of schooling completed
		*Married Pairs Indicator
		*Year Father Born
		*Year Mother Born
		*Sample Weight : !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		*Month Moved out of Main Family Unit
		*Year Moved out of Main Family Unit
		*Sequence Number
		*Person Number
		*Relationship to HH Head
		*Reason for Non-Response
		*1968 Interview Number of Father
		*1968 Interview Number of Mother
		*Highest Grade Finished
		*Weight

********************************************************************
***BEGIN RENAMING AND KEEPING OF KEY VARIABLES IN INDIVIDUAL FILE***
********************************************************************

*cd ..
*cd "Data"

/* cd "D:\data\PSID\PSID\Data" */
cd "$datadir"


use PSID_Individual, clear

ren ER31996 IndStratum2015
ren ER31997 IndCluster2015

*Interview Number for Individual File.
	/*	Only ER30001 is necessary for creating a unique time-invariant person number.
		The other interview numbers specify if the main family was a non-response, or
		a move-out and are necessary for merging to the yearly family files.
	*/
		{
			rename ER30001 ID1968
			rename ER30020 ID1969
			rename ER30043 ID1970
			rename ER30067 ID1971
			rename ER30091 ID1972
			rename ER30117 ID1973
			rename ER30138 ID1974
			rename ER30160 ID1975
			rename ER30188 ID1976
			rename ER30217 ID1977
			rename ER30246 ID1978
			rename ER30283 ID1979
			rename ER30313 ID1980
			rename ER30343 ID1981
			rename ER30373 ID1982
			rename ER30399 ID1983
			rename ER30429 ID1984
			rename ER30463 ID1985
			rename ER30498 ID1986
			rename ER30535 ID1987
			rename ER30570 ID1988
			rename ER30606 ID1989
			rename ER30642 ID1990
			rename ER30689 ID1991
			rename ER30733 ID1992
			rename ER30806 ID1993
			rename ER33101 ID1994
			rename ER33201 ID1995
			rename ER33301 ID1996
			rename ER33401 ID1997
			rename ER33501 ID1999
			rename ER33601 ID2001
			rename ER33701 ID2003
			rename ER33801 ID2005
			rename ER33901 ID2007
			rename ER34001 ID2009
			rename ER34101 ID2011 
			rename ER34201 ID2013
			rename ER34301 ID2015
		}
	*

*Age:
	{
	rename ER30004 Age1968
	rename ER30023 Age1969
	rename ER30046 Age1970
	rename ER30070 Age1971
	rename ER30094 Age1972
	rename ER30120 Age1973
	rename ER30141 Age1974
	rename ER30163 Age1975
	rename ER30191 Age1976
	rename ER30220 Age1977
	rename ER30249 Age1978
	rename ER30286 Age1979
	rename ER30316 Age1980
	rename ER30346 Age1981
	rename ER30376 Age1982
	rename ER30402 Age1983
	rename ER30432 Age1984
	rename ER30466 Age1985
	rename ER30501 Age1986
	rename ER30538 Age1987
	rename ER30573 Age1988
	rename ER30609 Age1989
	rename ER30645 Age1990
	rename ER30692 Age1991
	rename ER30736 Age1992
	rename ER30809 Age1993
	rename ER33104 Age1994
	rename ER33204 Age1995
	rename ER33304 Age1996
	rename ER33404 Age1997
	rename ER33504 Age1999
	rename ER33604 Age2001
	rename ER33704 Age2003
	rename ER33804 Age2005
	rename ER33904 Age2007
	rename ER34004 Age2009
	rename ER34104 Age2011
	rename ER34204 Age2013
	rename ER34305 Age2015

	
	*Label Age values
	label define Agel 	1 "Newborn up to 2nd Birthday" ///
						999 "NA; DK" ///
						0 "Inap. See Codebook Online"
	
	label values Age* Agel

	}

	*
	
*Sex:
	{
	rename ER32000 Sex
	label define Sexl 	1 "Male" ///
						2 "Female" ///
						9 "NA"
	
	label values Sex Sexl
	}
	*

/*Birth Month
	{
	rename ER30403 BirthMonth1983
	rename ER30433 BirthMonth1984
	rename ER30467 BirthMonth1985
	rename ER30502 BirthMonth1986
	rename ER30539 BirthMonth1987
	rename ER30574 BirthMonth1988
	rename ER30610 BirthMonth1989
	rename ER30646 BirthMonth1990
	rename ER30693 BirthMonth1991
	rename ER30737 BirthMonth1992
	rename ER30810 BirthMonth1993
	rename ER33105 BirthMonth1994
	rename ER33205 BirthMonth1995
	rename ER33305 BirthMonth1996
	rename ER33405 BirthMonth1997
	rename ER33505 BirthMonth1999
	rename ER33605 BirthMonth2001
	rename ER33705 BirthMonth2003
	rename ER33805 BirthMonth2005
	rename ER33905 BirthMonth2007
	rename ER34005 BirthMonth2009
	rename ER34105 BirthMonth2011
	
	label define BirthMonthl	1 "January" ///
								2 "February" ///
								3 "March" ///
								4 "April" ///
								5 "May" ///
								6 "June" ///
								7 "July" ///
								8 "August" ///
								9 "September" ///
								10 "October" ///
								11 "November" ///			
								12 "December" ///
								21 "Winter" ///
								22 "Spring" ///
								23 "Summer" ///
								24 "Fall" ///
								99 "NA; DK" ///
								0 "Inap."
	
	label values BirthMonth* BirthMonthl
	}
	*/
	

	
/*Birth Year
	{
	rename ER30404 BirthYear1983
	rename ER30434 BirthYear1984
	rename ER30468 BirthYear1985
	rename ER30503 BirthYear1986
	rename ER30540 BirthYear1987
	rename ER30575 BirthYear1988
	rename ER30611 BirthYear1989
	rename ER30647 BirthYear1990
	rename ER30694 BirthYear1991
	rename ER30738 BirthYear1992
	rename ER30811 BirthYear1993
	rename ER33106 BirthYear1994
	rename ER33206 BirthYear1995
	rename ER33306 BirthYear1996
	rename ER33406 BirthYear1997
	rename ER33506 BirthYear1999
	rename ER33606 BirthYear2001
	rename ER33706 BirthYear2003
	rename ER33806 BirthYear2005
	rename ER33906 BirthYear2007
	rename ER34006 BirthYear2009
	rename ER34106 BirthYear2011
	
	label define BirthYearl 9999 "NA; DK" 0 "Inap."
	label values BirthYear* BirthYearl
	}
	*/


/*
*--* Children Data
	{
	*Birth Month & Year of First Child, Youngest, 2nd Youngest, 3rd Youngest, and 4th Youngest
		rename ER32023 ChildBirthMonth_FirstChild
		rename ER32024 ChildBirthYear_FirstChild

		rename ER32025 ChildBirthMonth_Youngest
		rename ER32026 ChildBirthYear_Youngest

		rename ER32027 ChildBirthMonth_2ndYoungest
		rename ER32028 ChildBirthYear_2ndYoungest

		rename ER32029 ChildBirthMonth_3rdYoungest
		rename ER32030 ChildBirthYear_3rdYoungest

		rename ER32031 ChildBirthMonth_4thYoungest
		rename ER32032 ChildBirthYear_4thYoungest
		
		label define ChildBirthMonthl	1 "January" ///
										2 "February" ///
										3 "March" ///
										4 "April" ///
										5 "May" ///
										6 "June" ///
										7 "July" ///
										8 "August" ///
										9 "September" ///
										10 "October" ///
										11 "November" ///
										12 "December" ///
										21 "Winter" ///
										22 "Spring" ///
										23 "Summer" ///
										24 "Fall" ///
										98 "NA; DK, birth year known" ///
										99 "Missing or incomplete data"
		
		label values ChildBirthMonth_* ChildBirthMonthl
		
	*Year Child Birth Info Last Updated
		rename ER32021 BirthInfoLastUpdated
		
		label define BirthInfoLastUpdatedl 9999 "No birth history collected"
		label values BirthInfoLastUpdated BirthInfoLastUpdatedl
	}
		*
*/		

/*		
*--* Marriage Data
	{	
	*Year Marital Info Last Updated
		rename ER32033 YearMaritalInfoLastUpdated
		
		label define YearMaritalInfoLastUpdatedl 9999 "No marriage history collected"
		label values YearMaritalInfoLastUpdated YearMaritalInfoLastUpdatedl
		
		
	*--*First Marriage Info
		rename ER32035 FirstMarriageMonthStart
		rename ER32036 FirstMarriageYearStart

		rename ER32038 FirstMarriageMonthEnd
		rename ER32039 FirstMarriageYearEnd

		rename ER32040 FirstMarriageMonthSep
		rename ER32041 FirstMarriageYearSep

		label define FirstMarriageMonthl	1 "January" ///
											2 "February" ///
											3 "March" ///
											4 "April" ///
											5 "May" ///
											6 "June" ///
											7 "July" ///
											8 "August" ///
											9 "September" ///
											10 "October" ///
											11 "November" ///
											12 "December" ///
											21 "Winter" ///
											22 "Spring" ///
											23 "Summer" ///
											24 "Fall" ///
											98 "NA or DK date" ///
											99 "No marriage history collected"
											
		label values FirstMarriageMonth* FirstMarriageMonthl
		
		label define FirstMarriageYearl 9998 "NA; DK" 9999 "No marriage history collected"
		label values FirstMarriageYear* FirstMarriageYearl
		
		rename ER32037 FirstMarriageStatus
		
		label define FirstMarriageStatusl 	1	"First or only marriage still intact" ///
											3	"First or only marriage ended in widowhood" ///
											4	"First or only marriage ended in divorce or annulment" ///
											5	"Separated during first or only marriage" ///
											7	"Other" ///
											8	"NA; DK" ///
											9	"No marriage history was collected"
		
		label values FirstMarriageStatus FirstMarriageStatusl
*/

/*		
	*--*Second Marriage Info
		rename ER32042 LastMarriageMonthStart
		rename ER32043 LastMarriageYearStart

		rename ER32045 LastMarriageMonthEnd
		rename ER32046 LastMarriageYearEnd

		rename ER32047 LastMarriageMonthSep
		rename ER32048 LastMarriageYearSep

		*Since codes for Last Marriage are the same for First Marriage
		*Use the labels already defined for First Marriage
		label values LastMarriageMonth* FirstMarriageMonthl
		label values LastMarriageYear* FirstMarriageYearl
		
		rename ER32044 LastMarriageStatus
		
		label define LastMarriageStatusl 	1	"Most recent of two or more marriages still intact" ///
											3	"Most recent of two or more marriages ended in widowhood" ///
											4	"Most recent of two or more marriages ended in divorce or annulment" ///
											5	"Separated during most recent of two or more marriages" ///
											7	"Other" ///
											8	"NA; DK" /// 
											9	"No marriage history collected"
											
		label values LastMarriageStatus LastMarriageStatusl
		
	*Last Known Marital Status
		rename ER32049 LastKnownMaritalStatus
		
		label define LastKnownMaritalStatusl 	1	"Married" ///
												2	"Never married" ///
												3	"Widowed" ///
												4	"Divorced, annulment" ///
												5	"Separated" ///
												8	"NA; DK" ///
												9	"No marriage history collected"
		
		label values LastKnownMaritalStatus LastKnownMaritalStatusl
		
	*Total Number of Marriages
		rename ER32034 TotalNumberMarriages
		
		label define TotalNumberMarriagesl 	0 "None" ///
											98 "NA; DK" ///
											99 "No marriage history collected"
											
		label values TotalNumberMarriages TotalNumberMarriagesl
	}
	*
*/


	
*Years of Schooling // NOTE: 1969 Variable is MISSING
	{
	rename ER30010 YrsSchool1968
	rename ER30052 YrsSchool1970
	rename ER30076 YrsSchool1971
	rename ER30100 YrsSchool1972
	rename ER30126 YrsSchool1973
	rename ER30147 YrsSchool1974
	rename ER30169 YrsSchool1975
	rename ER30197 YrsSchool1976
	rename ER30226 YrsSchool1977
	rename ER30255 YrsSchool1978
	rename ER30296 YrsSchool1979
	rename ER30326 YrsSchool1980
	rename ER30356 YrsSchool1981
	rename ER30384 YrsSchool1982
	rename ER30413 YrsSchool1983
	rename ER30443 YrsSchool1984
	rename ER30478 YrsSchool1985
	rename ER30513 YrsSchool1986
	rename ER30549 YrsSchool1987
	rename ER30584 YrsSchool1988
	rename ER30620 YrsSchool1989
	rename ER30657 YrsSchool1990
	rename ER30703 YrsSchool1991
	rename ER30748 YrsSchool1992
	rename ER30820 YrsSchool1993
	rename ER33115 YrsSchool1994
	rename ER33215 YrsSchool1995
	rename ER33315 YrsSchool1996
	rename ER33415 YrsSchool1997
	rename ER33516 YrsSchool1999
	rename ER33616 YrsSchool2001
	rename ER33716 YrsSchool2003
	rename ER33817 YrsSchool2005
	rename ER33917 YrsSchool2007
	rename ER34020 YrsSchool2009
	rename ER34119 YrsSchool2011
	rename ER34230 YrsSchool2013
	rename ER34349 YrsSchool2015
	
	label define YrsSchooll 17 "Some PostGraduate Work" ///
							98 "DK" ///
							99 "NA" ///
							0 "Inap."
	
	label values YrsSchool* YrsSchooll
	}
	*


/*	
*Married Pairs Indicator
	{
	rename ER30005 MarriedPairsInd1968
	rename ER30024 MarriedPairsInd1969
	rename ER30047 MarriedPairsInd1970
	rename ER30071 MarriedPairsInd1971
	rename ER30095 MarriedPairsInd1972
	rename ER30121 MarriedPairsInd1973
	rename ER30142 MarriedPairsInd1974
	rename ER30164 MarriedPairsInd1975
	rename ER30192 MarriedPairsInd1976
	rename ER30221 MarriedPairsInd1977
	rename ER30250 MarriedPairsInd1978
	rename ER30287 MarriedPairsInd1979
	rename ER30317 MarriedPairsInd1980
	rename ER30347 MarriedPairsInd1981
	rename ER30377 MarriedPairsInd1982
	rename ER30405 MarriedPairsInd1983
	rename ER30435 MarriedPairsInd1984
	rename ER30469 MarriedPairsInd1985
	rename ER30504 MarriedPairsInd1986
	rename ER30541 MarriedPairsInd1987
	rename ER30576 MarriedPairsInd1988
	rename ER30612 MarriedPairsInd1989
	rename ER30648 MarriedPairsInd1990
	rename ER30695 MarriedPairsInd1991
	rename ER30739 MarriedPairsInd1992
	rename ER30812 MarriedPairsInd1993
	rename ER33107 MarriedPairsInd1994
	rename ER33207 MarriedPairsInd1995
	rename ER33307 MarriedPairsInd1996
	rename ER33407 MarriedPairsInd1997
	rename ER33507 MarriedPairsInd1999
	rename ER33607 MarriedPairsInd2001
	rename ER33707 MarriedPairsInd2003
	rename ER33807 MarriedPairsInd2005
	rename ER33907 MarriedPairsInd2007
	rename ER34007 MarriedPairsInd2009
	rename ER34107 MarriedPairsInd2011
	
	label define MarriedPairsIndl 	1 "Spouse in couple 1" ///
									2 "Spouse in couple 2" ///
									3 "Spouse in couple 3" ///
									4 "Spouse in couple 4" ///
									5 "Spouse in couple 5" ///
									0 "Inap."
									
	label values MarriedPairsInd* MarriedPairsIndl
	}
	*
*/

/*
	
*Year Father Born
	{
	rename ER32018 YearFatherBorn
	
	label define YearFatherBornl 	9998 "NA, DK" ///
									9999 "No info gathered"
	
	label values YearFatherBorn YearFatherBornl
	}
	*

*Year Mother Born
	{
	rename ER32011 YearMotherBorn
	
	label values YearMotherBorn YearFatherBornl // Because they are the same as the YearFatherBorn label defined above.
	}
	*
*/
	
/*
*Month Moved out of Main Family Unit
	{
	rename ER30037 MonthMovedOut1969
	rename ER30061 MonthMovedOut1970
	rename ER30085 MonthMovedOut1971
	rename ER30111 MonthMovedOut1972
	rename ER30132 MonthMovedOut1973
	rename ER30154 MonthMovedOut1974
	rename ER30182 MonthMovedOut1975
	rename ER30211 MonthMovedOut1976
	rename ER30240 MonthMovedOut1977
	rename ER30277 MonthMovedOut1978
	rename ER30307 MonthMovedOut1979
	rename ER30337 MonthMovedOut1980
	rename ER30367 MonthMovedOut1981
	rename ER30393 MonthMovedOut1982
	rename ER30422 MonthMovedOut1983
	rename ER30456 MonthMovedOut1984
	rename ER30491 MonthMovedOut1985
	rename ER30528 MonthMovedOut1986
	rename ER30563 MonthMovedOut1987
	rename ER30599 MonthMovedOut1988
	rename ER30635 MonthMovedOut1989
	rename ER30677 MonthMovedOut1990
	rename ER30720 MonthMovedOut1991
	rename ER30795 MonthMovedOut1992
	rename ER30856 MonthMovedOut1993
	rename ER33122 MonthMovedOut1994
	rename ER33278 MonthMovedOut1995
	rename ER33319 MonthMovedOut1996
	rename ER33431 MonthMovedOut1997
	rename ER33539 MonthMovedOut1999
	rename ER33630 MonthMovedOut2001
	rename ER33733 MonthMovedOut2003
	rename ER33839 MonthMovedOut2005
	rename ER33939 MonthMovedOut2007
	rename ER34033 MonthMovedOut2009
	rename ER34145 MonthMovedOut2011
	
	label define MonthMovedOutl	1	"January" ///
								2	"February" ///
								3	"March" ///
								4	"April" ///
								5	"May" ///
								6	"June" ///
								7	"July" ///
								8	"August" ///
								9	"September" ///
								10	"October" ///
								11	"November" ///
								12	"December" ///
								98 "??? - VK" /// This is a VK addition
								99	"NA; DK" ///
								0	"Inap."
	
	label values MonthMovedOut* MonthMovedOutl
	}
	*
*/

/*
*Year Moved out of Main Family Unit
	{
	rename ER30038 YearMovedOut1969
	rename ER30062 YearMovedOut1970
	rename ER30086 YearMovedOut1971
	rename ER30112 YearMovedOut1972
	rename ER30133 YearMovedOut1973
	rename ER30155 YearMovedOut1974
	rename ER30183 YearMovedOut1975
	rename ER30212 YearMovedOut1976
	rename ER30241 YearMovedOut1977
	rename ER30278 YearMovedOut1978
	rename ER30308 YearMovedOut1979
	rename ER30338 YearMovedOut1980
	rename ER30368 YearMovedOut1981
	rename ER30394 YearMovedOut1982
	rename ER30423 YearMovedOut1983
	rename ER30457 YearMovedOut1984
	rename ER30492 YearMovedOut1985
	rename ER30529 YearMovedOut1986
	rename ER30564 YearMovedOut1987
	rename ER30600 YearMovedOut1988
	rename ER30636 YearMovedOut1989
	rename ER30678 YearMovedOut1990
	rename ER30721 YearMovedOut1991
	rename ER30796 YearMovedOut1992
	rename ER30857 YearMovedOut1993
	rename ER33123 YearMovedOut1994
	rename ER33279 YearMovedOut1995
	rename ER33320 YearMovedOut1996
	rename ER33432 YearMovedOut1997
	rename ER33540 YearMovedOut1999
	rename ER33631 YearMovedOut2001
	rename ER33734 YearMovedOut2003
	rename ER33840 YearMovedOut2005
	rename ER33940 YearMovedOut2007
	rename ER34034 YearMovedOut2009
	rename ER34146 YearMovedOut2011

	label define YearMovedOutl 	9998 "Moved out of an institution" ///
								9999 "NA, DK" ///
								0 "Inap."
								
	label values YearMovedOut* YearMovedOutl
	}
	*
*/

/*
*Sequence Number or Status of the Individual in the Family Unit
	{
	rename ER30021 IndStatusInFU1969
	rename ER30044 IndStatusInFU1970
	rename ER30068 IndStatusInFU1971
	rename ER30092 IndStatusInFU1972
	rename ER30118 IndStatusInFU1973
	rename ER30139 IndStatusInFU1974
	rename ER30161 IndStatusInFU1975
	rename ER30189 IndStatusInFU1976
	rename ER30218 IndStatusInFU1977
	rename ER30247 IndStatusInFU1978
	rename ER30284 IndStatusInFU1979
	rename ER30314 IndStatusInFU1980
	rename ER30344 IndStatusInFU1981
	rename ER30374 IndStatusInFU1982
	rename ER30400 IndStatusInFU1983
	rename ER30430 IndStatusInFU1984
	rename ER30464 IndStatusInFU1985
	rename ER30499 IndStatusInFU1986
	rename ER30536 IndStatusInFU1987
	rename ER30571 IndStatusInFU1988
	rename ER30607 IndStatusInFU1989
	rename ER30643 IndStatusInFU1990
	rename ER30690 IndStatusInFU1991
	rename ER30734 IndStatusInFU1992
	rename ER30807 IndStatusInFU1993
	rename ER33102 IndStatusInFU1994
	rename ER33202 IndStatusInFU1995
	rename ER33302 IndStatusInFU1996
	rename ER33402 IndStatusInFU1997
	rename ER33502 IndStatusInFU1999
	rename ER33602 IndStatusInFU2001
	rename ER33702 IndStatusInFU2003
	rename ER33802 IndStatusInFU2005
	rename ER33902 IndStatusInFU2007
	rename ER34002 IndStatusInFU2009
	rename ER34102 IndStatusInFU2011
	
	*See codebook for meanings
	}
	*
*/
	
*Person Number.  
	/* 	This variable is important, as ER30001 and ER30002 together
		create a person's time-invariant identifier for any individual
		in the PSID.  Refer to Noura's e-mail or the FAQ #9 online for further
		information.
	*/
	
	rename 	ER30002	 PersonNumber
	
	*See codebook for further information.
	
*Relationship to Household Head
	{
	 rename ER30003 RelToHead1968
	 rename ER30022 RelToHead1969
	 rename ER30045 RelToHead1970
	 rename ER30069 RelToHead1971
	 rename ER30093 RelToHead1972
	 rename ER30119 RelToHead1973
	 rename ER30140 RelToHead1974
	 rename ER30162 RelToHead1975
	 rename ER30190 RelToHead1976
	 rename ER30219 RelToHead1977
	 rename ER30248 RelToHead1978
	 rename ER30285 RelToHead1979
	 rename ER30315 RelToHead1980
	 rename ER30345 RelToHead1981
	 rename ER30375 RelToHead1982
	 rename ER30401 RelToHead1983
	 rename ER30431 RelToHead1984
	 rename ER30465 RelToHead1985
	 rename ER30500 RelToHead1986
	 rename ER30537 RelToHead1987
	 rename ER30572 RelToHead1988
	 rename ER30608 RelToHead1989
	 rename ER30644 RelToHead1990
	 rename ER30691 RelToHead1991
	 rename ER30735 RelToHead1992
	 rename ER30808 RelToHead1993
	 rename ER33103 RelToHead1994
	 rename ER33203 RelToHead1995
	 rename ER33303 RelToHead1996
	 rename ER33403 RelToHead1997
	 rename ER33503 RelToHead1999
	 rename ER33603 RelToHead2001
	 rename ER33703 RelToHead2003
	 rename ER33803 RelToHead2005
	 rename ER33903 RelToHead2007
	 rename ER34003 RelToHead2009
	 rename ER34103 RelToHead2011
	 rename ER34203 RelToHead2013
	 rename ER34303 RelToHead2015


	 
	 *Pre-1983 Labels
	 label define RelToHeadl 	///
								1	"Head" ///
								2	"Wife" ///
								3	"Son or daughter; includes stepchildren and adopted children" ///
								4	"Brother or sister of Head" ///
								5	"Father or mother of Head" ///
								6	"Grandchild or great-grandchild" ///
								7	"Other relative; includes in-laws" ///
								8	"Nonrelative" ///
								9	"Husband of Head (i.e., wife was Head of FU)" ///
								0	"Inap." ///
								10	"Head" ///
								20	"Legal wife" ///
								22	"Wife--female cohabitor who has lived with Head for 12 months or more" ///
								30	"Son or daughter of Head (includes adopted children but not stepchildren)" ///
								33	"Stepson or stepdaughter of Head (children of legal wife (code 20) who are not children of Head)" ///
								35	"Son or daughter of `wife' but not Head (includes only those children of mothers whose relationship to Head is 22 but who are not children of Head)" ///
								37	"Son-in-law or daughter-in-law of Head (includes stepchildren-in-law)" ///
								38	"Foster son or foster daughter, not legally adopted" ///
								40	"Brother or sister of Head (includes step and half sisters and brothers)" ///
								47	"Brother-in-law or sister-in-law of Head; i.e., brother or sister of legal wife, or spouse of Head's brother or sister." ///
								48	"Brother or sister of Head's cohabitor (the cohabitor is coded 22 or 88)" ///
								50	"Father or mother of Head (includes stepparents)" ///
								57	"Father-in-law or mother-in-law of Head (includes parents of legal wives (code 20) only)" ///
								58	"Father or mother of Head's cohabitor (the cohabitor is coded 22 or 88)" ///
								60	"Grandson or granddaughter of Head (includes grandchildren of legal wife (code 20), but those of a cohabitor are coded 97)" ///
								65	"Great-grandson or great-granddaughter of Head (includes great-grandchildren of legal wife (code 20), but those of a cohabitor are coded 97)" ///
								66	"Grandfather or grandmother of Head (includes stepgrandparents)" ///
								67	"Grandfather or grandmother of legal wife (code 20)" ///
								68	"Great-grandfather or great-grandmother of Head" ///
								69	"Great-grandfather or great-grandmother of legal wife (code 20)" ///
								70	"Nephew or niece of Head" ///
								71	"Nephew or niece of legal wife (code 20)" ///
								72	"Uncle or Aunt of Head" ///
								73	"Uncle or Aunt of legal wife (code 20)" ///
								74	"Cousin of Head" ///
								75	"Cousin of legal wife (code 20)" ///
								83	"Children of first-year cohabitor but not of Head (the parent of this child is coded 88)" ///
								88	"First-year cohabitor of Head" ///
								90	"Legal husband of Head" ///
								95	"Other relative of Head" ///
								96	"Other relative of legal wife (code 20)" ///
								97	"Other relative of cohabitor (the cohabitor is code 22 or 88)" ///
								98	"Other nonrelatives (includes homosexual partners, friends of children of the FU, etc.)" ///
								0	"Inap."

	forvalues year=1983/1997 {
		label values RelToHead`year' RelToHeadl
	}
		
	forvalues year=1999(2)2015 {
		label values RelToHead`year' RelToHeadl
	}

	}
	*

	
/*
*Reason for Non-Response
	{
	rename ER30018 ReasonNoResponse1968
	rename ER30041 ReasonNoResponse1969
	rename ER30065 ReasonNoResponse1970
	rename ER30089 ReasonNoResponse1971
	rename ER30115 ReasonNoResponse1972
	rename ER30136 ReasonNoResponse1973
	rename ER30158 ReasonNoResponse1974
	rename ER30186 ReasonNoResponse1975
	rename ER30215 ReasonNoResponse1976
	rename ER30244 ReasonNoResponse1977
	rename ER30281 ReasonNoResponse1978
	rename ER30311 ReasonNoResponse1979
	rename ER30341 ReasonNoResponse1980
	rename ER30371 ReasonNoResponse1981
	rename ER30397 ReasonNoResponse1982
	rename ER30427 ReasonNoResponse1983
	rename ER30461 ReasonNoResponse1984
	rename ER30496 ReasonNoResponse1985
	rename ER30533 ReasonNoResponse1986
	rename ER30568 ReasonNoResponse1987
	rename ER30604 ReasonNoResponse1988
	rename ER30640 ReasonNoResponse1989
	rename ER30685 ReasonNoResponse1990
	rename ER30729 ReasonNoResponse1991
	rename ER30802 ReasonNoResponse1992
	rename ER30863 ReasonNoResponse1993
	rename ER33127 ReasonNoResponse1994
	rename ER33283 ReasonNoResponse1995
	rename ER33325 ReasonNoResponse1996
	rename ER33437 ReasonNoResponse1997
	rename ER33545 ReasonNoResponse1999
	rename ER33636 ReasonNoResponse2001
	rename ER33739 ReasonNoResponse2003
	rename ER33847 ReasonNoResponse2005
	rename ER33949 ReasonNoResponse2007
	rename ER34044 ReasonNoResponse2009
	rename ER34153 ReasonNoResponse2011
	
	label define ReasonNoResponsel	1 "Refusal by all FU members" ///
									2 "No-one at home" ///
									3 "Respondent absent" ///
									4 "Lost, unable to locate" ///
									5 "FU located too far away" ///
									10 "Adamant Refusal by all FU members" ///
									11 "In Armed Forces" ///
									12 "In Educ Institution" ///
									13 "In Health care facility" ///
									14 "In jail/prison" ///
									15 "Adamant refusal by all all FU members, removal request" ///
									19 "In some other institution" ///
									21 "Not eligible, bc head in Armed Forces" ///
									22 "Not eligible, bc head in Educ Institution" ///
									23 "Not eligible, bc head in Health care facility" ///
									24 "Not eligible, bc head in jail/prison" ///
									29 "Not eligible, bc head in some other institution" ///
									31 "Disabled" ///
									32 "Not eligible, bc head disabled" ///
									41 "Individual died between interview years" ///
									42 "Not eligible, bc head died between interview years" ///
									45 "Adopted by unrelated nonsample person" ///
									51 "Discovered to be nonsample" ///
									52 "Should have been followed but wasn't" ///
									53 "Mistakenly included in two or more response families" ///
									54 "Listing error, never existed" ///
									56 "Individual became followable non-sample parent" ///
									57 "Insufficient information for recontact" ///
									58 "PSID budget issue, decided not to locate/persuade FU" ///
									59 "Other error" ///
									60 "Nonsample parent of sample child nonfollowable" ///
									61 "Not eligible to be followed" ///
									80 "Individual connected with Latino sample" ///
									81 "Non-sample elderly followed between 1990-1995" ///
									91 "Moved out of the main family, but nonresponse is NA" ///
									92 "Ex-spouse not elibile bc moved out" ///
									93 "Head or wife of FU united with another FU, not eligible" ///
									94 "1992 Latino recontacts only" ///
									97 "Individual had not been born or moved into panel yet" ///
									98 "Spouse moved out, not returned, or died" ///
									99 "NA; DK" ///
									0 "Inap."
									
	label values ReasonNoResponse* ReasonNoResponsel
									
	}
	*
*/

/*
*Father's 1968 Interview Number
	rename ER32016 FatherIntNumber1968
	
*Mother's 1968 Interview Number
	rename ER32009 MotherIntNumber1968
*/

*Last Known Marital Status
	rename ER32049 MaritalStatus2011
	
*Employment Status
		rename ER30293 EmpStat1979
		rename ER30323 EmpStat1980
		rename ER30353 EmpStat1981
		rename ER30382 EmpStat1982
		rename ER30411 EmpStat1983
		rename ER30441 EmpStat1984
		rename ER30474 EmpStat1985
		rename ER30509 EmpStat1986
		rename ER30545 EmpStat1987
		rename ER30580 EmpStat1988
		rename ER30616 EmpStat1989
		rename ER30653 EmpStat1990
		rename ER30699 EmpStat1991
		rename ER30744 EmpStat1992
		rename ER30816 EmpStat1993
		rename ER33111 EmpStat1994
		rename ER33211 EmpStat1995
		rename ER33311 EmpStat1996
		rename ER33411 EmpStat1997
		rename ER33512 EmpStat1999
		rename ER33612 EmpStat2001
		rename ER33712 EmpStat2003
		rename ER33813 EmpStat2005
		rename ER33913 EmpStat2007
		rename ER34016 EmpStat2009
		rename ER34116 EmpStat2011
		rename ER34216 EmpStat2013
		rename ER34317 EmpStat2015
		
*Cross-Sectional Weights
	rename ER30019 Weight_Cross1968
	rename ER30042 Weight_Cross1969
	rename ER30066 Weight_Cross1970
	rename ER30090 Weight_Cross1971
	rename ER30116 Weight_Cross1972
	rename ER30137 Weight_Cross1973
	rename ER30159 Weight_Cross1974
	rename ER30187 Weight_Cross1975
	rename ER30216 Weight_Cross1976
	rename ER30245 Weight_Cross1977
	rename ER30282 Weight_Cross1978
	rename ER30312 Weight_Cross1979
	rename ER30342 Weight_Cross1980
	rename ER30372 Weight_Cross1981
	rename ER30398 Weight_Cross1982
	rename ER30428 Weight_Cross1983
	rename ER30462 Weight_Cross1984
	rename ER30497 Weight_Cross1985
	rename ER30534 Weight_Cross1986
	rename ER30569 Weight_Cross1987
	rename ER30605 Weight_Cross1988
	rename ER30641 Weight_Cross1989
	rename ER30686 Weight_Cross1990
	rename ER30730 Weight_Cross1991
	rename ER30803 Weight_Cross1992
	rename ER30864 Weight_Cross1993
	rename ER33119 Weight_Cross1994
	rename ER33275 Weight_Cross1995
	rename ER33318 Weight_Cross1996
	rename ER33438 Weight_Cross1997
	rename ER33547 Weight_Cross1999
	rename ER33639 Weight_Cross2001
	rename ER33742 Weight_Cross2003
	rename ER33849 Weight_Cross2005
	rename ER33951 Weight_Cross2007
	rename ER34046 Weight_Cross2009
	rename ER34155 Weight_Cross2011
	rename ER34269 Weight_Cross2013
	rename ER34414 Weight_Cross2015


*Longitudinal Weights
	/*rename ER30019 Weight_Long1968
	rename ER30042 Weight_Long1969
	rename ER30066 Weight_Long1970
	rename ER30090 Weight_Long1971
	rename ER30116 Weight_Long1972
	rename ER30137 Weight_Long1973
	rename ER30159 Weight_Long1974
	rename ER30187 Weight_Long1975
	rename ER30216 Weight_Long1976
	rename ER30245 Weight_Long1977
	rename ER30282 Weight_Long1978
	rename ER30312 Weight_Long1979
	rename ER30342 Weight_Long1980
	rename ER30372 Weight_Long1981
	rename ER30398 Weight_Long1982
	rename ER30428 Weight_Long1983
	rename ER30462 Weight_Long1984
	rename ER30497 Weight_Long1985
	rename ER30534 Weight_Long1986
	rename ER30569 Weight_Long1987
	rename ER30605 Weight_Long1988
	rename ER30641 Weight_Long1989
	rename ER30686 Weight_Long1990
	rename ER30730 Weight_Long1991
	rename ER30803 Weight_Long1992
	rename ER30864 Weight_Long1993
	rename ER33119 Weight_Long1994
	rename ER33275 Weight_Long1995
	rename ER33318 Weight_Long1996*/
	rename ER33430 Weight_Long1997
	rename ER33546 Weight_Long1999
	rename ER33637 Weight_Long2001
	rename ER33740 Weight_Long2003
	rename ER33848 Weight_Long2005
	rename ER33950 Weight_Long2007
	rename ER34045 Weight_Long2009
	rename ER34154 Weight_Long2011
	rename ER34268 Weight_Long2013
	rename ER34413 Weight_Long2015





***Drop unnecessary variables, generate time-invariant IndID, order variables, and save.
drop ER*

*From Noura at PSID: "In order to create the unique identifier you will need to multiply ER30001 by 1000 and then add ER30002."
gen IndID = (ID1968*1000)+PersonNumber
order *, alphabetic
order IndID
cd "$projdir"
save Individual_Small, replace
