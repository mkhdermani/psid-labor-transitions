
	
		{
		label define RelToHeadT 	///
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
		label values RelToHead RelToHeadT
		}
	label variable Sex "Sex of Individual"

* label current state
{	

		label define CurrentStatel ///
			0 "Inap.: U.S. territory or foreign country" ///
			1  "Alabama" ///
			2  "Arizona" ///
			3  "Arkansas" ///
			4  "California" ///
			5  "Colorado" ///
			6  "Connecticut" ///
			7  "Delaware" ///
			8  "District of Columbia" ///
			9  "Florida" ///
			10 "Georgia" ///
			11 "Idaho" ///
			12 "Illinois" ///
			13 "Indiana" ///
			14 "Iowa" ///
			15 "Kansas" ///
			16 "Kentucky" ///
			17 "Louisiana" ///
			18 "Maine" ///
			19 "Maryland" ///
			20 "Massachusetts" ///
			21 "Michigan" ///
			22 "Minnesota" ///
			23 "Mississippi" ///
			24 "Missouri" ///
			25 "Montana" ///
			26 "Nebraska" ///
			27 "Nevada" ///
			28 "New Hampshire" ///
			29 "New Jersey" ///
			30 "New Mexico" ///
			31 "New York" ///
			32 "North Carolina" ///
			33 "North Dakota" ///
			34 "Ohio" ///
			35 "Oklahoma" ///
			36 "Oregon" ///
			37 "Pennsylvania" ///
			38 "Rhode Island" ///
			39 "South Carolina" ///
			40 "South Dakota" ///
			41 "Tennessee" ///
			42 "Texas" ///
			43 "Utah" ///
			44 "Vermont" ///
			45 "Virginia" ///
			46 "Washington" ///
			47 "West Virginia" ///
			48 "Wisconsin" ///
			49 "Wyoming" ///
			50 "Alaska" ///
			51 "Hawaii" ///
			99 "DK; NA"
	label values CurrentState CurrentStatel
		
}	

cd "$projdir"
save PanelReshaped, replace
