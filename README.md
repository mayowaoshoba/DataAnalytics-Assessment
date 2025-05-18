# Data Analytics Assessment

## Overview
This repository contains solutions to COWRYWISE Data Analyst Assessment measure my ability to work with relational databases by writing SQL queries to solve business problems.

---

## Solutions

### Q1. High-Value Customers with Multiple Products
- **Goal**: Identify customers with at least one funded savings and one investment plan.
- **Approach**: Used joins and aggregate functions to count savings/investments and sum total deposits.

### Q2. Transaction Frequency Analysis
- **Goal**: Categorize customers by average monthly transaction frequency.
- **Approach**: Used CTEs to compute transaction counts and months active, then classified using `CASE` statements.

### Q3. Account Inactivity Alert
- **Goal**: Flag active accounts with no inflow for over 365 days.
- **Approach**: Extracted last transaction dates and calculated inactivity using `DATEDIFF`. Used `UNION ALL` to combine savings and investment data.

### Q4. Customer Lifetime Value (CLV)
- **Goal**: Estimate CLV using transaction volume and tenure.
- **Approach**: Calculated tenure since account signup, computed average profit, and applied provided CLV formula.

---

## Challenges
- Mapping out realistic assumptions in the absence of full schema definitions.
- Ensuring currency values stored in kobo were converted correctly.
- Handling divide-by-zero errors and NULLs gracefully using `NULLIF`.

---

## Folder Structure

```
DataAnalytics-Assessment/
├── Assessment_Q1.sql
├── Assessment_Q2.sql
├── Assessment_Q3.sql
├── Assessment_Q4.sql
└── README.md
```

---

## Submission
All queries are self-contained and well-commented. Each `.sql` file contains one query corresponding to a specific question.
