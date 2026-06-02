# PSID_SHELF — Labour-market transitions & wealth dynamics

**Author:** Mohsen Khalili (Dermani)  ·  **Role:** Research Assistant (for E. Sepahsalari)
**Tools:** Stata · R · Julia · Python · LaTeX

Research-assistant work studying **how individuals move between Employment, Unemployment
and Inactivity** (E↔U↔I transition rates) and how **income and wealth** evolve over the
life cycle, using four micro datasets and one macro source:

> ⚠️ **Data is not included in this repository.** The raw PSID / NLSY / CPS microdata are
> governed by data-use agreements and are **not redistributed here**. Only the *code*,
> *aggregate result graphs* and *write-ups* are published. See **[Data availability](#data-availability)**
> for how to obtain the underlying data.

| Dataset | What it is |
|---|---|
| **PSID**   | Panel Study of Income Dynamics, 1968–2019/2021 (income, wealth, employment) |
| **NLSY79** | National Longitudinal Survey of Youth, 1979 cohort |
| **NLSY97** | National Longitudinal Survey of Youth, 1997 cohort |
| **CPS**    | Current Population Survey (monthly labour-force flows) |
| **FRED**   | Federal Reserve macro series (used as a benchmark) |

The recurring research question is the **rate at which people move between
Employment (E), Unemployment (U) and Inactivity (I)** — the E↔U↔I transition
rates — compared across datasets and against the published benchmarks of
*Fallick & Fleischman* and *Shimer*.

---

## Folder structure

```
PSID_SHELF/
├── README.md                  ← this file
│
├── 01_PSID/                   (6 GB) — the main project
│   ├── setup_framework/         Python tool (by Ben Griffy) that downloads PSID and
│   │                            generates Stata code. See setup_framework/readme.txt.
│   │                            keyDocs/psid.xlsx = the variable crosswalk.
│   ├── code/
│   │   ├── data_prep/           Stata scripts, one per PSID topic (INCOME, WEALTH,
│   │   │                        EDUCATION, …) + the *Clean.do customisation files.
│   │   ├── analysis/            weighted_average_trends.do  ← MAIN analysis (see below)
│   │   │                        PSID_AnalysisMain.do / PSID_AnalysisMisc.do (framework)
│   │   │                        psid_analysis_julia.ipynb (Julia version)
│   │   └── misc/                helper scripts & notebooks (psid_transition.do, time.do,
│   │                            PSID.ipynb, INDIVIDUAL_PSID.ipynb, PSID_WEALTH.Rmd)
│   ├── data/
│   │   ├── PSIDSHELF_1968_2019_LONG.dta   master long panel (5.2 GB)
│   │   ├── merged_data.dta                merged analysis file (274 MB)
│   │   ├── dta/                           intermediate Stata datasets (see dta/README.txt)
│   │   └── excel/                         codebooks & variable lists (PSID.xlsx/.pdf/.txt)
│   ├── output/graphs/           result graphs (weighted_avg_*.png, etc.)
│   └── reports/                 All.tex/.pdf and analysis_of_psid_data.tex/.pdf
│
├── 02_NLSY79/                 (3 GB)
│   ├── extracts/               raw NLS Investigator downloads (Asset, Income,
│   │                           Program_Participation) with codebooks
│   ├── code/                   NLSYMaster.do, data_prep/, analysis/, monthly/, weekly/,
│   │                           notebooks (NLSY79.ipynb, wealth.ipynb, Plot.Rmd)
│   ├── data/                   nlsy_final.dta (1.6 GB), NLSY79.csv, Long_Employment_*.csv …
│   └── output/                 92 transition-rate graphs
│
├── 03_NLSY97/                 (770 MB)
│   ├── code/                   NLSY97.jl, NLSY97.ipynb, Plot.Rmd (+ lib/ for the html plot)
│   ├── data/                   NLSY97.csv, Long_Employment_NLSY97.csv …
│   ├── output/                 66 graphs
│   └── Readme.txt              author's note (R → reshape → Stata workflow)
│
├── 04_CPS/                    (11 GB) — three parallel approaches
│   ├── CPS-BLS/                CPS vs published BLS rates; "compare_psid" & "compare_nlsy"
│   ├── CPS-MINE/               own CPS build — Data/cps.dta (2.4 GB), cps_tr.dta (8 GB)
│   └── CPS-SHIMER/             transition rates using Shimer's method
│
├── 05_FRED/                   (1 MB)
│   ├── code/  data/Csv  data/dta  output/   FRED E/U/I flow series + plots
│
├── 06_Employment/            (193 MB)
│   Transition-rate analysis vs Fallick & Fleischman and BLS.
│   *.Rmd scripts, reshape.do, data, Graph/, Tex/ (Employment.tex/.pdf report)
│
└── reports/                  (28 MB)
    ├── NLSYs.tex / NLSYs.pdf          cross-dataset employment-transition report
    └── personal/                      job-application docs (CV, Motivation) — not research
```

---

## How to run the main PSID analysis

1. The master dataset is `01_PSID/data/PSIDSHELF_1968_2019_LONG.dta`.
2. Run `01_PSID/code/analysis/weighted_average_trends.do`. It loads the master data and,
   for each variable, builds a population-weighted average (or weighted proportion for
   categorical variables) by `YEAR` and exports a graph to `01_PSID/output/graphs/`.
   Set the paths once at the top of the file (the `global` lines).
3. The LaTeX file `01_PSID/reports/All.tex` then stitches those graphs into one PDF.

To (re)build the PSID panel from scratch instead, follow
`01_PSID/setup_framework/readme.txt`.

---

## Data availability

The raw microdata are **not part of this repository** (data-use agreements + file size).
They are freely available to registered users from the official providers:

| Dataset | Source |
|---|---|
| PSID            | Panel Study of Income Dynamics — <https://psidonline.isr.umich.edu> |
| NLSY79 / NLSY97 | NLS Investigator (BLS / Ohio State) — <https://www.nlsinfo.org> |
| CPS             | Current Population Survey — <https://www.census.gov/cps> (or IPUMS-CPS) |
| FRED            | Federal Reserve Economic Data — <https://fred.stlouisfed.org> |

To reproduce the analysis: download the data into each dataset's `data/` folder (and the
NLS extracts into `02_NLSY79/extracts/`), then run the scripts as described above. The PSID
panel can be rebuilt from scratch with the generator in `01_PSID/setup_framework/`.

