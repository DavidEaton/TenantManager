/********************************* Markups (must have at least one markup in the DB) **************************/

SET IDENTITY_INSERT [dbo].[MarkUp] ON
GO
INSERT [dbo].[MarkUp] ([Id], [Amount], [DefaultMarkup], [Formula], [UseFormula], [Name], [Active]) VALUES (1, 1.1, 1, N'', 0, N'10%', 1)
GO
INSERT [dbo].[MarkUp] ([Id], [Amount], [DefaultMarkup], [Formula], [UseFormula], [Name], [Active]) VALUES (2, 1.2, 0, N'', 0, N'20%', 1)
GO
SET IDENTITY_INSERT [dbo].[MarkUp] OFF
GO

/********************* Settings (must have LogoUrl, QuoteTerms and Metric in the DB) ************************/
