clear all
pause on
set more off

*Set Ben's Path
cd"$projdir"

use FAMILY_INDIVIDUAL, clear

*drop if ID1968>5000 & ID1968<7000
drop if ID1968>7000 & ID1968<9308

cd "$progdir/data_prep"
reshape long  ///
Age Age_ AgeWife_ MarDum_ Race_ FDEM137_ SexHead_  ///
FEDU155_ FEDU156_ FEDU157_ FEDU050_ FEDU052_ FEDU054_ FEDU056_ FEDU058_ FEDU060_ FEDU186_ FEDU062_ FEDU063_ HeadAdvancedDegree_yn_ WifeAdvancedDegree_yn_ HeadCollegeACTScoresAve_ WifeCollegeACTScoresAve_ HeadCollegeDegree_yn_ WifeCollegeDegree_yn_ HeadCollegeExpAve_ WifeCollegeExpAve_ HeadSchoolRatingA_ WifeSchoolRatingA_ HeadSchoolRatingB_ WifeSchoolRatingB_ HeadYrsCollege_ WifeYrsCollege_ HeadHSGrad_ WifeHSGrad_ HeadNonHSGrad_ WifeNonHSGrad_ HeadYrsSchool_ HeadYrsSchoolBkted_ WifeYrsSchool_ WifeYrsSchoolBkted_ HeadCollegeField1_ HeadCollegeField2_ WifeCollegeField1_ WifeCollegeField2_ HeadCollegeMajor_  ///
FFAMCO014_ FFAMCO031_ NumFam_ FFAMCO064_  ///
FHOU008_ HouseWork_ HouseWorkWife_  ///
HouseValue_ HouseValueACC_ Mortgage_yn_ HouseStat_  ///
FINC508_ FINC393_ FINC518_ FINC406_ FamilyBusiness_ FamIncMajorAssignment_ NomFamTaxInc_ FINC633_ NomFamInc_ FINC653_ FINC465_ NomLabInc_ FINC991_ NomSpouseLabInc_ FINC379_ HeadTransFromRel_ HeadTransFromRel93On_ WifeTransFromRel_ TransInc_yn_ NomPrivateTransInc_ FINC1167_ FINC1170_ FINC1171_ FINC1536_ NomTotalTransInc_  ///
HeadChildhoodECStat_ WifeChildhoodECStat_ FPAR133_ FPAR134_ FPAR139_ FPAR140_  ///
CoreLongWeight_  ///
ID FSURIN006_ FSURIN022_ FSURIN089_ FSURIN124_ FSURIN002_ FSURIN049_ FSURIN050_  ///
FWOR1299_ FWOR1300_ FWOR1301_ FWOR1302_ FWOR1303_ FWOR1304_ FWOR1305_ FWOR1306_ FWOR1307_ FWOR1308_ FWOR1309_ FWOR1310_ FWOR1311_ FWOR1312_ FWOR1313_ FWOR1314_ FWOR1315_ FWOR1316_ FWOR1317_ FWOR1318_ FWOR1319_ FWOR1320_ FWOR1321_ FWOR1322_ FWOR585_ FWOR1347_ FWOR591_ FWOR592_ HeadYrsWorkedSince18_ WifeYearsWorkedSince18_ FWOR1357_ FWOR1358_ FWOR1359_ FWOR2222_ FWOR2224_ FWOR2226_ FWOR2228_ FWOR2230_ FWOR1362_ FWOR1363_ FWOR1364_ FWOR2232_ FWOR2233_ FWOR2234_ FWOR2235_ FWOR2237_ FWOR2239_ FWOR1369_ FWOR1371_ FWOR2244_ FWOR1373_ FWOR621_ FWOR622_ FWOR1375_ FWOR1377_ FWOR1378_ FWOR2246_ FWOR2248_ FWOR2250_ FWOR2252_ FWOR2254_ FWOR2256_ FWOR2257_ FWOR2258_ FWOR2259_ FWOR2261_ FWOR2263_ FWOR631_ FWOR1379_ FWOR1380_ FWOR1389_ FWOR1391_ FWOR2270_ FWOR2271_ FWOR2272_ FWOR1392_ FWOR1393_ FWOR2276_ FWOR1567_ FWOR368_ HeadEverWorked_ WifeEverWorked_ HeadEmpStat_ FWOR1573_ FWOR1574_ FWOR1575_ FWOR1576_ FWOR1577_ FWOR1578_ FWOR1579_ FWOR1580_ FWOR1581_ FWOR1582_ FWOR1583_ FWOR1584_ FWOR1597_ FWOR1598_ FWOR1599_ FWOR1600_ FWOR1601_ FWOR1602_ FWOR1603_ FWOR1604_ FWOR1605_ FWOR1606_ FWOR1619_ FWOR1620_ FWOR1621_ FWOR1622_ FWOR1623_ FWOR1624_ FWOR1625_ FWOR1626_ FWOR1627_ FWOR1628_ FWOR1629_ FWOR1630_ WifeEmpStat_ FWOR748_ FWOR398_ FWOR399_ FWOR780_ FWOR782_ FWOR784_ FWOR805_ FWOR806_ FWOR809_ FWOR810_ FWOR813_ FWOR814_ FWOR821_ FWOR822_ FWOR825_ FWOR826_ FWOR831_ FWOR832_ FWOR2349_ FWOR2373_ FWOR876_ FWOR884_ FWOR1755_ FWOR1756_ FWOR1757_ FWOR1761_ FWOR1762_ FWOR1763_ FWOR1767_ FWOR1768_ FWOR1769_ FWOR974_ FWOR976_ FWOR980_ FWOR436_ FWOR438_ FWOR439_ FWOR440_ FWOR1839_ FWOR1840_ FWOR1841_ FWOR1842_ FWOR1843_ FWOR1844_ FWOR1845_ FWOR1846_ FWOR1847_ FWOR1860_ FWOR1861_ FWOR1862_ FWOR1863_ FWOR1864_ FWOR1865_ FWOR1866_ FWOR1867_ FWOR1868_ FWOR1869_ FWOR1870_ FWOR1871_ FWOR1034_ FWOR1036_ FWOR445_ FWOR447_ FWOR1058_ FWOR1059_ FWOR1060_ FWOR1924_ FWOR1926_ FWOR1928_ FWOR1930_ FWOR2444_ FWOR2445_ FWOR1932_ FWOR1934_ FWOR1936_ FWOR1938_ FWOR1940_ FWOR1941_ FWOR1944_ FWOR1946_ FWOR1948_ FWOR1950_ FWOR2448_ FWOR2449_ FWOR1093_ FWOR1095_ FWOR1097_ FWOR1099_ FWOR1101_ HeadBegMoPresentEmp_ WifeBegMoPresentEmp_ HeadBegYrPresentEmp_ WifeBegYrPresentEmp_ HeadMosPresentEmp94On_ WifeMosPresentEmp94On_ HeadMosPresentEmp94Prior_ WifeMosPresentEmp94Prior_ FWOR1114_ HeadYearsPresentEmp_ WifeYearsPresentEmp_ HeadYearsPresentJobBkted_ HeadSamePosPresentEmp_ WifeSamePosPresentEmp_ FWOR1952_ FWOR1954_ FWOR1956_ FWOR1958_ FWOR1960_ FWOR1962_ HeadPermPresentPos_ WifePermPresentPos_ HeadMosPresentPos_ WifeMosPresentPos_ FWOR1964_ FWOR1965_ FWOR1968_ FWOR1969_ FWOR1972_ FWOR1973_ FWOR1976_ FWOR1980_ FWOR1981_ FWOR1984_ FWOR1985_ HeadNewPosNewEmp_ WifeNewPosNewEmp_ FWOR1988_ FWOR1990_ FWOR1992_ FWOR1994_ FWOR1996_ FWOR1998_ FWOR2000_ FWOR2002_ FWOR2004_ FWOR2010_ FWOR2452_ FWOR2012_ FWOR2014_ FWOR2016_ FWOR2022_ FWOR2454_ FWOR2024_ HeadBegMoPresEmp_ WifeBegMoPresEmp_ HeadBegYrPresEmp_ WifeBegYrPresEmp_ FWOR2042_ FWOR1133_ FWOR1135_ FWOR1136_ FWOR2058_ FWOR2059_ FWOR1139_ FWOR1140_ FWOR1141_ FWOR2062_ FWOR2063_ FWOR2064_ FWOR2068_ FWOR2069_ FWOR2070_ FWOR2074_ FWOR2075_ FWOR2076_ FWOR2080_ FWOR2081_ FWOR2082_ FWOR2086_ FWOR2088_ FWOR2135_ FWOR2137_ FWOR2515_ FWOR2516_ FWOR2138_ FWOR148_ FWOR149_ FWOR150_ FWOR2524_ FWOR154_ FWOR155_ FWOR156_ FWOR282_ FWOR286_ FWOR171_ FWOR2139_ FWOR2141_ FWOR2142_ FWOR2533_ FWOR2534_ FWOR192_ FWOR193_ FWOR196_ FWOR197_ FWOR200_ FWOR201_ FWOR330_  ///
FLOCAN024_ CurrentState_  ///
ExpOnChildcare_ ExpOnEarnings_ ExpOnNonFamDependents_yn_ ExpOnNonFamDependents_ FEXP502_ FEXP505_ FEXP567_ FEXP506_ AddlExpOnEducation_yn_ ExpOnEducation_yn_ ExpOnEducation_ ExpOnHomeFood_ ExpOnRestaurantFood_ ExpOnFood_ HealthcareExpTotal_ HealthcareExpVisits_ HealthcareExpPres_ CostofHousing_ MortgageValue_ ExpOnRent_ PropertyTaxes_ VehiclesOwned_yn_ PublicTransit_yn_  ///
FFINDI167_  ///
FREL005_  ///
IRAAmt_ IRA_ACC_ IRA_yn_ Business_yn_ FarmBusinessAmtNet_ CashAmt_ CashAmtWOIRAs_ TotalLiquidAmt_ NumCheckAccts_ CheckingAmt_ TotalLiquidAmt_ACC_ Checking_yn_ FarmBusinessAmt2_ Business_ACC_ Business2_yn_ HomeEquityAmt_ HomeEquity_ACC_ Inheritance_yn_ InheritanceAmt_ Collectibles_yn_ CollectiblesAmt_ OtherAssetsAmt_ OtherAssets_ACC_ OtherAssets_yn_ OtherDebtAmt_ OtherDebtType_ OtherDebtImputed_ OtherDebt_yn_ OtherRealEstateAmt_ OtherRealEstate_yn_ OtherHouses_yn_ Savings_yn_ TwoMosSavings_ TwoMosSavingsinFiveYrs_ IndexFund_yn_ FinancialAssets_yn_ StocksAmt_ Stocks_ACC_ Stocks_yn_ StudentLoansAmt_ StudentLoans_ACC_ StudentLoans_yn_ TotalLiquidWealth_ TotalWealth_ PositiveWealth_ VehicleValueNet_ VehicleValue_ VehicleValue_ACC_ EmpStat IndCluster IndStratum RelToHead Weight_Cross Weight_Long YrsSchool, i(IndID) j(year)
ren Age_ AgeHead
ren AgeWife_ AgeWife
ren MarDum_ MarDum
ren Race_ Race
ren FDEM137_ FDEM137
ren SexHead_ SexHead
ren FEDU155_ FEDU155
ren FEDU156_ FEDU156
ren FEDU157_ FEDU157
ren FEDU050_ FEDU050
ren FEDU052_ FEDU052
ren FEDU054_ FEDU054
ren FEDU056_ FEDU056
ren FEDU058_ FEDU058
ren FEDU060_ FEDU060
ren FEDU186_ FEDU186
ren FEDU062_ FEDU062
ren FEDU063_ FEDU063
ren HeadAdvancedDegree_yn_ HeadAdvancedDegree_yn
ren WifeAdvancedDegree_yn_ WifeAdvancedDegree_yn
ren HeadCollegeACTScoresAve_ HeadCollegeACTScoresAve
ren WifeCollegeACTScoresAve_ WifeCollegeACTScoresAve
ren HeadCollegeDegree_yn_ HeadCollegeDegree_yn
ren WifeCollegeDegree_yn_ WifeCollegeDegree_yn
ren HeadCollegeExpAve_ HeadCollegeExpAve
ren WifeCollegeExpAve_ WifeCollegeExpAve
ren HeadSchoolRatingA_ HeadSchoolRatingA
ren WifeSchoolRatingA_ WifeSchoolRatingA
ren HeadSchoolRatingB_ HeadSchoolRatingB
ren WifeSchoolRatingB_ WifeSchoolRatingB
ren HeadYrsCollege_ HeadYrsCollege
ren WifeYrsCollege_ WifeYrsCollege
ren HeadHSGrad_ HeadHSGrad
ren WifeHSGrad_ WifeHSGrad
ren HeadNonHSGrad_ HeadNonHSGrad
ren WifeNonHSGrad_ WifeNonHSGrad
ren HeadYrsSchool_ HeadYrsSchool
ren HeadYrsSchoolBkted_ HeadYrsSchoolBkted
ren WifeYrsSchool_ WifeYrsSchool
ren WifeYrsSchoolBkted_ WifeYrsSchoolBkted
ren HeadCollegeField1_ HeadCollegeField1
ren HeadCollegeField2_ HeadCollegeField2
ren WifeCollegeField1_ WifeCollegeField1
ren WifeCollegeField2_ WifeCollegeField2
ren HeadCollegeMajor_ HeadCollegeMajor
ren FFAMCO014_ FFAMCO014
ren FFAMCO031_ FFAMCO031
ren NumFam_ NumFam
ren FFAMCO064_ FFAMCO064
ren FHOU008_ FHOU008
ren HouseWork_ HouseWork
ren HouseWorkWife_ HouseWorkWife
ren HouseValue_ HouseValue
ren HouseValueACC_ HouseValueACC
ren Mortgage_yn_ Mortgage_yn
ren HouseStat_ HouseStat
ren FINC508_ FINC508
ren FINC393_ FINC393
ren FINC518_ FINC518
ren FINC406_ FINC406
ren FamilyBusiness_ FamilyBusiness
ren FamIncMajorAssignment_ FamIncMajorAssignment
ren NomFamTaxInc_ NomFamTaxInc
ren FINC633_ FINC633
ren NomFamInc_ NomFamInc
ren FINC653_ FINC653
ren FINC465_ FINC465
ren NomLabInc_ NomLabInc
ren FINC991_ FINC991
ren NomSpouseLabInc_ NomSpouseLabInc
ren FINC379_ FINC379
ren HeadTransFromRel_ HeadTransFromRel
ren HeadTransFromRel93On_ HeadTransFromRel93On
ren WifeTransFromRel_ WifeTransFromRel
ren TransInc_yn_ TransInc_yn
ren NomPrivateTransInc_ NomPrivateTransInc
ren FINC1167_ FINC1167
ren FINC1170_ FINC1170
ren FINC1171_ FINC1171
ren FINC1536_ FINC1536
ren NomTotalTransInc_ NomTotalTransInc
ren HeadChildhoodECStat_ HeadChildhoodECStat
ren WifeChildhoodECStat_ WifeChildhoodECStat
ren FPAR133_ FPAR133
ren FPAR134_ FPAR134
ren FPAR139_ FPAR139
ren FPAR140_ FPAR140
ren CoreLongWeight_ CoreLongWeight
*ren ID_ ID
ren FSURIN006_ FSURIN006
ren FSURIN022_ FSURIN022
ren FSURIN089_ FSURIN089
ren FSURIN124_ FSURIN124
ren FSURIN002_ FSURIN002
ren FSURIN049_ FSURIN049
ren FSURIN050_ FSURIN050
ren FWOR1299_ FWOR1299
ren FWOR1300_ FWOR1300
ren FWOR1301_ FWOR1301
ren FWOR1302_ FWOR1302
ren FWOR1303_ FWOR1303
ren FWOR1304_ FWOR1304
ren FWOR1305_ FWOR1305
ren FWOR1306_ FWOR1306
ren FWOR1307_ FWOR1307
ren FWOR1308_ FWOR1308
ren FWOR1309_ FWOR1309
ren FWOR1310_ FWOR1310
ren FWOR1311_ FWOR1311
ren FWOR1312_ FWOR1312
ren FWOR1313_ FWOR1313
ren FWOR1314_ FWOR1314
ren FWOR1315_ FWOR1315
ren FWOR1316_ FWOR1316
ren FWOR1317_ FWOR1317
ren FWOR1318_ FWOR1318
ren FWOR1319_ FWOR1319
ren FWOR1320_ FWOR1320
ren FWOR1321_ FWOR1321
ren FWOR1322_ FWOR1322
ren FWOR585_ FWOR585
ren FWOR1347_ FWOR1347
ren FWOR591_ FWOR591
ren FWOR592_ FWOR592
ren HeadYrsWorkedSince18_ HeadYrsWorkedSince18
ren WifeYearsWorkedSince18_ WifeYearsWorkedSince18
ren FWOR1357_ FWOR1357
ren FWOR1358_ FWOR1358
ren FWOR1359_ FWOR1359
ren FWOR2222_ FWOR2222
ren FWOR2224_ FWOR2224
ren FWOR2226_ FWOR2226
ren FWOR2228_ FWOR2228
ren FWOR2230_ FWOR2230
ren FWOR1362_ FWOR1362
ren FWOR1363_ FWOR1363
ren FWOR1364_ FWOR1364
ren FWOR2232_ FWOR2232
ren FWOR2233_ FWOR2233
ren FWOR2234_ FWOR2234
ren FWOR2235_ FWOR2235
ren FWOR2237_ FWOR2237
ren FWOR2239_ FWOR2239
ren FWOR1369_ FWOR1369
ren FWOR1371_ FWOR1371
ren FWOR2244_ FWOR2244
ren FWOR1373_ FWOR1373
ren FWOR621_ FWOR621
ren FWOR622_ FWOR622
ren FWOR1375_ FWOR1375
ren FWOR1377_ FWOR1377
ren FWOR1378_ FWOR1378
ren FWOR2246_ FWOR2246
ren FWOR2248_ FWOR2248
ren FWOR2250_ FWOR2250
ren FWOR2252_ FWOR2252
ren FWOR2254_ FWOR2254
ren FWOR2256_ FWOR2256
ren FWOR2257_ FWOR2257
ren FWOR2258_ FWOR2258
ren FWOR2259_ FWOR2259
ren FWOR2261_ FWOR2261
ren FWOR2263_ FWOR2263
ren FWOR631_ FWOR631
ren FWOR1379_ FWOR1379
ren FWOR1380_ FWOR1380
ren FWOR1389_ FWOR1389
ren FWOR1391_ FWOR1391
ren FWOR2270_ FWOR2270
ren FWOR2271_ FWOR2271
ren FWOR2272_ FWOR2272
ren FWOR1392_ FWOR1392
ren FWOR1393_ FWOR1393
ren FWOR2276_ FWOR2276
ren FWOR1567_ FWOR1567
ren FWOR368_ FWOR368
ren HeadEverWorked_ HeadEverWorked
ren WifeEverWorked_ WifeEverWorked
ren HeadEmpStat_ HeadEmpStat
ren FWOR1573_ FWOR1573
ren FWOR1574_ FWOR1574
ren FWOR1575_ FWOR1575
ren FWOR1576_ FWOR1576
ren FWOR1577_ FWOR1577
ren FWOR1578_ FWOR1578
ren FWOR1579_ FWOR1579
ren FWOR1580_ FWOR1580
ren FWOR1581_ FWOR1581
ren FWOR1582_ FWOR1582
ren FWOR1583_ FWOR1583
ren FWOR1584_ FWOR1584
ren FWOR1597_ FWOR1597
ren FWOR1598_ FWOR1598
ren FWOR1599_ FWOR1599
ren FWOR1600_ FWOR1600
ren FWOR1601_ FWOR1601
ren FWOR1602_ FWOR1602
ren FWOR1603_ FWOR1603
ren FWOR1604_ FWOR1604
ren FWOR1605_ FWOR1605
ren FWOR1606_ FWOR1606
ren FWOR1619_ FWOR1619
ren FWOR1620_ FWOR1620
ren FWOR1621_ FWOR1621
ren FWOR1622_ FWOR1622
ren FWOR1623_ FWOR1623
ren FWOR1624_ FWOR1624
ren FWOR1625_ FWOR1625
ren FWOR1626_ FWOR1626
ren FWOR1627_ FWOR1627
ren FWOR1628_ FWOR1628
ren FWOR1629_ FWOR1629
ren FWOR1630_ FWOR1630
ren WifeEmpStat_ WifeEmpStat
ren FWOR748_ FWOR748
ren FWOR398_ FWOR398
ren FWOR399_ FWOR399
ren FWOR780_ FWOR780
ren FWOR782_ FWOR782
ren FWOR784_ FWOR784
ren FWOR805_ FWOR805
ren FWOR806_ FWOR806
ren FWOR809_ FWOR809
ren FWOR810_ FWOR810
ren FWOR813_ FWOR813
ren FWOR814_ FWOR814
ren FWOR821_ FWOR821
ren FWOR822_ FWOR822
ren FWOR825_ FWOR825
ren FWOR826_ FWOR826
ren FWOR831_ FWOR831
ren FWOR832_ FWOR832
ren FWOR2349_ FWOR2349
ren FWOR2373_ FWOR2373
ren FWOR876_ FWOR876
ren FWOR884_ FWOR884
ren FWOR1755_ FWOR1755
ren FWOR1756_ FWOR1756
ren FWOR1757_ FWOR1757
ren FWOR1761_ FWOR1761
ren FWOR1762_ FWOR1762
ren FWOR1763_ FWOR1763
ren FWOR1767_ FWOR1767
ren FWOR1768_ FWOR1768
ren FWOR1769_ FWOR1769
ren FWOR974_ FWOR974
ren FWOR976_ FWOR976
ren FWOR980_ FWOR980
ren FWOR436_ FWOR436
ren FWOR438_ FWOR438
ren FWOR439_ FWOR439
ren FWOR440_ FWOR440
ren FWOR1839_ FWOR1839
ren FWOR1840_ FWOR1840
ren FWOR1841_ FWOR1841
ren FWOR1842_ FWOR1842
ren FWOR1843_ FWOR1843
ren FWOR1844_ FWOR1844
ren FWOR1845_ FWOR1845
ren FWOR1846_ FWOR1846
ren FWOR1847_ FWOR1847
ren FWOR1860_ FWOR1860
ren FWOR1861_ FWOR1861
ren FWOR1862_ FWOR1862
ren FWOR1863_ FWOR1863
ren FWOR1864_ FWOR1864
ren FWOR1865_ FWOR1865
ren FWOR1866_ FWOR1866
ren FWOR1867_ FWOR1867
ren FWOR1868_ FWOR1868
ren FWOR1869_ FWOR1869
ren FWOR1870_ FWOR1870
ren FWOR1871_ FWOR1871
ren FWOR1034_ FWOR1034
ren FWOR1036_ FWOR1036
ren FWOR445_ FWOR445
ren FWOR447_ FWOR447
ren FWOR1058_ FWOR1058
ren FWOR1059_ FWOR1059
ren FWOR1060_ FWOR1060
ren FWOR1924_ FWOR1924
ren FWOR1926_ FWOR1926
ren FWOR1928_ FWOR1928
ren FWOR1930_ FWOR1930
ren FWOR2444_ FWOR2444
ren FWOR2445_ FWOR2445
ren FWOR1932_ FWOR1932
ren FWOR1934_ FWOR1934
ren FWOR1936_ FWOR1936
ren FWOR1938_ FWOR1938
ren FWOR1940_ FWOR1940
ren FWOR1941_ FWOR1941
ren FWOR1944_ FWOR1944
ren FWOR1946_ FWOR1946
ren FWOR1948_ FWOR1948
ren FWOR1950_ FWOR1950
ren FWOR2448_ FWOR2448
ren FWOR2449_ FWOR2449
ren FWOR1093_ FWOR1093
ren FWOR1095_ FWOR1095
ren FWOR1097_ FWOR1097
ren FWOR1099_ FWOR1099
ren FWOR1101_ FWOR1101
ren HeadBegMoPresentEmp_ HeadBegMoPresentEmp
ren WifeBegMoPresentEmp_ WifeBegMoPresentEmp
ren HeadBegYrPresentEmp_ HeadBegYrPresentEmp
ren WifeBegYrPresentEmp_ WifeBegYrPresentEmp
ren HeadMosPresentEmp94On_ HeadMosPresentEmp94On
ren WifeMosPresentEmp94On_ WifeMosPresentEmp94On
ren HeadMosPresentEmp94Prior_ HeadMosPresentEmp94Prior
ren WifeMosPresentEmp94Prior_ WifeMosPresentEmp94Prior
ren FWOR1114_ FWOR1114
ren HeadYearsPresentEmp_ HeadYearsPresentEmp
ren WifeYearsPresentEmp_ WifeYearsPresentEmp
ren HeadYearsPresentJobBkted_ HeadYearsPresentJobBkted
ren HeadSamePosPresentEmp_ HeadSamePosPresentEmp
ren WifeSamePosPresentEmp_ WifeSamePosPresentEmp
ren FWOR1952_ FWOR1952
ren FWOR1954_ FWOR1954
ren FWOR1956_ FWOR1956
ren FWOR1958_ FWOR1958
ren FWOR1960_ FWOR1960
ren FWOR1962_ FWOR1962
ren HeadPermPresentPos_ HeadPermPresentPos
ren WifePermPresentPos_ WifePermPresentPos
ren HeadMosPresentPos_ HeadMosPresentPos
ren WifeMosPresentPos_ WifeMosPresentPos
ren FWOR1964_ FWOR1964
ren FWOR1965_ FWOR1965
ren FWOR1968_ FWOR1968
ren FWOR1969_ FWOR1969
ren FWOR1972_ FWOR1972
ren FWOR1973_ FWOR1973
ren FWOR1976_ FWOR1976
ren FWOR1980_ FWOR1980
ren FWOR1981_ FWOR1981
ren FWOR1984_ FWOR1984
ren FWOR1985_ FWOR1985
ren HeadNewPosNewEmp_ HeadNewPosNewEmp
ren WifeNewPosNewEmp_ WifeNewPosNewEmp
ren FWOR1988_ FWOR1988
ren FWOR1990_ FWOR1990
ren FWOR1992_ FWOR1992
ren FWOR1994_ FWOR1994
ren FWOR1996_ FWOR1996
ren FWOR1998_ FWOR1998
ren FWOR2000_ FWOR2000
ren FWOR2002_ FWOR2002
ren FWOR2004_ FWOR2004
ren FWOR2010_ FWOR2010
ren FWOR2452_ FWOR2452
ren FWOR2012_ FWOR2012
ren FWOR2014_ FWOR2014
ren FWOR2016_ FWOR2016
ren FWOR2022_ FWOR2022
ren FWOR2454_ FWOR2454
ren FWOR2024_ FWOR2024
ren HeadBegMoPresEmp_ HeadBegMoPresEmp
ren WifeBegMoPresEmp_ WifeBegMoPresEmp
ren HeadBegYrPresEmp_ HeadBegYrPresEmp
ren WifeBegYrPresEmp_ WifeBegYrPresEmp
ren FWOR2042_ FWOR2042
ren FWOR1133_ FWOR1133
ren FWOR1135_ FWOR1135
ren FWOR1136_ FWOR1136
ren FWOR2058_ FWOR2058
ren FWOR2059_ FWOR2059
ren FWOR1139_ FWOR1139
ren FWOR1140_ FWOR1140
ren FWOR1141_ FWOR1141
ren FWOR2062_ FWOR2062
ren FWOR2063_ FWOR2063
ren FWOR2064_ FWOR2064
ren FWOR2068_ FWOR2068
ren FWOR2069_ FWOR2069
ren FWOR2070_ FWOR2070
ren FWOR2074_ FWOR2074
ren FWOR2075_ FWOR2075
ren FWOR2076_ FWOR2076
ren FWOR2080_ FWOR2080
ren FWOR2081_ FWOR2081
ren FWOR2082_ FWOR2082
ren FWOR2086_ FWOR2086
ren FWOR2088_ FWOR2088
ren FWOR2135_ FWOR2135
ren FWOR2137_ FWOR2137
ren FWOR2515_ FWOR2515
ren FWOR2516_ FWOR2516
ren FWOR2138_ FWOR2138
ren FWOR148_ FWOR148
ren FWOR149_ FWOR149
ren FWOR150_ FWOR150
ren FWOR2524_ FWOR2524
ren FWOR154_ FWOR154
ren FWOR155_ FWOR155
ren FWOR156_ FWOR156
ren FWOR282_ FWOR282
ren FWOR286_ FWOR286
ren FWOR171_ FWOR171
ren FWOR2139_ FWOR2139
ren FWOR2141_ FWOR2141
ren FWOR2142_ FWOR2142
ren FWOR2533_ FWOR2533
ren FWOR2534_ FWOR2534
ren FWOR192_ FWOR192
ren FWOR193_ FWOR193
ren FWOR196_ FWOR196
ren FWOR197_ FWOR197
ren FWOR200_ FWOR200
ren FWOR201_ FWOR201
ren FWOR330_ FWOR330
ren FLOCAN024_ FLOCAN024
ren CurrentState_ CurrentState
ren ExpOnChildcare_ ExpOnChildcare
ren ExpOnEarnings_ ExpOnEarnings
ren ExpOnNonFamDependents_yn_ ExpOnNonFamDependents_yn
ren ExpOnNonFamDependents_ ExpOnNonFamDependents
ren FEXP502_ FEXP502
ren FEXP505_ FEXP505
ren FEXP567_ FEXP567
ren FEXP506_ FEXP506
ren AddlExpOnEducation_yn_ AddlExpOnEducation_yn
ren ExpOnEducation_yn_ ExpOnEducation_yn
ren ExpOnEducation_ ExpOnEducation
ren ExpOnHomeFood_ ExpOnHomeFood
ren ExpOnRestaurantFood_ ExpOnRestaurantFood
ren ExpOnFood_ ExpOnFood
ren HealthcareExpTotal_ HealthcareExpTotal
ren HealthcareExpVisits_ HealthcareExpVisits
ren HealthcareExpPres_ HealthcareExpPres
ren CostofHousing_ CostofHousing
ren MortgageValue_ MortgageValue
ren ExpOnRent_ ExpOnRent
ren PropertyTaxes_ PropertyTaxes
ren VehiclesOwned_yn_ VehiclesOwned_yn
ren PublicTransit_yn_ PublicTransit_yn
ren FFINDI167_ FFINDI167
ren FREL005_ FREL005
ren IRAAmt_ IRAAmt
ren IRA_ACC_ IRA_ACC
ren IRA_yn_ IRA_yn
ren Business_yn_ Business_yn
ren FarmBusinessAmtNet_ FarmBusinessAmtNet
ren CashAmt_ CashAmt
ren CashAmtWOIRAs_ CashAmtWOIRAs
ren TotalLiquidAmt_ TotalLiquidAmt
ren NumCheckAccts_ NumCheckAccts
ren CheckingAmt_ CheckingAmt
ren TotalLiquidAmt_ACC_ TotalLiquidAmt_ACC
ren Checking_yn_ Checking_yn
ren FarmBusinessAmt2_ FarmBusinessAmt2
ren Business_ACC_ Business_ACC
ren Business2_yn_ Business2_yn
ren HomeEquityAmt_ HomeEquityAmt
ren HomeEquity_ACC_ HomeEquity_ACC
ren Inheritance_yn_ Inheritance_yn
ren InheritanceAmt_ InheritanceAmt
ren Collectibles_yn_ Collectibles_yn
ren CollectiblesAmt_ CollectiblesAmt
ren OtherAssetsAmt_ OtherAssetsAmt
ren OtherAssets_ACC_ OtherAssets_ACC
ren OtherAssets_yn_ OtherAssets_yn
ren OtherDebtAmt_ OtherDebtAmt
ren OtherDebtType_ OtherDebtType
ren OtherDebtImputed_ OtherDebtImputed
ren OtherDebt_yn_ OtherDebt_yn
ren OtherRealEstateAmt_ OtherRealEstateAmt
ren OtherRealEstate_yn_ OtherRealEstate_yn
ren OtherHouses_yn_ OtherHouses_yn
ren Savings_yn_ Savings_yn
ren TwoMosSavings_ TwoMosSavings
ren TwoMosSavingsinFiveYrs_ TwoMosSavingsinFiveYrs
ren IndexFund_yn_ IndexFund_yn
ren FinancialAssets_yn_ FinancialAssets_yn
ren StocksAmt_ StocksAmt
ren Stocks_ACC_ Stocks_ACC
ren Stocks_yn_ Stocks_yn
ren StudentLoansAmt_ StudentLoansAmt
ren StudentLoans_ACC_ StudentLoans_ACC
ren StudentLoans_yn_ StudentLoans_yn
ren TotalLiquidWealth_ TotalLiquidWealth
ren TotalWealth_ TotalWealth
ren PositiveWealth_ PositiveWealth
ren VehicleValueNet_ VehicleValueNet
ren VehicleValue_ VehicleValue
ren VehicleValue_ACC_ VehicleValue_ACC

	label variable Age "01>DEMOGRAPHIC 02>Age 03>head:"
	label variable AgeWife "01>DEMOGRAPHIC 02>Age 03>spouse:"
	label variable MarDum "01>DEMOGRAPHIC 02>Marriage 03>marital status 04>head 05>present status 06>cohabitors treated as married:"
	label variable Race "01>DEMOGRAPHIC 02>Race and Ethnicity 03>race 04>head 05>1st mention:"
	label variable FDEM137 "01>DEMOGRAPHIC 02>Race and Ethnicity 03>race 04>spouse 05>1st mention:"
	label variable SexHead "01>DEMOGRAPHIC 02>Sex 03>head:"
	label variable FEDU155 "01>EDUCATION 02>Additional Training Outside School System 03>certificates received 04>number of 05>head: 06>year 07>1st mention:"
	label variable FEDU156 "01>EDUCATION 02>Additional Training Outside School System 03>certificates received 04>number of 05>head: 06>year 07>2nd mention:"
	label variable FEDU157 "01>EDUCATION 02>Additional Training Outside School System 03>certificates received 04>number of 05>head: 06>year 07>3rd mention:"
	label variable FEDU050 "01>EDUCATION 02>Additional Training Outside School System 03>certification 04>1st mention 05>head:"
	label variable FEDU052 "01>EDUCATION 02>Additional Training Outside School System 03>certification 04>2nd mention 05>head:"
	label variable FEDU054 "01>EDUCATION 02>Additional Training Outside School System 03>certification 04>3rd mention 05>head:"
	label variable FEDU056 "01>EDUCATION 02>Additional Training Outside School System 03>field of study 04>1st mention 05>head:"
	label variable FEDU058 "01>EDUCATION 02>Additional Training Outside School System 03>field of study 04>2nd mention 05>head:"
	label variable FEDU060 "01>EDUCATION 02>Additional Training Outside School System 03>field of study 04>3rd mention 05>head:"
	label variable FEDU186 "01>EDUCATION 02>Additional Training Outside School System 03>head, whether:"
	label variable FEDU062 "01>EDUCATION 02>Additional Training Outside School System 03>organization, type of 04>head 05>1st mention:"
	label variable FEDU063 "01>EDUCATION 02>Additional Training Outside School System 03>organization, type of 04>head 05>2nd mention:"
	label variable HeadAdvancedDegree_yn "01>EDUCATION 02>College 03>advanced degree, whether 04>head:"
	label variable WifeAdvancedDegree_yn "01>EDUCATION 02>College 03>advanced degree, whether 04>spouse, from spouse interview:"
	label variable HeadCollegeACTScoresAve "01>EDUCATION 02>College 03>average ACT score of freshman class 04>head:"
	label variable WifeCollegeACTScoresAve "01>EDUCATION 02>College 03>average ACT score of freshman class 04>spouse:"
	label variable HeadCollegeDegree_yn "01>EDUCATION 02>College 03>college degree, whether 04>head:"
	label variable WifeCollegeDegree_yn "01>EDUCATION 02>College 03>college degree, whether 04>spouse:"
	label variable HeadCollegeExpAve "01>EDUCATION 02>College 03>expenditure per student 04>head:"
	label variable WifeCollegeExpAve "01>EDUCATION 02>College 03>expenditure per student 04>spouse:"
	label variable HeadSchoolRatingA "01>EDUCATION 02>College 03>ratings of status 04>1935-1954 05>head:"
	label variable WifeSchoolRatingA "01>EDUCATION 02>College 03>ratings of status 04>1935-1954 05>spouse:"
	label variable HeadSchoolRatingB "01>EDUCATION 02>College 03>ratings of status 04>1970-1974 05>head:"
	label variable WifeSchoolRatingB "01>EDUCATION 02>College 03>ratings of status 04>1970-1974 05>spouse:"
	label variable HeadYrsCollege "01>EDUCATION 02>Grades Completed 03>college only 04>head:"
	label variable WifeYrsCollege "01>EDUCATION 02>Grades Completed 03>college only 04>spouse:"
	label variable HeadHSGrad "01>EDUCATION 02>Grades Completed 03>excluding college 04>high school, no GED 05>graduate, whether 06>head:"
	label variable WifeHSGrad "01>EDUCATION 02>Grades Completed 03>excluding college 04>high school, no GED 05>graduate, whether 06>spouse:"
	label variable HeadNonHSGrad "01>EDUCATION 02>Grades Completed 03>excluding college 04>high school, no GED 05>nongraduate 06>head:"
	label variable WifeNonHSGrad "01>EDUCATION 02>Grades Completed 03>excluding college 04>high school, no GED 05>nongraduate 06>spouse:"
	label variable HeadYrsSchool "01>EDUCATION 02>Grades Completed 03>including college 04>head:"
	label variable HeadYrsSchoolBkted "01>EDUCATION 02>Grades Completed 03>including college 04>head: 05>bracket:"
	label variable WifeYrsSchool "01>EDUCATION 02>Grades Completed 03>including college 04>spouse:"
	label variable WifeYrsSchoolBkted "01>EDUCATION 02>Grades Completed 03>including college 04>spouse: 05>bracket:"
	label variable HeadCollegeField1 "01>EDUCATION 02>Since Last Interview 03>College 04>head 05>bachelor degree 06>field of study 07>1st mention:"
	label variable HeadCollegeField2 "01>EDUCATION 02>Since Last Interview 03>College 04>head 05>bachelor degree 06>field of study 07>2nd mention:"
	label variable WifeCollegeField1 "01>EDUCATION 02>Since Last Interview 03>College 04>spouse 05>bachelor degree 06>field of study 07>1st mention:"
	label variable WifeCollegeField2 "01>EDUCATION 02>Since Last Interview 03>College 04>spouse 05>bachelor degree 06>field of study 07>2nd mention:"
	label variable HeadCollegeMajor "01>EDUCATION 02>Since Last Interview 03>highest college degree received 04>head: 05>major area of study:"
	label variable FFAMCO014 "01>FAMILY COMPOSITION 02>Change Variables:"
	label variable FFAMCO031 "01>FAMILY COMPOSITION 02>Current: 03>head, whether same or new:"
	label variable NumFam "01>FAMILY COMPOSITION 02>Current: 03>number in family unit 04>total number in family unit:"
	label variable FFAMCO064 "01>FAMILY COMPOSITION 02>Current: 03>spouse, whether in family unit 04>same or new, whether:"
	label variable FHOU008 "01>HOUSEWORK 02>Hours 03>annual 04>spouse:"
	label variable HouseWork "01>HOUSEWORK 02>Hours 03>weekly 04>head:"
	label variable HouseWorkWife "01>HOUSEWORK 02>Hours 03>weekly 04>spouse:"
	label variable HouseValue "01>HOUSING 02>Home Ownership 03>house value:"
	label variable HouseValueACC "01>HOUSING 02>Home Ownership 03>house value: 04>accuracy code:"
	label variable Mortgage_yn "01>HOUSING 02>Home Ownership 03>mortgage, whether:"
	label variable HouseStat "01>HOUSING 02>Housing Status:"
	label variable FINC508 "01>INCOME 02>Asset 03>dividends only, annual: 04>reported: 05>head:"
	label variable FINC393 "01>INCOME 02>Asset 03>dividends, interest, etc.: 04>head:"
	label variable FINC518 "01>INCOME 02>Asset 03>interest only, annual: 04>reported: 05>head:"
	label variable FINC406 "01>INCOME 02>Asset 03>rent, dividends, interest, etc.: 04>head:"
	label variable FamilyBusiness "01>INCOME 02>Business 03>owned by family, whether:"
	label variable FamIncMajorAssignment "01>INCOME 02>Family Money 03>percent with major assignment: 04>accuracy code:"
	label variable NomFamTaxInc "01>INCOME 02>Family Money 03>taxable 04>head and spouse, whether: 05>amount:"
	label variable FINC633 "01>INCOME 02>Family Money 03>taxable 04>others 05>total:"
	label variable NomFamInc "01>INCOME 02>Family Money 03>total family income:"
	label variable FINC653 "01>INCOME 02>Labor 03>head 04>professional practice or trade 05>annual:"
	label variable FINC465 "01>INCOME 02>Labor 03>head 04>total (includes wages and other labor):"
	label variable NomLabInc "01>INCOME 02>Labor 03>head 04>wages and salaries:"
	label variable FINC991 "01>INCOME 02>Labor 03>head 04>wages and salaries: 05>reported: 06>accuracy code:"
	label variable NomSpouseLabInc "01>INCOME 02>Labor 03>spouse 04>total (includes wages and other labor):"
	label variable FINC379 "01>INCOME 02>Needs Standard 03>income, annual, current census version:"
	label variable HeadTransFromRel "01>INCOME 02>Transfers 03>private 04>from relatives outside household 05>head 06>amount:"
	label variable HeadTransFromRel93On "01>INCOME 02>Transfers 03>private 04>from relatives outside household 05>head 06>reported:"
	label variable WifeTransFromRel "01>INCOME 02>Transfers 03>private 04>from relatives outside household 05>spouse 06>amount:"
	label variable TransInc_yn "01>INCOME 02>Transfers 03>private 04>lump sum payments, whether:"
	label variable NomPrivateTransInc "01>INCOME 02>Transfers 03>private 04>lump sum payments, whether: 05>amount:"
	label variable FINC1167 "01>INCOME 02>Transfers 03>public 04>unemployment and worker's compensation 05>amount 06>head:"
	label variable FINC1170 "01>INCOME 02>Transfers 03>public 04>unemployment compensation 05>family in T-2, whether: 06>amount:"
	label variable FINC1171 "01>INCOME 02>Transfers 03>public 04>unemployment compensation 05>head 06>amount, annual:"
	label variable FINC1536 "01>INCOME 02>Transfers 03>public 04>unemployment compensation 05>head 06>amount, annual: 07>reported:"
	label variable NomTotalTransInc "01>INCOME 02>Transfers 03>total, whether: 04>head and spouse:"
	label variable HeadChildhoodECStat "01>PARENTS 02>Economic Situation of Family in Early Years 03>head:"
	label variable WifeChildhoodECStat "01>PARENTS 02>Economic Situation of Family in Early Years 03>spouse:"
	label variable FPAR133 "01>PARENTS 02>Education 03>head's father:"
	label variable FPAR134 "01>PARENTS 02>Education 03>head's mother:"
	label variable FPAR139 "01>PARENTS 02>Education 03>spouse's father:"
	label variable FPAR140 "01>PARENTS 02>Education 03>spouse's mother:"
	label variable CoreLongWeight "01>SAMPLE WEIGHT 02>Longitudinal 03>core:"
	label variable ID "01>SURVEY INFORMATION 02>Interview Information 03>family interview number (ID):"
	label variable FSURIN006 "01>SURVEY INFORMATION 02>Interview Information 03>household number 04>id number:"
	label variable FSURIN022 "01>SURVEY INFORMATION 02>Interview Information 03>respondent, relationship to head 04>head's interview:"
	label variable FSURIN089 "01>SURVEY INFORMATION 02>Manual Cross Year Identifier 03>1968 id (interview) number:"
	label variable FSURIN124 "01>SURVEY INFORMATION 02>Splitoff Information 03>splitoff indicator of family:"
	label variable FSURIN002 "01>SURVEY INFORMATION 02>Interview Information 03>date of interview 04>head:"
	label variable FSURIN049 "01>SURVEY INFORMATION 02>Interview Information 03>date of interview 04>head: 05>month:"
	label variable FSURIN050 "01>SURVEY INFORMATION 02>Interview Information 03>date of interview 04>head: 05>year:"
	label variable FWOR1299 "01>WORK 02>Employment History 03>previous employer 04>in year prior to interview 05>head, currently working 06>01 january:"
	label variable FWOR1300 "01>WORK 02>Employment History 03>previous employer 04>in year prior to interview 05>head, currently working 06>02 february:"
	label variable FWOR1301 "01>WORK 02>Employment History 03>previous employer 04>in year prior to interview 05>head, currently working 06>03 march:"
	label variable FWOR1302 "01>WORK 02>Employment History 03>previous employer 04>in year prior to interview 05>head, currently working 06>04 april:"
	label variable FWOR1303 "01>WORK 02>Employment History 03>previous employer 04>in year prior to interview 05>head, currently working 06>05 may:"
	label variable FWOR1304 "01>WORK 02>Employment History 03>previous employer 04>in year prior to interview 05>head, currently working 06>06 june:"
	label variable FWOR1305 "01>WORK 02>Employment History 03>previous employer 04>in year prior to interview 05>head, currently working 06>07 july:"
	label variable FWOR1306 "01>WORK 02>Employment History 03>previous employer 04>in year prior to interview 05>head, currently working 06>08 august:"
	label variable FWOR1307 "01>WORK 02>Employment History 03>previous employer 04>in year prior to interview 05>head, currently working 06>09 september:"
	label variable FWOR1308 "01>WORK 02>Employment History 03>previous employer 04>in year prior to interview 05>head, currently working 06>10 october:"
	label variable FWOR1309 "01>WORK 02>Employment History 03>previous employer 04>in year prior to interview 05>head, currently working 06>11 november:"
	label variable FWOR1310 "01>WORK 02>Employment History 03>previous employer 04>in year prior to interview 05>head, currently working 06>12 december:"
	label variable FWOR1311 "01>WORK 02>Employment History 03>previous employer 04>in year prior to interview 05>head, not currently working 06>01 january:"
	label variable FWOR1312 "01>WORK 02>Employment History 03>previous employer 04>in year prior to interview 05>head, not currently working 06>02 february:"
	label variable FWOR1313 "01>WORK 02>Employment History 03>previous employer 04>in year prior to interview 05>head, not currently working 06>03 march:"
	label variable FWOR1314 "01>WORK 02>Employment History 03>previous employer 04>in year prior to interview 05>head, not currently working 06>04 april:"
	label variable FWOR1315 "01>WORK 02>Employment History 03>previous employer 04>in year prior to interview 05>head, not currently working 06>05 may:"
	label variable FWOR1316 "01>WORK 02>Employment History 03>previous employer 04>in year prior to interview 05>head, not currently working 06>06 june:"
	label variable FWOR1317 "01>WORK 02>Employment History 03>previous employer 04>in year prior to interview 05>head, not currently working 06>07 july:"
	label variable FWOR1318 "01>WORK 02>Employment History 03>previous employer 04>in year prior to interview 05>head, not currently working 06>08 august:"
	label variable FWOR1319 "01>WORK 02>Employment History 03>previous employer 04>in year prior to interview 05>head, not currently working 06>09 september:"
	label variable FWOR1320 "01>WORK 02>Employment History 03>previous employer 04>in year prior to interview 05>head, not currently working 06>10 october:"
	label variable FWOR1321 "01>WORK 02>Employment History 03>previous employer 04>in year prior to interview 05>head, not currently working 06>11 november:"
	label variable FWOR1322 "01>WORK 02>Employment History 03>previous employer 04>in year prior to interview 05>head, not currently working 06>12 december:"
	label variable FWOR585 "01>WORK 02>Employment History 03>previous job 04>comparison with present 05>head, whether present job better:"
	label variable FWOR1347 "01>WORK 02>Employment History 03>previous job 04>comparison with present 05>head, whether present job better: 06>reason:"
	label variable FWOR591 "01>WORK 02>Employment History 03>previous job 04>reason no longer has last job 05>head, currently working:"
	label variable FWOR592 "01>WORK 02>Employment History 03>previous job 04>reason no longer has last job 05>head, not currently working:"
	label variable HeadYrsWorkedSince18 "01>WORK 02>Employment History 03>years worked since 18 04>head:"
	label variable WifeYearsWorkedSince18 "01>WORK 02>Employment History 03>years worked since 18 04>spouse:"
	label variable FWOR1357 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>activities to find job 05>head 06>not working now:"
	label variable FWOR1358 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>activities to find job 05>head 06>out of labor force only:"
	label variable FWOR1359 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>activities to find job 05>head 06>unemployed and looking for work only:"
	label variable FWOR2222 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>activities to find job 05>type of activities 06>employer, other 07>head:"
	label variable FWOR2224 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>activities to find job 05>type of activities 06>employer, previous 07>head:"
	label variable FWOR2226 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>activities to find job 05>type of activities 06>employment agency, private 07>head:"
	label variable FWOR2228 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>activities to find job 05>type of activities 06>employment agency, public 07>head:"
	label variable FWOR2230 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>activities to find job 05>type of activities 06>friends or relatives 07>head:"
	label variable FWOR1362 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>activities to find job 05>type of activities 06>head, employed:"
	label variable FWOR1363 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>activities to find job 05>type of activities 06>head, out of labor force:"
	label variable FWOR1364 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>activities to find job 05>type of activities 06>head, unemployed and looking for work:"
	label variable FWOR2232 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>activities to find job 05>type of activities 06>head: 07>1st mention:"
	label variable FWOR2233 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>activities to find job 05>type of activities 06>head: 07>2nd mention:"
	label variable FWOR2234 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>activities to find job 05>type of activities 06>head: 07>3rd mention:"
	label variable FWOR2235 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>activities to find job 05>type of activities 06>none 07>head:"
	label variable FWOR2237 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>activities to find job 05>type of activities 06>other 07>head:"
	label variable FWOR2239 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>activities to find job 05>type of activities 06>placed/answered ads 07>head:"
	label variable FWOR1369 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>length of time looking for work 05>months 06>head:"
	label variable FWOR1371 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>length of time looking for work 05>weeks 06>head:"
	label variable FWOR2244 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>length of time looking for work 05>weeks 06>total weeks 07>head:"
	label variable FWOR1373 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>length of time looking for work 05>years 06>head:"
	label variable FWOR621 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>number of places applied 05>head, if not working:"
	label variable FWOR622 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>number of places applied 05>head, if out of labor force only:"
	label variable FWOR1375 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>thinking of seeking new job 05>actively looking 06>head:"
	label variable FWOR1377 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>thinking of seeking new job 05>head 06>out of labor force:"
	label variable FWOR1378 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>thinking of seeking new job 05>head 06>working now:"
	label variable FWOR2246 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>thinking of seeking new job 05>type of activities 06>employer, current 07>head:"
	label variable FWOR2248 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>thinking of seeking new job 05>type of activities 06>employer, other 07>head:"
	label variable FWOR2250 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>thinking of seeking new job 05>type of activities 06>employment agency, private 07>head:"
	label variable FWOR2252 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>thinking of seeking new job 05>type of activities 06>employment agency, public 07>head:"
	label variable FWOR2254 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>thinking of seeking new job 05>type of activities 06>friend or relative 07>head:"
	label variable FWOR2256 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>thinking of seeking new job 05>type of activities 06>head: 07>1st mention:"
	label variable FWOR2257 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>thinking of seeking new job 05>type of activities 06>head: 07>2nd mention:"
	label variable FWOR2258 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>thinking of seeking new job 05>type of activities 06>head: 07>3rd mention:"
	label variable FWOR2259 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>thinking of seeking new job 05>type of activities 06>none 07>head:"
	label variable FWOR2261 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>thinking of seeking new job 05>type of activities 06>other 07>head:"
	label variable FWOR2263 "01>WORK 02>Employment Search and Possibilities 03>future employment 04>thinking of seeking new job 05>type of activities 06>placed/answered ads 07>head:"
	label variable FWOR631 "01>WORK 02>Employment Search and Possibilities 03>perceived job market conditions 04>undesirable jobs available 05>if looking for work, whether:"
	label variable FWOR1379 "01>WORK 02>Employment Search and Possibilities 03>perceived job market conditions 04>undesirable jobs available 05>if looking for work, whether: 06>wage rate:"
	label variable FWOR1380 "01>WORK 02>Employment Search and Possibilities 03>perceived job market conditions 04>undesirable jobs available 05>out of labor force, whether: 06>wage rate:"
	label variable FWOR1389 "01>WORK 02>Employment Search and Possibilities 03>search limitations 04>job location limitations 05>moving for job 06>good job, whether would move to get:"
	label variable FWOR1391 "01>WORK 02>Employment Search and Possibilities 03>search limitations 04>job location limitations 05>moving for job 06>more money, whether would move for:"
	label variable FWOR2270 "01>WORK 02>Employment Search and Possibilities 03>search limitations 04>job location limitations 05>moving for job 06>more money, whether would move for: 07>wage rate necessary for move if employed:"
	label variable FWOR2271 "01>WORK 02>Employment Search and Possibilities 03>search limitations 04>job location limitations 05>moving for job 06>more money, whether would move for: 07>wage rate necessary for move if unemployed and looking for work:"
	label variable FWOR2272 "01>WORK 02>Employment Search and Possibilities 03>search limitations 04>job location limitations 05>moving for job 06>moved for job, whether 07>head:"
	label variable FWOR1392 "01>WORK 02>Employment Search and Possibilities 03>search limitations 04>job location limitations 05>moving for job 06>reason wouldn't move if employed:"
	label variable FWOR1393 "01>WORK 02>Employment Search and Possibilities 03>search limitations 04>job location limitations 05>moving for job 06>reason wouldn't move if unemployed and looking for work:"
	label variable FWOR2276 "01>WORK 02>Employment Search and Possibilities 03>search limitations 04>job location limitations 05>moving for job 06>refused to move for job, whether ever 07>head:"
	label variable FWOR1567 "01>WORK 02>Employment Status 03>changes in employment status 04>going to work, whether thinking of 05>when might get a job 06>head, if didn't work last year:"
	label variable FWOR368 "01>WORK 02>Employment Status 03>employed now, whether 04>spouse:"
	label variable HeadEverWorked "01>WORK 02>Employment Status 03>ever employed, whether 04>head:"
	label variable WifeEverWorked "01>WORK 02>Employment Status 03>ever employed, whether 04>spouse:"
	label variable HeadEmpStat "01>WORK 02>Employment Status 03>head:"
	label variable FWOR1573 "01>WORK 02>Employment Status 03>last employer 04>monthly dating of 05>head 06>01 january:"
	label variable FWOR1574 "01>WORK 02>Employment Status 03>last employer 04>monthly dating of 05>head 06>02 february:"
	label variable FWOR1575 "01>WORK 02>Employment Status 03>last employer 04>monthly dating of 05>head 06>03 march:"
	label variable FWOR1576 "01>WORK 02>Employment Status 03>last employer 04>monthly dating of 05>head 06>04 april:"
	label variable FWOR1577 "01>WORK 02>Employment Status 03>last employer 04>monthly dating of 05>head 06>05 may:"
	label variable FWOR1578 "01>WORK 02>Employment Status 03>last employer 04>monthly dating of 05>head 06>06 june:"
	label variable FWOR1579 "01>WORK 02>Employment Status 03>last employer 04>monthly dating of 05>head 06>07 july:"
	label variable FWOR1580 "01>WORK 02>Employment Status 03>last employer 04>monthly dating of 05>head 06>08 august:"
	label variable FWOR1581 "01>WORK 02>Employment Status 03>last employer 04>monthly dating of 05>head 06>09 september:"
	label variable FWOR1582 "01>WORK 02>Employment Status 03>last employer 04>monthly dating of 05>head 06>10 october:"
	label variable FWOR1583 "01>WORK 02>Employment Status 03>last employer 04>monthly dating of 05>head 06>11 november:"
	label variable FWOR1584 "01>WORK 02>Employment Status 03>last employer 04>monthly dating of 05>head 06>12 december:"
	label variable FWOR1597 "01>WORK 02>Employment Status 03>monthly dating of 04>in year of interview 05>head 06>01 january:"
	label variable FWOR1598 "01>WORK 02>Employment Status 03>monthly dating of 04>in year of interview 05>head 06>02 february:"
	label variable FWOR1599 "01>WORK 02>Employment Status 03>monthly dating of 04>in year of interview 05>head 06>03 march:"
	label variable FWOR1600 "01>WORK 02>Employment Status 03>monthly dating of 04>in year of interview 05>head 06>04 april:"
	label variable FWOR1601 "01>WORK 02>Employment Status 03>monthly dating of 04>in year of interview 05>head 06>05 may:"
	label variable FWOR1602 "01>WORK 02>Employment Status 03>monthly dating of 04>in year of interview 05>head 06>06 june:"
	label variable FWOR1603 "01>WORK 02>Employment Status 03>monthly dating of 04>in year of interview 05>head 06>07 july:"
	label variable FWOR1604 "01>WORK 02>Employment Status 03>monthly dating of 04>in year of interview 05>head 06>08 august:"
	label variable FWOR1605 "01>WORK 02>Employment Status 03>monthly dating of 04>in year of interview 05>head 06>09 september:"
	label variable FWOR1606 "01>WORK 02>Employment Status 03>monthly dating of 04>in year of interview 05>head 06>10 october:"
	label variable FWOR1619 "01>WORK 02>Employment Status 03>monthly dating of 04>with present employer 05>head 06>01 january:"
	label variable FWOR1620 "01>WORK 02>Employment Status 03>monthly dating of 04>with present employer 05>head 06>02 february:"
	label variable FWOR1621 "01>WORK 02>Employment Status 03>monthly dating of 04>with present employer 05>head 06>03 march:"
	label variable FWOR1622 "01>WORK 02>Employment Status 03>monthly dating of 04>with present employer 05>head 06>04 april:"
	label variable FWOR1623 "01>WORK 02>Employment Status 03>monthly dating of 04>with present employer 05>head 06>05 may:"
	label variable FWOR1624 "01>WORK 02>Employment Status 03>monthly dating of 04>with present employer 05>head 06>06 june:"
	label variable FWOR1625 "01>WORK 02>Employment Status 03>monthly dating of 04>with present employer 05>head 06>07 july:"
	label variable FWOR1626 "01>WORK 02>Employment Status 03>monthly dating of 04>with present employer 05>head 06>08 august:"
	label variable FWOR1627 "01>WORK 02>Employment Status 03>monthly dating of 04>with present employer 05>head 06>09 september:"
	label variable FWOR1628 "01>WORK 02>Employment Status 03>monthly dating of 04>with present employer 05>head 06>10 october:"
	label variable FWOR1629 "01>WORK 02>Employment Status 03>monthly dating of 04>with present employer 05>head 06>11 november:"
	label variable FWOR1630 "01>WORK 02>Employment Status 03>monthly dating of 04>with present employer 05>head 06>12 december:"
	label variable WifeEmpStat "01>WORK 02>Employment Status 03>spouse:"
	label variable FWOR748 "01>WORK 02>Hourly Earnings 03>after job change 04>higher wage in present job, whether 05>head:"
	label variable FWOR398 "01>WORK 02>Hourly Earnings 03>average (annual labor income divided by annual work hours) 04>head:"
	label variable FWOR399 "01>WORK 02>Hourly Earnings 03>average (annual labor income divided by annual work hours) 04>spouse:"
	label variable FWOR780 "01>WORK 02>Hourly Earnings 03>main job, current 04>rate when began current position 05>head:"
	label variable FWOR782 "01>WORK 02>Hourly Earnings 03>main job, current 04>rate when began with current employer 05>head:"
	label variable FWOR784 "01>WORK 02>Hourly Earnings 03>main job, current 04>salary, current 05>head:"
	label variable FWOR805 "01>WORK 02>Hourly Earnings 03>previous job 04>pay when began with previous employer 05>head, currently working:"
	label variable FWOR806 "01>WORK 02>Hourly Earnings 03>previous job 04>pay when began with previous employer 05>head, not currently working:"
	label variable FWOR809 "01>WORK 02>Hourly Earnings 03>previous job 04>pay when left previous employer 05>head, currently working:"
	label variable FWOR810 "01>WORK 02>Hourly Earnings 03>previous job 04>pay when left previous employer 05>head, not currently working:"
	label variable FWOR813 "01>WORK 02>Hourly Earnings 03>previous job 04>rate when began last position 05>head, if currently working:"
	label variable FWOR814 "01>WORK 02>Hourly Earnings 03>previous job 04>rate when began last position 05>head, if not currently working:"
	label variable FWOR821 "01>WORK 02>Hourly Earnings 03>previous job 04>rate when began with previous employer 05>head, currently working:"
	label variable FWOR822 "01>WORK 02>Hourly Earnings 03>previous job 04>rate when began with previous employer 05>head, not currently working:"
	label variable FWOR825 "01>WORK 02>Hourly Earnings 03>previous job 04>rate when left last position 05>head, currently working:"
	label variable FWOR826 "01>WORK 02>Hourly Earnings 03>previous job 04>rate when left last position 05>head, not currently working:"
	label variable FWOR831 "01>WORK 02>Hourly Earnings 03>previous job 04>rate when left previous employer 05>head, currently working:"
	label variable FWOR832 "01>WORK 02>Hourly Earnings 03>previous job 04>rate when left previous employer 05>head, not currently working:"
	label variable FWOR2349 "01>WORK 02>Hours and Weeks 03>additional jobs 04>hours per week 05>previous year 06>head, currently working 07>1st mention:"
	label variable FWOR2373 "01>WORK 02>Hours and Weeks 03>additional jobs 04>weeks per year 05>previous year 06>head, currently working 07>1st mention:"
	label variable FWOR876 "01>WORK 02>Hours and Weeks 03>annual in prior year 04>head 05>total:"
	label variable FWOR884 "01>WORK 02>Hours and Weeks 03>annual in prior year 04>spouse 05>total:"
	label variable FWOR1755 "01>WORK 02>Hours and Weeks 03>main job 04>previous year 05>hours per week 06>head, currently working:"
	label variable FWOR1756 "01>WORK 02>Hours and Weeks 03>main job 04>previous year 05>hours per week 06>head, not currently working:"
	label variable FWOR1757 "01>WORK 02>Hours and Weeks 03>main job 04>previous year 05>hours per week 06>head, out of labor force only:"
	label variable FWOR1761 "01>WORK 02>Hours and Weeks 03>main job 04>previous year 05>overtime, whether additional 06>head, currently working:"
	label variable FWOR1762 "01>WORK 02>Hours and Weeks 03>main job 04>previous year 05>overtime, whether additional 06>head, not currently working:"
	label variable FWOR1763 "01>WORK 02>Hours and Weeks 03>main job 04>previous year 05>overtime, whether additional 06>head, whether worked:"
	label variable FWOR1767 "01>WORK 02>Hours and Weeks 03>main job 04>previous year 05>weeks per year 06>head, currently working:"
	label variable FWOR1768 "01>WORK 02>Hours and Weeks 03>main job 04>previous year 05>weeks per year 06>head, not currently working:"
	label variable FWOR1769 "01>WORK 02>Hours and Weeks 03>main job 04>previous year 05>weeks per year 06>head, out of labor force only:"
	label variable FWOR974 "01>WORK 02>Industry 03>present main job 04>3-digit 1970 census code 05>head:"
	label variable FWOR976 "01>WORK 02>Industry 03>present main job 04>3-digit 1970 census code, retrospective 05>head:"
	label variable FWOR980 "01>WORK 02>Industry 03>present or last main job 04>3-digit 2000 census code 05>head:"
	label variable FWOR436 "01>WORK 02>Occupation 03>change in types of jobs/occupations, whether 04>head:"
	label variable FWOR438 "01>WORK 02>Occupation 03>job sought 04>head, if employed:"
	label variable FWOR439 "01>WORK 02>Occupation 03>job sought 04>head, if out of labor force:"
	label variable FWOR440 "01>WORK 02>Occupation 03>job sought 04>head, if unemployed and looking for work:"
	label variable FWOR1839 "01>WORK 02>Occupation 03>monthly dating of changes in employer or position 04>in year of interview 05>head 06>02 february:"
	label variable FWOR1840 "01>WORK 02>Occupation 03>monthly dating of changes in employer or position 04>in year of interview 05>head 06>03 march:"
	label variable FWOR1841 "01>WORK 02>Occupation 03>monthly dating of changes in employer or position 04>in year of interview 05>head 06>04 april:"
	label variable FWOR1842 "01>WORK 02>Occupation 03>monthly dating of changes in employer or position 04>in year of interview 05>head 06>05 may:"
	label variable FWOR1843 "01>WORK 02>Occupation 03>monthly dating of changes in employer or position 04>in year of interview 05>head 06>06 june:"
	label variable FWOR1844 "01>WORK 02>Occupation 03>monthly dating of changes in employer or position 04>in year of interview 05>head 06>07 july:"
	label variable FWOR1845 "01>WORK 02>Occupation 03>monthly dating of changes in employer or position 04>in year of interview 05>head 06>08 august:"
	label variable FWOR1846 "01>WORK 02>Occupation 03>monthly dating of changes in employer or position 04>in year of interview 05>head 06>09 september:"
	label variable FWOR1847 "01>WORK 02>Occupation 03>monthly dating of changes in employer or position 04>in year of interview 05>head 06>10 october:"
	label variable FWOR1860 "01>WORK 02>Occupation 03>monthly dating of changes in employer or position 04>in year prior to interview 05>head 06>01 january:"
	label variable FWOR1861 "01>WORK 02>Occupation 03>monthly dating of changes in employer or position 04>in year prior to interview 05>head 06>02 february:"
	label variable FWOR1862 "01>WORK 02>Occupation 03>monthly dating of changes in employer or position 04>in year prior to interview 05>head 06>03 march:"
	label variable FWOR1863 "01>WORK 02>Occupation 03>monthly dating of changes in employer or position 04>in year prior to interview 05>head 06>04 april:"
	label variable FWOR1864 "01>WORK 02>Occupation 03>monthly dating of changes in employer or position 04>in year prior to interview 05>head 06>05 may:"
	label variable FWOR1865 "01>WORK 02>Occupation 03>monthly dating of changes in employer or position 04>in year prior to interview 05>head 06>06 june:"
	label variable FWOR1866 "01>WORK 02>Occupation 03>monthly dating of changes in employer or position 04>in year prior to interview 05>head 06>07 july:"
	label variable FWOR1867 "01>WORK 02>Occupation 03>monthly dating of changes in employer or position 04>in year prior to interview 05>head 06>08 august:"
	label variable FWOR1868 "01>WORK 02>Occupation 03>monthly dating of changes in employer or position 04>in year prior to interview 05>head 06>09 september:"
	label variable FWOR1869 "01>WORK 02>Occupation 03>monthly dating of changes in employer or position 04>in year prior to interview 05>head 06>10 october:"
	label variable FWOR1870 "01>WORK 02>Occupation 03>monthly dating of changes in employer or position 04>in year prior to interview 05>head 06>11 november:"
	label variable FWOR1871 "01>WORK 02>Occupation 03>monthly dating of changes in employer or position 04>in year prior to interview 05>head 06>12 december:"
	label variable FWOR1034 "01>WORK 02>Occupation 03>present main job 04>3-digit 1970 census code 05>head:"
	label variable FWOR1036 "01>WORK 02>Occupation 03>present main job 04>3-digit 1970 census code, retrospective 05>head:"
	label variable FWOR445 "01>WORK 02>Occupation 03>present main job 04>head:"
	label variable FWOR447 "01>WORK 02>Occupation 03>present or last main job, 3-digit 2000 census code 04>head:"
	label variable FWOR1058 "01>WORK 02>Skills and Training 03>future job 04>training required, whether 05>head, if employed:"
	label variable FWOR1059 "01>WORK 02>Skills and Training 03>future job 04>training required, whether 05>head, if out of labor force:"
	label variable FWOR1060 "01>WORK 02>Skills and Training 03>future job 04>training required, whether 05>head, if unemployed and looking for work:"
	label variable FWOR1924 "01>WORK 02>Tenure 03>last year's positions 04>changed positions 05>began with current employer before prior calendar year 06>head:"
	label variable FWOR1926 "01>WORK 02>Tenure 03>last year's positions 04>changed positions 05>began with current employer in current year 06>head:"
	label variable FWOR1928 "01>WORK 02>Tenure 03>last year's positions 04>changed positions 05>began with most recent employer before prior calendar year 06>head:"
	label variable FWOR1930 "01>WORK 02>Tenure 03>last year's positions 04>changed positions 05>began with most recent employer in prior calendar year 06>head:"
	label variable FWOR2444 "01>WORK 02>Tenure 03>last year's positions 04>changed positions 05>with previous employer 06>head 07>currently working:"
	label variable FWOR2445 "01>WORK 02>Tenure 03>last year's positions 04>changed positions 05>with previous employer 06>head 07>not currently working:"
	label variable FWOR1932 "01>WORK 02>Tenure 03>last year's positions 04>month changed 05>began with current employer before prior calendar year 06>head:"
	label variable FWOR1934 "01>WORK 02>Tenure 03>last year's positions 04>month changed 05>began with current employer in prior calendar year 06>head:"
	label variable FWOR1936 "01>WORK 02>Tenure 03>last year's positions 04>month changed 05>began with most recent employer before prior calendar year 06>head:"
	label variable FWOR1938 "01>WORK 02>Tenure 03>last year's positions 04>month changed 05>began with most recent employer in prior calendar year 06>head:"
	label variable FWOR1940 "01>WORK 02>Tenure 03>last year's positions 04>month changed 05>with previous employer 06>head, currently working:"
	label variable FWOR1941 "01>WORK 02>Tenure 03>last year's positions 04>month changed 05>with previous employer 06>head, not currently working:"
	label variable FWOR1944 "01>WORK 02>Tenure 03>last year's positions 04>type of change 05>began with current employer before prior calendar year 06>head:"
	label variable FWOR1946 "01>WORK 02>Tenure 03>last year's positions 04>type of change 05>began with current employer in prior calendar year 06>head:"
	label variable FWOR1948 "01>WORK 02>Tenure 03>last year's positions 04>type of change 05>began with most recent employer before prior calendar year 06>head:"
	label variable FWOR1950 "01>WORK 02>Tenure 03>last year's positions 04>type of change 05>began with most recent employer in prior calendar year 06>head:"
	label variable FWOR2448 "01>WORK 02>Tenure 03>last year's positions 04>type of change 05>with previous employer 06>head 07>currently working:"
	label variable FWOR2449 "01>WORK 02>Tenure 03>last year's positions 04>type of change 05>with previous employer 06>head 07>not currently working:"
	label variable FWOR1093 "01>WORK 02>Tenure 03>most recent employer if not working now 04>beginning month 05>head:"
	label variable FWOR1095 "01>WORK 02>Tenure 03>most recent employer if not working now 04>beginning year 05>head:"
	label variable FWOR1097 "01>WORK 02>Tenure 03>next-to-last position 04>beginning month 05>head:"
	label variable FWOR1099 "01>WORK 02>Tenure 03>next-to-last position 04>beginning year 05>head:"
	label variable FWOR1101 "01>WORK 02>Tenure 03>next-to-last position 04>ending year 05>head:"
	label variable HeadBegMoPresentEmp "01>WORK 02>Tenure 03>present employment 04>beginning month 05>head:"
	label variable WifeBegMoPresentEmp "01>WORK 02>Tenure 03>present employment 04>beginning month 05>spouse:"
	label variable HeadBegYrPresentEmp "01>WORK 02>Tenure 03>present employment 04>beginning year 05>head:"
	label variable WifeBegYrPresentEmp "01>WORK 02>Tenure 03>present employment 04>beginning year 05>spouse:"
	label variable HeadMosPresentEmp94On "01>WORK 02>Tenure 03>present employment 04>months 05>head:"
	label variable WifeMosPresentEmp94On "01>WORK 02>Tenure 03>present employment 04>months 05>spouse:"
	label variable HeadMosPresentEmp94Prior "01>WORK 02>Tenure 03>present employment 04>total number of months 05>head:"
	label variable WifeMosPresentEmp94Prior "01>WORK 02>Tenure 03>present employment 04>total number of months 05>spouse:"
	label variable FWOR1114 "01>WORK 02>Tenure 03>present employment 04>weeks 05>head:"
	label variable HeadYearsPresentEmp "01>WORK 02>Tenure 03>present employment 04>years 05>head:"
	label variable WifeYearsPresentEmp "01>WORK 02>Tenure 03>present employment 04>years 05>spouse:"
	label variable HeadYearsPresentJobBkted "01>WORK 02>Tenure 03>present job 04>years: 05>bracketed number:"
	label variable HeadSamePosPresentEmp "01>WORK 02>Tenure 03>present position 04>began present position when began with present employer, whether 05>head:"
	label variable WifeSamePosPresentEmp "01>WORK 02>Tenure 03>present position 04>began present position when began with present employer, whether 05>spouse:"
	label variable FWOR1952 "01>WORK 02>Tenure 03>present position 04>beginning month 05>began with employer before prior calendar year 06>head:"
	label variable FWOR1954 "01>WORK 02>Tenure 03>present position 04>beginning month 05>began with employer in current year 06>head:"
	label variable FWOR1956 "01>WORK 02>Tenure 03>present position 04>beginning month 05>began with employer in prior calendar year 06>head:"
	label variable FWOR1958 "01>WORK 02>Tenure 03>present position 04>beginning year 05>began with employer before prior calendar year 06>head:"
	label variable FWOR1960 "01>WORK 02>Tenure 03>present position 04>beginning year 05>began with employer in current year 06>head:"
	label variable FWOR1962 "01>WORK 02>Tenure 03>present position 04>beginning year 05>began with employer in prior calendar year 06>head:"
	label variable HeadPermPresentPos "01>WORK 02>Tenure 03>present position 04>permanence of current position when began 05>head:"
	label variable WifePermPresentPos "01>WORK 02>Tenure 03>present position 04>permanence of current position when began 05>spouse:"
	label variable HeadMosPresentPos "01>WORK 02>Tenure 03>present position 04>total number of months 05>head:"
	label variable WifeMosPresentPos "01>WORK 02>Tenure 03>present position 04>total number of months 05>spouse:"
	label variable FWOR1964 "01>WORK 02>Tenure 03>previous employers 04>beginning month 05>head 06>currently working:"
	label variable FWOR1965 "01>WORK 02>Tenure 03>previous employers 04>beginning month 05>head 06>not currently working:"
	label variable FWOR1968 "01>WORK 02>Tenure 03>previous employers 04>beginning year 05>head 06>currently working:"
	label variable FWOR1969 "01>WORK 02>Tenure 03>previous employers 04>beginning year 05>head 06>not currently working:"
	label variable FWOR1972 "01>WORK 02>Tenure 03>previous employers 04>ending month 05>head 06>currently working:"
	label variable FWOR1973 "01>WORK 02>Tenure 03>previous employers 04>ending month 05>head 06>not currently working:"
	label variable FWOR1976 "01>WORK 02>Tenure 03>previous employers 04>ending year 05>head 06>currently working:"
	label variable FWOR1980 "01>WORK 02>Tenure 03>previous employers 04>other employers, whether 05>head 06>currently working:"
	label variable FWOR1981 "01>WORK 02>Tenure 03>previous employers 04>other employers, whether 05>head 06>not currently working:"
	label variable FWOR1984 "01>WORK 02>Tenure 03>previous employers 04>still working for, whether 05>head 06>currently working:"
	label variable FWOR1985 "01>WORK 02>Tenure 03>previous employers 04>still working for, whether 05>head 06>not currently working:"
	label variable HeadNewPosNewEmp "01>WORK 02>Tenure 03>previous positions 04>began last position when began with most recent employer, whether 05>head:"
	label variable WifeNewPosNewEmp "01>WORK 02>Tenure 03>previous positions 04>began last position when began with most recent employer, whether 05>spouse:"
	label variable FWOR1988 "01>WORK 02>Tenure 03>previous positions 04>beginning month 05>began with most recent employer before prior calendar year 06>head:"
	label variable FWOR1990 "01>WORK 02>Tenure 03>previous positions 04>beginning month 05>began with most recent employer in current year 06>head:"
	label variable FWOR1992 "01>WORK 02>Tenure 03>previous positions 04>beginning month 05>began with most recent employer in prior calendar year 06>head:"
	label variable FWOR1994 "01>WORK 02>Tenure 03>previous positions 04>beginning month 05>ended with most recent employer since january 1 of prior calendar year 06>head:"
	label variable FWOR1996 "01>WORK 02>Tenure 03>previous positions 04>beginning year 05>began with most recent employer before prior calendar year 06>head:"
	label variable FWOR1998 "01>WORK 02>Tenure 03>previous positions 04>beginning year 05>began with most recent employer in current year 06>head:"
	label variable FWOR2000 "01>WORK 02>Tenure 03>previous positions 04>beginning year 05>began with most recent employer in prior calendar year 06>head:"
	label variable FWOR2002 "01>WORK 02>Tenure 03>previous positions 04>beginning year 05>ended with most recent employer since january 1 of prior calendar year 06>head:"
	label variable FWOR2004 "01>WORK 02>Tenure 03>previous positions 04>ending month 05>if currently employed 06>head:"
	label variable FWOR2010 "01>WORK 02>Tenure 03>previous positions 04>ending month 05>most recent job 06>head:"
	label variable FWOR2452 "01>WORK 02>Tenure 03>previous positions 04>ending month 05>most recent job 06>if last worked before questionnaire period 07>head:"
	label variable FWOR2012 "01>WORK 02>Tenure 03>previous positions 04>ending month 05>next-to-last position 06>head:"
	label variable FWOR2014 "01>WORK 02>Tenure 03>previous positions 04>ending month 05>not employed 06>head:"
	label variable FWOR2016 "01>WORK 02>Tenure 03>previous positions 04>ending year 05>currently employed 06>head:"
	label variable FWOR2022 "01>WORK 02>Tenure 03>previous positions 04>ending year 05>most recent job 06>head:"
	label variable FWOR2454 "01>WORK 02>Tenure 03>previous positions 04>ending year 05>most recent job 06>if last worked before questionnaire period 07>head:"
	label variable FWOR2024 "01>WORK 02>Tenure 03>previous positions 04>ending year 05>not employed 06>head:"
	label variable HeadBegMoPresEmp "01>WORK 02>Tenure 03>when began with present or last employer 04>month 05>head:"
	label variable WifeBegMoPresEmp "01>WORK 02>Tenure 03>when began with present or last employer 04>month 05>spouse:"
	label variable HeadBegYrPresEmp "01>WORK 02>Tenure 03>when began with present or last employer 04>year 05>head:"
	label variable WifeBegYrPresEmp "01>WORK 02>Tenure 03>when began with present or last employer 04>year 05>spouse:"
	label variable FWOR2042 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>labor force, time out of 04>T-2, whether: 05>head: 06>number of weeks:"
	label variable FWOR1133 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>out of labor force 04>hours, annual 05>head:"
	label variable FWOR1135 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>out of labor force 04>in current year, whether 05>head, currently working:"
	label variable FWOR1136 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>out of labor force 04>in current year, whether 05>head, not currently working:"
	label variable FWOR2058 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>out of labor force 04>in current year, whether 05>number of weeks 06>head, currently working:"
	label variable FWOR2059 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>out of labor force 04>in current year, whether 05>number of weeks 06>head, not currently working:"
	label variable FWOR1139 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>out of labor force 04>in previous year, whether 05>head, currently working:"
	label variable FWOR1140 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>out of labor force 04>in previous year, whether 05>head, not currently working:"
	label variable FWOR1141 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>out of labor force 04>in previous year, whether 05>head:"
	label variable FWOR2062 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>out of labor force 04>in previous year, whether 05>number of weeks 06>head, currently working:"
	label variable FWOR2063 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>out of labor force 04>in previous year, whether 05>number of weeks 06>head, imputed:"
	label variable FWOR2064 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>out of labor force 04>in previous year, whether 05>number of weeks 06>head, not currently working:"
	label variable FWOR2068 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>out of labor force 04>in previous year, whether 05>reported number of days 06>head, currently working:"
	label variable FWOR2069 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>out of labor force 04>in previous year, whether 05>reported number of days 06>head, not currently working:"
	label variable FWOR2070 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>out of labor force 04>in previous year, whether 05>reported number of days 06>head:"
	label variable FWOR2074 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>out of labor force 04>in previous year, whether 05>reported number of months 06>head, currently working:"
	label variable FWOR2075 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>out of labor force 04>in previous year, whether 05>reported number of months 06>head, not currently working:"
	label variable FWOR2076 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>out of labor force 04>in previous year, whether 05>reported number of months 06>head:"
	label variable FWOR2080 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>out of labor force 04>in previous year, whether 05>reported number of weeks 06>head, currently working:"
	label variable FWOR2081 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>out of labor force 04>in previous year, whether 05>reported number of weeks 06>head, not currently working:"
	label variable FWOR2082 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>out of labor force 04>in previous year, whether 05>reported number of weeks 06>head:"
	label variable FWOR2086 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>hours of work lost annually 05>strikes and unemployment (combined) 06>head:"
	label variable FWOR2088 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>hours of work lost annually 05>unemployment only 06>head:"
	label variable FWOR2135 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>weeks of work lost annually 05>layoff only in previous year, whether 06>head:"
	label variable FWOR2137 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>weeks of work lost annually 05>strikes and unemployment (combined), whether 06>head:"
	label variable FWOR2515 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>weeks of work lost annually 05>strikes and unemployment (combined), whether 06>number of weeks lost 07>head, currently working:"
	label variable FWOR2516 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>weeks of work lost annually 05>strikes and unemployment (combined), whether 06>number of weeks lost 07>head, not currently working:"
	label variable FWOR2138 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>weeks of work lost annually 05>strikes and unemployment (combined), whether 06>spouse:"
	label variable FWOR148 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>weeks of work lost annually 05>unemployment and layoff only 06>in current year, whether 07>number of weeks lost 08>head, if last worked before prior calendar year:"
	label variable FWOR149 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>weeks of work lost annually 05>unemployment and layoff only 06>in current year, whether 07>number of weeks lost 08>head, if not working now but has since prior calendar year:"
	label variable FWOR150 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>weeks of work lost annually 05>unemployment and layoff only 06>in current year, whether 07>number of weeks lost 08>head, if working:"
	label variable FWOR2524 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>weeks of work lost annually 05>unemployment and layoff only 06>in previous year, whether 07>head, last worked before prior calendar year:"
	label variable FWOR154 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>weeks of work lost annually 05>unemployment and layoff only 06>in previous year, whether 07>number of weeks 08>head, currently working:"
	label variable FWOR155 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>weeks of work lost annually 05>unemployment and layoff only 06>in previous year, whether 07>number of weeks 08>head, last worked before prior calendar year:"
	label variable FWOR156 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>weeks of work lost annually 05>unemployment and layoff only 06>in previous year, whether 07>number of weeks 08>head, not currently working but worked since prior calendar year:"
	label variable FWOR282 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>weeks of work lost annually 05>unemployment and layoff only 06>in previous year, whether 07>number of weeks 08>temporary layoff only, imputed 09>head:"
	label variable FWOR286 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>weeks of work lost annually 05>unemployment and layoff only 06>in previous year, whether 07>number of weeks 08>unemployment only, imputed 09>head:"
	label variable FWOR171 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>weeks of work lost annually 05>unemployment and layoff only 06>t-2 whether: 07>head: 08>number of weeks:"
	label variable FWOR2139 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>weeks of work lost annually 05>unemployment only in previous year, whether 06>head:"
	label variable FWOR2141 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>weeks of work lost annually 05>weeks missed in one or in more time periods 06>head, currently employed:"
	label variable FWOR2142 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>weeks of work lost annually 05>weeks missed in one or in more time periods 06>head, unemployed and looking for work:"
	label variable FWOR2533 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>work lost annually 05>unemployment and layoff only 06>in previous year, whether 07>head, if working:"
	label variable FWOR2534 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>work lost annually 05>unemployment and layoff only 06>in previous year, whether 07>head, not currently working but worked since prior calendar year:"
	label variable FWOR192 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>work lost annually 05>unemployment and layoff only 06>in previous year, whether 07>reported number of days 08>head, currently working:"
	label variable FWOR193 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>work lost annually 05>unemployment and layoff only 06>in previous year, whether 07>reported number of days 08>head, not currently working but worked since prior calendar year:"
	label variable FWOR196 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>work lost annually 05>unemployment and layoff only 06>in previous year, whether 07>reported number of months 08>head, currently working:"
	label variable FWOR197 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>work lost annually 05>unemployment and layoff only 06>in previous year, whether 07>reported number of months 08>head, not currently working but worked since prior calendar year:"
	label variable FWOR200 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>work lost annually 05>unemployment and layoff only 06>in previous year, whether 07>reported number of weeks 08>head, currently working:"
	label variable FWOR201 "01>WORK 02>Unemployment, Layoff, Out of Labor Force 03>unemployment and layoff 04>work lost annually 05>unemployment and layoff only 06>in previous year, whether 07>reported number of weeks 08>head, not currently working but worked since prior calendar year:"
	label variable FWOR330 "01>WORK 02>Employment History 03>1st regular job 04>same employer now, whether:"
	label variable FLOCAN024 "01>LOCATION AND MOBILITY 02>Current 03>region:"
	label variable CurrentState "01>LOCATION AND MOBILITY 02>Current 03>state 04>gsa, modified:"
	label variable ExpOnChildcare "01>EXPENDITURES 02>Child Care 03>amount 04>annual:"
	label variable ExpOnEarnings "01>EXPENDITURES 02>Cost of Earnings:"
	label variable ExpOnNonFamDependents_yn "01>EXPENDITURES 02>Dependents Outside of Family Unit, Whether:"
	label variable ExpOnNonFamDependents "01>EXPENDITURES 02>Dependents Outside of Family Unit, Whether: 03>amount paid in support of:"
	label variable FEXP502 "01>EXPENDITURES 02>Dependents Outside of Family Unit, Whether: 03>amount paid in support of:"
	label variable FEXP505 "01>EXPENDITURES 02>Dependents Outside of Family Unit, Whether: 03>more than half of support, whether contributed by family unit if more"
	label variable FEXP567 "01>EXPENDITURES 02>Dependents Outside of Family Unit, Whether: 03>more than half of support, whether contributed by family unit if more 04>number:"
	label variable FEXP506 "01>EXPENDITURES 02>Dependents Outside of Family Unit, Whether: 03>number:"
	label variable AddlExpOnEducation_yn "01>EXPENDITURES 02>Education 03>additional costs, whether:"
	label variable ExpOnEducation_yn "01>EXPENDITURES 02>Education 03>school, whether:"
	label variable ExpOnEducation "01>EXPENDITURES 02>Education 03>total annual cost, imputed:"
	label variable ExpOnHomeFood "01>EXPENDITURES 02>Food 03>at home 04>used at home 05>annual:"
	label variable ExpOnRestaurantFood "01>EXPENDITURES 02>Food 03>away from home 04>restaurant meals 05>amount spent 06>annually:"
	label variable ExpOnFood "01>EXPENDITURES 02>Food 03>consumption 04>total:"
	label variable HealthcareExpTotal "01>EXPENDITURES 02>Health Care 03>amount for all medical care:"
	label variable HealthcareExpVisits "01>EXPENDITURES 02>Health Care 03>amount for doctor, outpatient surgery, and dental:"
	label variable HealthcareExpPres "01>EXPENDITURES 02>Health Care 03>amount for prescriptions and other services:"
	label variable CostofHousing "01>EXPENDITURES 02>Housing 03>cost:"
	label variable MortgageValue "01>EXPENDITURES 02>Housing 03>home ownership 04>mortgage 05>14th mortgage 06>principal remaining:"
	label variable ExpOnRent "01>EXPENDITURES 02>Housing 03>rent 04>payments, annual:"
	label variable PropertyTaxes "01>EXPENDITURES 02>Taxes 03>property taxes 04>annual amount:"
	label variable VehiclesOwned_yn "01>EXPENDITURES 02>Transportation 03>cars and trucks 04>owned, whether:"
	label variable PublicTransit_yn "01>EXPENDITURES 02>Transportation 03>public, whether:"
	label variable FFINDI167 "01>FINANCIAL DISTRESS 02>Debts, Whether: 03>amount, current:"
	label variable FREL005 "01>RELIGION 02>Preference 03>head:"
	label variable IRAAmt "01>WEALTH 02>Annuity/IRA 03>value:"
	label variable IRA_ACC "01>WEALTH 02>Annuity/IRA 03>value: 04>accuracy code:"
	label variable IRA_yn "01>WEALTH 02>Annuity/IRA 03>whether:"
	label variable Business_yn "01>WEALTH 02>Business or Farm, Whether:"
	label variable FarmBusinessAmtNet "01>WEALTH 02>Business or Farm, Whether: 03>net value, current:"
	label variable CashAmt "01>WEALTH 02>Cash &Checking/Savings 03>cash, including checking/savings accounts, certificates of deposit, etc: 04>including ira's and pension:"
	label variable CashAmtWOIRAs "01>WEALTH 02>Cash &Checking/Savings 03>cash, including checking/savings accounts, certificates of deposit, etc: 04>not including ira's and pension:"
	label variable TotalLiquidAmt "01>WEALTH 02>Cash &Checking/Savings 03>cash, including checking/savings accounts, certificates of deposit, etc: 04>not including ira's and pension: 05>total current amount in all accounts:"
	label variable NumCheckAccts "01>WEALTH 02>Cash &Checking/Savings 03>checking/savings account 04>number of:"
	label variable CheckingAmt "01>WEALTH 02>Cash &Checking/Savings 03>checking/savings account 04>value:"
	label variable TotalLiquidAmt_ACC "01>WEALTH 02>Cash &Checking/Savings 03>checking/savings account 04>value: 05>accuracy code:"
	label variable Checking_yn "01>WEALTH 02>Cash &Checking/Savings 03>checking/savings account 04>whether:"
	label variable FarmBusinessAmt2 "01>WEALTH 02>Farm/Business 03>value:"
	label variable Business_ACC "01>WEALTH 02>Farm/Business 03>value: 04>accuracy code:"
	label variable Business2_yn "01>WEALTH 02>Farm/Business 03>whether:"
	label variable HomeEquityAmt "01>WEALTH 02>Home Equity 03>value:"
	label variable HomeEquity_ACC "01>WEALTH 02>Home Equity 03>value: 04>accuracy code:"
	label variable Inheritance_yn "01>WEALTH 02>Inheritance 03>received, whether:"
	label variable InheritanceAmt "01>WEALTH 02>Inheritance 03>received, whether: 04>value of, 1st:"
	label variable Collectibles_yn "01>WEALTH 02>Other Assets 03>bonds, insurance policies, collectibles, whether:"
	label variable CollectiblesAmt "01>WEALTH 02>Other Assets 03>bonds, insurance policies, collectibles, whether: 04>net value, current:"
	label variable OtherAssetsAmt "01>WEALTH 02>Other Assets 03>value:"
	label variable OtherAssets_ACC "01>WEALTH 02>Other Assets 03>value: 04>accuracy code:"
	label variable OtherAssets_yn "01>WEALTH 02>Other Assets 03>whether:"
	label variable OtherDebtAmt "01>WEALTH 02>Other Debt 03>amount:"
	label variable OtherDebtType "01>WEALTH 02>Other Debt 03>type:"
	label variable OtherDebtImputed "01>WEALTH 02>Other Debt 03>value: 04>imputed:"
	label variable OtherDebt_yn "01>WEALTH 02>Other Debt 03>whether:"
	label variable OtherRealEstateAmt "01>WEALTH 02>Real Estate 03>other 04>value:"
	label variable OtherRealEstate_yn "01>WEALTH 02>Real Estate 03>other 04>whether:"
	label variable OtherHouses_yn "01>WEALTH 02>Real Estate 03>other than main home, whether:"
	label variable Savings_yn "01>WEALTH 02>Savings, Whether:"
	label variable TwoMosSavings "01>WEALTH 02>Savings, Whether: 03>balance 04>currently equal to or greater than two months' income:"
	label variable TwoMosSavingsinFiveYrs "01>WEALTH 02>Savings, Whether: 03>balance 04>equal to or greater than two months' income in last five years:"
	label variable IndexFund_yn "01>WEALTH 02>Savings, Whether: 03>reserve fund position (index):"
	label variable FinancialAssets_yn "01>WEALTH 02>Stocks 03>stocks, mutual funds, etc., whether:"
	label variable StocksAmt "01>WEALTH 02>Stocks 03>value:"
	label variable Stocks_ACC "01>WEALTH 02>Stocks 03>value: 04>accuracy code:"
	label variable Stocks_yn "01>WEALTH 02>Stocks 03>whether:"
	label variable StudentLoansAmt "01>WEALTH 02>Student Loans 03>amount:"
	label variable StudentLoans_ACC "01>WEALTH 02>Student Loans 03>amount: 04>accuracy code:"
	label variable StudentLoans_yn "01>WEALTH 02>Student Loans 03>whether:"
	label variable TotalLiquidWealth "01>WEALTH 02>Total Family Wealth 03>excluding home equity:"
	label variable TotalWealth "01>WEALTH 02>Total Family Wealth 03>including home equity:"
	label variable PositiveWealth "01>WEALTH 02>Total Family Wealth 03>net worth, whether positive or negative:"
	label variable VehicleValueNet "01>WEALTH 02>Vehicles 03>autos, mobile homes, etc. 04>net value, current:"
	label variable VehicleValue "01>WEALTH 02>Vehicles 03>value:"
	label variable VehicleValue_ACC "01>WEALTH 02>Vehicles 03>value: 04>accuracy code:"
