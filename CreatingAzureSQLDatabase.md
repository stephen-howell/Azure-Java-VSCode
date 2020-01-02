# How-to: Create an Azure SQL Database

This how-to will require an Azure account, so if you don't have one yet:
1. If you're a student with an institutional email address, you can avail of Azure for Students (**not** Azure for Students *Starter*) https://azure.microsoft.com/en-us/free/students/
2. There is a free for 12 months (with some start credit for 30 days) Azure account https://azure.microsoft.com/en-gb/free/

Official docs: [Getting started with single databases in Azure SQL Database](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-single-database-quickstart-guide)

## Create a database on the Azure SQL Server
1. Login to the Azure Portal: https://portal.azure.com
2. Search (open the search bar with `G + /`) for `SQL databases`
3. Select `Add`
4. `Subscription`: If you have more than 1 subscription, ensure you select the correct one (e.g. if you have a student and work account, ensure you are on the correct one)
5. `Resource group`: If you already have an RG, select it here, or click `Create new`. I named it `VaadinRG` but any name you will remember will do
6. `Database name`: `VaadinDB`
7. `Server`: Select `Create new`
   1. `Server name`: this must be globally unique, so recommend using something like `<your name>VaddinServer`. I used `vaadintest2020`. **Your name will have to be different**. The final part of the URL `.database.windows.net` is automatically added in.
   2. `Server admin login`: *Your login name must not contain a SQL Identifier or a typical system name (like admin, administrator, sa, root, dbmanager, loginmanager, etc.) or a built-in database user or role (like dbo, guest, public, etc.)*; I used `vaadin_testuser`
   3.  `Password` and `Confirm password`: 
       1.  Your password must be at least 8 characters in length.
       2.  Your password must contain characters from three of the following categories – English uppercase letters, English lowercase letters, numbers (0-9), and non-alphanumeric characters (!, $, #, %, etc.).
   4.  `Location`: Choose the closest location to you, for me, being in Ireland, I chose `(Europe) North Europe`
   5.  Click Ok  
8.  `Want to use SQL elastic pool?`: No
9.  `Compute + storage`: Click `Configure database`, then `Looking for basic, standard, premium?`
10. Select `Basic` and drag the slider for DTUs all the way to the left for 100 MB and click `Apply`
12. Select `Next: Networking`: and on `Connectivity method` select `Public endpoint`
13. `Firewall rules`: 
    1.  `Allow Azure services and resources to access this server`: **Yes**
    2.  `Add current client IP address`: **Yes**
14. Skip the `Additional Settings` and `Tags` tabs and under `Review + create` note the `Estimated cost per month` should be approx $5 or €4.21. If it isn't make sure you have the correct settings in `Compute + storage`. This cost will come from your free credit (as a student or on the free trial) or from your work / personal account. This cost will be incurred even if you don't use the database after setting it up and following this tutorial - so **remember** to delete the server (and resource group) when you no longer need them
15. Click `Create` and once it's finished creating everything for you `Go to resource`

Next, we'll [connect to our new database with Visual Studio Code](ConnectingQueryingDB.md).