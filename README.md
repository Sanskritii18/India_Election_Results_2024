# 🗳️ India Election Results 2024 - Data Analysis & Dashboard

This project presents a comprehensive SQL-based analysis and an interactive Power BI dashboard to explore the **2024 Indian General Election** results. The goal is to deliver data-driven insights on seat distribution, party alliances, voting patterns, and state-wise performance.

---

## 📂 Project Structure

- `India_Election_Results_2024_SQL.sql`: Contains SQL scripts to create the schema, load data, and perform a wide variety of analytical queries on the election results.
- `India Election 2024 Dashboard.pbix`: Power BI dashboard providing visual insights like:
  - Total Seats Won by Party and Alliance
  - State-wise and Constituency-wise Breakdown
  - Alliance Comparison (NDA vs I.N.D.I.A vs Others)
  - EVM vs Postal Vote Comparison
  - Winning & Runner-up Candidate Analysis

---

## 🧠 Key SQL Insights

Some of the core analytical queries in the SQL script:
- Total seats and state-wise seat availability.
- Seat wins by major alliances: **NDA**, **I.N.D.I.A**, and **OTHERS**.
- Top 10 candidates by EVM votes.
- Party-wise wins in each state.
- Runner-up vs winner comparison in every constituency.
- Maharashtra-specific total votes and seat analysis.

---

## 📊 Power BI Dashboard Features

- Interactive slicers by State and Party
- Drill-through pages for deep-dives on constituencies
- Alliance-wise maps and charts
- Comparative insights on vote types (EVM vs Postal)

---

## 🛠️ Tech Stack

- **MySQL 8.0** – Data preparation and querying
- **Power BI** – Visual analytics and storytelling
- **CSV Uploads** – Simulated real-world data loading using `LOAD DATA INFILE`

---

## 📁 How to Use

### 1. SQL Setup
- Run `India_Election_Results_2024_SQL.sql` in MySQL Workbench.
- Ensure your `secure_file_priv` path is properly set to load CSVs.

### 2. Power BI Dashboard
- Open `India Election 2024 Dashboard.pbix` in Power BI Desktop.
- Connect to your SQL server or import CSVs as needed.

---

## 📌 Notes

- Party alliances were manually classified into `NDA`, `I.N.D.I.A`, and `OTHER`.
- All data is assumed to be anonymized/simulated for educational/demo purposes.
- Ensure proper file paths for `LOAD DATA INFILE` operations.

---

## 👤 Author

**Sanskriti**  
Data Analyst | SQL | Power BI | Tableau  

---

## 📜 License
This repository is **not licensed for reuse**.

- ✅ You may **view and run** the contents for educational or demonstration purposes.
- ❌ **Copying, modifying, redistributing, or reusing** any part of this project without permission is **strictly prohibited**.

All rights reserved © 2025 Sanskriti
