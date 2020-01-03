# How-to: Working with Azure SQL Databases using Visual Studio Code

(This How-to assumes you have followed the [Creating a Azure SQL Database](CreatingAzureSQLDatabase.md) steps *or* have an Azure account with a SQL Database already recreated).

Ensure you have the [SQL Server (mssql)](https://marketplace.visualstudio.com/items?itemName=ms-mssql.mssql) installed (or in VSCode, `CTRL + SHIFT + X`, search for `SQL Server (mssql)`).

## Steps to connect:
1. Open the SQL Server extension `CTRL + ALT + D`
2. Click `+ Add Connection`
3. In the command palette, enter the details of your SQL server (Azure Database) instance (assuming you have followed the previous steps in [Creating a Azure SQL Database](CreatingAzureSQLDatabase.md)):
   1. Server name: `vaadintest2020.database.windows.net` (your server name will be different...)
   2. Database name: `VaadinDB`
   3. Authentication type: `SQL Login`
   4. User name: `vaadin_testuser`
   5. Password: *the password you set for the database*
   6. Save password: `Yes`
   7. If you are asked *mssql: Account signed In. Create new firewall rule?* select `Create Firewall Rule` and accept the Start and End IP addresses. If you are on a VPN you may need to change the IP addresses to suit.

Should you receive an error from the extension as follows: *"mssql: Your client IP address does not have access to the server. Download and install the Azure Account extension to sign in to an Azure account and create a new firewall rule to enable access."* the simplest solution is to click `Download and Install` that accompanies the error. This will propose you install the `Azure Account` extension, which allows you to connect to and manage Azure from VS Code. Once installed, it will give you the message: *mssql: Azure Account extension activated. Sign in to an Azure account?*. You will have a choice of `Azure: Sign In` and `Azure: Sign In with Device Code`. Once you are signed in (either with the browser message *You are signed in now and can close this page.*), you can try the steps above again. 

## Creating and populating a database table

We can now execute arbitrary SQL statements on the connected database.
If you don't want to type all the statements below yourself (or don't want to copy and paste from here), they are all available in a [file](database.sql)).

