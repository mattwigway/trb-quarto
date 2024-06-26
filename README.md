
# TRB Quarto format

This is a [Quarto](https://quarto.org) template for creating Transportation Research Board annual meeting articles.

## Creating a New Article

To create a new article using this format:

```bash
quarto use template mattwigway/trb-quarto
```

This will create a new directory with an example document that uses this format.

## Using with an Existing Document

To add this format to an existing document:

```bash
quarto add mattwigway/trb-quarto
```

Then, add the format to your document options:

```yaml
format:
  trb-pdf: default
```

## Author block

In your YAML metadata, you need to include all of the affiliation information for each author, e.g.:

```yaml
authors:
  - name: Matthew Wigginton Bhagat-Conway
    affiliations:
      - name: University of North Carolina at Chapel Hill
        department: Department of City and Regional Planning
        address: "223 E Cameron Ave, CB #3140"
        city: Chapel Hill
        state: NC
        country: USA
        postal-code: 27599
    orcid: 0000-0002-1210-2982
    email: mwbc@unc.edu
```

## Word count

Words and tables are counted automatically; words in tables do not count towards the total word count, and neither does the title page. Word counting is based on Andrew Heiss's [quarto-wordcount](https://github.com/andrewheiss/quarto-wordcount). You can override the word count by setting `nwords: number_of_words` in your YAML front matter, and `ntables: number_of_tables` likewise. The word count should be reliable, however the table count may fail to detect some tables depending on how they are represented in the Quarto document.

## Page header

By default, the page header is generated automatically, listing family names of all authors if there are three or fewer, and the first author et al. if there are more. You can override this by specifying `authorheader: "Desired header"` in your YAML front matter.

## Submission date

You need to include a `date` field in your YAML front matter.

## Abstract and keywords

Include an `abstract:` and `keywords:` in your YAML front matter.

## Example

Here is the source code for a minimal sample document: [template.qmd](template.qmd).

