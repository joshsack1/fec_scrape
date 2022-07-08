using HTTP, Gumbo, Cascadia, CSV, DataFrames

#Pull Initial Data
#Set url
println("Enter the url for the committee's latest fling")
url = readline()
#Request html
request = HTTP.get(url)
#Parse HTLM
h = parsehtml(String(request.body))

#Start pulling useful information
file_date_raw = h.root[2][5][20]
summary_page = h.root[2][5][30]
detailed = h.root[2][5][36]

#Break out data for raising
#Raised from contributions
form_3_11a_i = detailed[2][4] #Large contributions
form_3_11a_ii = detailed[2][5] #Small Contributions
form_3_11a_iii = detailed[2][6] #Total from individuals
form_3_11b = detailed[2][7] #party committees
form_3_11c = detailed[2][8] #PACs
form_3_11d = detailed[2][9] #self financing
form_3_11e = detailed[2][10] #Total contributions

#Break out data for loans
form_3_13a = detailed[2][13] #made or guaranteed by the candidate
form_3_13b = detailed[2][14] #Other
form_3_13c = detailed[2][15] #All loans

#Total Contributions
form_3_16 = detailed[2][18]

#Break out data for Expenses
form_3_19a = detailed[2][23] #Loan repayments when guaranteed or made by the candidate
form_3_20d = detailed[2][30] #Total Contribution Refunds

#Total Dispersements
form_3_22 = detailed[2][32]

#Cash on Hand
form_3_27 = detailed[2][38]

#Period Summary
period_raised_string = form_3_11e[2][1].text
period_raised_float = parse(Float64,period_raised_string)
period_spent_string = form_3_22[2][1].text
period_spent_float = parse(Float64,period_spent_string)
period_unitemized_donations_string = form_3_11a_ii[2][1].text
period_loans = form_3_13c[2][1].text
period_burn_rate_float = 100.0*(period_spent_float/period_raised_float)
period_burn_rate_float = round(period_burn_rate_float, digits = 2)
period_burn_rate_string = string(period_burn_rate_float)*"%"
period_unitemized_donations_float = parse(Float64, period_unitemized_donations_string)
period_small_dollar_rate_float = 100.0*(period_unitemized_donations_float/period_raised_float)
period_small_dollar_rate_float = round(period_small_dollar_rate_float, digits =  2)
period_small_dollar_rate_string = string(period_small_dollar_rate_float) * "%"
period_coh = form_3_27[2][1].text
#Create DataFrame for CSV Export
period_summary = DataFrame()
period_summary.Raised = ["Period Raised", period_raised_string]
period_summary.Spent = ["Period Spent", period_spent_string]
period_summary.Loans = ["Period Loans", period_loans]
period_summary.Burn_Rate = ["Period Burn Rate", period_burn_rate_string]
period_summary.Unitemized_Rate = ["Period % Unitemized Donations", period_small_dollar_rate_string]
period_summary.Cash_on_Hand = ["Period Cash on Hand", period_coh]
CSV.write("Most_Recent_Campaign_Finance_Numbers.csv", period_summary)

#Total Summary
total_raised_string = form_3_11e[3][1].text
total_raised_float = parse(Float64, total_raised_string)
total_spent_string = form_3_22[3][1].text
total_spent_float = parse(Float64,total_spent_string)
#total_unitemized_donations_string = form_3_11a_ii[3][1].text
total_loans = form_3_13c[3][1].text
total_burn_rate_float = 100.0*(total_spent_float/total_raised_float)
total_burn_rate_float = round(total_burn_rate_float, digits = 2)
total_burn_rate_string = string(total_burn_rate_float)*"%"
#total_unitemized_donations_float = parse(Float64, total_unitemized_donations_string)
#total_small_dollar_rate_float = 100.0*(total_unitemized_donations_float/total_raised_float)
#total_small_dollar_rate_float = round(total_small_dollar_rate_float, digits =  2)
#total_small_dollar_rate_string = string(total_small_dollar_rate_float) * "%"
total_coh = form_3_27[2][1].text
#Create DataFrame for CSV Export
total_summary = DataFrame()
total_summary.Raised = ["Total Raised", total_raised_string]
total_summary.Spent = ["Total Spent", total_spent_string]
total_summary.Loans = ["Total Loans", total_loans]
total_summary.Burn_Rate = ["Overall Burn Rate", total_burn_rate_string]
#total_summary.Unitemized_Rate = ["% Unitemized Donations", total_small_dollar_rate_string]
total_summary.Cash_on_Hand = ["Cash on Hand", total_coh]
CSV.write("Total_Campaign_Finance_Numbers.csv", total_summary)