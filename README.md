# Data Mining Project Template

This repository contains the code for a small data mining project developed as part of the course:

**Data Access and Data Mining for Social Sciences**

University of Lucerne

Lindegger S.
Course: Data Mining for the Social Sciences using R
Term: Spring 2026

## Project Goal

The goal of this project is to collect and analyze data from an online source (API or web scraping) in order to answer a research question relevant to political or social science.

This specific project focuses of parliamentary affairs of the Swiss parliament. The main aim is to firstly, evaluate affairs that address democracy. Secondly, it aims to evaluate which security issues regarding democracy are addressed in parliamentary affairs. As a limitation of this course, the project only evaluates 5'000 affairs. Additionally, AI was used to categorise affairs regarding democracy as well as an analysis of the title and keywords regarding security issues.


## Research Question

What are the current security issues regarding Swiss democracy discussed in parliament?
How frequent are security security issues regarding Swiss democracy discussed in parliament?


## Data Source

Parlament.ch - Curia Visa : https://ws-old.parlament.ch/

THe data is firstly accessed by scraping the ID of all available affairs and connecting them to their according keywords. Originally, the idea was to draw the affair text from the identified affairs and evaluated, after the keywords are assessed

However, do to limitations of this research, the focus is on the title and keywords of 5'000 affairs rather than assessing the text. 


## Repository Structure

/data_preprocessed     output from working with raw data sets
/data_raw              dataset drawn from website
/scripts               scripts used to collect/process data

README.md               project description
.gitignore              


## Reproducibility

To reproduce this project:

1. Clone the repository
2. Install required R packages
3. Run the scripts in the `script/ folder
4. Connect R Studio to Claude API for evaluation

All data should be generated automatically by the scripts.

