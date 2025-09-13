-- Eliminar si ya existe
IF DB_ID('ChinookDW') IS NOT NULL
    DROP DATABASE ChinookDW;
GO

-- Crear base de datos DW
CREATE DATABASE ChinookDW;
GO

USE ChinookDW;
GO

-- CREAR TABLAS DIMENSIONALES

-- Dimensión Clientes
CREATE TABLE DimCustomer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerId INT, -- ID original OLTP
    FirstName NVARCHAR(40),
    LastName NVARCHAR(40),
    Company NVARCHAR(80) NULL,
    Address NVARCHAR(70) NULL,
    City NVARCHAR(40) NULL,
    State NVARCHAR(40) NULL,
    Country NVARCHAR(40),
    PostalCode NVARCHAR(10) NULL,
    Phone NVARCHAR(24) NULL,
    Fax NVARCHAR(24) NULL,
    Email NVARCHAR(60),
    SupportRepId INT NULL
);

-- Dimensión Artistas
CREATE TABLE DimArtist (
    ArtistKey INT IDENTITY(1,1) PRIMARY KEY,
    ArtistId INT,
    Name NVARCHAR(120)
);

-- Dimensión Álbumes
CREATE TABLE DimAlbum (
    AlbumKey INT IDENTITY(1,1) PRIMARY KEY,
    AlbumId INT,
    Title NVARCHAR(160),
    ArtistKey INT FOREIGN KEY REFERENCES DimArtist(ArtistKey)
);

-- Dimensión Géneros
CREATE TABLE DimGenre (
    GenreKey INT IDENTITY(1,1) PRIMARY KEY,
    GenreId INT,
    Name NVARCHAR(120)
);

-- Dimensión Tipos de Media
CREATE TABLE DimMediaType (
    MediaTypeKey INT IDENTITY(1,1) PRIMARY KEY,
    MediaTypeId INT,
    Name NVARCHAR(120)
);

-- Dimensión Pistas
CREATE TABLE DimTrack (
    TrackKey INT IDENTITY(1,1) PRIMARY KEY,
    TrackId INT,
    Name NVARCHAR(200),
    AlbumKey INT FOREIGN KEY REFERENCES DimAlbum(AlbumKey),
    GenreKey INT FOREIGN KEY REFERENCES DimGenre(GenreKey),
    MediaTypeKey INT FOREIGN KEY REFERENCES DimMediaType(MediaTypeKey),
    Composer NVARCHAR(220) NULL,
    Milliseconds INT,
    Bytes INT NULL,
    UnitPrice DECIMAL(10,2)
);

-- Dimensión Fechas
CREATE TABLE DimDate (
    DateKey INT IDENTITY(1,1) PRIMARY KEY,
    FullDate DATE,
    Year INT,
    Month INT,
    Day INT,
    Quarter INT
);

-- CREAR TABLA DE HECHOS

CREATE TABLE FactSales (
    FactKey INT IDENTITY(1,1) PRIMARY KEY,
    InvoiceLineId INT, -- ID del sistema fuente (para trazabilidad)

    -- Claves foráneas a dimensiones
    CustomerKey INT FOREIGN KEY REFERENCES DimCustomer(CustomerKey),
    TrackKey INT FOREIGN KEY REFERENCES DimTrack(TrackKey),
    DateKey INT FOREIGN KEY REFERENCES DimDate(DateKey),

    -- Medidas de negocio
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    TotalLine DECIMAL(12,2)
);