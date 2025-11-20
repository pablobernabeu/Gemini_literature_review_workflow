# Gemini Showcase Presentation - University of Oxford

This directory contains the xaringan presentation for the Gemini Pro Pilot showcase event at the University of Oxford.

## Files

- `gemini_showcase_presentation.Rmd` - Main R Markdown presentation file
- `oxford-blue.css` - Custom CSS theme with Oxford University blue color scheme
- `oxford-fonts.css` - Typography styling
- `README.md` - This file

## Required Setup

### 1. Install Required R Packages

```r
install.packages(c("xaringan", "xaringanExtra", "ggplot2", "dplyr", "tidyr", "DiagrammeR"))
```

### 2. Add Logo Images

You need to add two logo files to this directory:

1. **University of Oxford Logo**: Save as `oxford_logo.png`
   - Download from: University of Oxford brand guidelines
   - Recommended size: 400x400px or higher
   - Transparent background preferred

2. **AI Competency Centre Logo**: Save as `ai_competency_centre_logo.png`
   - Use the official AI Competency Centre logo
   - Recommended size: 400x400px or higher
   - Transparent background preferred

### 3. Render the Presentation with Infinite Moon Reader

**Recommended Method - Live Preview with Auto-Reload:**

```r
# In R console or RStudio:
xaringan::inf_mr("gemini_showcase_presentation.Rmd")
```

This will:
- Open the presentation in your browser
- Automatically reload when you save changes
- Provide a live preview for editing

**Alternative Method - One-time Render:**

```r
# In RStudio: Open the .Rmd file and click "Knit"
# Or in R console:
rmarkdown::render("gemini_showcase_presentation.Rmd")
```

## Presentation Features

### Interactive Elements (xaringanExtra)

- **Tile View**: Press `O` to see all slides at once
- **Progress Bar**: Track your position in the presentation
- **Panelsets**: Interactive tabbed content on workflow slides
- **Webcam**: Optional presenter webcam feature
- **Animations**: Smooth transitions and effects

### Navigation

- **Arrow keys**: Navigate between slides
- **P**: Toggle presenter notes
- **F**: Enter fullscreen mode
- **H**: Show keyboard shortcuts help
- **C**: Clone slides (for presenter view)

## Presentation Structure

1. **Title Slide**: Cover page with Oxford and AI Competency Centre logos
2. **Slide 1**: The Challenge - Traditional approach problems
3. **Slide 2**: The Solution - Multi-stage Gemini-powered workflow (with panelsets)
4. **Slide 3**: The Impact - Productivity gains and new capabilities
5. **Slide 4**: Key Learnings - Boundaries, challenges, and lessons
6. **Slide 5**: Knowledge Sharing - Collaboration and future directions
7. **Closing Slide**: Thank you and questions
8. **Appendices**: 
   - Workflow diagram
   - Impact metrics visualization

## Customization

### Changing Colors

Edit `oxford-blue.css` and modify the CSS variables at the top:

```css
:root {
  --oxford-blue: #002147;
  --oxford-light-blue: #4E84C4;
  --oxford-mid-blue: #0071BC;
  /* Add your custom colors */
}
```

### Adjusting Content

The presentation uses R Markdown with xaringan. Edit `gemini_showcase_presentation.Rmd`:

- Slides are separated by `---`
- Use `class:` to specify slide types
- Speaker notes go after `???`
- R code chunks generate dynamic content

### Font Sizes

For different screen sizes or venues, adjust in `oxford-fonts.css`:

```css
.remark-slide-content {
  font-size: 24px;  /* Change this value */
}
```

## Tips for Presenting

1. **Practice Navigation**: Get comfortable with the panelsets and transitions
2. **Test Setup**: Run the presentation on the venue's equipment beforehand
3. **Print Handouts**: Consider printing key slides as backup
4. **Prepare for Questions**: Review the workflow diagram and metrics
5. **Time Management**: Aim for 12-15 minutes to leave time for discussion

## Troubleshooting

### Logos Not Appearing

- Check that logo files are in the same directory as the .Rmd file
- Verify filenames match exactly: `oxford_logo.png` and `ai_competency_centre_logo.png`
- Ensure files are PNG format with transparency

### Presentation Won't Compile

- Verify all required packages are installed
- Check for R syntax errors in code chunks
- Ensure all file paths are correct

### Interactive Features Not Working

- Make sure you've loaded xaringanExtra in the setup chunk
- Test in a modern web browser (Chrome, Firefox, Edge)
- Some features require an internet connection

## Output

The compiled presentation will be an HTML file that can be:

- Viewed in any modern web browser
- Presented directly from your laptop
- Shared as a standalone file
- Converted to PDF (print to PDF from browser)

## Contact

For questions or issues with this presentation, contact Pablo Bernabeu.

## License

This presentation template is based on xaringan (MIT License) with custom styling for University of Oxford branding.
