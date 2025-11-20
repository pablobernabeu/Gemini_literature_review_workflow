# ==============================================================================
# Merge References Preprocessing Script
# ==============================================================================
#
# This script merges two datasets:
# 1. rscopus_plus output: References retrieved from Scopus API
# 2. NotebookLM output: Systematic review data organized manually
#
# MERGE STRATEGY: For overlapping variables, rscopus data takes priority
# over NotebookLM data, with NotebookLM serving as fallback when rscopus is missing.
#
# ==============================================================================

# Load required libraries
library(dplyr)
library(readr)
library(stringr)
library(lubridate)
library(tidyr)

# Set working directory
setwd("c:/Users/pablob/OneDrive - Nexus365/Documents/GitHub/language-vision-semanticpriming/lit_review")

# ==============================================================================
# 1. READ INPUT FILES
# ==============================================================================

cat("Loading input files...\n")

# Load rscopus_plus reference data (original search results)
scopus_refs <- read_csv("references_for_review_input_2025-08-29.csv",
    show_col_types = FALSE
)

# Load NotebookLM systematic review data (manually organized)
notebookLM_data <- read_csv("NotebookLM output.csv",
    show_col_types = FALSE
)

cat("Scopus references loaded:", nrow(scopus_refs), "records\n")
cat("NotebookLM data loaded:", nrow(notebookLM_data), "records\n")

# ==============================================================================
# 2. DATA PREPARATION AND CLEANING
# ==============================================================================

cat("\nPreparing data for merge...\n")

# Clean filename columns for matching
scopus_refs <- scopus_refs %>%
    mutate(
        # Clean filename - remove .pdf extension if present
        filename_clean = str_replace(filename, "\\.pdf$", ""),
        # Create matching key
        match_key = str_to_lower(str_trim(filename_clean))
    )

notebookLM_data <- notebookLM_data %>%
    mutate(
        # Clean filename - remove .pdf.pdf or .pdf extensions
        filename_clean = str_replace_all(filename, "\\.pdf(\\.pdf)?$", ""),
        # Create matching key
        match_key = str_to_lower(str_trim(filename_clean))
    )

# Check for potential matches
cat("Sample filename formats:\n")
cat("Scopus:", head(scopus_refs$filename_clean, 3), "\n")
cat("NotebookLM:", head(notebookLM_data$filename_clean, 3), "\n")

# ==============================================================================
# 3. DATA CONSOLIDATION - STANDARDIZE NA VALUES
# ==============================================================================

cat("\nConsolidating NA-equivalent values in NotebookLM data...\n")

# Define NA-equivalent values to replace with blank cells
na_equivalents <- c(
    "NA", "N/A", "Not applicable", "Not found", "Not mentioned",
    "Not stated", "Not specified", "Not explicitly detailed",
    "Not detailed", "Not explicitly titled", "Not explicitly detailed in excerpts",
    "Not detailed in excerpts", "None mentioned", "None explicitly detailed",
    "None explicitly mentioned", "Not applicable", "Not found",
    "Not explicitly stated", "Not explicitly measured"
)

# Function to standardize NA values
standardize_na <- function(x) {
    # Convert to character if not already
    if (!is.character(x)) {
        x <- as.character(x)
    }

    # Replace NA-equivalent values with actual NA
    x[is.na(x) | str_trim(x) == "" | str_trim(x) %in% na_equivalents] <- NA_character_

    return(x)
}

# Apply standardization to all character/text columns in NotebookLM data
notebookLM_data <- notebookLM_data %>%
    mutate(
        # Apply to all relevant columns that might contain NA-equivalent values
        across(where(is.character), standardize_na),
        # Also handle any remaining logical or numeric columns that might have "NA" as text
        across(everything(), ~ ifelse(as.character(.x) %in% na_equivalents, NA, .x))
    )

# Report consolidation results
na_count_after <- notebookLM_data %>%
    summarise(across(everything(), ~ sum(is.na(.x)))) %>%
    pivot_longer(everything(), names_to = "column", values_to = "na_count") %>%
    summarise(total_na = sum(na_count))

cat("NA consolidation completed. Total NA values after standardization:", na_count_after$total_na, "\n")

# ==============================================================================
# 4. MERGE DATASETS
# ==============================================================================

cat("\nMerging datasets...\n")

# Perform left join to keep all Scopus references and add NotebookLM data where available
merged_data <- scopus_refs %>%
    left_join(notebookLM_data,
        by = "match_key",
        suffix = c("_scopus", "_notebook")
    )

# Check merge success
cat("Merged dataset contains:", nrow(merged_data), "records\n")
cat("Records with NotebookLM data:", sum(!is.na(merged_data$relevance_rating)), "\n")
cat("Records without NotebookLM data:", sum(is.na(merged_data$relevance_rating)), "\n")

# Check column names after merge to debug
cat("Column names in merged data:\n")
print(names(merged_data))

