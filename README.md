# 🏢 Enterprise Supply Chain & Logistics Analytics Dashboard

![Executive Overview](Executive%20Overview.png)

## 📌 Executive Summary & Business Context
In global supply chain management, data discrepancies and lack of visibility into inventory levels can lead to costly stockouts, overstocking, and delayed customer deliveries. 

This project provides an **Enterprise-grade Power BI Solution** based on the Northwind Supply Chain dataset. It connects raw relational database operations with executive-level decision-making by tracking:
1. **Financial Health & Sales Trends** across categories and temporal periods.
2. **Inventory Stockout & Capital Risks** to protect working capital.
3. **Logistics Performance & Freight Costs** to identify carrier bottlenecks.

---

## 🎯 Problem Statement & Key Business Challenges
Prior to building this analytics suite, the business faced critical operational hurdles:
* **Data Granularity & Overcounting Risks:** Joining transaction tables (`Orders`, `Order Details`, `Products`) created one-to-many relationship duplications, leading to inflated financial and inventory totals if aggregated naively.
* **Lack of Inventory Risk Visibility:** Management lacked an automated mechanism to distinguish between total physical stock vs. stock actively at risk of depletion.
* **Logistics & Carrier Inefficiencies:** No centralized monitoring for delivery delays, average freight cost per order, or carrier reliability.

---

## 🛠️ Data Architecture & Technologies Used
* **SQL Server / T-SQL (`instnwnd.sql`, `queris.sql`, `View.sql`):** Data extraction, transformation, structural cleanup, and creation of optimized SQL Views (`vw_SupplyChain_Analytics`) to handle complex joins at the database layer.
* **Microsoft Power BI (`Supplu_Chain.pbix`):** Data modeling, interactive visual representation, geographic mapping, and layout engineering.
* **DAX (Data Analysis Expressions):** Development of high-accuracy measures, evaluation context handling, dynamic KPI calculations, and time-intelligence analysis.

---

## 💡 Technical Solutions & Business Logic (DAX Implementation)
To eliminate data inflation and guarantee high business accuracy, custom DAX logic was designed:

1. **Solving Granularity Duplication:**
   To calculate true inventory values without multiplying stock by duplicate order rows, iteration over unique product dimensions was enforced:
   $$\text{Total Inventory Value} = \sum_{p \in \text{Products}} (\text{UnitsInStock}_p \times \text{UnitPrice}_p)$$

2. **At-Risk Inventory Quantification:**
   Filtering logic isolates stock levels falling below designated reorder thresholds:
   ```dax
   At-Risk Inventory Value = 
   CALCULATE(
       [Total Inventory Value],
       vw_SupplyChain_Analytics[UnitsInStock] <= vw_SupplyChain_Analytics[ReorderLevel]
   )
