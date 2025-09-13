USE ChinookDW;

-- 1. Ventas por cliente
SELECT 
    c.CustomerKey,
    c.FirstName + ' ' + c.LastName AS Cliente,
    SUM(f.TotalLine) AS TotalVentas
FROM FactSales f
JOIN DimCustomer c 
    ON f.CustomerKey = c.CustomerKey
GROUP BY c.CustomerKey, c.FirstName, c.LastName
ORDER BY TotalVentas DESC;

-- 2. Total de ventas por género musical
SELECT 
    g.Name AS Genero,
    SUM(f.TotalLine) AS TotalVentas
FROM FactSales f
JOIN DimTrack t 
    ON f.TrackKey = t.TrackKey
JOIN DimGenre g
    ON t.GenreKey = g.GenreKey
GROUP BY g.Name
ORDER BY TotalVentas DESC;

-- 3. Total de ventas por artista
SELECT 
    a.Name AS Artista,
    SUM(f.TotalLine) AS TotalVentas
FROM FactSales f
JOIN DimTrack t
    ON f.TrackKey = t.TrackKey
JOIN DimAlbum al
    ON t.AlbumKey = al.AlbumKey
JOIN DimArtist a
    ON al.ArtistKey = a.ArtistKey
GROUP BY a.Name
ORDER BY TotalVentas DESC;

-- 4. Total de ventas por país
SELECT 
    c.Country,
    SUM(f.TotalLine) AS TotalVentas
FROM FactSales f
JOIN DimCustomer c
    ON f.CustomerKey = c.CustomerKey
GROUP BY c.Country
ORDER BY TotalVentas DESC;



-- EXTRAS

-- Ventas por año y mes:
SELECT 
    d.Year,
    d.Month,
    SUM(f.TotalLine) AS TotalVentas
FROM FactSales f
JOIN DimDate d
    ON f.DateKey = d.DateKey
GROUP BY d.Year, d.Month
ORDER BY d.Year, d.Month;

-- Cantidad vendida por cliente y género:
SELECT 
    c.FirstName + ' ' + c.LastName AS Cliente,
    g.Name AS Genero,
    SUM(f.Quantity) AS CantidadVendida
FROM FactSales f
JOIN DimCustomer c ON f.CustomerKey = c.CustomerKey
JOIN DimTrack t ON f.TrackKey = t.TrackKey
JOIN DimGenre g ON t.GenreKey = g.GenreKey
GROUP BY c.FirstName, c.LastName, g.Name
ORDER BY Cliente, CantidadVendida DESC;