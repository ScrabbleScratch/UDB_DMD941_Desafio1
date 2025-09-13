-- CREAR DB DE STAGING
IF DB_ID('Chinook_Staging') IS NOT NULL
    DROP DATABASE Chinook_Staging;
GO

CREATE DATABASE Chinook_Staging;
GO

USE Chinook_Staging;
GO


-- CREAR TABLAS DE STAGING
-- Clientes
CREATE TABLE stg_Customer (
    CustomerId INT,
    FirstName NVARCHAR(40),
    LastName NVARCHAR(20),
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

-- Facturas
CREATE TABLE stg_Invoice (
    InvoiceId INT,
    CustomerId INT,
    InvoiceDate DATETIME,
    BillingAddress NVARCHAR(70) NULL,
    BillingCity NVARCHAR(40) NULL,
    BillingState NVARCHAR(40) NULL,
    BillingCountry NVARCHAR(40),
    BillingPostalCode NVARCHAR(10) NULL,
    Total DECIMAL(10,2)
);

-- Detalle de facturas
CREATE TABLE stg_InvoiceLine (
    InvoiceLineId INT,
    InvoiceId INT,
    TrackId INT,
    UnitPrice DECIMAL(10,2),
    Quantity INT
);

-- Pistas musicales
CREATE TABLE stg_Track (
    TrackId INT,
    Name NVARCHAR(200),
    AlbumId INT NULL,
    MediaTypeId INT,
    GenreId INT,
    Composer NVARCHAR(220) NULL,
    Milliseconds INT,
    Bytes INT NULL,
    UnitPrice DECIMAL(10,2)
);

-- Álbumes
CREATE TABLE stg_Album (
    AlbumId INT,
    Title NVARCHAR(160),
    ArtistId INT
);

-- Artistas
CREATE TABLE stg_Artist (
    ArtistId INT,
    Name NVARCHAR(120)
);

-- Géneros
CREATE TABLE stg_Genre (
    GenreId INT,
    Name NVARCHAR(120)
);

-- Tipos de media (MP3, WAV, AAC, etc.)
CREATE TABLE stg_MediaType (
    MediaTypeId INT,
    Name NVARCHAR(120)
);