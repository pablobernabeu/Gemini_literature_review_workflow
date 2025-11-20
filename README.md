# Literature Review Project (R)

This project is set up for conducting a literature review using R. It integrates Pablo Bernabeu's `rscopus_plus` functions from GitHub and the NotebookLM.

## Setup Instructions

1. Install required R packages:

   - `devtools` (for installing from GitHub)
   - `remotes` (if needed)

2. Install `rscopus_plus` from GitHub:

   ```R
   # Install devtools if not already installed
   install.packages('devtools')
   library(devtools)
   # Install rscopus_plus
   devtools::install_github('pablobernabeu/rscopus_plus')
   library(rscopus_plus)
   ```

3. Perform Scopus search in `Scopus_search.R`.

## Files

- `Scopus_search.R`: Main script for literature review workflow.
- `.Rproj`: RStudio project file for easy project management.

## References

Bernabeu, P. (2024). *rscopus_plus*. OSF. https://doi.org/10.17605/OSF.IO/BUZQ6

Malik, M., & Sime, J. A. (2025). Teamwork, co-Regulation, and socially shared regulation skills within engineering education studies: A GenAI-assisted scoping review. ASEE Annual Conference & Exposition, Montreal, Quebec, Canada. https://doi.org/10.18260/1-2--57199

