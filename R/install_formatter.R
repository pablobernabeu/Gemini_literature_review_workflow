# Install styler package for R formatting
if (!requireNamespace("styler", quietly = TRUE)) {
  install.packages("styler")
}

# Also install languageserver if not already installed
if (!requireNamespace("languageserver", quietly = TRUE)) {
  install.packages("languageserver")
}

cat("R formatting packages installed successfully!\n")
cat("styler version:", packageVersion("styler"), "\n")
cat("languageserver version:", packageVersion("languageserver"), "\n")
