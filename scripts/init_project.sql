-- Switch to master database
USE master;
GO

--Create Database for our project
CREATE DATABASE DataWarehouse;
GO

--Use our Database
USE DataWarehouse;
GO

--Create our schemas, logical blueprint of our database, for each layer
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
