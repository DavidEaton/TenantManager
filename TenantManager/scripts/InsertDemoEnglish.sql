SET IDENTITY_INSERT [dbo].[Person] ON
GO
INSERT [dbo].[Person] ([Id], [LastName], [FirstName], [MiddleName], [Gender], [Birthday], [DriversLicenseNumber], [DriversLicenseIssued], [DriversLicenseExpiry], [DriversLicenseState], [AddressLine], [AddressCity], [AddressState], [AddressPostalCode]) VALUES (1, N'Smith', N'Steve', NULL, 0, CAST(N'1985-09-28T00:00:00.0000000' AS DateTime2), N'E350 844 25414', CAST(N'2020-09-28T00:00:00.0000000' AS DateTime2), CAST(N'2021-09-28T00:00:00.0000000' AS DateTime2), N'NE', N'123 Four Ave', N'City', N'NE', N'74444')
GO
INSERT [dbo].[Person] ([Id], [LastName], [FirstName], [MiddleName], [Gender], [Birthday], [DriversLicenseNumber], [DriversLicenseIssued], [DriversLicenseExpiry], [DriversLicenseState], [AddressLine], [AddressCity], [AddressState], [AddressPostalCode]) VALUES (2, N'Jones', N'Jane', N'J', 1, NULL, N'Z00 21 5636155', CAST(N'2019-09-28T00:00:00.0000000' AS DateTime2), CAST(N'2020-09-28T00:00:00.0000000' AS DateTime2), N'MI', N'321 Zero Street', N'Town', N'MI', N'68555')
GO
SET IDENTITY_INSERT [dbo].[Person] OFF
GO
SET IDENTITY_INSERT [dbo].[Organization] ON
GO
INSERT [dbo].[Organization] ([Id], [Name], [ContactId], [AddressLine], [AddressCity], [AddressState], [AddressPostalCode], [Note]) VALUES (1, N'WalMart', 1, N'555 Never Road', N'Metropolis', N'MI', N'68555', N'some notes regarding WalMart')
GO
INSERT [dbo].[Organization] ([Id], [Name], [ContactId], [AddressLine], [AddressCity], [AddressState], [AddressPostalCode], [Note]) VALUES (2, N'Kinkos', NULL, N'111 End Lane', N'Tinyton', N'MI', N'68222', N'another note')
GO
SET IDENTITY_INSERT [dbo].[Organization] OFF
GO
SET IDENTITY_INSERT [dbo].[Customer] ON
GO
INSERT [dbo].[Customer] ([Id], [CustomerType], [AllowMail], [AllowEmail], [AllowSms], [OrganizationId], [PersonId]) VALUES (2, 0, 0, 1, 1, 1, NULL)
GO
INSERT [dbo].[Customer] ([Id], [CustomerType], [AllowMail], [AllowEmail], [AllowSms], [OrganizationId], [PersonId]) VALUES (3, 0, 0, 0, 1, NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[Email] ON
GO
INSERT [dbo].[Email] ([Id], [Address], [IsPrimary], [OrganizationId], [PersonId]) VALUES (1, N'ss@ssmith.com', 1, NULL, 1)
GO
INSERT [dbo].[Email] ([Id], [Address], [IsPrimary], [OrganizationId], [PersonId]) VALUES (2, N'wally@walmart.com', 1, 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[Email] OFF
GO
SET IDENTITY_INSERT [dbo].[Phone] ON
GO
INSERT [dbo].[Phone] ([Id], [Number], [PhoneType], [IsPrimary], [OrganizationId], [PersonId]) VALUES (1, N'9896279206', 3, 1, NULL, 1)
GO
INSERT [dbo].[Phone] ([Id], [Number], [PhoneType], [IsPrimary], [OrganizationId], [PersonId]) VALUES (2, N'2315559999', 2, 1, 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[Phone] OFF
GO