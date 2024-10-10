-- Creación de la base de datos Administracion (si no existe)
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Administracion')
BEGIN
    CREATE DATABASE Administracion;
END
GO

-- Seleccionar la base de datos
USE Administracion;
GO

-- Creación de la tabla Usuarios (si no existe)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Usuarios')
BEGIN
    CREATE TABLE Usuarios (
        Id INT PRIMARY KEY IDENTITY(1,1),
        Nombre VARCHAR(100) NOT NULL,
        Correo VARCHAR(100) UNIQUE NOT NULL,
        Rol VARCHAR(50) DEFAULT 'Editor'
    );
END
GO

-- Creación de índices para la tabla Usuarios (si no existen)
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_Nombre' AND object_id = OBJECT_ID('Usuarios'))
BEGIN
    CREATE INDEX idx_Nombre ON Usuarios(Nombre);
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_Correo' AND object_id = OBJECT_ID('Usuarios'))
BEGIN
    CREATE INDEX idx_Correo ON Usuarios(Correo);
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_Id' AND object_id = OBJECT_ID('Usuarios'))
BEGIN
    CREATE INDEX idx_Id ON Usuarios(Id);
END
GO

-- Creación de la tabla Paginas (si no existe)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Paginas')
BEGIN
    CREATE TABLE Paginas (
        Id INT PRIMARY KEY IDENTITY(1,1),
        Titulo VARCHAR(100) NOT NULL,
        Contenido TEXT NOT NULL,
        FechaCreacion DATETIME NULL
    );
END
GO

-- Creación de índices para la tabla Paginas (si no existen)
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_Titulo' AND object_id = OBJECT_ID('Paginas'))
BEGIN
    CREATE INDEX idx_Titulo ON Paginas(Titulo);
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_FechaCreacion' AND object_id = OBJECT_ID('Paginas'))
BEGIN
    CREATE INDEX idx_FechaCreacion ON Paginas(FechaCreacion);
END
GO

-- Creación de la tabla Permisos (si no existe)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Permisos')
BEGIN
    CREATE TABLE Permisos (
        UsuarioId INT,
        PaginaId INT,
        NivelAcceso VARCHAR(50) CHECK (NivelAcceso IN ('Lectura', 'Escritura', 'Admin')),
        PRIMARY KEY (UsuarioId, PaginaId),
        FOREIGN KEY (UsuarioId) REFERENCES Usuarios(Id),
        FOREIGN KEY (PaginaId) REFERENCES Paginas(Id)
    );
END
GO
