# CPS — Current Population Survey

Three parallel ways of getting monthly **Employment / Unemployment / Inactivity
(E/U/I) transition rates** from the CPS, so the survey-based rates can be
cross-checked against each other and against the published benchmarks.

> ⚠️ The large CPS data files (`cps.dta` ≈ 2.4 GB, `cps_tr.dta` ≈ 8 GB) are
> git-ignored — see the main README's *Data availability* section.

## The three approaches

### `CPS-MINE/` — my own build from the raw micro-data
- `Do/cps_transition.do` — sets the person panel (`cpsidv` × month), compares each
  month's `empstat` to the previous month, and aggregates weighted (`wtfinl`)
  transition counts into rates. (empstat: employed 1/10/12, unemployed 20–22,
  inactive 30–36.)
- `Data/` — the IPUMS CPS extract and the derived transition file.
- `Graph/` — output figures.

### `CPS-SHIMER/` — transition rates with Shimer's (2012) method
- `DO/cps_transition.do` — plots the Shimer-adjusted rates and exports one PNG per
  flow (EU, UE, EI, IE, UI, IU). `cps_transition.jl` is the Julia version.
- `DATA/` — `shimer.dta` (the Shimer-method rates) and helpers.

### `CPS-BLS/` — compare against the published BLS gross-flow series
- `compare_psid/` and `compare_nlsy/` hold the same workflow aimed at each comparison:
  - `panel_cps.do` — load the BLS flow series (`LNU…` codes) from `PANEL_CPS.xlsx`
    and rename them to readable names (levels + EE/EU/EI/UE/… gross flows).
  - `shimer_comparison.do` — aggregate the monthly rates to **quarterly** means and
    plot them on the comparison time scale.
  - `.jl` files are Julia versions; `CPS_PSID-1.ipynb` / `CPS_BLS.Rmd` are the
    notebook/markdown write-ups.
- `transition_graphs/` and `Graph/` — output figures.
