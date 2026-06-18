# PSID — code

Code for the main project: the PSID income / wealth / employment panel
(`../data/PSIDSHELF_1968_2019_LONG.dta`). Output graphs go to `../output/graphs/`,
reports to `../reports/`.

## `analysis/` — the main analysis (mine)
| File | What it does |
|---|---|
| `weighted_average_trends.do` | **Main script.** For each variable, builds a population-weighted average (or weighted proportion for categorical variables) by `YEAR` and exports a graph to `../output/graphs/`. Set the paths in the `global` lines at the top first. |
| `psid_analysis_julia.ipynb`  | Julia version of the analysis. |
| `PSID_AnalysisMain.do` / `PSID_AnalysisMisc.do` | Example analysis files from the setup framework (see below). |

## `misc/` — helper scripts & notebooks (mine)
| File | What it does |
|---|---|
| `psid_transition.do` | Rename raw PSID codes (`ER…`) to readable names per wave and build E/U/I transition rates. |
| `time.do`            | Build a daily date variable and stamp 1 Jan of each survey year. |
| `PSID.ipynb` / `INDIVIDUAL_PSID.ipynb` / `PSID_WEALTH.Rmd` | Exploratory notebooks for the panel, the individual file, and the wealth variables. |

## `data_prep/` and `../setup_framework/` — third-party (not mine)
These come from **Ben Griffy's** PSID setup framework. `../setup_framework/`
(Python) downloads the PSID and *generates* the Stata code; `data_prep/` then holds
one generated do-file per PSID topic (`INCOME.do`, `WEALTH.do`, `EDUCATION.do`, …)
plus the reshape/label/merge and `*Clean.do` steps. `PSIDMaster.do` runs them.
Their example paths are templates — set your own before running. See
`../setup_framework/readme.txt` for the full workflow.
