using DataFrames, StatFiles, Plots

# Read CPS data file from DTA
df = DataFrame(load("shimer.dta"))

# Define the path where the graphs will be saved
path = "D:/PSID_SHELF/04_CPS/CPS-SHIMER/"

# eu_shimer
p_eu = plot(df.year_formatted, df.eu_shimer, label="EU Shimer", title="Transition Rate: Employment to Unemployment",
            xlabel="Year", ylabel="Transition Rate", legend=:bottomright)
savefig(p_eu, "$(path)eu_shimer.png")

# ue_shimer
p_ue = plot(df.year_formatted, df.ue_shimer, label="UE Shimer", title="Transition Rate: Unemployment to Employment",
            xlabel="Year", ylabel="Transition Rate", legend=:bottomright)
savefig(p_ue, "$(path)ue_shimer.png")

# ei_shimer
p_ei = plot(df.year_formatted, df.ei_shimer, label="EI Shimer", title="Transition Rate: Employment to Inactivity",
            xlabel="Year", ylabel="Transition Rate", legend=:bottomright)
savefig(p_ei, "$(path)ei_shimer.png")

# ie_shimer
p_ie = plot(df.year_formatted, df.ie_shimer, label="IE Shimer", title="Transition Rate: Inactivity to Employment",
            xlabel="Year", ylabel="Transition Rate", legend=:bottomright)
savefig(p_ie, "$(path)ie_shimer.png")

# ui_shimer
p_ui = plot(df.year_formatted, df.ui_shimer, label="UI Shimer", title="Transition Rate: Unemployment to Inactivity",
            xlabel="Year", ylabel="Transition Rate", legend=:bottomright)
savefig(p_ui, "$(path)ui_shimer.png")

# iu_shimer
p_iu = plot(df.year_formatted, df.iu_shimer, label="IU Shimer", title="Transition Rate: Inactivity to Unemployment",
            xlabel="Year", ylabel="Transition Rate", legend=:bottomright)
savefig(p_iu, "$(path)iu_shimer.png")
