﻿USE [DBVareco]
GO
/****** Object:  StoredProcedure [dbo].[SPClienteActivar]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPClienteActivar] 
	@Cedula varchar(255)
AS
BEGIN

	SET NOCOUNT OFF;

	UPDATE Cliente set Activo = 1
	WHERE ClienteCedula = @Cedula;

	SELECT 1;
END
GO
/****** Object:  StoredProcedure [dbo].[SPClienteAgregar]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPClienteAgregar] 
	@Cedula varchar(255),
	@Nombre varchar(255),
	@Telefono varchar(255),
	@Correo varchar(255), 
	@Direccion varchar(255),
	@TipoID int
AS
BEGIN
	SET NOCOUNT OFF;
	
	INSERT INTO Cliente
	(ClienteCedula,ClienteNombre, ClienteTelefono, ClienteEmail,
	ClienteDireccion,TipoClienteID)
	VALUES
	(@Cedula,@Nombre,@Telefono,@Correo,@Direccion,@TipoID)

	SELECT 1;
END
GO
/****** Object:  StoredProcedure [dbo].[SPClienteEditar]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPClienteEditar] 
	@Cedula varchar(255),
	@Nombre varchar(255),
	@Telefono varchar(255),
	@Correo varchar(255), 
	@Direccion varchar(255),
	@TipoID int,
	@ID int
AS
BEGIN
	
	SET NOCOUNT OFF;

	IF @Cedula = ''
	BEGIN
		UPDATE Cliente SET
		ClienteCedula= @Cedula,
		ClienteNombre = @Nombre,
		ClienteTelefono = @Telefono,
		ClienteEmail = @Correo,
		ClienteDireccion = @Direccion,
		TipoClienteID = @TipoID
		WHERE ClienteID = @ID;
	END

	ELSE
	BEGIN
	UPDATE Cliente SET
		ClienteCedula= @Cedula,
		ClienteNombre = @Nombre,
		ClienteTelefono = @Telefono,
		ClienteEmail = @Correo,
		ClienteDireccion = @Direccion,
		TipoClienteID = @TipoID
		WHERE ClienteID = @ID;
	END

	SELECT 1;
END
GO
/****** Object:  StoredProcedure [dbo].[SPClienteEliminar]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPClienteEliminar] 
	@Cedula varchar(255)
AS
BEGIN

	SET NOCOUNT OFF;

	UPDATE Cliente set Activo = 0
	WHERE ClienteCedula = @Cedula;

	SELECT 1;
END
GO
/****** Object:  StoredProcedure [dbo].[SPConsultarCliente]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPConsultarCliente] 
	@Cedula varchar(255),
	@IDCedula INT
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT Cliente.ClienteID, Cliente.ClienteCedula, Cliente.ClienteNombre, Cliente.ClienteTelefono, Cliente.ClienteEmail,
	Cliente.ClienteDireccion, Cliente.Activo, TipoCliente.TipoClienteID, TipoCliente.TipoClienteDescripcion
	FROM Cliente INNER JOIN
    TipoCliente ON Cliente.TipoClienteID = TipoCliente.TipoClienteID
	WHERE ClienteCedula = @Cedula OR ClienteID = @IDCedula;

END
GO
/****** Object:  StoredProcedure [dbo].[SPConsultarPedido]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPConsultarPedido] 
	@IDPedido int,
	@IDProducto int
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT Pedido.PedidoID, Pedido.PedidoFecha, Pedido.PedidoFechaEntraga,Pedido.PedidoNotas,
		Cliente.ClienteNombre, Usuario.UsuarioNombre,Producto.ProductoID, Producto.ProductoNombre,
		EstadoPedido.EstadoPedidoID AS ID,
		EstadoPedido.EstadoPedidoDescripcion as TIPO, PedidoDetalle.pedidoDetalleCantidad,
		PedidoDetalle.pedidoDetallePrecio
		FROM Pedido INNER JOIN Usuario ON Pedido.UsuarioID = Usuario.UsuarioID
		INNER JOIN Cliente ON Cliente.ClienteID = Pedido.ClienteID INNER JOIN
		EstadoPedido ON EstadoPedido.EstadoPedidoID = Pedido.EstadoPedidoID INNER JOIN 
		PedidoDetalle ON PedidoDetalle.PedidoID = Pedido.PedidoID INNER JOIN Producto ON
		Producto.ProductoID = PedidoDetalle.ProductoID
		WHERE Pedido.PedidoID = @IDPedido AND
		(PedidoDetalle.ProductoID = @IDProducto) AND
		(pedidoDetalle.PedidoID = @IDPedido )
		
	

END
GO
/****** Object:  StoredProcedure [dbo].[SPConsultarPedidoID]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Josue Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPConsultarPedidoID] 
	@IDPedido int 
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT Pedido.PedidoID, Pedido.PedidoFecha, Pedido.PedidoFechaEntraga,Pedido.PedidoNotas,
		Cliente.ClienteNombre, Usuario.UsuarioNombre,
		EstadoPedido.EstadoPedidoID AS ID,
		EstadoPedido.EstadoPedidoDescripcion as TIPO 
		FROM Pedido INNER JOIN Usuario ON Pedido.UsuarioID = Usuario.UsuarioID
		INNER JOIN Cliente ON Cliente.ClienteID = Pedido.ClienteID INNER JOIN
		EstadoPedido ON EstadoPedido.EstadoPedidoID = Pedido.EstadoPedidoID 
		WHERE(Pedido.PedidoID = @IDPedido)
   
END
GO
/****** Object:  StoredProcedure [dbo].[SPConsultarProducto]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPConsultarProducto]
	@IDProducto INT
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT ProductoID, ProductoNombre, ProductoStock, ProductoNotas, Activo, 
	ProductoPrecio
	FROM Producto WHERE  ProductoID = @IDProducto;

END
GO
/****** Object:  StoredProcedure [dbo].[SPConsultarUsuario]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPConsultarUsuario] 
	@Cedula varchar(255),
	@IDUsuario INT
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT Usuario.UsuarioID, Usuario.UsuarioCorreo, Usuario.UsuarioContrasenia, Usuario.UsuarioNombre, 
	Usuario.UsuarioCedula, Usuario.UsuarioTelefono, Usuario.UsuarioDireccion, Usuario.Activo, UsuarioRol.UsuarioRolID, 
    UsuarioRol.UsuarioRolDescripcion
	FROM Usuario INNER JOIN
    UsuarioRol ON Usuario.UsuarioRolID = UsuarioRol.UsuarioRolID
	WHERE Usuario.UsuarioCedula= @Cedula OR Usuario.UsuarioID = @IDUsuario;

END
GO
/****** Object:  StoredProcedure [dbo].[SPListarActivosClientes]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPListarActivosClientes] 
	@filtroBusqueda varchar(255) = ''
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @filtro varchar(255)
	SET @filtro = '%' + @filtroBusqueda + '%'

	IF @filtroBusqueda IS NULL OR @filtroBusqueda = ''
		BEGIN

		SELECT 
			Cliente.ClienteID, 
			Cliente.ClienteCedula, 
			Cliente.ClienteNombre,
			Cliente.ClienteTelefono, 
			Cliente.ClienteEmail, 
			TipoCliente.TipoClienteDescripcion AS TIPO
		FROM Cliente INNER JOIN
			TipoCliente ON Cliente.TipoClienteID = TipoCliente.TipoClienteID
		WHERE Cliente.Activo = 1;
		END

	ELSE
	BEGIN

	SELECT 
			Cliente.ClienteID, 
			Cliente.ClienteCedula, 
			Cliente.ClienteNombre,
			Cliente.ClienteTelefono, 
			Cliente.ClienteEmail, 
			TipoCliente.TipoClienteDescripcion AS TIPO
		FROM Cliente INNER JOIN
			TipoCliente ON Cliente.TipoClienteID = TipoCliente.TipoClienteID
			WHERE (Cliente.Activo = 1) AND (ClienteNombre LIKE @filtro) 
			OR (Cliente.Activo = 1) AND (ClienteTelefono LIKE @filtro);

	END

END
GO
/****** Object:  StoredProcedure [dbo].[SPListarActivosPedidos]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPListarActivosPedidos] 
	@filtroBusqueda varchar(255) = ''

AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @filtro varchar(255)
	SET @filtro = '%' + @filtroBusqueda + '%'

	IF @filtroBusqueda IS NULL OR @filtroBusqueda = ''
		BEGIN

		SELECT Pedido.PedidoID, Pedido.PedidoFecha, Pedido.PedidoFechaEntraga,
		Cliente.ClienteNombre, Usuario.UsuarioNombre,Producto.ProductoID, Producto.ProductoNombre,
		EstadoPedido.EstadoPedidoDescripcion as TIPO
		FROM Pedido INNER JOIN Usuario ON Pedido.UsuarioID = Usuario.UsuarioID
		INNER JOIN Cliente ON Cliente.ClienteID = Pedido.ClienteID INNER JOIN
		EstadoPedido ON EstadoPedido.EstadoPedidoID = Pedido.EstadoPedidoID INNER JOIN 
		PedidoDetalle ON PedidoDetalle.PedidoID = Pedido.PedidoID INNER JOIN Producto ON
		Producto.ProductoID = PedidoDetalle.ProductoID
		WHERE Pedido.Activo = 1 order by Pedido.PedidoID;;
	END
	ELSE
	BEGIN
		SELECT Pedido.PedidoID, Pedido.PedidoFecha, Pedido.PedidoFechaEntraga,
		Cliente.ClienteNombre, Usuario.UsuarioNombre, Producto.ProductoNombre,
		EstadoPedido.EstadoPedidoDescripcion as TIPO
		FROM Pedido INNER JOIN Usuario ON Pedido.UsuarioID = Usuario.UsuarioID
		INNER JOIN Cliente ON Cliente.ClienteID = Pedido.ClienteID INNER JOIN
		EstadoPedido ON EstadoPedido.EstadoPedidoID = Pedido.EstadoPedidoID INNER JOIN 
		PedidoDetalle ON PedidoDetalle.PedidoID = Pedido.PedidoID INNER JOIN Producto ON
		Producto.ProductoID = PedidoDetalle.ProductoID
		WHERE (Pedido.Activo = 1) AND (Cliente.ClienteNombre LIKE @filtro) OR
			  (Pedido.Activo = 1) AND (Usuario.UsuarioNombre LIKE @filtro) OR
			  (Pedido.Activo = 1) AND (Producto.ProductoNombre LIKE @filtro) OR
			  (Pedido.Activo = 1) AND (EstadoPedido.EstadoPedidoDescripcion LIKE @filtro)
	END



END
GO
/****** Object:  StoredProcedure [dbo].[SPListarActivosProductos]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPListarActivosProductos] 
	@filtroBusqueda varchar(255) = ''
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @filtro varchar(255)
	SET @filtro = '%' + @filtroBusqueda + '%'

	IF @filtroBusqueda IS NULL OR @filtroBusqueda = ''
		BEGIN

		SELECT 
		ProductoNombre, ProductoStock, ProductoID, ProductoPrecio
		FROM  Producto
		WHERE Producto.Activo = 1;
	
	END

	ELSE
	BEGIN

		SELECT 
		ProductoNombre, ProductoStock, ProductoID, ProductoPrecio
		FROM  Producto	
		WHERE (Producto.Activo = 1) AND (ProductoNombre LIKE @filtro);

	END

END
GO
/****** Object:  StoredProcedure [dbo].[SPListarActivosUsuarios]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPListarActivosUsuarios] 
	@filtroBusqueda varchar(255) = ''
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @filtro varchar(255)
	SET @filtro = '%' + @filtroBusqueda + '%'

	IF @filtroBusqueda IS NULL OR @filtroBusqueda = ''
	BEGIN


	SELECT        Usuario.UsuarioID,
				  Usuario.UsuarioNombre,
				  Usuario.UsuarioCorreo,
				  Usuario.UsuarioCedula,
				  Usuario.UsuarioTelefono,
				  UsuarioRol.UsuarioRolDescripcion AS TIPO
	FROM          Usuario INNER JOIN
                  UsuarioRol ON Usuario.UsuarioRolID = UsuarioRol.UsuarioRolID
				  where Usuario.Activo = 1;
	END
	ELSE
	BEGIN

	SELECT		  Usuario.UsuarioID,
				  Usuario.UsuarioNombre,
				  Usuario.UsuarioCorreo,
				  Usuario.UsuarioCedula,
				  Usuario.UsuarioTelefono,
				  UsuarioRol.UsuarioRolDescripcion AS TIPO
	FROM          Usuario INNER JOIN
                  UsuarioRol ON Usuario.UsuarioRolID = UsuarioRol.UsuarioRolID
				  where (Usuario.Activo = 1) AND (UsuarioNombre LIKE @filtro) 
				  OR (Usuario.Activo = 1) AND (UsuarioTelefono LIKE @filtro);

	END

END
GO
/****** Object:  StoredProcedure [dbo].[SPListarEstadoPedido]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPListarEstadoPedido]

AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT EstadoPedidoID AS ID, EstadoPedidoDescripcion AS Descripcion
	FROM EstadoPedido
END
GO
/****** Object:  StoredProcedure [dbo].[SPListarInactivosClientes]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPListarInactivosClientes] 
	@filtroBusqueda varchar(255) = ''
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @filtro varchar(255)
	SET @filtro = '%' + @filtroBusqueda + '%'

	IF @filtroBusqueda IS NULL OR @filtroBusqueda = ''
		BEGIN

		SELECT 
			Cliente.ClienteID, 
			Cliente.ClienteCedula, 
			Cliente.ClienteNombre,
			Cliente.ClienteTelefono, 
			Cliente.ClienteEmail, 
			TipoCliente.TipoClienteDescripcion AS TIPO
		FROM Cliente INNER JOIN
			TipoCliente ON Cliente.TipoClienteID = TipoCliente.TipoClienteID
		WHERE Cliente.Activo = 0;
		END

	ELSE
	BEGIN

	SELECT 
			Cliente.ClienteID, 
			Cliente.ClienteCedula, 
			Cliente.ClienteNombre,
			Cliente.ClienteTelefono, 
			Cliente.ClienteEmail, 
			TipoCliente.TipoClienteDescripcion AS TIPO
		FROM Cliente INNER JOIN
			TipoCliente ON Cliente.TipoClienteID = TipoCliente.TipoClienteID
			WHERE (Cliente.Activo = 0) AND (ClienteNombre LIKE @filtro) 
			OR (Cliente.Activo = 0) AND (ClienteTelefono LIKE @filtro);

	END

END
GO
/****** Object:  StoredProcedure [dbo].[SPListarInactivosPedidos]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPListarInactivosPedidos] 
	@filtroBusqueda varchar(255) = ''

AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @filtro varchar(255)
	SET @filtro = '%' + @filtroBusqueda + '%'

	IF @filtroBusqueda IS NULL OR @filtroBusqueda = ''
		BEGIN

		SELECT Pedido.PedidoID, Pedido.PedidoFecha, Pedido.PedidoFechaEntraga,
		Cliente.ClienteNombre, Usuario.UsuarioNombre,Producto.ProductoID, Producto.ProductoNombre,
		EstadoPedido.EstadoPedidoDescripcion as TIPO
		FROM Pedido INNER JOIN Usuario ON Pedido.UsuarioID = Usuario.UsuarioID
		INNER JOIN Cliente ON Cliente.ClienteID = Pedido.ClienteID INNER JOIN
		EstadoPedido ON EstadoPedido.EstadoPedidoID = Pedido.EstadoPedidoID INNER JOIN 
		PedidoDetalle ON PedidoDetalle.PedidoID = Pedido.PedidoID INNER JOIN Producto ON
		Producto.ProductoID = PedidoDetalle.ProductoID
		WHERE Pedido.Activo = 0 order by Pedido.PedidoID;;
	END
	ELSE
	BEGIN
		SELECT Pedido.PedidoID, Pedido.PedidoFecha, Pedido.PedidoFechaEntraga,
		Cliente.ClienteNombre, Usuario.UsuarioNombre, Producto.ProductoNombre,
		EstadoPedido.EstadoPedidoDescripcion as TIPO
		FROM Pedido INNER JOIN Usuario ON Pedido.UsuarioID = Usuario.UsuarioID
		INNER JOIN Cliente ON Cliente.ClienteID = Pedido.ClienteID INNER JOIN
		EstadoPedido ON EstadoPedido.EstadoPedidoID = Pedido.EstadoPedidoID INNER JOIN 
		PedidoDetalle ON PedidoDetalle.PedidoID = Pedido.PedidoID INNER JOIN Producto ON
		Producto.ProductoID = PedidoDetalle.ProductoID
		WHERE (Pedido.Activo = 0) AND (Cliente.ClienteNombre = @filtro) OR
			  (Pedido.Activo = 0) AND (Usuario.UsuarioNombre = @filtro) OR
			  (Pedido.Activo = 0) AND (Producto.ProductoNombre = @filtro) OR
			  (Pedido.Activo = 0) AND (EstadoPedido.EstadoPedidoDescripcion = @filtro)
	END



END
GO
/****** Object:  StoredProcedure [dbo].[SPListarInactivosProductos]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPListarInactivosProductos] 
	@filtroBusqueda varchar(255) = ''
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @filtro varchar(255)
	SET @filtro = '%' + @filtroBusqueda + '%'

	IF @filtroBusqueda IS NULL OR @filtroBusqueda = ''
		BEGIN

		SELECT 
		ProductoNombre, ProductoStock, ProductoID, ProductoPrecio
		FROM  Producto
		WHERE Producto.Activo = 0;
	
	END

	ELSE
	BEGIN

		SELECT 
		ProductoNombre, ProductoStock, ProductoID, ProductoPrecio
		FROM  Producto
		WHERE (Producto.Activo = 0) AND (ProductoNombre LIKE @filtro);

	END

END
GO
/****** Object:  StoredProcedure [dbo].[SPListarInactivosUsuarios]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPListarInactivosUsuarios] 
	@filtroBusqueda varchar(255) = ''
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @filtro varchar(255)
	SET @filtro = '%' + @filtroBusqueda + '%'

	IF @filtroBusqueda IS NULL OR @filtroBusqueda = ''
	BEGIN


	SELECT        Usuario.UsuarioID,
				  Usuario.UsuarioNombre,
				  Usuario.UsuarioCorreo,
				  Usuario.UsuarioCedula,
				  Usuario.UsuarioTelefono,
				  UsuarioRol.UsuarioRolDescripcion AS TIPO
	FROM          Usuario INNER JOIN
                  UsuarioRol ON Usuario.UsuarioRolID = UsuarioRol.UsuarioRolID
				  where Usuario.Activo = 0;
	END
	ELSE
	BEGIN

	SELECT		  Usuario.UsuarioID,
				  Usuario.UsuarioNombre,
				  Usuario.UsuarioCorreo,
				  Usuario.UsuarioCedula,
				  Usuario.UsuarioTelefono,
				  UsuarioRol.UsuarioRolDescripcion AS TIPO
	FROM          Usuario INNER JOIN
                  UsuarioRol ON Usuario.UsuarioRolID = UsuarioRol.UsuarioRolID
				  where (Usuario.Activo = 0) AND (UsuarioNombre LIKE @filtro) 
				  OR (Usuario.Activo = 0) AND (UsuarioTelefono LIKE @filtro);

	END

END
GO
/****** Object:  StoredProcedure [dbo].[SPListarTipoCliente]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPListarTipoCliente]

AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT TipoClienteID AS ID, TipoClienteDescripcion AS Descripcion
	FROM TipoCliente
END
GO
/****** Object:  StoredProcedure [dbo].[SPListarUsuarioRol]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPListarUsuarioRol] 

AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT UsuarioRolID AS ID, UsuarioRolDescripcion AS Descripcion
	FROM UsuarioRol
END
GO
/****** Object:  StoredProcedure [dbo].[SPPedidoActivar]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPPedidoActivar] 
	@IDPedido INT
AS
BEGIN

	SET NOCOUNT OFF;

	UPDATE Pedido set Activo = 1
	WHERE PedidoID = @IDPedido;

	SELECT 1;
END
GO
/****** Object:  StoredProcedure [dbo].[SPPedidoAgregar]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPPedidoAgregar] 

	@IDCliente int, 
	@EstadoPedido int,
	@IDUsuario int,
	@Notas varchar(2000),
	@FechaEntrega date
AS
BEGIN
	
	SET NOCOUNT OFF;

	INSERT INTO Pedido(ClienteID, EstadoPedidoID, UsuarioID, PedidoNotas, PedidoFechaEntraga)
	VALUES (@IDCliente, @EstadoPedido,@IDUsuario,@Notas,@FechaEntrega)
	
	SELECT SCOPE_IDENTITY() AS ID


   
END
GO
/****** Object:  StoredProcedure [dbo].[SPPedidoDetalleAgregar]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPPedidoDetalleAgregar] 
	@IDPedido int,
	@IDProducto int,
	@Cantidad int,
	@Precio decimal(18,2)
AS
BEGIN

	SET NOCOUNT OFF;
	
	INSERT INTO PedidoDetalle
	(PedidoID, ProductoID,pedidoDetalleCantidad, pedidoDetallePrecio)
	VALUES (@IDPedido,@IDProducto,@Cantidad,@Precio);

	SELECT 1
END
GO
/****** Object:  StoredProcedure [dbo].[SPPedidoDetalleEditar]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPPedidoDetalleEditar] 
	@IDPedido int,
	@ProductoID INT,
	@pedidoDetalleCantidad INT
AS
BEGIN

	SET NOCOUNT OFF;
	
	DECLARE @ProductoPrecio DECIMAL(10, 2)

	SELECT @ProductoPrecio = Producto.ProductoPrecio
	FROM Producto
	WHERE Producto.ProductoID = @ProductoID

	UPDATE PedidoDetalle SET
	pedidoDetalleCantidad = @pedidoDetalleCantidad,
	pedidoDetallePrecio = @ProductoPrecio * @pedidoDetalleCantidad
	WHERE PedidoDetalle.PedidoID = @IDPedido AND PedidoDetalle.ProductoID = @ProductoID

	SELECT 1
END
GO
/****** Object:  StoredProcedure [dbo].[SPPedidoDetalleEsquema]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Volmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPPedidoDetalleEsquema] 
	
	
AS
BEGIN
	SET NOCOUNT ON;

	SELECT PedidoDetalle.ProductoID, PedidoDetalle.pedidoDetalleCantidad,
	PedidoDetalle.pedidoDetallePrecio, Producto.ProductoNombre
	FROM   PedidoDetalle INNER JOIN
    Producto ON PedidoDetalle.ProductoID = Producto.ProductoID
  
	
END
GO
/****** Object:  StoredProcedure [dbo].[SPPedidoEditar]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPPedidoEditar] 
	@IDPedido INT,
	@PedidoFechaEntraga DATE,
	@PedidoNotas VARCHAR(2000),
	@EstadoPedidoID INT
AS
BEGIN
	
	SET NOCOUNT OFF;

	UPDATE Pedido SET
		   PedidoFechaEntraga = @PedidoFechaEntraga,
		   PedidoNotas = @PedidoNotas,
		   pedido.EstadoPedidoID = @EstadoPedidoID
	WHERE PedidoID = @IDPedido 
	
	SELECT 1;

END
GO
/****** Object:  StoredProcedure [dbo].[SPPedidoEliminar]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPPedidoEliminar] 
	@IDPedido INT
AS
BEGIN

	SET NOCOUNT OFF;

	UPDATE Pedido set Activo = 0
	WHERE PedidoID = @IDPedido;

	SELECT 1;
END
GO
/****** Object:  StoredProcedure [dbo].[SPProductoActivar]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPProductoActivar] 
	@Nombre varchar(255)
AS
BEGIN

	SET NOCOUNT OFF;

	UPDATE Producto set Activo = 1
	WHERE ProductoNombre = @Nombre;

	SELECT 1;
END
GO
/****** Object:  StoredProcedure [dbo].[SPProductoAgregar]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPProductoAgregar] 
	@Nombre varchar(255),
	@Stock int,
	@Precio decimal(18,2),
	@Notas varchar(255)
AS
BEGIN
	SET NOCOUNT OFF;
	
	INSERT INTO Producto
	(ProductoNombre, ProductoStock, ProductoPrecio, ProductoNotas)
	VALUES
	(@Nombre,@Stock,@Precio, @Notas)

	SELECT 1;
END
GO
/****** Object:  StoredProcedure [dbo].[SPProductoEditar]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPProductoEditar] 
	
	@Nombre varchar(255),
	@Stock int,
	@Precio decimal(18,2),
	@Notas varchar(255),
	
	@ID int
AS
BEGIN
	
	SET NOCOUNT OFF;

	UPDATE Producto SET
	
		ProductoNombre = @Nombre,
		ProductoStock = @Stock,
		ProductoPrecio = @Precio,
		ProductoNotas = @Notas

		WHERE ProductoID = @ID;
	

	SELECT 1;
END
GO
/****** Object:  StoredProcedure [dbo].[SPProductoEliminar]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPProductoEliminar] 
	@Nombre varchar(255)
AS
BEGIN

	SET NOCOUNT OFF;

	UPDATE Producto set Activo = 0
	WHERE ProductoNombre = @Nombre;

	SELECT 1;
END
GO
/****** Object:  StoredProcedure [dbo].[SPUsuarioActivar]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPUsuarioActivar]
	@Cedula varchar(255)
AS
BEGIN

	SET NOCOUNT OFF;

	UPDATE Usuario set Activo = 1
	WHERE UsuarioCedula = @Cedula;

	SELECT 1;
END
GO
/****** Object:  StoredProcedure [dbo].[SPUsuarioAgregar]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPUsuarioAgregar] 
	@Correo varchar(255), 
	@Contrasenia varchar(255),
	@Nombre varchar(255),
	@Cedula varchar(255),
	@Telefono varchar(255),
	@Direccion varchar(255),
	@RolID int
AS
BEGIN
	SET NOCOUNT OFF;
	
	INSERT INTO Usuario
	(UsuarioNombre, UsuarioCedula, UsuarioTelefono, UsuarioDireccion, UsuarioCorreo,UsuarioContrasenia,UsuarioRolID)
	VALUES
	(@Nombre,@Cedula,@Telefono, @Direccion, @Correo,@Contrasenia,@RolID)

	SELECT 1;
END
GO
/****** Object:  StoredProcedure [dbo].[SPUsuarioEditar]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPUsuarioEditar] 
	-- Add the parameters for the stored procedure here
	@Correo varchar(255), 
	@Contrasenia varchar(255) = '',
	@Nombre varchar(255),
	@Cedula varchar(255),
	@Telefono varchar(255),
	@Direccion varchar(255),
	@RolID int,
	@ID int
AS
BEGIN
	
	SET NOCOUNT OFF;

	IF @Contrasenia IS NULL OR @Cedula = ''
	BEGIN
		UPDATE Usuario SET
		UsuarioCorreo = @Correo,
		UsuarioNombre = @Nombre,
		UsuarioCedula = @Cedula,
		UsuarioTelefono = @Telefono,
		UsuarioDireccion = @Direccion,
		UsuarioRolID = @RolID
		WHERE UsuarioID = @ID
	END

	ELSE
	BEGIN
	UPDATE Usuario SET
		UsuarioCorreo = @Correo,
		UsuarioNombre = @Nombre,
		UsuarioCedula = @Cedula,
		UsuarioTelefono = @Telefono,
		UsuarioDireccion = @Direccion,
		UsuarioRolID = @RolID,
		UsuarioContrasenia = @Contrasenia
		WHERE UsuarioID = @ID
	END

	SELECT 1;
END
GO
/****** Object:  StoredProcedure [dbo].[SPUsuarioEliminar]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPUsuarioEliminar] 
	@Cedula varchar(255)
AS
BEGIN

	SET NOCOUNT OFF;

	UPDATE Usuario set Activo = 0
	WHERE UsuarioCedula = @Cedula;

	SELECT 1;
END
GO
/****** Object:  StoredProcedure [dbo].[SPUsuarioValidarSesion]    Script Date: 09/12/2023 18:33:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vólmar Carvajal
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SPUsuarioValidarSesion] 
	@correo varchar(255),
	@contrasenia varchar(255)
AS
BEGIN
	
	SET NOCOUNT ON;

SELECT        Usuario.UsuarioID, Usuario.UsuarioCorreo, Usuario.UsuarioContrasenia, Usuario.UsuarioNombre, Usuario.UsuarioCedula, Usuario.UsuarioTelefono,
			  Usuario.UsuarioDireccion, 
			  Usuario.Activo, UsuarioRol.UsuarioRolID, 
              UsuarioRol.UsuarioRolDescripcion
FROM          Usuario INNER JOIN UsuarioRol ON Usuario.UsuarioRolID = UsuarioRol.UsuarioRolID

WHERE		  Usuario.UsuarioCorreo = @correo AND UsuarioContrasenia = @contrasenia and Usuario.Activo = 1

    
END
GO
