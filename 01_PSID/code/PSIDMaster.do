/* Generate PSID datafiles for use with many projects */
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
    global progdir = "/media/ben/workA/shared/Dropbox/Research/$projname/programs/data/PSID"
    global modeldatadir = "$pd/data/modeluse_data/"
    global psiddir = "/media/ben/workA/datasets/PSID"
    global datadir = "$psiddir/data"
    global alldatadir = "/media/ben/workA/data"
    global projdir = "/media/ben/workA/datasets/PSID/projects/$shortname"
    global tmpdir = "$datadir/tmp/$shortname"
}
if `i' == 2{
    global pd = "E:\Dropbox\Research\$projname"
    global progdir = "E:\Dropbox\Research\$projname\programs\data\PSID"
    global modeldatadir = "$pd\data\modeluse_data"
    global datadir = "E:\data\PSID\data"
    global alldatadir = "E:\data"
    global projdir = "E:\data\PSID\projects\$shortname"
    global tmpdir = "$datadir\tmp"
}
if `i' == 3{
    global pd = "C:\Users\Ben\Dropbox\Research\$projname"
    global progdir = "C:\Users\Ben\Dropbox\Research\$projname\programs\data\PSID"
    global modeldatadir = "$pd\data\modeluse_data"
    global datadir = "C:\Users\Ben\Dropbox\data\PSID\data"
    global alldatadir = "C:\data"
    global projdir = "C:\Users\Ben\Dropbox\data\PSID\projects\$shortname"
    global tmpdir = "$datadir\tmp"
}
if `i' == 4{
    global pd = "/home/ben//Dropbox/Research/$projname"
    global progdir = "/home/ben//Dropbox/Research/$projname/programs/data/PSID"
    global modeldatadir = "$pd/data/modeluse_data/"
    global psiddir = "/media/ben/workUSB/datasets/PSID"
    global datadir = "$psiddir/data"
    global alldatadir = "/media/ben/workUSB/data"
    global projdir = "/media/ben/workUSB/datasets/PSID/projects/$shortname"
    global tmpdir = "$datadir/tmp"
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
local incwealthclean = 0
local demogclean = 0
local empclean = 0
local finalclean = 0

local allanalysis = 0
local mainanalysis = 0
local miscanalysis = 0

local cleartmp = 0

/* Data Generation */

if `createdata' == 1 | `alldata' == 1{
    cd "$progdir/data_prep"
    do PSID_Stata_Datasets_Creation
}

if `cleanfam' == 1 | `alldata' == 1{
    cd "$progdir/data_prep"
    do PSID_Variable_Selection_Family
}

if `cleanind' == 1 | `alldata' == 1{
    cd "$progdir/data_prep"
    do PSID_Variable_Selection_Individual
}

if `mergefamind' == 1 | `alldata' == 1{
    cd "$progdir/data_prep"
    do Merge
}

if `genbasepanel' == 1 | `alldata' == 1{
    cd "$progdir/data_prep"
    do ReshapeLabelData
    do LabelSave
}

if `incwealthclean' == 1 | `cleanpanel' == 1 | `alldata' == 1{
    cd "$progdir/data_prep"
    do IncomeWealthClean
}

if `demogclean' == 1 | `cleanpanel' == 1 | `alldata' == 1{
    cd "$progdir/data_prep"
    do DemographicsClean
}

if `empclean' == 1 | `cleanpanel' == 1 | `alldata' == 1{
    cd "$progdir/data_prep"
    do EmploymentClean
}

if `finalclean' == 1 | `cleanpanel' == 1 | `alldata' == 1{
    cd "$progdir/data_prep"
    do FinalClean
}

/* Analysis */

if `mainanalysis' == 1 | `allanalysis' == 1{
    cd "$progdir/analysis"
    do PSID_AnalysisMain
}

if `miscanalysis' == 1 | `allanalysis' == 1{
    cd "$progdir/analysis"
    do PSID_AnalysisMisc
}
