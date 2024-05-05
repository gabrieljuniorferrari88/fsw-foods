BEGIN TRY

BEGIN TRAN;

-- CreateTable
CREATE TABLE [dbo].[Restaurant] (
    [id] INT NOT NULL IDENTITY(1,1),
    [name] NVARCHAR(1000) NOT NULL,
    [imageUrl] NVARCHAR(1000) NOT NULL,
    [deliveryFee] DECIMAL(10,2) NOT NULL,
    [deliveryTimeMinutes] INT NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [Restaurant_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [Restaurant_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[Category] (
    [id] INT NOT NULL IDENTITY(1,1),
    [name] NVARCHAR(1000) NOT NULL,
    [imageUrl] NVARCHAR(1000) NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [Category_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [Category_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[Product] (
    [id] INT NOT NULL IDENTITY(1,1),
    [name] NVARCHAR(1000) NOT NULL,
    [description] NVARCHAR(1000) NOT NULL,
    [imageUrl] NVARCHAR(1000) NOT NULL,
    [price] DECIMAL(10,2) NOT NULL,
    [discountPercentage] INT NOT NULL CONSTRAINT [Product_discountPercentage_df] DEFAULT 0,
    [restaurantId] INT NOT NULL,
    [categoryId] INT NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [Product_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [Product_pkey] PRIMARY KEY CLUSTERED ([id])
);

-- CreateTable
CREATE TABLE [dbo].[_CategoryToRestaurant] (
    [A] INT NOT NULL,
    [B] INT NOT NULL,
    CONSTRAINT [_CategoryToRestaurant_AB_unique] UNIQUE NONCLUSTERED ([A],[B])
);

-- CreateIndex
CREATE NONCLUSTERED INDEX [_CategoryToRestaurant_B_index] ON [dbo].[_CategoryToRestaurant]([B]);

-- AddForeignKey
ALTER TABLE [dbo].[Product] ADD CONSTRAINT [Product_restaurantId_fkey] FOREIGN KEY ([restaurantId]) REFERENCES [dbo].[Restaurant]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Product] ADD CONSTRAINT [Product_categoryId_fkey] FOREIGN KEY ([categoryId]) REFERENCES [dbo].[Category]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[_CategoryToRestaurant] ADD CONSTRAINT [_CategoryToRestaurant_A_fkey] FOREIGN KEY ([A]) REFERENCES [dbo].[Category]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[_CategoryToRestaurant] ADD CONSTRAINT [_CategoryToRestaurant_B_fkey] FOREIGN KEY ([B]) REFERENCES [dbo].[Restaurant]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
