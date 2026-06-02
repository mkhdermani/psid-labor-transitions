using DataFrames, StatFiles, CSV, Dates, Plots

# Read panel CPS data file
df = DataFrame(load("panel_cps.dta"))

# Convert 'year' from string to integer if necessary
df.year = parse.(Int, df.year)

# Generate 'quarter' based on 'month'
df.quarter = ifelse.(df.month .∈ [1, 2, 3], 1,
            ifelse.(df.month .∈ [4, 5, 6], 2,
            ifelse.(df.month .∈ [7, 8, 9], 3,
            ifelse.(df.month .∈ [10, 11, 12], 4, missing))))

# Calculate mean transition rates by quarter and year for specified variables
for var in ["EU", "UE", "IE", "EI", "IU", "UI"]
    df[!, Symbol("tr_", var, "_quarter_mean")] = by(df, [:quarter, :year], 
                                                    :tr_ => var => mean => Symbol("mean_tr_", var))
end

# Sort by date_num
sort!(df, :date_num)

# Plot and save quarterly mean transition rates
path = "D:/PSID_SHELF/04_CPS/CPS-SHIMER/"
for var in ["EU", "UE", "IE", "EI", "IU", "UI"]
    p = plot(df.year .+ (df.quarter .- 1) / 4, df[!, Symbol("mean_tr_", var)],
             title="Transition Rate: $(var) Quarterly Mean",
             xlabel="Year", ylabel="Mean Transition Rate", legend=false)
    savefig(p, "$(path)tr_$(var)_quarterly.png")
end

# Merge with Shimer data
shimer_df = DataFrame(load("D:/PSID_SHELF/04_CPS/CPS-SHIMER/shimer.dta"))
merged_df = outerjoin(df, shimer_df, on = [:year, :quarter], makeunique=true, indicator=:merge)

# Keep only the matched observations
merged_df = filter(row -> row.merge == :both, merged_df)

# Rename variables for clarity in comparison plots
for var in ["eu", "ue", "ie", "ei", "iu", "ui"]
    rename!(merged_df, Symbol(var * "_shimer") => Symbol(uppercase(var) * "_shimer"))
end

# Plot and save comparison of mean transition rates
for var in ["EU", "UE", "IE", "EI", "IU", "UI"]
    p = plot(merged_df.year .+ (merged_df.quarter .- 1) / 4,
             [merged_df[!, Symbol("mean_tr_", var)], merged_df[!, Symbol(var * "_shimer")]],
             label=["CPS" "SHIMER"], title="Transition Rate: $(var) Comparison",
             xlabel="Year", ylabel="Mean Transition Rate")
    savefig(p, "$(path)tr_$(var)_compare.png")
end
