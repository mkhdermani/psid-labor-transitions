/* Generate NLSY79 datafiles for use with many projects */
/* Author: Ben Griffy */
/* Date: Apr., 2018 */
/* Website: https://www.bengriffy.com */

clear all
pause on
set more off

local i = 1
global projname = "Long Project Name"
global shortname = "LPN"

if `i' == 1{
    global pd = "/media/ben/workA/shared/Dropbox/Research/$projname"
    global progdir = "/media/ben/workA/shared/Dropbox/Research/$projname/programs/data/NLSY79"
    global modeldatadir = "$pd/data/modeluse_data/"
    global psiddir = "/media/ben/workA/datasets/NLSY79"
    global datadir = "$psiddir/data"
    global alldatadir = "/media/ben/workA/data"
    global projdir = "/media/ben/workA/datasets/NLSY79/projects/$shortname"
    global tmpdir = "$datadir/tmp"
}
if `i' == 2{
    global pd = "E:\Dropbox\Research\$projname"
    global progdir = "E:\Dropbox\Research\$projname\programs\data\NLSY79"
    global modeldatadir = "$pd\data\modeluse_data"
    global datadir = "E:\data\NLSY79\data"
    global alldatadir = "E:\data"
    global projdir = "E:\data\NLSY79\projects\$shortname"
    global tmpdir = "$datadir\tmp"
}
if `i' == 3{
    global pd = "C:\Users\Ben\Dropbox\Research\$projname"
    global progdir = "C:\Users\Ben\Dropbox\Research\$projname\programs\data\NLSY79"
    global modeldatadir = "$pd\data\modeluse_data"
    global datadir = "C:\Users\Ben\Dropbox\data\NLSY79\data"
    global alldatadir = "C:\data"
    global projdir = "C:\Users\Ben\Dropbox\data\NLSY79\projects\$shortname"
    global tmpdir = "$datadir\tmp"
}

global graphicpath = "$pd/figures/graphics"
global tablepath = "$pd/figures/tables"

capture confirm file $projdir/
if _rc mkdir $projdir/

capture confirm file $tmpdir/
if _rc mkdir $tmpdir/

local alldata = 0
local createdata = 0
local cleanfam = 0
local cleanind = 0
local mergefamind = 0
local genbasepanel = 0
local cleanpanel = 0

local allanalysis = 0
local mainanalysis = 0
local miscanalysis = 0

local cleartmp = 0

/* Data Generation */

if `genbasepanel' == 1 | `alldata' == 1{
    cd "$progdir/data_prep"
    do InfileClean
}

if `cleanpanel' == 1 | `alldata' == 1{
    cd "$progdir/data_prep"
    do FinalClean
}

/* Analysis */

if `mainanalysis' == 1 | `allanalysis' == 1{
    cd "$progdir/analysis"
    do NLSY_AnalysisMain
}

if `miscanalysis' == 1 | `allanalysis' == 1{
    cd "$progdir/analysis"
    do NLSY_AnalysisMisc
}
