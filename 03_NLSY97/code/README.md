# NLSY97 — code

Code for the NLSY97 (1997 birth cohort): build the labour-status panel,
compute E/U/I transition rates, and compare them against the published
Fallick & Fleischman benchmark. Data files are in `../data/`, graphs in
`../output/`.

Because Stata was slow on the wide raw files, the workflow loads and reshapes
the data in **R / Julia first**, then returns to Stata (see `../Readme.txt`).

| File | What it does |
|---|---|
| `NLSY97.jl`    | Julia (Pluto) notebook — loads the raw NLSY97 extract, cleans it, and reshapes wide → long to get the person-period panel. |
| `NLSY97.ipynb` | Jupyter notebook version of the loading / cleaning / transition-rate steps. |
| `Plot.Rmd`     | Builds the result charts, including the NLSY97-vs-Fallick & Fleischman dual-axis figure. |
| `lib/`         | Third-party JavaScript/CSS bundled by R when it exported an interactive html chart — **not my code** (safe to ignore). |
