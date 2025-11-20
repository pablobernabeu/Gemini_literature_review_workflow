# Quick Start Guide - Gemini Showcase Presentation

## Before the Event

### 1. Install R Packages (Run Once)

```r
# Core presentation packages
install.packages("xaringan")
install.packages("xaringanExtra")

# Data visualization packages
install.packages("ggplot2")
install.packages("dplyr")
install.packages("tidyr")
install.packages("DiagrammeR")
```

### 2. Add Logo Files

Place these two files in the presentation directory:

- `oxford_logo.png` (University of Oxford logo)
- `ai_competency_centre_logo.png` (AI Competency Centre logo)

### 3. Render the Presentation

**Option A - Infinite Moon Reader (Recommended for Development):**
```r
# Navigate to the presentation directory
setwd("path/to/Gemini_showcase_presentation/")

# Start infinite moon reader - it will auto-reload on save
xaringan::inf_mr("gemini_showcase_presentation.Rmd")
```

Benefits:
- ✅ Live preview in browser
- ✅ Auto-reloads when you save changes
- ✅ Perfect for editing and practicing
- ✅ See changes immediately

**Option B - RStudio Knit (For Final Version):**
1. Open `gemini_showcase_presentation.Rmd` in RStudio
2. Click the "Knit" button
3. The presentation will open in your browser

**Option C - R Console Render:**
```r
setwd("path/to/Gemini_showcase_presentation/")
rmarkdown::render("gemini_showcase_presentation.Rmd")
```

## Working with Infinite Moon Reader

### Development Workflow

1. **Start the server:**
```r
xaringan::inf_mr("gemini_showcase_presentation.Rmd")
```

2. **Edit your slides** in RStudio or your favorite editor

3. **Save the file** - the browser will auto-reload

4. **Navigate slides** in the preview to check your changes

5. **Stop the server** when done: Press `Ctrl+C` in the R console or close the console

### Tips for Using Infinite Moon Reader

- **Keep it running** while editing - changes appear instantly
- **Multiple monitors**: Keep preview on one screen, code on another
- **Browser sync**: The preview stays in sync with your file
- **Error checking**: Watch the R console for any rendering errors
- **Port conflicts**: If you get an error, another server may be running - restart R

## During the Presentation

### Essential Keyboard Shortcuts

| Key | Action |
|-----|--------|
| `→` or `Space` | Next slide |
| `←` | Previous slide |
| `O` | Tile view (overview of all slides) |
| `F` | Fullscreen |
| `P` | Presenter notes (toggle) |
| `C` | Clone slides (presenter mode) |
| `H` | Help (show all shortcuts) |
| `Esc` | Exit tile view/fullscreen |

### Panelset Navigation

On Slide 2 (The Solution), you have interactive tabs:
- Click on tab names to switch between panels
- Or use mouse to navigate through workflow stages

## Presentation Structure & Timing

**Total time: ~15 minutes (12 min presentation + 3 min Q&A)**

| Slide | Content | Time |
|-------|---------|------|
| Title | Introduction | 0:30 |
| Slide 1 | The Challenge | 2:00 |
| Slide 2 | The Solution (with panelsets) | 4:00 |
| Slide 3 | The Impact | 2:30 |
| Slide 4 | Key Learnings | 3:00 |
| Slide 5 | Knowledge Sharing | 2:00 |
| Closing | Questions | 3:00+ |
| Appendices | (if time permits) | Extra |

## Key Message Points

### Slide 1 - The Challenge
- **Problem**: Manual extraction of 10+ data points from 100-500+ papers
- **Impact**: 30+ hours of repetitive work prone to errors
- **Bottleneck**: Opening → Searching → Copy-pasting → Repeat

### Slide 2 - The Solution
**Six-stage workflow** (use panelsets to walk through):
1. Scoping (Scopus API)
2. Curation (Manual PDF collection)
3. Extraction (NotebookLM - 30 PDFs/batch)
4. Validation (10% sample check)
5. Synthesis (Gemini analysis)
6. Finalization (Human-led writing)

**Key insight**: Batch size of 30 PDFs prevents data loss

### Slide 3 - The Impact
- **Time savings**: 30+ hours saved per review
- **Scale transformation**: From 50 papers → 500+ papers feasible
- **Cognitive shift**: From data extractor → data synthesizer
- **Validation**: Supported by recent research (Malik & Sime, 2025)

### Slide 4 - Key Learnings
- **Prompt engineering is critical**: Detailed prompts prevent drift
- **Technical boundary**: 30 PDF batch limit in NotebookLM
- **Validation mandatory**: Check 10%, refine prompts, re-run ALL batches
- **Exceeded expectations**: Initially skeptical, now core to workflow

### Slide 5 - Knowledge Sharing
- Collaborated with Oxford PhD student
- Workflow is adaptable across disciplines
- Need for standardized validation protocols
- Open to sharing with wider research community

## Troubleshooting on the Day

### Presentation Won't Open
- Check internet connection (for Google Fonts)
- Try different browser (Chrome recommended)
- Have PDF backup ready

### Logos Missing
- Verify files are in correct directory
- Check spelling: `oxford_logo.png` (case-sensitive on some systems)
- Use placeholder text if needed

### Interactive Features Not Working
- Reload page
- Clear browser cache
- Continue without interactive features (content is accessible)

### Need to Print Handouts
- Open presentation in browser
- Print to PDF
- Select "Print background graphics"
- Choose 2 or 4 slides per page

## Backup Plan

If technical issues arise:
1. Have PDF version ready
2. Key points memorized for each slide
3. Workflow diagram on paper/tablet
4. Can present without slides if necessary

## Post-Presentation

### Sharing the Presentation
- HTML file can be shared directly
- Upload to web server or GitHub Pages
- Convert to PDF for easier distribution
- Consider recording a screencast

### Follow-up Materials
- Code repository: GitHub link ready
- Contact information on final slide
- Workflow documentation to share
- Validation protocols for interested researchers

## Questions to Anticipate

**Q: How accurate is the extraction?**
A: With proper prompts and validation, very accurate. I check 10% and found minimal errors after prompt refinement.

**Q: What about hallucinations?**
A: They occur but are caught in validation. Detailed prompts and structured output minimize risk.

**Q: Can this work for [other discipline]?**
A: Yes! The workflow is adaptable. Key is defining clear data points and validation criteria.

**Q: How much does it cost?**
A: NotebookLM is currently free. Main cost is researcher time for validation and refinement.

**Q: What about research integrity?**
A: Human validation is mandatory. AI accelerates extraction but doesn't replace critical analysis.

**Q: Can you share the prompts?**
A: Yes, I'm working on documenting and sharing the full workflow including prompt templates.

## Additional Resources

- Malik & Sime (2025): https://doi.org/10.18260/1-2--57199
- GitHub repository: [language-vision-semanticpriming]
- Contact: [Your email/contact info]

---

**Good luck with your presentation! 🎓**
