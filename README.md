# 🛒 Retail Behavior Intelligence
### End-to-End Customer Analytics — SQL · Python · Power BI

![Python](https://img.shields.io/badge/Python-3.10-blue?logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-PostgreSQL-336791?logo=postgresql&logoColor=white)
![PowerBI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?logo=powerbi&logoColor=black)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

---

## 👋 About This Project

Hi, I'm **Rohan Tand** — a Data Analytics graduate student at the **University of Illinois Springfield**, with hands-on experience in statewide data reporting and policy analysis at the **Illinois Department of Human Services (IDHS)**. This project reflects how I approach analytics in the real world: structured SQL querying, Python-powered exploratory analysis, and decision-ready Power BI dashboards.

The goal isn't just to clean data — it's to answer questions that matter to a business:
- *Which customer segments drive the most revenue?*
- *What behavioral patterns repeat across seasons?*
- *Where are the untapped upsell and retention opportunities?*

---

## 📁 Project Structure

```
Retail-Behavior-Intelligence-SQL-Python-PowerBI/
│
├── retail_behavior_analysis.ipynb   # Python EDA & visualization notebook
├── retail_sql_queries.sql           # SQL KPI extraction & segmentation queries
├── retail_dashboard.pbix            # Power BI interactive dashboard
├── retail_shopping_data.csv         # Dataset (3,900 transactions, 19 columns)
└── README.md
```

---

## 🆕 What Makes This Unique

This project extends the standard retail analysis template with **2 original derived columns** and **7 independent SQL queries** not found in any base walkthrough:

| Addition | Description |
|---|---|
| `spend_tier` column | Derived field classifying orders as Low / Mid / High based on purchase amount |
| `loyalty_score` column | Computed from purchase frequency and subscription status (Bronze → Platinum) |
| Generational Cohort SQL | Segments customers into Gen Z / Millennials / Gen X / Boomers with spend comparison |
| Loyalty Tier Heatmap | SQL + Power BI cross-tab of loyalty tier × spend tier revenue |
| Untapped Segment Query | Identifies high-frequency buyers who never use promos — upsell targets |
| Cross-Sell Gap Matrix | Flags category × season combos with below-average satisfaction ratings |
| Promo Sensitivity Analysis | Measures whether discounts are concentrated in low-loyalty segments |
| Retention Approximation | Classifies customers by frequency as a proxy for retention risk |
| Payment × Shipping Matrix | Behavioral bundles mapped for checkout UX optimization |

---

## 🔍 Analysis Breakdown

### 🗄️ SQL (`retail_sql_queries.sql`)
7 sections, 20+ queries covering:
- Core KPIs: revenue, AOV, order volume
- Generational cohort segmentation
- Subscription and loyalty tier analysis
- Seasonal trend and promo effectiveness
- Geographic premium market identification
- Satisfaction signals by category and spend tier
- **Section 7: 4 original independent queries** written by Rohan Tand

### 🐍 Python Notebook (`retail_behavior_analysis.ipynb`)
Full EDA using **Pandas, Matplotlib, Seaborn**:
- Data profiling and validation
- Age/gender demographic distributions
- Purchase amount distribution with statistical markers
- Revenue by category and season with trend lines
- Subscription vs non-subscription value comparison
- Loyalty tier × spend tier heatmap
- Promo redemption and payment method analysis
- Correlation matrix across numerical features
- **Conclusions section with 5 actionable business recommendations**

### 📊 Power BI Dashboard (`retail_dashboard.pbix`)
Interactive executive dashboard with:
- Revenue KPIs: total, AOV, order volume
- Loyalty tier and spend tier cross-tab
- Seasonal drill-through by category
- Geographic spend distribution map
- Subscription vs non-subscription comparison
- Promo and discount impact analysis

---

## 📊 Dataset

| Feature | Detail |
|---|---|
| Records | 3,900 transactions |
| Columns | 19 (17 base + 2 derived: `spend_tier`, `loyalty_score`) |
| Key Variables | Category, Season, Loyalty Score, Spend Tier, Payment Method, Subscription Status, Review Rating |

---

## 🧰 Tech Stack

| Tool | Purpose |
|---|---|
| **Python** (Pandas, Matplotlib, Seaborn) | EDA, data wrangling, visualization |
| **SQL** (PostgreSQL / SQLite compatible) | KPI queries, segmentation, aggregations |
| **Power BI** | Interactive dashboard & business storytelling |
| **Jupyter Notebook** | Analysis environment |

---

## 💡 Key Findings

- **Outerwear** has the highest average order value — underpromoted relative to revenue potential
- **Subscription customers** spend ~23% more per transaction on average than non-subscribers
- **Fall** is the peak revenue season across all product categories
- **Platinum loyalty customers who never use promo codes** represent a high-margin upsell segment
- **Spring discounting** drives volume but compresses revenue — high redemption, low AOV

---

## 🚀 How to Run

**Python Notebook:**
```bash
git clone https://github.com/Rtandra65/Retail-Behavior-Intelligence-SQL-Python-PowerBI.git
cd Retail-Behavior-Intelligence-SQL-Python-PowerBI
pip install pandas matplotlib seaborn
jupyter notebook retail_behavior_analysis.ipynb
```

**SQL Queries:**
Load `retail_shopping_data.csv` into PostgreSQL, MySQL, or SQLite, then run `retail_sql_queries.sql`.

**Power BI:**
Open `retail_dashboard.pbix` in Power BI Desktop and connect to the CSV or your local DB.

---

## 🌐 Connect

Actively seeking full-time roles in **data analytics, business intelligence, and public sector data** — particularly with Illinois state government and federal agencies.

- 📧 rohantandra92@gmail.com
- 💼 [LinkedIn](https://linkedin.com/in/rohantand)
- 🎓 M.S. Data Analytics · University of Illinois Springfield · May 2026

---
