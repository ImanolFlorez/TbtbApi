--Inserciones Tabla Usuarios
INSERT INTO Usuarios (Nombre, Correo, Rol) VALUES
('Juan Pérez', 'juan.perez@example.com', 'Admin'),
('María López', 'maria.lopez@example.com', 'Editor'),
('Carlos García', 'carlos.garcia@example.com', 'Viewer'),
('Ana Torres', 'ana.torres@example.com', 'Editor'),
('Luis Martínez', 'luis.martinez@example.com', 'Admin');


--Inserciones Tabla Paginas
INSERT INTO Paginas (Titulo, Contenido, FechaCreacion) VALUES
('Bienvenido a la Administración', 'Esta es la página de bienvenida de nuestro sistema de administración.', GETDATE()),
('Políticas de Uso', 'Aquí se describen las políticas de uso del sistema.', GETDATE()),
('Contactar Soporte', 'Información sobre cómo contactar al soporte técnico.', GETDATE()),
('Guía de Usuario', 'Guía para el uso efectivo del sistema.', GETDATE()),
('Actualizaciones del Sistema', 'Últimas actualizaciones y cambios realizados en el sistema.', GETDATE());

--Inserciones Tabla Permisos
INSERT INTO Permisos (UsuarioId, PaginaId, NivelAcceso) VALUES
(1, 1, 'Admin'),
(1, 2, 'Escritura'),
(2, 3, 'Lectura'),
(3, 4, 'Lectura'),
(4, 5, 'Escritura');



# -------------------------------------------------------------------------------------------------------

--INNER JOIN 
SELECT U.Nombre, P.Titulo, PM.NivelAcceso
FROM Usuarios U
INNER JOIN Permisos PM ON U.Id = PM.UsuarioId
INNER JOIN Paginas P ON PM.PaginaId = P.Id;

--LEFT JOIN
SELECT U.Nombre, P.Titulo, PM.NivelAcceso
FROM Usuarios U
LEFT JOIN Permisos PM ON U.Id = PM.UsuarioId
LEFT JOIN Paginas P ON PM.PaginaId = P.Id;

--UNION
SELECT Correo AS Informacion FROM Usuarios
UNION
SELECT Titulo AS Informacion FROM Paginas;

--CASE
SELECT U.Nombre, 
       CASE 
           WHEN PM.NivelAcceso = 'Admin' THEN 'Acceso Total'
           WHEN PM.NivelAcceso = 'Escritura' THEN 'Puede Editar'
           WHEN PM.NivelAcceso = 'Lectura' THEN 'Solo Lectura'
           ELSE 'Sin Acceso'
       END AS DescripcionAcceso
FROM Usuarios U
LEFT JOIN Permisos PM ON U.Id = PM.UsuarioId;



