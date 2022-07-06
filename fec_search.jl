using HTTP, Gumbo, Cascadia, CSV, DataFrames

#Pull Initial Data
#Set url
url = "https://docquery.fec.gov/cgi-bin/forms/C00213512/1585746/"
#Request html
request = HTTP.get(url)
#Parse HTLM
h = parsehtlm(String(request.body))

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