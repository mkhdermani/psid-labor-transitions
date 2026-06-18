# NLSY79 — code

Code for building **Employment / Unemployment / Inactivity (E/U/I) transition
rates** for the NLSY79 (1979 birth cohort) at weekly, monthly and survey
frequency. Raw NLS Investigator extracts live in `../extracts/`; data files in
`../data/`; output graphs in `../output/`.

## My analysis scripts
| File | What it does |
|---|---|
| `weekly/transition.do`  | Weekly E/U/I transition rates from the `STATUS_WK_*` array (clean → `tsset` → compare each week to the previous one → weighted rates). |
| `monthly/transition.do` | Same idea aggregated to the **month** (converts the week index to a calendar date, week 0 = 25 Dec 1977). |
| `weekly/final.R`        | Attaches the correct NLSY79 **yearly sampling weight** (`SAMPWEIGHT_<year>`) to each weekly observation so the rates can be population-weighted. |
| `Plot.Rmd`              | Builds the result charts (R Markdown / ggplot). |
| `NLSY79.ipynb`          | Exploratory notebook (loading / cleaning / checks). |
| `wealth.ipynb`          | Notebook for the NLSY79 wealth variables. |
| `nov19.NLSY79`          | NLS Investigator **tagset** = the list of variable codes selected for the extract (Nov 2019). |

## Framework code (not mine — third-party)
`NLSYMaster.do`, `data_prep/InfileClean.do`, `data_prep/FinalClean.do`, and
`analysis/NLSY_AnalysisMain.do` / `NLSY_AnalysisMisc.do` come from Ben Griffy's
NLSY setup framework (the NLSY equivalent of the PSID `setup_framework`). They
download the raw data and read it into Stata; the example paths in them are
templates — set your own before running.

## Rough order
1. Get the raw data (NLS Investigator, or the framework `*Clean.do`).
2. `weekly/transition.do` or `monthly/transition.do` to build the transitions.
3. `weekly/final.R` to add weights.
4. `Plot.Rmd` to draw the graphs.
