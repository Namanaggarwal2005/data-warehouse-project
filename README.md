# 📊 Data Warehouse (DWH) Project

## 🚀 Overview

This repository contains a complete **Data Warehouse (DWH)** project designed to store, transform, and analyze structured data efficiently. The goal is to enable **business insights, reporting, and historical analysis** using ETL pipelines and dimensional modeling.

---

## 🧱 Project Architecture

The project follows a standard DWH architecture:

```
Source Data (CSV / APIs / DB)
        ↓
ETL Process (Extract → Transform → Load)
        ↓
Staging Layer
        ↓
Data Warehouse (Fact & Dimension Tables)
        ↓
Reporting / Analysis
```

---

## ⚙️ Technologies Used

* SQL (for data modeling & querying)
* CSV files (data source)
* ETL scripts (custom / batch processing)
* GitHub (version control)

---

## 📂 Repository Structure

```
├── data/                 # Raw CSV files
├── staging/              # Cleaned & transformed data
├── warehouse/            # Final fact & dimension tables
├── scripts/              # ETL scripts
├── batch/                # Monthly batch processing files
├── docs/                 # Documentation
└── README.md             # Project documentation
```

---

## 🔄 ETL Process

### 1. Extract

* Data is collected from CSV files or other sources.

### 2. Transform

* Data cleaning (handling nulls, duplicates)
* Data formatting
* Applying business rules
* Slowly Changing Dimensions (SCD Type 1)

### 3. Load

* Data is loaded into:

  * **Fact Tables** → transactional data
  * **Dimension Tables** → descriptive attributes

---

## 📅 Batch Processing

* Data is processed in **monthly batches**.
* Each batch updates the warehouse with new records.
* Helps in handling **large CSV files efficiently** instead of loading everything at once.

👉 Batch files are organized month-wise (see project files). 

---

## 📊 Data Modeling

### ⭐ Fact Tables

* Store measurable data (e.g., sales, orders)

### 📘 Dimension Tables

* Store descriptive data (e.g., customer, product, time)

---

## 🔑 Key Concepts Used

* ETL Pipelines
* Star Schema
* SCD Type 1
* Data Partitioning
* Batch Processing

---

## 📈 Use Cases

* Monthly and yearly sales analysis
* Customer behavior tracking
* Trend analysis
* Business intelligence reporting

---

## 🛠️ How to Run

1. Clone the repository:

   ```bash
   git clone <repo-url>
   ```

2. Load raw CSV data into `/data`

3. Query the warehouse using SQL

---

## 📌 Future Improvements

* Automate ETL with scheduling tools (e.g., Airflow)
* Add incremental loading
* Integrate dashboards (Power BI / Tableau)
* Optimize performance with indexing & partitioning

---

## 👨‍💻 Author

Naman Aggarwal

---
This project is for educational purposes.

