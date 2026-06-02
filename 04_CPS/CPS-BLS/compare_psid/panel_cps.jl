using DataFrames, CSV, Dates, Plots, StatsPlots

# Import data from Excel
df = CSV.File("PANEL_CPS.xlsx", DataFrame, sheet="Sheet2")

# Rename columns
rename!(df, [
    :LNU02000000 => :Employment_Level,
    :LNU07000000 => :EE,
    :LNU07100000 => :UE,
    :LNU07200000 => :IE,
    :LNU07300000 => :ME,
    :LNU03000000 => :Unemployment_Level,
    :LNU07400000 => :EU,
    :LNU07500000 => :UU,
    :LNU07600000 => :IU,
    :LNU07700000 => :MU,
    :LNU05000000 => :Not_in_Labor_Force,
    :LNU07800000 => :EI,
    :LNU07900000 => :UI,
    :LNU08000000 => :II,
    :LNU08100000 => :MI,
    :LNU08200000 => :EM,
    :LNU08300000 => :UM,
    :LNU08400000 => :IM
])

# Extract month and year from YEAR_MONTH
df.month = map(x -> monthabbr(Date(x, "uymmmm")), df.YEAR_MONTH)
df.year = map(x -> parse(Int, strip(x[startswith(x, "19") || startswith(x, "20") ? end-3:end])), df.YEAR_MONTH)

# Convert abbreviated month to numerical representation and sort
df.date_num = map(x -> Date(x, "uymmmmyyyy"), df[:date_str])
sort!(df, :date_num)

# Generate lagged variables for each labor market status
df.Employment_Level_lag = [missing; df.Employment_Level[1:end-1]]
df.Unemployment_Level_lag = [missing; df.Unemployment_Level[1:end-1]]
df.Not_in_Labor_Force_lag = [missing; df.Not_in_Labor_Force[1:end-1]]

# Calculate transition variables using log transformation
df.tr_EE = -log.(1 .- (df.EE ./ df.Employment_Level_lag))
df.tr_UU = -log.(1 .- (df.UU ./ df.Unemployment_Level_lag))
df.tr_II = -log.(1 .- (df.II ./ df.Not_in_Labor_Force_lag))
df.tr_EU = -log.(1 .- (df.EU ./ df.Employment_Level_lag))
df.tr_UE = -log.(1 .- (df.UE ./ df.Unemployment_Level_lag))
df.tr_IE = -log.(1 .- (df.IE ./ df.Employment_Level_lag))
df.tr_EI = -log.(1 .- (df.EI ./ df.Employment_Level_lag))
df.tr_IU = -log.(1 .- (df.IU ./ df.Not_in_Labor_Force_lag))
df.tr_UI = -log.(1 .- (df.UI ./ df.Unemployment_Level_lag))

# Plot Transition Rate: Employment to Unemployment
p1 = plot(df.date_num, df.tr_EU, title="Transition Rate: Employment to Unemployment",
     xlabel="Year", ylabel="Transition Rate", legend=false)
savefig(p1, "tr_EU.png")

# Save DataFrame to CSV
CSV.write("panel_cps.csv", df)

# Additional plots for other transition rates

# Plot Transition Rate: Unemployment to Employment
p2 = plot(df.date_num, df.tr_UE, title="Transition Rate: Unemployment to Employment",
     xlabel="Year", ylabel="Transition Rate", legend=false)
savefig(p2, "tr_UE.png")

# Plot Transition Rate: Employment to Inactivity
p3 = plot(df.date_num, df.tr_EI, title="Transition Rate: Employment to Inactivity",
     xlabel="Year", ylabel="Transition Rate", legend=false)
savefig(p3, "tr_EI.png")

# Plot Transition Rate: Inactivity to Employment
p4 = plot(df.date_num, df.tr_IE, title="Transition Rate: Inactivity to Employment",
     xlabel="Year", ylabel="Transition Rate", legend=false)
savefig(p4, "tr_IE.png")

# Plot Transition Rate: Unemployment to Inactivity
p5 = plot(df.date_num, df.tr_UI, title="Transition Rate: Unemployment to Inactivity",
     xlabel="Year", ylabel="Transition Rate", legend=false)
savefig(p5, "tr_UI.png")

# Plot Transition Rate: Inactivity to Unemployment
p6 = plot(df.date_num, df.tr_IU, title="Transition Rate: Inactivity to Unemployment",
     xlabel="Year", ylabel="Transition Rate", legend=false)
savefig(p6, "tr_IU.png")

# Plot Transition Rate: Employment to Employment
p7 = plot(df.date_num, df.tr_EE, title="Transition Rate: Employment to Employment",
     xlabel="Year", ylabel="Transition Rate", legend=false)
savefig(p7, "tr_EE.png")

# Plot Transition Rate: Unemployment to Unemployment
p8 = plot(df.date_num, df.tr_UU, title="Transition Rate: Unemployment to Unemployment",
     xlabel="Year", ylabel="Transition Rate", legend=false)
savefig(p8, "tr_UU.png")

# Plot Transition Rate: Inactivity to Inactivity
p9 = plot(df.date_num, df.tr_II, title="Transition Rate: Inactivity to Inactivity",
     xlabel="Year", ylabel="Transition Rate", legend=false)
savefig(p9, "tr_II.png")

# Assuming you have another dataset for merging
# Let's say it's called "nlsy79_data.csv" and you want to merge it with your current DataFrame

# Load the additional dataset
nlsy79_df = CSV.read("nlsy79_data.csv", DataFrame)

# Merge the two datasets on the 'date_num' column
merged_df = innerjoin(df, nlsy79_df, on = :date_num)


