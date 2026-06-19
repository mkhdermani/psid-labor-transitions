# Employment

A focused sub-project: build a monthly PSID **employment panel** and compare its
Employment↔Unemployment transition rates against the published **Fallick &
Fleischman** (and BLS) benchmark series. The write-up is in `Tex/` and the
figures in `Graph/`.

## Scripts (rough run order)
| Step | File | What it does |
|---|---|---|
| 1 | `reshape.do`                       | Reshape the PSID extract `psid_employment_wide.dta` from **wide → long** (one row per person-month); drops unused job-detail variables and reshapes the monthly `WEIGHT_/RELATION_/SEX_/EMP_/UNE_/OUT_` arrays. |
| 2 | `Emp_Gen.Rmd`                      | Generate / assemble the monthly employment panel from the reshaped data. |
| 3 | `Rename.Rmd`                       | Rename variables to readable, consistent names. |
| 4 | `Mean_Compare.Rmd`                 | Compute the transition rates and compare their means to the benchmark. |
| 5 | `transition_rates_and_graphs.Rmd` | Produce the final transition-rate series and the comparison figures. |

## Data & reference files
- `psid_employment_wide.dta`, `psid_employment_long.dta` — the wide extract and the reshaped long panel.
- `employment_monthly_data.xlsx` + `employment_monthly_codebook.pdf` — the monthly
  employment series and its codebook.
- `fallick_and_fleischman.xlsx` — the published benchmark transition rates.
- `Graph/` — output figures (incl. `Graph/Mean_Compare/`).
- `Tex/` — the LaTeX report (`Employment.tex` / `Employment.pdf`).
