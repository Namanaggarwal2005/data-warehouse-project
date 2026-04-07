/*
==============================================================
Create Database and Schemas
==============================================================

Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists.
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas
    within the database: 'bronze', 'silver', and 'gold'.

WARNING:
     if the database named as "DataWarehouse" already exists then it would cause an error
*/

USE master;
GO




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
