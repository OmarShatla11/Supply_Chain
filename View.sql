USE NORTHWND;
GO

CREATE OR ALTER VIEW vw_SupplyChain_Analytics AS
SELECT 
    -- تفاصيل الطلبيات الشحن
    o.OrderID,
    o.OrderDate,
    o.RequiredDate,
    o.ShippedDate,
    o.Freight AS FreightCost,
    o.ShipCountry,
    o.ShipCity,
    sh.CompanyName AS CarrierName,
    
    -- حساب حالة الشحن والمدة بالـ Days (Lead Time & Logistics Metrics)
    CASE 
        WHEN o.ShippedDate IS NULL THEN 'Not Shipped Yet'
        WHEN o.ShippedDate > o.RequiredDate THEN 'Late Delivery'
        ELSE 'On-Time Delivery'
    END AS ShippingStatus,
    
    DATEDIFF(DAY, o.OrderDate, o.ShippedDate) AS OrderToShipDays, -- أيام المعالجة والشحن
    DATEDIFF(DAY, o.RequiredDate, o.ShippedDate) AS DelayDays,     -- أيام التأخير (إن وجدت)

    -- تفاصيل المنتجات والمخزون
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    s.CompanyName AS SupplierName,
    s.Country AS SupplierCountry,
    p.UnitsInStock,
    p.ReorderLevel,
    p.UnitsOnOrder,
    p.UnitPrice AS ProductUnitPrice,

    -- حالة المخزون الديناميكية
    CASE 
        WHEN p.UnitsInStock = 0 THEN 'Out of Stock'
        WHEN p.UnitsInStock <= p.ReorderLevel THEN 'Critical - Reorder'
        ELSE 'Safe Stock'
    END AS StockStatus,

    -- التفاصيل المالية والفواتير
    od.UnitPrice AS SellingUnitPrice,
    od.Quantity,
    od.Discount,
    ROUND((od.Quantity * od.UnitPrice * (1 - od.Discount)), 2) AS LineSalesAmount

FROM Orders o
INNER JOIN Shippers sh ON o.ShipVia = sh.ShipperID
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID;
GO

select * from Orders

