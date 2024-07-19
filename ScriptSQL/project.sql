	USE [master]
	GO
	CREATE DATABASE [MobileCRUD2]
	GO
	USE [MobileCRUD2]
	GO
	DROP TABLE tbl_Cart
	DROP TABLE tbl_Mobile
	DROP TABLE tbl_User
CREATE TABLE [dbo].[tbl_Cart] (
	[cartId] [int] IDENTITY(1,1) NOT NULL,
	[userId] varchar(50),
	[mobileId] varchar(50),
	[quantity] [int],
PRIMARY KEY CLUSTERED ([cartId] ASC)
)


CREATE TABLE [dbo].[tbl_Mobile] (
	[mobileId] varchar(50) NOT NULL,
	[description] varchar(50) NOT NULL,
	[price] [float],
	[mobileName] varchar(50) NOT NULL,
	[yearOfProduction] [int],
	[quantity] [int],
	[notSale] [bit] DEFAULT ((0)),
	[image] varchar(200),
PRIMARY KEY CLUSTERED ([mobileId] ASC)
)
GO
	CREATE TABLE [dbo].[tbl_User] (
		[userId] varchar(50) NOT NULL,
		[password] [int] NOT NULL,
		[fullName] varchar(50) NOT NULL,
		[role] [int] CHECK ([role] IN (2, 1, 0)),
	PRIMARY KEY CLUSTERED ([userId] ASC)	
	)
	GO

	SET IDENTITY_INSERT [dbo].[tbl_Cart] ON 
	INSERT [dbo].[tbl_Cart] ([cartId], [userId], [mobileId], [quantity]) VALUES (12, N'user_Tony', N'M003', 1)
	INSERT [dbo].[tbl_Cart] ([cartId], [userId], [mobileId], [quantity]) VALUES (13, N'user_Tony', N'M003', 1)
	INSERT [dbo].[tbl_Cart] ([cartId], [userId], [mobileId], [quantity]) VALUES (14, N'user_Tony', N'M002', 1)
	SET IDENTITY_INSERT [dbo].[tbl_Cart] OFF
	INSERT [dbo].[tbl_Mobile] ([mobileId], [description], [price], [mobileName], [yearOfProduction], [quantity], [notSale],[image]) VALUES (N'M001', N'A30', 700, N'Samsung', 2019, 19, 0,N'https://images3.pricecheck.co.za/images/objects/hash/product/f4c/645/b10/image_big_156334046.jpg?1561378592')
	INSERT [dbo].[tbl_Mobile] ([mobileId], [description], [price], [mobileName], [yearOfProduction], [quantity], [notSale],[image]) VALUES (N'M002', N'15', 1000, N'Iphone', 2023, 9, 0,N'https://jasystore.com/wp-content/uploads/2021/12/apple-iphone-15-1-500x500.jpg')
	INSERT [dbo].[tbl_Mobile] ([mobileId], [description], [price], [mobileName], [yearOfProduction], [quantity], [notSale],[image]) VALUES (N'M003', N'G7', 650, N'LG', 2019, 31, 0,N'https://www.lg.com/us/mobile-phones/g7-thinq/images/hero-G7-discover-m.png')
	INSERT [dbo].[tbl_User] ([userId], [password], [fullName], [role]) VALUES (N'manager_Jenifer', 123, N'Jenifer', 1)
	INSERT [dbo].[tbl_User] ([userId], [password], [fullName], [role]) VALUES (N'staff_Chau', 123, N'Chau', 0)
	INSERT [dbo].[tbl_User] ([userId], [password], [fullName], [role]) VALUES (N'user_Tony', 123, N'Tony', 2)
	ALTER TABLE [dbo].[tbl_Cart]  WITH CHECK ADD FOREIGN KEY([mobileId]) REFERENCES [dbo].[tbl_Mobile] ([mobileId])
	ALTER TABLE [dbo].[tbl_Cart]  WITH CHECK ADD FOREIGN KEY([userId]) REFERENCES [dbo].[tbl_User] ([userId])
	GO

	use MobileCRUD2
	select * from tbl_Cart

	INSERT INTO tbl_Cart (userId, mobileId, quantity) VALUES ('user_Tony', 'M002', 1);
	DELETE FROM tbl_Cart WHERE userId = 'user_Tony' AND mobileId = 'M002';

	SELECT M.price, C.quantity FROM tbl_Cart C JOIN tbl_Mobile M ON C.mobileId = M.mobileId WHERE C.userId = 'user_Tony'

UPDATE tbl_Cart SET quantity = quantity + 1 WHERE userId = 'user_Tony' AND mobileId = 'M002'
SELECT quantity FROM tbl_Cart WHERE userId = 'user_Tony' AND mobileId = 'M002';
