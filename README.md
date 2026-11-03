# 🏢 Enterprise Supply Chain & Logistics Analytics Hub
### End-to-End Business Intelligence & Data Engineering Solution

<div align="center">

![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![SQL Server](https://img.shields.io/badge/SQL_Server-CC292B?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![DAX](https://img.shields.io/badge/DAX_Engine-0078D4?style=for-the-badge&logo=microsoft&logoColor=white)
![Domain](https://img.shields.io/badge/Domain-Supply_Chain_%26_Logistics-059669?style=for-the-badge)

**A comprehensive 3-page interactive Power BI dashboard tracking $74K+ in inventory assets, $207K+ in freight expenditures, and operational risk mitigation for the Northwind Supply Chain.**

</div>

---

## 📊 Dashboard Overview

This project delivers an end-to-end Business Intelligence solution designed to analyze supply chain performance, monitor inventory health, and evaluate logistics costs using SQL Server and Power BI.

The dashboard consists of three interactive pages, featuring a professional dark-themed UI (`#0B1320`), floating container cards, and intuitive sidebar navigation.

### 1. Executive Overview
Provides a high-level summary of business performance, including:
- Total inventory and financial KPIs.
- Overall order health and operational performance.
- Historical sales trends.
- Key performance indicators for executive decision-making.

### 2. Inventory Risk & Management
Focuses on inventory optimization and stock management:
- Warehouse stock level monitoring.
- Identification of critical stockout products.
- Reorder-level monitoring.
- At-risk inventory valuation.
- Inventory risk identification and prioritization.

### 3. Logistics & Freight Cost Analysis
Evaluates shipping efficiency and transportation expenses:
- Shipping carrier cost comparison.
- Freight cost efficiency analysis.
- Delivery delay monitoring.
- Geographic distribution of shipping expenses.
- Identification of high-cost international destinations.

---

## 📸 Dashboard Preview

### 1. Executive Overview
![Executive Overview](Executive%20Overview.png)

### 2. Inventory Risk & Management
![Inventory Risk](Inventory%20Risk.png)

### 3. Logistics & Freight Cost Analysis
![Logistics & Cost](Logistics%20%26%20Cost.png)

---

## 🎯 Problem Statement & Business Challenges

Before implementing this analytics solution, the business faced several operational and analytical challenges:

**1. Data Granularity & Overcounting Risks**
- Joining transactional tables such as `Orders`, `Order Details`, and `Products` introduced one-to-many relationship duplication.
- These duplications could inflate financial metrics and inventory calculations.
- Accurate aggregation across different data granularities was essential.

**2. Lack of Inventory Risk Visibility**
- Management lacked clear visibility into inventory depletion risks.
- There was no effective distinction between total physical stock and inventory actively at risk of stockout.
- Reorder decisions required better analytical support.

**3. Carrier Cost Inefficiencies**
- Shipping carrier rates and delivery performance were not sufficiently monitored.
- Delivery delays and high transportation expenses negatively affected operational efficiency and profit margins.
- Management needed a clearer understanding of international shipping cost distribution.

---

## 🛠️ Tools & Technologies Used

| Technology | Purpose |
|---|---|
| SQL Server | Database management and data extraction |
| T-SQL | Data transformation and analytical queries |
| SQL Views | Optimized relational joins and granularity control |
| Power BI Desktop | Interactive dashboard development |
| DAX | Dynamic KPIs and advanced analytical calculations |
| Data Modeling | Relationships and analytical model design |
| Bing Maps | Geographic and regional analysis |

### Technical Components

**SQL Server / T-SQL**
- Database creation and schema deployment using `instnwnd.sql`.
- Data extraction and structural preparation.
- Development of optimized SQL Views.
- Complex relational joins and granularity management.
- Analytical queries and validation tests.

**Power BI Desktop**
- Data modeling and relationship management.
- Interactive visualizations and KPI development.
- Dashboard layout and UI/UX engineering.
- Geographic analysis using Bing Maps.
- Dynamic filtering and interactive reporting.

**DAX (Data Analysis Expressions)**
- Dynamic KPI calculations.
- Context-aware aggregations.
- Inventory valuation.
- Risk identification.
- Delivery delay analysis.

---

## 🧠 Technical Solutions & Advanced DAX Implementation

One of the main technical objectives was maintaining accurate calculations despite the complexity of relational joins and different data granularities.

### 1. Eliminating Inventory Duplication

Joining product-level inventory information with order-level transactions can duplicate stock values.

To avoid overcounting, inventory valuation is calculated at the individual product level.

**Business Logic:**

Total Inventory Value = Σ (Units In Stock × Unit Price)

**DAX Implementation:**

```dax
Total Inventory Value =
SUMX(
    VALUES(vw_SupplyChain_Analytics[ProductID]),
    CALCULATE(
        MAX(vw_SupplyChain_Analytics[UnitsInStock]) *
        MAX(vw_SupplyChain_Analytics[UnitPrice])
    )
)
```

This approach ensures that each product contributes only once to the total inventory valuation, even when multiple transactional records exist.

### 2. At-Risk Inventory Isolation

Identifies products whose available stock has reached or fallen below their designated reorder levels.

**DAX Implementation:**

```dax
At-Risk Inventory Value =
CALCULATE(
    [Total Inventory Value],
    FILTER(
        VALUES(vw_SupplyChain_Analytics[ProductID]),
        CALCULATE(
            MAX(vw_SupplyChain_Analytics[UnitsInStock])
        ) <=
        CALCULATE(
            MAX(vw_SupplyChain_Analytics[ReorderLevel])
        )
    )
)
```

This measure isolates inventory assets requiring attention and helps management prioritize replenishment decisions.

### 3. Positive Delivery Lag Tracking

Measures actual delivery delays while excluding negative delay values that do not represent late deliveries.

**DAX Implementation:**

```dax
Total Delay Days =
CALCULATE(
    SUM(vw_SupplyChain_Analytics[DelayDays]),
    vw_SupplyChain_Analytics[DelayDays] > 0
)
```

**Calculated Result:** 568 total delay days.

This metric provides a clearer picture of fulfillment bottlenecks and shipping performance.

---

## 💡 Key Business Insights & Strategic Recommendations

The analysis revealed several important findings that can support operational and strategic decision-making.

### 1. Carrier Rate Optimization
- United Package accounts for the highest share of freight expenses, exceeding approximately $10K.
- **Recommendation:** Renegotiate carrier pricing agreements or redistribute shipping volumes to more cost-efficient alternatives, such as Speedy Express and Federal Shipping.

### 2. Targeted Inventory Reordering
- Five products were completely out of stock.
- Approximately **$4,936 in inventory value** was identified as being at risk of stockout.
- Products such as Gorgonzola Telino and Outback Lager were among the identified risk items.
- **Recommendation:** Implement automated reorder alerts to minimize stockout risks and potential revenue loss.

### 3. Regional Fulfillment Optimization
- Significant freight cost concentrations were observed in destinations including the USA, Germany, and Austria.
- **Recommendation:** Evaluate regional fulfillment strategies and distribution hubs to reduce cross-border transportation costs and delivery delays.

---

## 📁 Repository Structure

```text
Enterprise-Supply-Chain-Analytics/
│
├── Supplu_Chain.pbix
│
├── instnwnd.sql
├── View.sql
├── queris.sql
│
├── Executive Overview.png
├── Inventory Risk.png
└── Logistics & Cost.png
```

### Repository Files

| File | Type | Description |
|---|---|---|
| `Supplu_Chain.pbix` | Power BI | Master interactive dashboard |
| `instnwnd.sql` | T-SQL | Database creation and schema deployment |
| `View.sql` | T-SQL | Optimized SQL Views for analytical queries |
| `queris.sql` | T-SQL | Analytical queries and validation tests |
| `Executive Overview.png` | Image | Dashboard Page 1 screenshot |
| `Inventory Risk.png` | Image | Dashboard Page 2 screenshot |
| `Logistics & Cost.png` | Image | Dashboard Page 3 screenshot |

---

## 🚀 Project Objectives & Value

This project demonstrates practical Business Intelligence capabilities through:

- End-to-end data analysis and reporting.
- Relational database querying and SQL View development.
- Data granularity management and duplicate prevention.
- Advanced DAX measure development.
- Inventory risk and financial performance analysis.
- Logistics cost optimization.
- Translating raw business data into actionable insights.

---

## 👨‍💻 Author

**Omar Shatla**

Data Analyst | Business Intelligence Engineer

**Core Focus:** Data Analytics, SQL Server, Power BI, DAX, and Business Intelligence.

---

<div align="center">

**Turning Supply Chain Data into Actionable Business Decisions.**

</div>