# ==============================================================================
# 5. COLUMN HARMONIZATION AND INTEGRATION
# ==============================================================================

cat("\nHarmonizing columns...\n")

# Reconcile overlapping columns
merged_data <- merged_data %>%
    mutate(
        # Use the most complete filename
        filename_final = case_when(
            !is.na(filename_scopus) ~ filename_scopus,
            !is.na(filename_notebook) ~ filename_notebook,
            TRUE ~ "unknown"
        ),

        # Use Scopus title first, then NotebookLM title as fallback
        title_final = case_when(
            !is.na(title_scopus) ~ title_scopus,
            !is.na(title_notebook) & str_length(title_notebook) > 10 ~ title_notebook,
            TRUE ~ title_scopus
        ),

        # Reconcile exclusion reasons - prioritize Scopus data
        exclusion_reason_final = case_when(
            !is.na(exclusion_reason_scopus) ~ exclusion_reason_scopus,
            !is.na(exclusion_reason_notebook) ~ exclusion_reason_notebook,
            TRUE ~ NA_character_
        ),

        # Add data source indicator
        data_source = case_when(
            !is.na(relevance_rating) ~ "Both (Scopus + NotebookLM)",
            TRUE ~ "Scopus only"
        ),

        # Create comprehensive exclusion flag
        excluded = case_when(
            !is.na(exclusion_reason_final) ~ TRUE,
            pdf_missing == "X" ~ TRUE,
            TRUE ~ FALSE
        ),

        # Combine overlapping columns - prioritize rscopus data first
        experiment_ID = coalesce(experiment_ID_scopus, experiment_ID_notebook),
        number_of_participants = coalesce(number_of_participants_scopus, number_of_participants_notebook),
        number_of_trials = coalesce(number_of_trials_scopus, number_of_trials_notebook),
        statistical_method = coalesce(statistical_method_scopus, statistical_method_notebook),
        power_analysis_method = coalesce(power_analysis_method_scopus, power_analysis_method_notebook),
        target_power = coalesce(target_power_scopus, target_power_notebook),
        required_participants_for_language = coalesce(required_participants_for_language_scopus, required_participants_for_language_notebook),
        required_participants_for_imagery = coalesce(required_participants_for_imagery_scopus, required_participants_for_imagery_notebook),
        required_trials_for_language = coalesce(required_trials_for_language_scopus, required_trials_for_language_notebook),
        required_trials_for_imagery = coalesce(required_trials_for_imagery_scopus, required_trials_for_imagery_notebook)
    )

# ==============================================================================
# 6. CREATE FINAL INTEGRATED DATASET
# ==============================================================================

cat("\nCreating final integrated dataset...\n")

# Select and organize final columns
final_dataset <- merged_data %>%
    select(
        # Core identification
        author1,
        year,
        title_final,
        publication,
        url,
        filename_final,

        # Review status
        data_source,
        excluded,
        exclusion_reason_final,
        pdf_missing,
        relevance_rating,

        # Study characteristics (NotebookLM data when available)
        experiment_ID,
        number_of_participants,
        number_of_trials,

        # Language measures (combined from both sources)
        language_of_testing,
        first_language,
        second_language,
        language_measure,
        first_second_language,
        lexical_or_semantic_task,
        individual_language_experience_measure,

        # Effects on language processing
        effect_of_language_on_semantic_processing,
        effect_size_of_language_on_semantic_processing,
        effect_of_individual_language_experience_on_semantic_processing,
        effect_size_of_individual_language_experience_on_semantic_processing,

        # Imagery measures
        imagery_measure,
        individual_imagery_experience_measure,
        effect_of_imagery_on_semantic_processing,
        effect_size_of_imagery_on_semantic_processing,
        effect_of_individual_imagery_experience_on_semantic_processing,
        effect_size_of_individual_imagery_experience_on_semantic_processing,

        # Statistical information
        statistical_method,
        power_analysis_method,
        target_power,
        required_participants_for_language,
        required_participants_for_imagery,
        required_trials_for_language,
        required_trials_for_imagery,

        # Other factors
        other_individual_differences
    ) %>%
    rename(
        title = title_final,
        filename = filename_final,
        exclusion_reason = exclusion_reason_final
    )

# ==============================================================================
# 7. DATA QUALITY CHECKS AND SUMMARY
# ==============================================================================

cat("\nGenerating data quality summary...\n")

# Summary statistics
summary_stats <- list(
    total_records = nrow(final_dataset),
    with_notebookLM_data = sum(final_dataset$data_source == "Both (Scopus + NotebookLM)"),
    scopus_only = sum(final_dataset$data_source == "Scopus only"),
    excluded_records = sum(final_dataset$excluded, na.rm = TRUE),
    missing_pdfs = sum(final_dataset$pdf_missing == "X", na.rm = TRUE),
    with_relevance_rating = sum(!is.na(final_dataset$relevance_rating)),
    with_participant_data = sum(!is.na(final_dataset$number_of_participants)),
    with_effect_sizes = sum(!is.na(final_dataset$effect_size_of_language_on_semantic_processing) |
        !is.na(final_dataset$effect_size_of_imagery_on_semantic_processing), na.rm = TRUE)
)

