USE NORTHWND;
GO

-- 1. المنتجات التي وصل مخزونها لحد إعادة الطلب أو أقل (تحذير فوري)
SELECT 
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    s.CompanyName AS SupplierName,
    p.UnitsInStock,
    p.ReorderLevel,
    p.UnitsOnOrder,
    CASE 
        WHEN p.UnitsInStock = 0 THEN 'Out of Stock'
        WHEN p.UnitsInStock <= p.ReorderLevel THEN 'Critical - Reorder Now'
        ELSE 'Safe'
    END AS InventoryStatus
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE p.UnitsInStock <= p.ReorderLevel OR p.UnitsInStock = 0
ORDER BY p.UnitsInStock ASC;

-- 2. تحليل التأخيرات لكل شركة شحن (Shipper Performance)
SELECT 
    sh.CompanyName AS FreightCarrier,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(CASE WHEN o.ShippedDate > o.RequiredDate THEN 1 ELSE 0 END) AS LateOrders,
    ROUND(
        (CAST(SUM(CASE WHEN o.ShippedDate > o.RequiredDate THEN 1 ELSE 0 END) AS FLOAT) / COUNT(o.OrderID)) * 100, 
        2
    ) AS LateDeliveryRatePercentage
FROM Orders o
INNER JOIN Shippers sh ON o.ShipVia = sh.ShipperID
WHERE o.ShippedDate IS NOT NULL
GROUP BY sh.CompanyName
ORDER BY LateDeliveryRatePercentage DESC;


-- تحليل إجمالي ومتوسط تكاليف الشحن حسب دولة العميل
SELECT 
    o.ShipCountry,
    COUNT(o.OrderID) AS TotalOrders,
    ROUND(SUM(o.Freight), 2) AS TotalFreightCost,
    ROUND(AVG(o.Freight), 2) AS AvgFreightPerOrder
FROM Orders o
GROUP BY o.ShipCountry
ORDER BY TotalFreightCost DESC;

-- حساب إجمالي قيمة المخزون الحالي مجمع حسب الأقسام
SELECT 
    c.CategoryName,
    COUNT(p.ProductID) AS TotalProducts,
    SUM(p.UnitsInStock) AS TotalUnitsInStock,
    ROUND(SUM(p.UnitsInStock * p.UnitPrice), 2) AS TotalInventoryValue
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName
ORDER BY TotalInventoryValue DESC;