---

## File-path convention (important)

All scripts originally used absolute paths under the old location
`D:\Sepahsalari\...`. During cleanup these were **rewritten to the current
location** `D:\PSID_SHELF\<dataset>\...` so the code runs from here. For example:

```
old:  use D:\Sepahsalari\PSID_SHELF\Data\PSIDSHELF_1968_2019_LONG.dta
new:  use D:\PSID_SHELF\01_PSID\data\PSIDSHELF_1968_2019_LONG.dta

old:  graph export "D:\Sepahsalari\PSID_SHELF\Graph\..."
new:  graph export "D:\PSID_SHELF\01_PSID\output\graphs\..."
```

165 paths in code files, 67 in notebooks, and 91 in the LaTeX reports/notes were updated
(`.do`, `.R`, `.Rmd`, `.jl`, `.py`, `.ipynb`, `.tex`, `.txt`). If you move this folder
to a different drive/path, do a find-and-replace of `D:\PSID_SHELF` (and `D:/PSID_SHELF`).

**Two known leftovers (by design):**
- `01_PSID/setup_framework/` (`PSIDMaster.py`, `PSIDMaster.do`) still contains the
  original author's *example* paths (`/media/ben/...`). That is a template — set your own
  paths before using the downloader/generator.
- A few `.dta` files contain an old path string inside their Stata metadata. This is
  harmless (Stata still loads them); only the file location matters.

---

## What was cleaned up (29 GB → 21 GB)

- **Deleted** `No/DONT-USE/` (3 GB of superseded scratch: beta `.dta` files, an unrelated
  document, old CPS extracts).
- **Deleted** `Wealth.dta` (5.2 GB) — it was a byte-for-byte duplicate of the master
  `PSIDSHELF_1968_2019_LONG.dta` (verified by hashing head + tail).
- **Deleted** regenerable build artifacts: LaTeX `.aux/.log/.out/.synctex.gz/.toc`,
  Python `__pycache__`/`.pyc`, IDE `.idea/` folders, redundant `.zip` archives whose
  contents were already extracted, and empty/broken folders.
- **Merged** three overlapping copies of the project (the old `All/`, `No/`, and
  `Sepahsalari/` trees) into the single per-dataset layout above. Where the same file
  existed in more than one place, the most complete / most recent version was kept and
  exact duplicates were removed.

---

## Code review & professional naming (second pass)

- **Consolidated the PSID weighted-average analysis.** 26 near-identical per-topic
  do-files (several unfinished, with placeholder `your_dataset.dta` paths and typo names
  like `chilhood.do`, `emplyment_status.do`, `ind_emp;yment.do`) were merged into one
  documented, parameterised script: `01_PSID/code/analysis/weighted_average_trends.do`.
  Every variable group is preserved as a labelled section.
- **Removed 24 empty placeholder do-files** (PSID categories with no selected variables)
  and commented out their now-dangling `do <CATEGORY>` calls in the runner.
- **Repaired `misc/time.do`**, which had been saved as a console log (Stata `.` prompts and
  `(1 real change made)` output mixed into the code); the 23 hand-typed yearly lines are
  now a single loop.
- **Renamed files/folders for consistency** (no spaces, typos or special characters), and
  updated every reference: e.g. `comapre psid/` → `compare_psid/`, `compare nlsy/` →
  `compare_nlsy/`, `Shimer_comparision.*` → `shimer_comparison.*`, `cps_ transition.do` →
  `cps_transition.do`, `TR&Graph.Rmd` → `transition_rates_and_graphs.Rmd`,
  `Fallick and Fleischman.xlsx` → `fallick_and_fleischman.xlsx`, `tarnsition.dta` →
  `transition.dta`, `Analysis of PSID data.*` → `analysis_of_psid_data.*`.
- **Curated intermediate datasets.** Unreferenced scratch files with meaningless names
  (`unknow.dta`, `your_panel_data_ymd.dta`, `asle.dta`, `lns.dta`) were removed; the
  remaining derived datasets are documented in `01_PSID/data/dta/README.txt`.
- **Cleaned all notebooks for sharing.** Output cells were stripped from every `.ipynb`
  (4.2 MB → 0.1 MB), removing stale results and machine-specific execution logs while
  keeping all code and markdown.
- **Left untouched** the auto-generated code that is not the author's to maintain: the PSID
  `setup_framework` generator, the large generated category extracts, and the NLS
  Investigator extract scripts under `02_NLSY79/extracts/`.

_Reorganised, reviewed and documented. Auto-generated framework/extract code was preserved
as-is; the author's own analysis code was cleaned, repaired and consolidated as above._
