Intermediate / derived PSID datasets
====================================

These .dta files are working datasets produced while building the PSID analysis.
They are derived from the master panel (../PSIDSHELF_1968_2019_LONG.dta) and the
scripts in ../../code, and can be regenerated from those sources.

File                what it holds (best understanding from the workflow)
------------------  --------------------------------------------------------------
L_F_S.dta           small labour-force-status lookup / crosswalk
lfs.dta             labour-force-status panel extract
labour_force.dta    labour-force subset of the panel
employment.dta      employment subset of the panel
inactivity.dta      inactivity subset of the panel
family.dta          family-level subset
transition.dta      working dataset for E/U/I transition rates
unweight.dta        unweighted variant used for checks
new_psid.dta        working PSID extract
us_transition.dta   output of ../../code/misc/time.do (dated transition series)

Note: cryptically-named scratch files that were not referenced by any script
(unknow.dta, your_panel_data_ymd.dta, asle.dta, lns.dta) were removed during the
2026 cleanup to keep this folder professional. If you need any of them, regenerate
from the master panel.