In VSCode, open a folder and create a new file:
1. `CTRL + O`, select a folder, I created a `Documents\Code` folder, but an existing project is fine too
2. `CTRL + N` to create a file, name it `database.sql`
3. Add the following SQL statements to the file (I use Mockaroo.com to create these, it's brilliant for creating mock data in a hurry)
```SQL
create table Zoo (
	id INT,
	animal VARCHAR(50),
	colour VARCHAR(50),
	amount INT
);
```
4. Select the create table statement above and execute it with `CTRL + SHIFT + E` (or right click and `Execute Query`). 
   1. It may ask you which connection to use, select the correct one (possibly the only one you have). 
5. Extension should open a new `MESSAGES` pane with 

```SQL
Started executing query at Line 1
Commands completed successfully. 
Total execution time: 00:00:00.109
```
6. Now we check what this has changed in our database:
   1. `CTRL + ALT + D` to open the SQL Server extension - then expand (lick the `>` beside the server name)
   2. Expand `Tables`
   3. You should see and then expand `dbo.Zoo`
   4. Expand `Columns`
   5. You should see 
      1. `id (int, null)`
      2. `animal (varchar(50), null)`
      3. `colour (varchar(50), null)`
      4. `amount (int, null)`
7. This tells us not only our database was created but we can explore what happened without running SQL statements. We could execute the following script as well: 
```SQL
/* SQL query to check the what columns are in the table 'Zoo' */
select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'Zoo';
```
8. Next we want to add some data or rows to our Zoo table. Add the following lines to the `database.sql` file and select them (and only them) and execute with `CTRL + SHIFT + E`:
```SQL
/* Insert some rows into the Zoo table */
insert into Zoo (id, animal, colour, amount) values (1, 'Cow', 'Turquoise', 72);
insert into Zoo (id, animal, colour, amount) values (2, 'Fox', 'Red', 37);
insert into Zoo (id, animal, colour, amount) values (3, 'Raccoon', 'Orange', 91);
insert into Zoo (id, animal, colour, amount) values (4, 'Snake', 'Orange', 32);
insert into Zoo (id, animal, colour, amount) values (5, 'Stork', 'Indigo', 24);
insert into Zoo (id, animal, colour, amount) values (6, 'Spoonbill', 'Orange', 68);
insert into Zoo (id, animal, colour, amount) values (7, 'Armadillo', 'Crimson', 10);
insert into Zoo (id, animal, colour, amount) values (8, 'Rhinoceros', 'Khaki', 44);
insert into Zoo (id, animal, colour, amount) values (9, 'Antelope', 'Orange', 47);
insert into Zoo (id, animal, colour, amount) values (10, 'Cockatoo', 'Green', 18);
```
1. Now add and execute the following SQL `select` statements (a table showing the expected output is given):
   1. Select all the data from the table:
    ```sql 
    select * from Zoo; 
    ```
    id | animal | colour | amount
    --- | ---| ---| ---|
    1	|Cow	|Turquoise	|72
    2	|Fox	|Red	|37
    3	|Raccoon|	Orange|	91
    4	|Snake	|Orange	|32
    5	|Stork	|Indigo	|24
    6	|Spoonbill	|Orange|	68
    7	|Armadillo	|Crimson|	10
    8	|Rhinoceros|	Khaki|	44
    9	|Antelope|	Orange	|47
    10	|Cockatoo|	Green	|18
    
    2. Select all the data from the table ordered by amount of animals of each type:
    ```sql 
    select * from Zoo order by amount; 
    ```

    id | animal | colour | amount
    --- | ---| ---| ---|
    7	|Armadillo|	Crimson	|10
    10	|Cockatoo|	Green	|18
    5	|Stork|	Indigo	|24
    4	|Snake|	Orange	|32
    2	|Fox|	Red	|37
    8	|Rhinoceros|	Khaki	|44
    9	|Antelope|	Orange	|47
    6	|Spoonbill|	Orange	|68
    1	|Cow|	Turquoise	|72
    3	|Raccoon|	Orange	|91

   3.  Select all the data from the table matching the colour 'Orange'
   ```sql
   select * from Zoo where colour = 'Orange';
    ```
    id | animal | colour | amount
    --- | ---| ---| ---|
    3	|Raccoon	|Orange	|91
    4	|Snake	    |Orange	|32
    6	|Spoonbill	|Orange	|68
    9	|Antelope	|Orange	|47

    
    4. Select all the data from the table where the amount is greater than 50
    ```sql 
    select * from Zoo where amount > 50;
    ```
    id | animal | colour | amount
    --- | ---| ---| ---|
    1	|Cow	|Turquoise	|72
    3	|Raccoon	|Orange	|91
    6	|Spoonbill	|Orange	|68

## Connecting to the database using Java and Vaadin
Typically, for any CRUD app, it makes sense to use Sping JPA or Hibernate or some form of row mapper to convert from SQL rows to objects and back again. For this minimal app however, we will create and manage the JDBC connection direcly, issue the SQL statements, and iterate over the results ourselves. We wouldn't do this in a commercial app, but it's reasonable to do it once ourselves when learning to see what is happening behind the scenes. If you create the minimal [Vaadin app](DevelopingMinimalJavaVaadinApp.md) previously, open that folder and skip the first (Creating the initial app) section.

## Creating a minimal Vaadin app in VSCode

We need to follow these steps to connect to an Azure Database from Java:
   1. Create an initial 'Hello World' Vaadin app
   2. Add the JDBC driver dependency to the Maven project 
   3. Add the imports to Java to use JDBC
   4. Add the code to connect to the database
   5. Add the code to query the database
   6. Add the code to show the results
   
### Creating the initial app
1. Using the Command Palette `CTRL + SHIFT + P`, issue the following command:
   1. Enter `Maven: Create Maven Project`
   2. Specify the parent folder where the app will be created
   3. Supply an archetype: `vaadin-archetype-application` (if you type `vaa` it should find it)
   4. Select the Vaadin version (the latest version at time of writing was `13.0.10`)
   5. Specify a *groupId*: `com.vaadinjdbc` 
   6. Specify an *artifactId*: `HelloAzureDatabase`
   7. For the rest of the questions you can accept the defaults and hit enter for each question
2. Open the folder Maven created for you `HelloAzureDatabase` and find and open the following files:
   1. `MainView.java`
   2. `pom.xml`

### Add the JDBC driver dependency to the Maven project 
1. Using the Command Palette `CTRL + SHIFT + P`, issue the following command:
   1. `Maven: Add a dependency`
   2. Select the `HelloAzureDatabase` POM
   3. Enter `mssql` and enter and select `mssql-jdbc` from `com.microsoft.sqlserver` from the list (there are several options so double check you have the correct one)
   4. This (or similar except for version number) should be added to your dependencies in the POM:
    ```xml
    <dependency>
        <groupId>com.microsoft.sqlserver</groupId>
        <artifactId>mssql-jdbc</artifactId>
        <version>8.1.1.jre13-preview</version>
    </dependency>
    ```
    5. Change the `jre13` to `jre8` (as we are using JRE8 elsewhere, it will cause issues unless we change to 13 throughout)
    ```xml
        <version>8.1.1.jre8-preview</version>
    ```
    6. Save the POM with `CTRL + S`
       1. You may be asked to update your classpath, if this is the only project you are working on at a time, it is safe to say `Always`
    7. Right click on the Maven project `HelloAzureDatabase` in the `Maven Projects` extension and select `install`
    8. If you navigate to `...\HelloAzureDatabase\target\HelloAzureDatabase-1.0-SNAPSHOT\WEB-INF` you will see `mssql-jdbc-8.1.1.jre13-preview.jar` was added to your project

### Add the imports to Java to use JDBC
Editing the `MainView.java` file add the following after line 1 (the `package` line) and before the other `imports`:
    ```java
    import java.sql.Connection;
    import java.sql.DriverManager;
    import java.sql.ResultSet;
    import java.sql.SQLException;
    ```

### Add the code to connect to the database
To connect to the database, we need:
1. The JDBC Connection details (supplied by Azure)
2. Register the driver
3. Attempt the connection

Before editing the code below, retrieve the *connection string* from the Azure portal as follows:
1. Login to the https://portal.azure.com
2. Navigate to SQL Databases (VaadinDB in my case)
3. Enter `Connection strings : Show database connection strings`
4. Select `JDBC` tab
5. Select the `Copy to clipboard` button in the bottom right of the grey box
   1. In my case, it was: `jdbc:sqlserver://vaadintest2020.database.windows.net:1433;database=VaadinDB;user=vaadin_testuser@vaadintest2020;password={your_password_here};encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;` but yours will be different (server and password)
   2. Note the password is not supplied - you must edit that in yourself (below)
 
Change the MainView class code:
```java
public class MainView extends VerticalLayout 
{
    Connection db;
    public MainView() {
        Button connect = new Button("Connect to Zoo database", event ->
        {
            String jdbcConnectionString = "jdbc:sqlserver://{your database server here}.database.windows.net:1433;" +
                                          "database={your database name here};" +
                                          "user={user accountname}@{server name};" +
                                          "password={your password here};" +
                                          "encrypt=true;" +
                                          "trustServerCertificate=false;" +
                                          "hostNameInCertificate=*.database.windows.net;" +
                                          "loginTimeout=30;";
            try
            {
                DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver());
                db = DriverManager.getConnection(jdbcConnectionString);  
                Notification.show("Connected to " + db.getCatalog());
            }
            catch(SQLException e)
            {
                Notification.show("Error: " + e.getMessage());
            }
        });
        add(connect);
    }
}
```
1. Save `MainView.java` with `CTRL + S`
2. Right click on the Maven project and select `Install`. 
3. Then right click and select `Custom ...` and type `jetty:run`
4. Open a web browser and navigate to `localhost:8080` (once the Jetty server is running)

If you are struggling to remember the settings in the connection string above, here is a sample that I used, but your server name and password will be different:
```java
String jdbcConnectionString = "jdbc:sqlserver://vaadintest2020.database.windows.net:1433;" +
                                "database=VaadinDB;" +
                                "user=vaadin_testuser@vaadintest2020;" +
                                "password={Password Goes Here};" +
                                "encrypt=true;" +
                                "trustServerCertificate=false;" +
                                "hostNameInCertificate=*.database.windows.net;" +
                                "loginTimeout=30;";
```
### Add the code to query the database and the code to show the results
Add the following code (note, if you haven't stopped the Jetty server, every time you save the file it will automatically recompile and execute, so perhaps wait until you are finished editing to reload the `localhost:8080` app)
```java
    // Notification.show("Connected to " + db.getCatalog()); // Commenting out this line as no longer needed and also shows where to insert new lines!
    // Query the database - execute the select
    ResultSet rsZooRows = db.createStatement().executeQuery("select * from Zoo"); // This can be any SQL query but best used for 'select' statements here
    // While there are rows in the resultset, take each row (next()) and
    while(rsZooRows.next())
    {
        // Create a HTML H4 tag with the extracted column values in the following order
        add(new H4(rsZooRows.getInt("amount") + " x " +
                    rsZooRows.getString("colour") + " " +
                    rsZooRows.getString("animal")));
    }
```
Executing this on Jetty, loading `localhost:8080` and clicking the `Connect to Zoo database` should give you an output as follows: 
![](2020-01-03-22-27-13.png)

**Remember**: If you no longer need the SQL Server we created - delete it - it incurs a cost even if not being used.

In the next [how-to](VaadinCRUD.md), we'll look at using more advanced UI components from Vaadin to show our database data.

### Troubleshooting
If you tend to work on a VPN, or in school, work, and home at different times, the IP address you connect with the Azure will be different.
Each time you change IP address, you will need to add that IP address to the Azure firewall for the SQL Server. This is easy to do in the Azure portal, look for `Add client IP` in teh `Firewall settings` in the SQL Server you wish to access.