# FRED — macro benchmark

A small set of **Federal Reserve Economic Data (FRED)** labour-flow series, used
as an independent macro benchmark for the survey-derived E/U/I transition rates.

| Folder / file | Contents |
|---|---|
| `data/Csv/` | Raw series downloaded from FRED. The two-letter names are flows: `eu` = employment→unemployment, `ue` = unemployment→employment, `ei`, `ie`, `iu`, `ui`; plus `emplo`/`pop`/`UNEMPLOY` levels. |
| `data/dta/` | The same series converted to Stata `.dta` (`all.dta` = everything combined). |
| `code/rateall.do` | Overlays each FRED flow rate against the corresponding **computed** transition rate (`tr_*_to_*`) and exports one comparison plot per flow to `output/`. |
| `output/` | The comparison figures. |

> Note: `rateall.do` expects a time-series dataset already in memory that holds
> both the FRED `*_rate` series and the computed `tr_*` series (set with `tsset`).