# Print summary
cat("\n=== MERGE SUMMARY ===\n")
cat("Total records:", summary_stats$total_records, "\n")
cat("Records with NotebookLM data:", summary_stats$with_notebookLM_data, "\n")
cat("Records from Scopus only:", summary_stats$scopus_only, "\n")
cat("Excluded records:", summary_stats$excluded_records, "\n")
cat("Missing PDFs:", summary_stats$missing_pdfs, "\n")
cat("With relevance ratings:", summary_stats$with_relevance_rating, "\n")
cat("With participant data:", summary_stats$with_participant_data, "\n")
cat("With effect sizes:", summary_stats$with_effect_sizes, "\n")

# Check for potential duplicate matches or issues
duplicate_matches <- final_dataset %>%
    group_by(filename) %>%
    filter(n() > 1) %>%
    select(filename, title, author1, year)

if (nrow(duplicate_matches) > 0) {
    cat("\nWARNING: Potential duplicate filenames detected:\n")
    print(duplicate_matches)
}

# ==============================================================================
# 8. SAVE MERGED DATASET
# ==============================================================================

# Generate output filename with timestamp
output_filename <- paste0("merged_references_", format(Sys.Date(), "%Y-%m-%d"), ".csv")

cat("\nSaving merged dataset to:", output_filename, "\n")

# Save the merged dataset
write_csv(final_dataset, output_filename)

# Save summary statistics
summary_filename <- paste0("merge_summary_", format(Sys.Date(), "%Y-%m-%d"), ".txt")
writeLines(c(
    "=== REFERENCE MERGE SUMMARY ===",
    paste("Date:", Sys.Date()),
    paste("Time:", Sys.time()),
    "",
    "INPUT FILES:",
    paste("- Scopus references:", "references_for_review_input_2025-08-29.csv"),
    paste("- NotebookLM data:", "NotebookLM output.csv"),
    "",
    "OUTPUT FILE:",
    paste("- Merged dataset:", output_filename),
    "",
    "SUMMARY STATISTICS:",
    paste("- Total records:", summary_stats$total_records),
    paste("- Records with NotebookLM data:", summary_stats$with_notebookLM_data),
    paste("- Records from Scopus only:", summary_stats$scopus_only),
    paste("- Excluded records:", summary_stats$excluded_records),
    paste("- Missing PDFs:", summary_stats$missing_pdfs),
    paste("- With relevance ratings:", summary_stats$with_relevance_rating),
    paste("- With participant data:", summary_stats$with_participant_data),
    paste("- With effect sizes:", summary_stats$with_effect_sizes),
    "",
    "MERGE SUCCESS RATE:",
    paste(
        "- Percentage with NotebookLM data:",
        round(100 * summary_stats$with_notebookLM_data / summary_stats$total_records, 1), "%"
    )
), summary_filename)

cat("Summary saved to:", summary_filename, "\n")

# ==============================================================================
# 9. GENERATE RECOMMENDED NEXT STEPS
# ==============================================================================

cat("\n=== RECOMMENDED NEXT STEPS ===\n")
cat("1. Review the merged dataset for data quality\n")
cat("2. Check records with 'Scopus only' status for potential manual data entry\n")
cat("3. Verify exclusion criteria are correctly applied\n")
cat("4. Consider creating filtered datasets for specific analyses\n")
cat("5. Update NotebookLM data for remaining unprocessed references\n")

# Create filtered datasets for common use cases
cat("\nCreating filtered datasets...\n")

# References with complete NotebookLM data
complete_refs <- final_dataset %>%
    filter(data_source == "Both (Scopus + NotebookLM)", !excluded) %>%
    arrange(desc(relevance_rating), desc(year))

write_csv(complete_refs, paste0("complete_references_", format(Sys.Date(), "%Y-%m-%d"), ".csv"))
cat("Complete references saved:", nrow(complete_refs), "records\n")

# References needing NotebookLM processing
pending_refs <- final_dataset %>%
    filter(data_source == "Scopus only", !excluded) %>%
    select(author1, year, title, filename, url, publication) %>%
    arrange(desc(year), author1)

write_csv(pending_refs, paste0("pending_for_notebookLM_", format(Sys.Date(), "%Y-%m-%d"), ".csv"))
cat("References pending NotebookLM processing:", nrow(pending_refs), "records\n")

cat("\n=== MERGE PREPROCESSING COMPLETED ===\n")
cat("Check the generated files and summary for next steps in your systematic review.\n")
