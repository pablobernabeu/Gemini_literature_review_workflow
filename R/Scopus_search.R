# Run `scopus_search` as many times as necessary based on the number of results,
# limited to limit of results per search allowed by my API quota (normally, 20).

library(dplyr)
library(stringr)
library(rscopus)
library(lubridate)

# Read in 'scopus_search_plus' function
source("https://raw.githubusercontent.com/pablobernabeu/rscopus_plus/main/scopus_search_plus.R")

# Note. Before running the current function, the user must read in their Scopus API key
# confidentially (see https://cran.r-project.org/web/packages/rscopus/vignettes/api_key.html).
# An error will be thrown if there's no Scopus API key registered.

search_period <- "1900-2030"

# Compose search query

semantic_processing <- paste(
  "TITLE-ABS-KEY(",
  '"semantic processing" OR',
  '"conceptual processing" OR',
  '"word comprehension" OR',
  '"semantic priming" OR',
  '"semantic decision" OR',
  '"semantic judgement" OR', # British spelling
  '"semantic judgment" OR', # American spelling
  '"semantic richness" OR',
  '"lexical decision"',
  ")"
)

language_experience <- paste(
  "ALL(",
  '"vocabulary size" OR',
  '"vocabulary knowledge" OR',
  '"vocabulary experience" OR',
  '"vocabulary skills" OR',
  '"vocabulary ability" OR',
  '"vocabulary dexterity" OR',
  '"reading experience" OR',
  '"reading skills" OR',
  '"reading ability" OR',
  '"reading dexterity" OR',
  '"language experience" OR',
  '"language skills" OR',
  '"language ability" OR',
  '"language dexterity" OR',
  '"linguistic experience" OR',
  '"linguistic skills" OR',
  '"linguistic ability" OR',
  '"linguistic dexterity" OR',
  '"individual differences in vocabulary" OR',
  '"individual differences in reading" OR',
  '"individual differences in language" OR',
  '"individual differences in linguistic" OR',
  '("first language" AND "second language")',
  ")"
)

imagery_experience <- paste(
  "ALL(",
  '"Plymouth Sensory Imagery Questionnaire" OR',
  '"Vividness of Visual Imagery Questionnaire" OR',
  '"mental comparison task" OR',
  '"perceptual acuity" OR',
  '"perceptual experience" OR',
  '"perceptual skills" OR',
  '"perceptual ability" OR',
  '"perceptual dexterity" OR',
  '"visual acuity" OR',
  '"visual experience" OR',
  '"visual skills" OR',
  '"visual ability" OR',
  '"visual dexterity" OR',
  '"imagery acuity" OR',
  '"imagery experience" OR',
  '"imagery skills" OR',
  '"imagery ability" OR',
  '"imagery dexterity" OR',
  '"simulation experience" OR',
  '"simulation skills" OR',
  '"simulation ability" OR',
  '"simulation dexterity" OR',
  '"embodiment experience" OR',
  '"embodiment skills" OR',
  '"embodiment ability" OR',
  '"embodiment dexterity" OR',
  '"individual differences in perception" OR',
  '"individual differences in vision" OR',
  '"individual differences in visual" OR',
  '"individual differences in imagery" OR',
  '"individual differences in simulation" OR',
  '"individual differences in embodiment"',
  ")"
)

query <- paste(
  'TITLE-ABS-KEY("individual differences") AND', semantic_processing,
  "AND (", language_experience, "OR", imagery_experience, ")"
)

# Perform search
results <- scopus_search_plus(query, search_period, 20)

# Transform date column to year
if ("date" %in% names(results)) {
  results <- results %>%
    mutate(date_parsed = suppressWarnings(lubridate::parse_date_time(date, c("ymd", "mdy", "dmy", "y", "ym")))) %>%
    mutate(year = lubridate::year(date_parsed)) %>%
    select(-date_parsed) # Remove the intermediate parsed date, keep only year
} else {
  cat("Warning: 'date' column not found. Available columns:", paste(names(results), collapse = ", "), "\n")
}

# Arrange columns and save to spreadsheet
results %>%
  rename(author1 = author) %>% # Rename author column for accuracy
  mutate(
    url = paste0("https://doi.org/", doi),
    filename = paste0(
      word(author1, 1),
      "_",
      year,
      "_",
      paste(word(title, 1), word(title, 2), word(title, 3), sep = "_"),
      ".pdf"
    ),
    exclusion_reason = NA_character_,
    experiment_ID = NA_character_,
    relevance_rating = NA_real_,
    number_of_participants = NA_real_,
    number_of_trials = NA_real_,
    language_of_testing = NA_character_,
    first_language = NA_character_,
    second_language = NA_character_,
    semantic_task = NA_character_,
    individual_language_experience_measure = NA_character_,
    effect_of_individual_language_experience_on_semantic_processing = NA_real_,
    effect_size_of_individual_language_experience_on_semantic_processing = NA_character_,
    individual_imagery_experience_measure = NA_character_,
    effect_of_individual_imagery_experience_on_semantic_processing = NA_real_,
    effect_size_of_individual_imagery_experience_on_semantic_processing = NA_character_,
    other_individual_differences = NA_character_,
    statistical_method = NA_character_,
    power_analysis_method = NA_character_,
    target_power = NA_real_,
    required_participants_for_language = NA_real_,
    required_participants_for_imagery = NA_real_,
    required_trials_for_language = NA_real_,
    required_trials_for_imagery = NA_real_
  ) %>%
  select(
    author1, year, title, publication, url, filename, exclusion_reason,
    experiment_ID, relevance_rating, number_of_participants, number_of_trials,
    language_of_testing, first_language, second_language, semantic_task,
    individual_language_experience_measure,
    effect_of_individual_language_experience_on_semantic_processing,
    effect_size_of_individual_language_experience_on_semantic_processing,
    individual_imagery_experience_measure,
    effect_of_individual_imagery_experience_on_semantic_processing,
    effect_size_of_individual_imagery_experience_on_semantic_processing,
    other_individual_differences, statistical_method, power_analysis_method,
    target_power, required_participants_for_language,
    required_participants_for_imagery, required_trials_for_language,
    required_trials_for_imagery
  ) %>%
  # Save to CSV file to allow manually inputting the results of the review.
  write.csv(paste0("intermediate_output/references_before_NotebookLM_input_", Sys.Date(), ".csv"), row.names = FALSE)
