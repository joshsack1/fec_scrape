using HTTP, Gumbo, Cascadia, CSV

#Pull Initial Data
#Set url
url = "https://docquery.fec.gov/cgi-bin/forms/C00213512/1585746/"
#Request html
request = HTTP.get(url)
#Parse HTLM
h = parsehtlm(String(r.body))

#Start pulling useful information
file_date_raw = h.root[2][5][20]