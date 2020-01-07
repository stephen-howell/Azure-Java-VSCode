# Connection Pooling and Vaadin

## Creating a Java class to model the SQL result set data
Instead, let's look at a more sophisticated approach.
1. We'll create a Java class `Animal.java` to *model* the data in the `Zoo` table.
2. When we run a query on the database, we convert the ResultSet of animals into a Java collection of animals
3. We create UI components and call *setItems* on each with a parameter of the collection we wish to use

To achieve the above, we'll add in some handy [Apache Commons DbUtils](http://commons.apache.org/proper/commons-dbutils/) to make it easier and safer.
To save endless getters and setters, we'll also use `lombok`.  

1. Add `DbUtils` and `lombok` to Maven with
   1. `CTRL + SHIFT + P` and `Maven: Add a dependency`
      1. Search for `commons dbutils` and select `commons-dbutils` from the list
      2. Repeat and add `Lombok` by searching for `lombok` from `org.projectlombok`

Here is the above example done in this newer approach.

```java
        try 
        {
            DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver());
            db = DriverManager.getConnection(jdbcConnectionString);
            QueryRunner run = new QueryRunner();
            ResultSetHandler<List<Inventory>> resultSetHandler = new BeanListHandler<Inventory>(Inventory.class);

            add(new H3("Simple list of all animals in the zoo"));
            // Execute query
            List<Inventory> animalList = run.query(db, "select DISTINCT animal, id, colour, amount from Zoo", resultSetHandler);
            // Create a Vaadin UI comboxbox
            ComboBox<Inventory> animalCombo = new ComboBox<>();
            
            animalCombo.setItems(animalList);
            animalCombo.setItemLabelGenerator(Inventory::getAnimal);
            
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
        finally
        {
            DbUtils.closeQuietly(db);
        }
```
and the `Inventory.java` class (in the same folder as all the other classes we have so far like `MainView.java`):
```java
package com.vaadinjdbc;

import lombok.Data;

@Data
public class Inventory {
    private int id;
    private String animal;
    private String colour;
    private int amount;
}
```
Note that this class *needs* getters and setters for each field. As this gets messy (and the code is effectively boilerplate as we aren't changing anything other than a simple getter and setter), it is much easier to use *Lombok*. This uses an annotation `@Data` which automatically generates all the code we need at run time and keeps the source code nice and short.

### JDBC Connection Pooling
This is slightly better but we're still handling the JDBC connection ourselves. This is a bad idea because:
1. We have to manage the connection opening and closing (and any boilerplate)
2. Very resource inefficient to open and close our connection in every class that needs to access the database
3. It's hard to migrate to other databases
4. Configuration is in the Java files, rather than XML or settings files

The solution is to use *connection pooling* which manages the JDBC connection requests across the entire application. 

To add pooling:
1. Update configuration files for your JDBC connection settings
2. Update each class to use a pooled connection

We can use connection pooling with Tomcat, Jetty, Spring etc. and each have a different way of doing it. This way uses `Hikari` Connection Pooling, because it's super fast and simple.
1.  Create a folder under `src/main` called `resources`
2.  Create a file in this folder called `hikari.properties`
3.  Add the following to the file (change to match your own settings)
```
dataSourceClassName=com.microsoft.sqlserver.jdbc.SQLServerDataSource
dataSource.serverName={your_server}.database.windows.net
dataSource.user=vaadin_testuser
dataSource.password={your password}
dataSource.databaseName=VaadinDB
dataSource.portNumber=1433
```
4. Add a dependency to Maven (`CTRL + SHIFT + P` and `Maven: Add a dependency`) of `HikariCP` from `com.zaxxer`
5.  Add a new file in same folder as `MainView.java` called `Database.java` with:
```java
package com.vaadinjdbc;

import java.sql.*;
import javax.sql.DataSource;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

public class Database 
{     
    private static HikariConfig config;
    private static HikariDataSource ds;
     
    static 
    {
        config = new HikariConfig("/hikari.properties");
        ds = new HikariDataSource(config);
    }
     
    public static DataSource getDS() throws SQLException {
        return ds;
    }
    public Database() { }
}
```
Now, whenever we need a datasource, we use the static call `Database.getDS()` and let Hikari handle the connections and pooling and everything else. And look how much simpler the code is now:
```java
package com.vaadinjdbc;

import com.vaadinjdbc.Inventory;

import java.sql.SQLException;
import java.util.List;

import com.vaadin.flow.component.combobox.ComboBox;
import com.vaadin.flow.component.dialog.Dialog;
import com.vaadin.flow.component.html.H3;
import com.vaadin.flow.component.html.Label;
import com.vaadin.flow.component.notification.Notification;
import com.vaadin.flow.component.orderedlayout.HorizontalLayout;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.router.Route;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

@Route("best")
public class BestView extends VerticalLayout {
    
    public BestView() 
    {    
        HorizontalLayout hpanel = new HorizontalLayout();
        try 
        {
            QueryRunner run = new QueryRunner(Database.getDS());
            ResultSetHandler<List<Inventory>> resultSetHandler = new BeanListHandler<Inventory>(Inventory.class);

            add(new H3("Simple list of all animals in the zoo"));
            // Execute query
            List<Inventory> animalList = run.query("select DISTINCT animal, id, colour, amount from Zoo", resultSetHandler);
            // Create a Vaadin UI comboxbox
            ComboBox<Inventory> animalCombo = new ComboBox<>();
            
            animalCombo.setItems(animalList);
            animalCombo.setItemLabelGenerator(Inventory::getAnimal);
            
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
Navigate to `localhost:8080/best` to see it in action.

Next, let's look at how we use the most complex component - the `Grid`.
The `Grid` shows rows and columns of data, and we can hide the columns (fields) we don't want to show, and sort and filter them.

In this example, we will: 
1. Create a UI as follows:
   1. A grid of all the current animals in the zoo (the *Inventory*) 
   2. A way to add a new animals to the Zoo
   3. A way to edit existing animals in the Zoo
   4. A way to delete animals (completely) from the Zoo (not just edit the amount of them)

### Adding and configuring a Grid
