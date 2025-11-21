# Install and use styler package for R code formatting

# Install styler if not already installed
if (!require(styler, quietly = TRUE)) {
  install.packages("styler")
  library(styler)
}

cat("🎨 R CODE FORMATTER SETUP\n")
cat("=" = 30, "\n\n")

# Format the current Scopus_search.R file
cat("Formatting Scopus_search.R...\n")
styler::style_file("Scopus_search.R")

cat("✅ Scopus_search.R has been formatted!\n\n")

# Function to format all R files in the directory
format_all_r_files <- function() {
  r_files <- list.files(pattern = "\\.R$", full.names = TRUE)

  cat("Found", length(r_files), "R files to format:\n")
  for (file in r_files) {
    cat("  -", basename(file), "\n")
  }
  cat("\n")

  for (file in r_files) {
    cat("Formatting", basename(file), "...\n")
    styler::style_file(file)
  }

  cat("\n✅ All R files have been formatted!\n")
}

# Uncomment the line below to format all R files at once
# format_all_r_files()

cat("💡 MANUAL FORMATTING:\n")
cat("To format any R file manually, run:\n")
cat("styler::style_file('filename.R')\n\n")

cat("📁 To format all R files in this directory, run:\n")
cat("format_all_r_files()\n\n")

cat("⚙️  AUTOMATIC FORMATTING:\n")
cat("The VS Code settings have been configured to auto-format on save.\n")
cat("If it's not working, try:\n")
cat("1. Reload VS Code window (Ctrl+Shift+P -> 'Developer: Reload Window')\n")
cat("2. Check that R Language Server is running\n")
cat("3. Use manual formatting with styler package\n")
