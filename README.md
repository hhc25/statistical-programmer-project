# statistical-programmer-project

# Clinical Oncology SAS Project

This project simulates the end-to-end clinical trial data programming workflow using SAS. It includes the creation of SDTM and ADaM datasets from raw data, and the generation of TLF outputs (Tables, Listings, and Figures), all aligned with CDISC standards.

---

## Project Objectives

- Build mock clinical trial datasets based on oncology data structure
- Convert raw data into SDTM datasets according to CDISC structure
- Create ADaM datasets for subject-level, adverse event, and exposure analysis
- Generate Tables, Listings, and Figures for safety reporting

---

## Project Structure

```
clinical-oncology-sas-project/
├── 1_raw_data/          # Raw data inputs (CSV files)
├── 2_sdtm/              # SDTM SAS programs (AE, DM, EX, etc.)
├── 3_adam/              # ADaM datasets (ADSL, ADAE, ADEX)
├── 4_tlf/
│   ├── t_*.sas          # Table programs (e.g., AE summaries)
│   ├── l_*.sas          # Listing programs (e.g., AE/CM listings)
│   ├── f_*.sas          # Figure programs (e.g., bar charts)
│   └── output/          # RTF/PNG outputs
└── README.md            # Project documentation
```

---

## Technologies Used

- **Base SAS**: Data step, PROC SQL, PROC REPORT
- **ODS RTF**: Reporting and table output
- **SGPLOT**: Statistical graphics (bar charts, stacked bars)
- **CDISC Standards**: SDTM (AE, DM, EX, CM, LB, TU), ADaM (ADSL, ADAE, ADEX, ADLB)

---

## Outputs

- **Tables**

  - T14.1.1: Adverse Event Summary by Preferred Term
  - T14.1.2: Serious Adverse Event Summary
  - T14.1.3: Grade ≥3 Adverse Event Summary

- **Listings**

  - L14.2.1: AE Listing
  - L14.2.2: Concomitant Medications Listing

- **Figures**
  - F14.1: Top 10 Adverse Events (Grouped Bar Chart)
  - F14.2: CTCAE Grade Distribution (Stacked Bar Chart)

---

## For

- Entry-level statistical programmers building clinical trial portfolios
- Clinical SAS learners practicing SDTM/ADaM development
- Anyone seeking end-to-end TLF experience aligned with industry standards
