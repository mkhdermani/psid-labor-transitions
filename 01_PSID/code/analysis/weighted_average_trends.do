*===============================================================================
* weighted_average_trends.do
*-------------------------------------------------------------------------------
* Project : PSID_SHELF  (RA work for Sepahsalari)
* Author  : Mohsen Khalili
* Purpose : Compute population-weighted averages (or, for categorical variables,
*           weighted proportions) of PSID variables by survey YEAR, and export a
*           time-series plot for each variable to the graphs folder.
*
* Input   : 01_PSID/data/PSIDSHELF_1968_2019_LONG.dta   (master long panel)
* Weight  : IW  (individual longitudinal weight)
* Output  : 01_PSID/output/graphs/weighted_avg_<VAR>.png
*
* Note    : This single script replaces 26 near-identical per-topic do-files
*           (total_wealth.do, networth.do, education.do, ...). Each former file
*           is preserved below as a clearly labelled section.
*===============================================================================

clear all
set more off

*--- Configure paths in ONE place ---------------------------------------------
global root    "D:/PSID_SHELF/01_PSID"
global data    "${root}/data/PSIDSHELF_1968_2019_LONG.dta"
global graphs  "${root}/output/graphs"

*-------------------------------------------------------------------------------
* Program: wavg_plot
*   For one variable, load the master data, build a population-weighted series
*   by YEAR, plot it over time, and export it as a PNG.
*     - numeric variables      -> weighted mean
*     - categorical variables  -> weighted share of category == 1
*-------------------------------------------------------------------------------
capture program drop wavg_plot
program define wavg_plot
    args var
    quietly use "${data}", clear

    * skip silently if the variable is not in the dataset
    capture confirm variable `var'
    if _rc {
        display as text "  (skipped: `var' not found)"
        exit
    }

    local lbl : variable label `var'
    if "`lbl'" == "" local lbl "`var'"

    capture confirm numeric variable `var'
    if !_rc {
        * ---- numeric: weighted mean ----
        quietly gen double _w = `var' * IW
        quietly collapse (sum) _w IW, by(YEAR)
        quietly gen double weighted_avg_`var' = _w / IW
        twoway line weighted_avg_`var' YEAR if weighted_avg_`var' != 0, ///
            title("`lbl'") ytitle("Weighted average") xtitle("Year") ///
            name(g_`var', replace)
    }
    else {
        * ---- categorical: weighted proportion of category 1 ----
        quietly gen double _w = (`var' == 1) * IW
        quietly collapse (sum) _w IW, by(YEAR)
        quietly gen double weighted_avg_`var' = _w / IW
        twoway line weighted_avg_`var' YEAR, ///
            title("`lbl' (share)") ytitle("Weighted proportion") xtitle("Year") ///
            name(g_`var', replace)
    }
    graph export "${graphs}/weighted_avg_`var'.png", replace
    display as result "  exported weighted_avg_`var'.png"
end

*===============================================================================
* Run every topic. Comment out any block you do not need.
*===============================================================================

* --- Demographics: sex, birth, death, age ---
foreach v in SEX BIRTHYEAR BIRTHMONTH DEATHYEAR AGEREP {
    wavg_plot `v'
}

* --- Race ---
foreach v in RACEMAJ RACEMAJMM RACE RACEX RACERP RACESP RACEMM RACEMMX RACEMMRP ///
             RACEMMSP RACE1MREP RACE2MREP RACE3MREP RACE4MREP {
    wavg_plot `v'
}

* --- Geography (was mislabelled "chilhood.do") ---
foreach v in GEOSTATE GEOSTATECHI GEOREGION GEOREGIONCHI {
    wavg_plot `v'
}

* --- Relationship to reference person ---
foreach v in REL RELX {
    wavg_plot `v'
}

* --- Sample membership & non-response ---
foreach v in SAMPLE SAMPLEP NONRESPONSE NONRESPONSEX {
    wavg_plot `v'
}

* --- Family composition ---
foreach v in FAMSIZE FAMCHILD FAMMARSTAT FAMPARTNERED FAMMARRIED {
    wavg_plot `v'
}

* --- Education ---
foreach v in EDUYEARSP EDUYEARRC EDUYEARMAX EDUYEARMAXRP EDUYEARMAXSP EDUYEARMAXRC ///
             EDULEVEL EDULEVELRP EDULEVELSP EDULEVELRC EDULEVELMAXRP EDULEVELMAXSP ///
             EDULEVELMAXRC EDUCOMP EDUHSGRAD EDUANYCOL EDUDEGREE EDUFINST EDUFDEGREE {
    wavg_plot `v'
}

* --- Family income ---
foreach v in INCFAMN INCFAMR INCFAMFN INCFAMFR {
    wavg_plot `v'
}

* --- Individual earnings (reference person, spouse, combined) ---
foreach v in EARNINDN EARNINDR EARNINDFN EARNINDFR ///
             EARNINDNRP EARNINDRRP EARNINDFNRP EARNINDFRRP ///
             EARNINDNSP EARNINDRSP EARNINDFNSP EARNINDFRSP ///
             EARNINDNRC EARNINDRRC EARNINDFNRC EARNINDFRRC {
    wavg_plot `v'
}

* --- Employment status & currently working ---
foreach v in EMPSTAT1M EMPSTAT2M EMPSTAT3M EMPSTAT1MRP EMPSTAT1MSP ///
             EMPWORK EMPWORKRP EMPWORKSP EMPWORKMM EMPWORKMMRP EMPWORKMMSP {
    wavg_plot `v'
}

* --- Occupation ---
foreach v in OCC1970C OCC1970CRP OCC1970CSP ///
             OCC2000C1M OCC2000C2M OCC2000C3M OCC2000C4M OCC2000C1MRP OCC2000C1MSP ///
             OCC2010C1M OCC2010C2M OCC2010C3M OCC2010C4M OCC2010C1MRP OCC2010C1MSP {
    wavg_plot `v'
}

* --- Home value & mortgages ---
foreach v in HOMEOWN HOMEEQUITYN HOMEEQUITYR HOMEEQUITYFN HOMEEQUITYFR ///
             HOMEVALUEN HOMEVALUER HOMEVALUEFN HOMEVALUEFR HOMEMORNUM ///
             HOMEMORTOTN HOMEMORTOTR HOMEMORTOTFN HOMEMORTOTFR ///
             HOMEMOR1MN HOMEMOR1MR HOMEMOR1MFN HOMEMOR1MFR ///
             HOMEMOR2MN HOMEMOR2MR HOMEMOR2MFN HOMEMOR2MFR {
    wavg_plot `v'
}

* --- Net worth ---
foreach v in NETWORTHN NETWORTHR NETWORTHFN NETWORTHFR ///
             NETWORTH2N NETWORTH2R NETWORTH2FN ///
             NETWORTH3N NETWORTH3R NETWORTH3FN NETWORTH3FR {
    wavg_plot `v'
}

* --- Total assets & total debt ---
foreach v in TOTASSN TOTASSR TOTASSFN TOTASSFR TOTASS2N TOTASS2R TOTASS2FN TOTASS2FR ///
             TOTASS3N TOTASS3R TOTASS3FN TOTASS3FR ///
             TOTDEBN TOTDEBR TOTDEBFN TOTDEBFR TOTDEB2N TOTDEB2R TOTDEB2FN TOTDEB2FR ///
             TOTDEB3N TOTDEB3R TOTDEB3FN TOTDEB3FR {
    wavg_plot `v'
}

* --- Wealth components (home, real estate, business, savings, funds, autos,
*     other assets, other debts) ---
foreach v in WLTHHOMETOTN WLTHHOMETOTR WLTHHOMETOTFN WLTHHOMETOTFR ///
             WLTHHOMEASSN WLTHHOMEASSR WLTHHOMEASSFN WLTHHOMEASSFR ///
             WLTHHOMEDEBN WLTHHOMEDEBR WLTHHOMEDEBFN WLTHHOMEDEBFR ///
             WLTHREALTOTN WLTHREALTOTR WLTHREALTOTFN WLTHREALTOTFR ///
             WLTHREALASSN WLTHREALASSR WLTHREALASSFN WLTHREALASSFR ///
             WLTHREALDEBN WLTHREALDEBR WLTHREALDEBFN WLTHREALDEBFR ///
             WLTHFBIZTOTN WLTHFBIZTOTR WLTHFBIZTOTFN WLTHFBIZTOTFR ///
             WLTHFBIZASSN WLTHFBIZASSR WLTHFBIZASSFN WLTHFBIZASSFR ///
             WLTHFBIZDEBN WLTHFBIZDEBR WLTHFBIZDEBFN WLTHFBIZDEBFR ///
             WLTHSAVETOTN WLTHSAVETOTR WLTHSAVETOTFN WLTHSAVETOTFR ///
             WLTHSAVEBNKN WLTHSAVEBNKR WLTHSAVEBNKFN WLTHSAVEBNKFR ///
             WLTHSAVEBNDN WLTHSAVEBNDR WLTHSAVEBNDFN WLTHSAVEBNDFR ///
             WLTHFUNDTOTN WLTHFUNDTOTR WLTHFUNDTOTFN WLTHFUNDTOTFR ///
             WLTHFUNDSTKN WLTHFUNDSTKR WLTHFUNDSTKFN WLTHFUNDSTKFR ///
             WLTHFUNDIRAN WLTHFUNDIRAR WLTHFUNDIRAFN ///
             WLTHAUTOTOTN WLTHAUTOTOTR WLTHAUTOTOTFN WLTHAUTOTOTFR ///
             WLTHOASSTOTN WLTHOASSTOTR WLTHOASSTOTFN WLTHOASSTOTFR ///
             WLTHODEBTOTN WLTHODEBTOTR WLTHODEBTOTFN WLTHODEBTOTFR ///
             WLTHODEBCREN WLTHODEBCRER WLTHODEBCREFN WLTHODEBCREFR ///
             WLTHODEBSTUN WLTHODEBSTUR WLTHODEBSTUFN WLTHODEBSTUFR ///
             WLTHODEBMEDN WLTHODEBMEDR WLTHODEBMEDFN WLTHODEBMEDFR ///
             WLTHODEBLEGN WLTHODEBLEGR WLTHODEBLEGFN WLTHODEBLEGFR ///
             WLTHODEBFAMN WLTHODEBFAMFN WLTHODEBFAMFR ///
             WLTHODEBREMN WLTHODEBREMR WLTHODEBREMFN WLTHODEBREMFR {
    wavg_plot `v'
}

* --- Parent / child / marriage history (relationship file) ---
foreach v in RELPARNUM RELCHINUM RELMARNUM {
    wavg_plot `v'
}

display as result _n "Done. Graphs written to ${graphs}"
