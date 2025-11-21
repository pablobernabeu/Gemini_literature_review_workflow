# Scaling systematic reviews: A solo researcher's workflow with Gemini

An automated workflow for conducting large-scale systematic literature reviews using R, Scopus API, NotebookLM and Gemini. This workflow enables solo researchers to extract and synthesise data from hundreds of papers, saving 30+ hours per review.

## Overview

This workflow addresses the challenge of extracting multiple data points (methodology, sample size, findings, etc.) from large corpora of academic papers. It shifts the researcher's role from manual data extractor to high-level synthesiser.

### Key Benefits

- **Efficiency**: Processes 500+ papers that would traditionally require a large team
- **Scalability**: Batch processing with validation ensures consistency across large datasets
- **Focus**: Frees cognitive capacity for synthesis and insight rather than manual extraction

## Workflow

![Workflow diagram](https://raw.githubusercontent.com/pablobernabeu/Gemini_literature_review_workflow/main/Gemini_showcase_presentation/workflow_diagram.png)

1. **Scoping**: Identify publications using Scopus API in R (`rscopus_plus`)
2. **Curation**: Download PDFs for each publication
3. **Extraction**: Upload PDFs to NotebookLM in batches of 30 with structured prompts
4. **Validation**: Manually verify ~10% of extracted data; refine prompts if needed
5. **Synthesis**: Upload validated spreadsheet to Gemini for trend analysis
6. **Drafting**: Use Gemini to draft initial review sections
7. **Finalising**: Human-led writing and final analysis

## Setup Instructions

1. Install required R packages:

   ```R
   install.packages('devtools')
   library(devtools)
   devtools::install_github('pablobernabeu/rscopus_plus')
   library(rscopus_plus)
   ```

2. Configure Scopus API credentials and run `Scopus_search.R`

3. Process papers through NotebookLM using detailed prompts (see workflow above)

## Key Files

- `R/Scopus_search.R`: Scopus API search and DOI retrieval
- `R/merge_references_preprocessing.R`: Merges Scopus and NotebookLM outputs
- `Gemini_showcase_presentation/workflow_diagram.R`: Visual workflow representation
- `lit_review.Rproj`: RStudio project file

## Validation & Best Practices

- **Batch size limit**: Process ≤30 papers per NotebookLM batch to prevent omissions
- **Prompt engineering**: Use detailed, specific prompts to minimise hallucinations
- **Human validation**: Essential for accuracy—this is an accelerator, not autopilot
- **Prompt refinement**: If validation fails, refine prompts and reprocess all batches for consistency

## Background References

Bernabeu, P. (2024). *rscopus_plus*. OSF. <https://doi.org/10.17605/OSF.IO/BUZQ6>

Malik, M., & Sime, J. A. (2025). Teamwork, co-Regulation, and socially shared regulation skills within engineering education studies: A GenAI-assisted scoping review. ASEE Annual Conference & Exposition, Montreal, Quebec, Canada. <https://doi.org/10.18260/1-2--57199>

