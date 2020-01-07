# Vaadin UI Components for CRUD

This (how-to) builds from the [previous](ConnectingQueryingDB.md) how-to on working with SQL Server to show row data from table in a web app. Here we'll use nicer components to show and interact with the data.

## Vaadin UI Components
Check out the [Vaadin UI components](https://vaadin.com/components) and you see lots of nice UI components you can use.

For each component we use, we: 
1. Create the component
2. Populate it with the data we need and
3. Define the behaviour (if any) when it is clicked, selected or whatever interaction it has

For many components, a simple string or int will suffice for data, but this is quite a raw way to do it, prone to error and hard to fix when/if the data schema changes.
Another way is to use a RowMapper or similar to model the SQL data as Java objects.

For instance, here is a long example that uses raw Java to extract the strings from a ResultSet and place them in a combo box:
```java
package com.vaadinjdbc; // If you used different package in the Maven setup, change it here

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.vaadin.flow.component.combobox.ComboBox;
import com.vaadin.flow.component.dialog.Dialog;
import com.vaadin.flow.component.html.H3;
import com.vaadin.flow.component.html.Label;
import com.vaadin.flow.component.notification.Notification;
import com.vaadin.flow.component.orderedlayout.HorizontalLayout;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.router.Route;

@Route("simple") // This is important as it allows routing
public class SimpleView extends VerticalLayout {
    Connection db;
    final String jdbcConnectionString = 
                    "jdbc:sqlserver://vaadintest2020.database.windows.net:1433;" + // Change to your server name
                    "database=VaadinDB;" + 
                    "user=vaadin_testuser@vaadintest2020;" + 
                    "password={Your Password Here};" +
                    "encrypt=true;" + 
                    "trustServerCertificate=false;" +
                    "hostNameInCertificate=*.database.windows.net;" + 
                    "loginTimeout=30;";
        
    public SimpleView() 
    {
        HorizontalLayout hpanel = new HorizontalLayout();
        try 
        {
            DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver());
            db = DriverManager.getConnection(jdbcConnectionString);
            add(new H3("Simple list of all animals in the zoo"));
            // Execute query
            ResultSet rsAnimalNames = db.createStatement().executeQuery("select DISTINCT(animal) from Zoo");
            // Create a list (a Java Collection data structure) to store the resulting data
            List<String> animalList = new ArrayList<>();
            // Loop throught the data and put it in the string list
            while (rsAnimalNames.next()) {
                animalList.add(rsAnimalNames.getString("animal"));
            }
            // Create a Vaadin UI comboxbox
            ComboBox<String> animalCombo = new ComboBox<>();
            // Set the items in the string list to the combo list
            animalCombo.setItems(animalList);
            animalCombo.setPlaceholder("Select animal");
            animalCombo.addValueChangeListener(event -> Notification.show("Selected: " + event.getValue()));
            hpanel.add(animalCombo);
        }
        catch(SQLException e)
        {
            Dialog dialog = new Dialog();
            dialog.add(new Label(e.getMessage()));
            dialog.setWidth("450px");
            dialog.setHeight("450px");
            dialog.open();
        }
        add(hpanel);
    }
}

```
If you create a file in your existing Vaadin project called SimpleView.java and paste this code (making the changes indicated in comments), you can navigate to once running to `localhost:8080/simple` to see the code in action.

You'll notice that it is quite raw - lots of looping and converting the ResultSet into string array list. There is a better way, but it uses more advanced concepts. You can skip there [right now](VaadinConnectionPooling.md) but if you're still learning Java and JDBC you can finish this how-to first.

## Working with raw data types vs objects
When we put data into (and pull data out of) a SQL table, it goes in and out as standard data types like *strings*, *ints* and so on. We can work with them directly but it is messy. A better way is to create a plain old Java object (a *Pojo*) to model the row of data that was returned.

For instance, if a SQL statement `select id, name, age, dob from students` returned:
id|name | age | dob
---|---|---|---
1|Jack|16|28/11/2003
2|Ada|14|06/01/2006
3|Sam|11|02/02/2008
4|Molly|9|01/01/2010

We *could* represent that in code as 4 arrays (or any collection) as follows: 
`ArrayList<String> names = { "Jack", "Ada", "Sam", "Molly" };` but that would be messy - hard to get the data in, out or change it. Also complex to manage that Sam is id 3 and his age is 11 because these are stored in a different collection.
What we should do is create a class that matches a single row of data as follows:
```java
class Student
{
    private int id;
    private String name;
    private int age;
    private Date dob;
}
```
Then, we can create an array, arraylist or any collection to store all the student objects, and it is easier to work with them that way.

### Steps for modelling a resultset row
1. Identify the entities you need to model in SQL (you may be given an existing database or have the luxury of making your own)
2. Write and test the SQL that extracts the data you need
3. Create a Java class to model the SQL results
4. Convert the resultset row into a Java object
5. Store the Java objects in a collection

There are a number of handy tools to automate much of this, but they are covered here [instead](VaadinConnectionPooling.md) as they are a bit more advanced.

### Worked Example (Raw JDBC)
You have been given an existing database with 3 tables and asked to write a Java web app to view and edit the data. The data relates to cyclists in a local club and the various events, races that they can enter.  
1. Table 1: Cyclists: cyclist_id, name, insurance, gender
2. Table 2: Events: event_id, title, county, date, distance
3. Table 3: Entries: entry_id, cyclist_id, event_id

The club would like the following interface for their data:
1. A H2 header at the top of the page with "🚲Cycling Club Events"
2. A vertical set of 3 grids as follows:
   1. All cyclists in the club
   2. All events the club has
   3. Which events each member has entered (with the name of the cyclist, the name of the event and the distance)
   4. A H3 label in before each grid with a title of the grid

Here is some sample SQL:
```sql
create table Cyclists (
	id INT NOT NULL IDENTITY(1, 1),
	name VARCHAR(50),
	age INT,
	gender VARCHAR(50)
);
insert into Cyclists (name, age, gender) values ('Granville Oger', 23, 'Male');
insert into Cyclists (name, age, gender) values ('Gilbert Fahy',  41, 'Male');
insert into Cyclists (name, age, gender) values ('Gardner Harrod', 56, 'Male');
insert into Cyclists (name, age, gender) values ('Marie-jeanne Aimeric', 45, 'Female');
insert into Cyclists (name, age, gender) values ('Mervin Medford', 33, 'Male');
insert into Cyclists (name, age, gender) values ('Sancho Rosoman', 22, 'Male');
insert into Cyclists (name, age, gender) values ('Ursa McMeanma', 46, 'Female');
insert into Cyclists (name, age, gender) values ('Helsa Piell', 81, 'Female');
insert into Cyclists (name, age, gender) values ('Clemmie Kacheller', 21, 'Male');
insert into Cyclists (name, age, gender) values ('Griswold Croxley', 67, 'Male');

create table Events (
	id INT NOT NULL IDENTITY(1, 1),
	title VARCHAR(34),
	cost VARCHAR(50),
	date DATE,
	distance INT
);
insert into Events (title, cost, date, distance) values ('Ride Dingle', '€27', '2020/03/11', 60);
insert into Events (title, cost, date, distance) values ('Ring of Beara Cycle', '€40', '2020/09/21', 80);
insert into Events (title, cost, date, distance) values ('Cliffs of Moher Cycle Challenge', '€78', '2020/09/02', 60);
insert into Events (title, cost, date, distance) values ('Wild Atlantic Way Spring Sportif', '€51', '2020/04/06', 100);
insert into Events (title, cost, date, distance) values ('Gaelforce Night Rider Sportif', '€23', '2020/04/21', 50);
insert into Events (title, cost, date, distance) values ('Westport Gran Fondo', '€59', '2020/03/27', 90);
insert into Events (title, cost, date, distance) values ('Tour de Lough Corrib', '€40', '2020/04/17', 35);
insert into Events (title, cost, date, distance) values ('The Giants Causeway Coast Sportive', '€70', '2020/09/13', 60);
insert into Events (title, cost, date, distance) values ('Quest Kenmare Quest Glendalough', '€74', '2020/04/04', 50);

create table Entries (
	id INT NOT NULL IDENTITY(1, 1),
	cyclist_id INT,
	event_id INT
);
insert into Entries (cyclist_id, event_id) values (10, 6);
insert into Entries (cyclist_id, event_id) values (10, 3);
insert into Entries (cyclist_id, event_id) values (2, 3);
insert into Entries (cyclist_id, event_id) values (2, 2);
insert into Entries (cyclist_id, event_id) values (8, 9);
insert into Entries (cyclist_id, event_id) values (9, 2);
insert into Entries (cyclist_id, event_id) values (5, 3);
insert into Entries (cyclist_id, event_id) values (1, 9);
insert into Entries (cyclist_id, event_id) values (6, 7);
insert into Entries (cyclist_id, event_id) values ( 6, 1);
insert into Entries (cyclist_id, event_id) values ( 1, 2);
insert into Entries (cyclist_id, event_id) values ( 8, 5);
insert into Entries (cyclist_id, event_id) values ( 8, 6);
insert into Entries (cyclist_id, event_id) values ( 10, 2);
insert into Entries (cyclist_id, event_id) values ( 1, 6);
insert into Entries (cyclist_id, event_id) values ( 4, 2);
insert into Entries (cyclist_id, event_id) values ( 10, 4);
insert into Entries (cyclist_id, event_id) values ( 9, 5);
insert into Entries (cyclist_id, event_id) values ( 6, 4);
insert into Entries (cyclist_id, event_id) values ( 7, 3);
```

#### Try: Create an Azure database called `ClubDB` and execute the SQL above
1. Create the database, note the server & database name, user name, password etc.
2. Add your IP address to the firewall
3. Execute the queries on the database
 
Because you can use Maven to create a Vaadin app, you know you will have `MainView.java`. You will also need to create a class for each of the entities above:
1. `class Cyclist`
2. `class Event`
3. `class Entry`
Note to use the singular noun in the class (the collection can be named the plural noun).
For each class, add private member variables which match the SQL names.
Then add getters and setters for each member variable. 

#### Try: Create a new Vaadin app
1. Create a new Vaadin app with Maven called `ClubExplorer`
2. Add the MSSQL JDBC driver to the POM
3. Add the `Cyclist` and `Event` classes (above) to the project (leave Entry for now)
4. In the MainView class
   1. Add the JDBC connection code to your database
   2. Run the SQL select query to get all the cyclists
   3. Convert the resultset rows into a List of Cyclist objects
   4. Create a Vaadin Grid component and set the list of cyclists to be displayed
   5. Repeat these steps for Events

#### Try: Modelling more complex SQL results 
For Entries, it is slightly more complicated, because it is a relational table (it represents a relationship between cyclists and events, namely which events a cyclist has entered). Our Java class will therefore not only model the SQL table rows (which are just id, cyclist_id, and event_id) but all the joined data the SQL query will return.

1. Write a SQL query that returns all the information from (joins) the Cyclists and Events tables based on the Entry relationships
2. Write a Java class Entry that contains members for *all* the information from the 3 tables
3. Create a Grid (as above) to show the data 

### Solution
Try the above yourself, if you've read through all the [tutorials](Tutorial.md) it should be achieveable.

Here is (the most important bits of) my code if you get stuck:
```java
public MainView()  
{
    add(new H2("🚲Cycling Club Events"));
    add(new H3("Members"));
    try 
    {
        DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver());
        conn = DriverManager.getConnection(jdbcConnectionString);
        // Run the query (simple select all like this might not be appropriate for large data sets)
        ResultSet rsCyclists = conn.createStatement().executeQuery("select * from Cyclists");
        // Create the collection to hold the objects based on cyclists
        ArrayList<Cyclist> cyclists = new ArrayList<>();
        // While we have more rows, take each one and
        while(rsCyclists.next())
        {
            // Create a cyclist object with it, extract the data from the row
            Cyclist c = new Cyclist();
            c.setId(rsCyclists.getInt("id"));
            c.setName(rsCyclists.getString("name"));
            c.setAge(rsCyclists.getInt("age"));
            c.setGender(rsCyclists.getString("gender"));
            // Add the cyclist object to the collection
            cyclists.add(c);
        }
        // Create the UI component that will show the data
        Grid<Cyclist> cyclistGrid = new Grid<>(Cyclist.class);
        cyclistGrid.removeAllColumns();
        cyclistGrid.addColumn(Cyclist::getName).setHeader("Member Name").setSortable(true).setTextAlign(ColumnTextAlign.START);
        cyclistGrid.addColumn(Cyclist::getAge).setHeader("Member Age").setSortable(true).setTextAlign(ColumnTextAlign.CENTER);
        cyclistGrid.addColumn(Cyclist::getGender).setHeader("Member Gender").setSortable(true).setTextAlign(ColumnTextAlign.START);
        cyclistGrid.setItems(cyclists);
        cyclistGrid.setWidth("50%");
        add(cyclistGrid);
        // Repeat for other grids
    }
    catch(SQLException e)
    {
        Dialog d = new Dialog(); 
        d.add(new H4(e.getMessage()));
        d.open();
    }
    finally
    {
        try 
        {
            conn.close();
        } 
        catch (SQLException e) 
        {
            e.printStackTrace();
        }
    }
```