USE ChinookDW;

-- ¿Se cargaron los clientes?
SELECT TOP 10 * FROM DimCustomer;

-- ¿Dimensiones tienen surrogate keys bien asignados?
SELECT CustomerKey, CustomerId FROM DimCustomer ORDER BY CustomerKey;

-- ¿La FactSales tiene datos?
SELECT TOP 10 * FROM FactSales;

-- ¿Cruce correcto cliente–venta?
SELECT c.FirstName, c.LastName, SUM(f.TotalLine) AS TotalGastado
FROM FactSales f
JOIN DimCustomer c ON f.CustomerKey = c.CustomerKey
GROUP BY c.FirstName, c.LastName
ORDER BY TotalGastado DESC;