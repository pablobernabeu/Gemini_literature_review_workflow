1. Describe the task you used Gemini to support.

The task is supporting systematic literature reviews. Specifically, this involves extracting over 10 distinct data points (e.g., methodology, sample size, key findings) from a large corpus of academic papers, often numbering in the hundreds.


2. Explain how you approached this task before using any generative AI tools.

Prior to using generative AI, this was an entirely manual and laborious process. It involved opening each PDF individually and using a combination of keyword searches, visual scanning and in-depth reading to locate each specific data point. This information was then manually copied and pasted into a spreadsheet. The process was time-consuming, repetitive and prone to human error from fatigue.


3. Describe the impact of using Gemini on your productivity or efficiency.

The impact on productivity has been profound. For a typical review, this workflow saves an estimated 30+ hours of manual data extraction. NotebookLM's ability to process papers in batches and output structured data (which I merge into a spreadsheet) handles the most time-intensive part of the review.

This frees up significant cognitive capacity. Subsequently, I use Gemini to analyse the compiled spreadsheet, asking it to identify trends and draft introductory sections (e.g., 'Draft an introduction that summarizes the key gap in the literature'). This shifts my role from manual data extractor to high-level data synthesiser.


4. Provide any examples or illustrations of this impact.

The primary illustration of this impact is the development of a structured, multi-tool workflow:

- Scoping: Identify publications using the Scopus API in R.

- Curation: Manually download the PDF for each publication.

- Extraction (NotebookLM): Upload PDFs to NotebookLM in batches of 30. I found this limit prevents data being missed in the output. I include a detailed prompt that contextualises the task, lists the required data points and specifies a structured output format.

- Validation: Manually assess ~10% of the extracted data for accuracy. If unreliable, I refine the prompt and re-run all batches for consistency.

- Synthesis (Gemini): Upload the final, validated spreadsheet to Gemini to discuss key insights.

- Drafting (Gemini): Ask Gemini to draft initial sections of the review.

- Finalising: I take over the draft for final, human-led writing and analysis.


5. Reflect on any broader implications of changes to efficiency.

This efficiency gain has several broad implications, both positive and negative:

Positive: It democratises large-scale systematic literature reviews, enabling sole researchers or small teams to tackle reviews of 500+ papers, a scale previously requiring a large, coordinated team. It allows researchers to focus their efforts on high-level synthesis and insight rather than manual grunt work.

Negative/Challenges: This power demands new responsibilities. There is a clear risk of shallow or homogenised reviews if researchers blindly trust the output without rigorous validation. There is also a potential loss of the serendipitous discoveries that can arise from deep, manual reading of papers.


6. Explain any challenges or boundaries you faced while using Gemini.

The primary challenge is prompt engineering and output validation. I learned quickly that detailed, specific prompts are paramount to prevent model drift or hallucinations.

A key boundary I discovered in NotebookLM was file processing; attempting to process large batches (>30) resulted in some papers being omitted from the output spreadsheet. This forced me to adopt the smaller batch-processing workflow. Finally, the tool is only as good as the human validation—it's an accelerator, not an auto-pilot.


7. To what extent did Gemini meet your expectations for this task?

Initially, my expectations were low. I was wary of hallucinations and had never used GenAI to process a large corpus of files simultaneously. However, after a few revisions of my prompts, the output significantly exceeded my expectations in its accuracy and structure. This positive experience aligns with emerging research on GenAI-assisted reviews (e.g., Malik & Sime, 2025, https://doi.org/10.18260/1-2--57199), which validates its potential as a powerful research aid.


8. Did you share your approach or process with others?

Yes, I recently discussed this workflow with a PhD student at the University of Oxford who is developing a similar, API-driven approach. We compared our methods and agreed on the importance of human validation to benchmark the reliability of these new workflows. This suggests the process is not just valuable to me, but could be adapted, validated and shared to benefit a much wider academic audience.

