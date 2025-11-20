# Workflow Diagram for Gemini-Powered Literature Review
# Standalone R script for generating high-quality workflow visualisation

library(DiagrammeR)

# Create ZIGZAG workflow diagram with alternating upper/lower placement
workflow_diagram <- grViz("
digraph workflow {

  # Manual positioning with neato for zigzag pattern
  graph [
    layout = neato,
    bgcolor = 'transparent',
    overlap = false,
    pad = 1,
    splines = curved
  ]

  # MASSIVE nodes with ENORMOUS fonts and REDUCED padding
  node [
    shape = box,
    style = 'rounded,filled',
    fontname = 'Arial Bold',
    fontsize = 72,
    width = 7,
    height = 4,
    margin = 0.2,
    penwidth = 4
  ]

  # Zigzag layout: alternating upper and lower placement with OPTIMIZED vertical distance
  # Upper row: stages 1, 3, 5, 7 (y=12)
  # Lower row: stages 2, 4, 6 (y=-4)
  # Decision node in middle (y=4)
  # Total vertical separation: 16 units

  A [
    label = 'STAGE 1\n━━━━━━\nScopus API:\nIdentify\npublications',
    fillcolor = '#002147',
    fontcolor = white,
    fontsize = 70,
    pos = '0,12!'
  ]

  B [
    label = 'STAGE 2\n━━━━━━\nManually\ndownload\nPDFs',
    fillcolor = '#4E84C4',
    fontcolor = white,
    fontsize = 70,
    pos = '12,-4!'
  ]

  C [
    label = 'STAGE 3\n━━━━━━\nNotebookLM\nextraction\nwith 30 PDFs\nper batch',
    fillcolor = '#0071BC',
    fontcolor = white,
    fontsize = 70,
    pos = '24,12!'
  ]

  D [
    label = 'STAGE 4\n━━━━━━\nHuman\nvalidation of\n10–30% sample',
    fillcolor = '#009E73',
    fontcolor = white,
    fontsize = 70,
    pos = '36,-4!'
  ]

  H [
    label = 'Quality\ncheck\n━━━━━━\nAccurate?',
    shape = diamond,
    fillcolor = '#F4E8C1',
    fontcolor = black,
    fontsize = 64,
    width = 8,
    height = 8,
    penwidth = 6,
    pos = '46,4!'
  ]

  E [
    label = 'STAGE 5\n━━━━━━\nMerge CSVs.\nReview with\nGemini',
    fillcolor = '#0071BC',
    fontcolor = white,
    fontsize = 70,
    pos = '60,12!'
  ]

  F [
    label = 'STAGE 6\n━━━━━━\nDraft review\nwith Gemini',
    fillcolor = '#4E84C4',
    fontcolor = white,
    fontsize = 70,
    pos = '72,-4!'
  ]

  G [
    label = 'STAGE 7\n━━━━━━\nHuman\nfinalisation of\nthe review',
    fillcolor = '#002147',
    fontcolor = white,
    fontsize = 70,
    pos = '84,12!'
  ]

  # Invisible label node for YES Proceed
  YES_LABEL [
    label = 'ACCURATE:\nProceed',
    shape = plaintext,
    fontsize = 70,
    fontcolor = '#009E73',
    style = '',
    fillcolor = 'transparent',
    color = 'transparent',
    pos = '54,10!'
  ]

  # VERY thick edges with HUGE labels and ENORMOUS arrowheads
  A -> B [penwidth = 8, color = '#002147', arrowsize = 5]
  B -> C [penwidth = 8, color = '#002147', arrowsize = 5]
  C -> D [penwidth = 8, color = '#002147', arrowsize = 5]
  D -> H [penwidth = 8, color = '#002147', arrowsize = 5]

  H -> E [
    penwidth = 8,
    color = '#009E73',
    arrowsize = 5
  ]

  H -> C [
    label = '     INACCURATE:\n     Refine prompts\n     and rerun\n     all batches',
    fontsize = 70,
    penwidth = 8,
    color = red,
    fontcolor = red,
    arrowsize = 5,
    labeldistance = 3.5,
    labelangle = -20
  ]

  E -> F [penwidth = 8, color = '#002147', arrowsize = 5]
  F -> G [penwidth = 8, color = '#002147', arrowsize = 5]

}
")

# Display the diagram in RStudio viewer
print(workflow_diagram)

# Save as HTML using htmlwidgets (without pandoc requirement)
library(htmlwidgets)
# Get the directory of the current script (works both in RStudio and command line)
script_dir <- file.path(getwd(), "Gemini_showcase_presentation")
if (!dir.exists(script_dir)) {
  dir.create(script_dir, recursive = TRUE)
}
output_file <- file.path(script_dir, "workflow_diagram.html")
saveWidget(workflow_diagram, output_file, selfcontained = FALSE)

cat("\n=== ZIGZAG Workflow Diagram Generated ===\n")
cat("File saved:", output_file, "\n")
cat("Font size: 70-72pt (MASSIVE)\n")
cat("Node size: 8 x 4 inches (HUGE)\n")
cat("Edge thickness: 8px (VERY THICK)\n")
cat("Layout: ZIGZAG with OPTIMIZED vertical separation\n")
cat("Upper row: Stages 1, 3, 5, 7 (y=12)\n")
cat("Lower row: Stages 2, 4, 6 (y=-4)\n")
cat("Vertical distance: 16 units (REDUCED from 24)\n")
cat("Node margin: 0.2 (REDUCED from 1.0)\n")
cat("Decision node: Centered (y=4)\n")
cat("Colors: Oxford blue theme\n")
cat("\nOpening in browser...\n")

# Open the HTML file in default browser
tryCatch(
  {
    browseURL(normalizePath(output_file))
  },
  error = function(e) {
    cat("Browser open failed, but file saved successfully at:", normalizePath(output_file), "\n")
  }
)
