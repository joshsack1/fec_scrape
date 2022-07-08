using HTTP, Gumbo, Cascadia, CSV, DataFrames

#Save the url of the summary page
println("Enter the url for the committee's latest fling")
url = readline()
#Request the HTML
full_page = HTTP.get(url)
#Parse the page
parsed_page = parsehtml(String(full_page.body))
#Pull the summary table
summary_page = parsed_page.root[2][5][28]

#Break out data from summary table
total_contributions = summary_page[2][3]
total_expenditures = summary_page[2][7]
cash_on_hand = summary_page[2][10]
#debt = summary_page[2][13]

#Sort data to export
period_contributions = total_contributions[2][1].text
period_expenditures = total_expenditures[2][1].text
period_cash_on_hand = cash_on_hand[2][1].text

cycle_contributions = total_contributions[3][1].text
cycle_expenditures = total_expenditures[3][1].text
cycle_cash_on_hand = cash_on_hand[2][1].text

#Create DataFrames
period_summary = DataFrame()
period_summary.Contributions = [period_contributions]
period_summary.Expenditures = [period_expenditures]
period_summary.Cash_On_Hand = [period_cash_on_hand]

total_summary = DataFrame()
total_summary.Contributions = [cycle_contributions]
total_summary.Expenditures = [cycle_expenditures]
total_summary.Cash_On_Hand = [cycle_cash_on_hand]

#Export DataFrames
CSV.write("Most_Recent_Campaign_Finance_Numbers.csv", period_summary)
CSV.write("Cycle_Campaign_Finance_Numbers.csv", total_summary)