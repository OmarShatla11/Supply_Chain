<div align="center">

# 🏢 ENTERPRISE SUPPLY CHAIN & LOGISTICS ANALYTICS HUB
### 📊 End-to-End Business Intelligence & Data Engineering Solution

[![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)](https://powerbi.microsoft.com/)
[![SQL Server](https://img.shields.io/badge/SQL_Server-CC292B?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)](https://www.microsoft.com/sql-server)
[![DAX](https://img.shields.io/badge/DAX_Engine-0078D4?style=for-the-badge&logo=microsoft&logoColor=white)]()
[![Domain](https://img.shields.io/badge/Domain-Supply_Chain_%26_Logistics-059669?style=for-the-badge)]()

<p align="center">
  <b>A comprehensive 3-page interactive Power BI dashboard tracking $74K+ in inventory assets, $207K+ in freight expenditures, and operational risk mitigation for the Northwind Supply Chain.</b>
</p>

</div>

---

## 📊 Dashboard Overview

The dashboard consists of 3 main pages designed with a professional dark-themed UI (`#0B1320`), floating container cards, and intuitive sidebar page navigation:

1. **Executive Overview**: High-level financial health summary, total units, overall order health, and historical sales trends.
2. **Inventory Risk & Management**: Deep dive into warehouse stock levels, critical stockout items, and at-risk capital quantification.
3. **Logistics & Cost**: Evaluation of shipping carrier expenses, freight cost efficiency, delivery delays, and global geographic distribution.

---

## 📸 Dashboard Preview

### 1. Executive Overview
![Executive Overview](Executive%20Overview.png)

### 2. Inventory Risk & Management
![Inventory Risk](Inventory%20Risk.png)

### 3. Logistics & Freight Cost Analysis
![Logistics & Cost](Logistics%20&%20Cost.png)

---

## 🎯 Problem Statement & Business Challenges

Prior to building this analytics suite, the business faced critical operational hurdles:
* **Data Granularity & Overcounting Risks:** Joining transaction tables (`Orders`, `Order Details`, `Products`) created one-to-many relationship duplications, leading to inflated financial and inventory totals.
* **Lack of Inventory Risk Visibility:** Management lacked automated mechanisms to distinguish between total physical stock vs. stock actively at risk of depletion.
* **Carrier Cost Inefficiencies:** Unmonitored shipping carrier rates and delivery delays eroded profit margins across international delivery routes.

---

## 🛠️ Tools & Technologies Used
* **SQL Server / T-SQL (`instnwnd.sql`, `View.sql`):** Data extraction, transformation, structural cleanup, and creation of optimized SQL Views (`vw_SupplyChain_Analytics`) to handle complex relational joins at the database layer.
* **Power BI Desktop (`Supplu_Chain.pbix`):** Data modeling, interactive visual representation, geographic Bing mapping, custom DAX measures, and UI/UX layout engineering.
* **DAX (Data Analysis Expressions):** Development of high-accuracy evaluation context handling, dynamic KPI calculations, and time-intelligence analysis.

---

## 🧠 Technical Solutions & Advanced DAX Implementation

To achieve **100% data integrity** and resolve granularity issues, custom backend views and advanced DAX formulations were engineered:

### 1. Eliminating Inventory Duplication
To accurately compute total physical stock and total asset value without overcounting caused by order detail joins:
$$\text{Total Inventory Value} = \sum_{p \in \text{Products}} \left( \text{UnitsInStock}_p \times \text{UnitPrice}_p \right)$$

```dax
Total Inventory Value = 
SUMX(
    VALUES(vw_SupplyChain_Analytics[ProductID]),
    CALCULATE(SUM(vw_SupplyChain_Analytics[UnitsInStock]) * AVERAGE(vw_SupplyChain_Analytics[UnitPrice]))
)
