USE master
GO

CREATE DATABASE DBVareco
USE DBVareco

CREATE TABLE Usuario (
  UsuarioID          int IDENTITY NOT NULL, 
  UsuarioCorreo      varchar(255) NOT NULL, 
  UsuarioContrasenia varchar(255) NOT NULL, 
  UsuarioNombre      varchar(255) NOT NULL, 
  UsuarioCedula      varchar(255) NOT NULL, 
  UsuarioTelefono    varchar(255) NOT NULL, 
  UsuarioDireccion   varchar(2000) NULL, 
  Activo             bit DEFAULT '1' NOT NULL, 
  UsuarioRolID       int NOT NULL);
CREATE TABLE Cliente (
  ClienteID        int IDENTITY NOT NULL, 
  ClienteCedula    varchar(255) NOT NULL, 
  ClienteNombre    varchar(255) NOT NULL, 
  ClienteTelefono  varchar(255) NOT NULL, 
  ClienteEmail     varchar(255) NULL, 
  ClienteDireccion varchar(2000) NULL, 
  Activo           bit DEFAULT '1' NOT NULL, 
  TipoClienteID    int NOT NULL);
CREATE TABLE Pedido (
  PedidoID           int IDENTITY NOT NULL, 
  PedidoNumero       int NOT NULL, 
  PedidoFecha        date DEFAULT GETDATE() NOT NULL, 
  PedidoFechaEntraga date NOT NULL, 
  PedidoNotas        varchar(2000) NULL, 
  Activo             bit DEFAULT '1' NOT NULL, 
  EstadoPedidoID     int NOT NULL, 
  ClienteID          int NOT NULL, 
  UsuarioID          int NOT NULL);
CREATE TABLE UsuarioRol (
  UsuarioRolID          int IDENTITY NOT NULL, 
  UsuarioRolDescripcion varchar(255) NOT NULL);
CREATE TABLE EstadoPedido (
  EstadoPedidoID          int IDENTITY NOT NULL, 
  EstadoPedidoDescripcion varchar(255) NOT NULL);
CREATE TABLE Producto (
  ProductoID     int IDENTITY NOT NULL, 
  ProductoNombre varchar(255) NOT NULL, 
  ProductoStock  int NOT NULL, 
  ProductoPrecio decimal(18, 2) NOT NULL, 
  ProductoNotas  varchar(2000) NULL, 
  Activo         bit DEFAULT '1' NOT NULL);
CREATE TABLE TipoCliente (
  TipoClienteID          int IDENTITY NOT NULL, 
  TipoClienteDescripcion varchar(255) NOT NULL);
CREATE TABLE PedidoDetalle (
  pedidoDetalleCantidad int NOT NULL, 
  pedidoDetallePrecio   decimal(18, 2) NOT NULL, 
  PedidoID              int NOT NULL, 
  ProductoID            int NOT NULL);
