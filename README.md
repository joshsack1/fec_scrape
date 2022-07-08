# fec_scrape
Julia HTML scraper to pull fec form 3 data
# How To Use
Navigate to the directory that you have cloned this reposetory to in your terminal.
In Julia, activate the package manager with the close braket charachter `]`
Activate the project with the 
```Julia
(@v.17) pkg > activate .
```
Exit the package manager with the delete or backspace key
run the file you want to with the `include()` command:
Then paste the url of the uploaded form. 
## To Scrape the Main Body of a Form 3
```Julia
julia> include("form_3_main.jl")
```

## To Scrape the Summary of a Form 3
```Julia
julia> include("form_3_summary_search.jl")

# Flags
The main body scraper has only been validated with Pelosi's Q1 filing, while the summary scraper has only been validated with Kiggans' Q1 filing
