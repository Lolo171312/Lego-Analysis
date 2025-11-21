# Lego Data Analysis
This project represents a complete, end-to-end data analysis workflow designed to uncover the hidden market strategies and consumer trends within the official LEGO set catalogue.

## Project Goal
The primary objective was to move beyond simple product listings and analyze complex relationships between key variables—Price, Number of Pieces, Rating, and Theme—to answer fundamental questions about the LEGO market:
- **Pricing Strategy**: Which themes are most cost-efficient (lowest price per piece) versus which themes are driven by premium/licensing costs?
- **Market Focus**: Which themes show the highest variability in price (Standard Deviation/Coefficient of Variation), indicating they target the widest financial range of customers?
- **Audience Targeting**: How do factors like Age Rating and Average Set Size correlate with customer satisfaction (Rating)?

## Technical Workflow and Stack
### Data Collection | Python, Selenium and Pandas
Overcame Client-Side Rendering challenges (React/JavaScript) by simulating a full browser environment to dynamically scrape the entire catalogue, achieving accurate data extraction where standard requests failed.
### Data Processing & Analysis | SQL (MySQL/PostgreSQL Syntax)
Performed rigorous analytical querying and data validation. Key calculations included: Price per Piece (PPP), Coefficient of Variation (CV) for price volatility, Theme Rankings and using the Pearson Correlation Coefficient to statistically verify the relationship between set size and customer rating.
### Visualization & Reporting | PowerBI, DAX
Developed an interactive, multi-page dashboard to communicate findings. Implemented custom DAX logic for: creating Theme Segmentations and calculating Rating Relativity


## Key Findings
The analysis successfully challenged initial assumptions, confirming that:
- **Rarity Over Royalty**: Piece size and uniqueness (e.g., Duplo) often drive the PPP metric more significantly than licensing fees (though licenses contribute a noticeable premium).
- **Segmentation Strategy**: High-volume themes like Star Wars and Batman exhibit the highest price variance, demonstrating a robust strategy to appeal to both child and adult collector markets.
- **Customer Expectation**: A weak negative correlation exists between set size and rating, confirming that customer expectations increase significantly as the size and cost of a set grow.
