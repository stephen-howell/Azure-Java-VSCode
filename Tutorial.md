# Tutorial: Developing and deploying a minimal CRUD web app on Azure with Java

This tutorial is broken down into a number of semi-independent *how-to's*, some of which are optional and others mandatory for understanding the subsequent how-to's. All of the steps and how-to's have been tested on Windows 10 and Ubuntu 19. This is a minimal CRUD app, so only Java 8 and SQL are used, no JPA or Spring etc. are used in the minimal app.

Operating System, applications and services used:
1. Windows 10 or Ubuntu (your choice, OSX should work but I don't have access to a Mac to test)
2. Visual Studio Code (and several extensions)
3. Azure App Services
4. Azure SQL Database

Prerequisite:
1. Setup your Azure account in advance of starting the tutorial
   1. If you're a student with an institutional email address, you can avail of Azure for Students (**not** Azure for Students *Starter*) 
      1. https://azure.microsoft.com/en-us/free/students/
   2. There is a free for 12 months (with some start credit for 30 days) Azure account 
      1. https://azure.microsoft.com/en-gb/free/

Let's get started:
1. [Setting up our Visual Studio Code development environment (Windows 10 and Ubuntu 19 options)](SettingupVSCodeDevEnv.md)
2. [Developing a minimal 'Hello World' Java app using Vaadin](DevelopingMinimalJavaVaadinApp.md)
3. [Creating an Azure SQL Database](CreatingAzureSQLDatabase.md)
   1. [Connecting and querying the database using VSCode](ConnectingQueryingDB.md)
4. [Using Vaadin UI components to Create Read Update Delete (CRUD) with more complex data](VaadinCRUD.md)
5. [Deploying the final app on Azure](DeployingAppAzureAppServices.md)
