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

For instance, we can populate a combo box with strings as follows:
```java
ResultSet rsZooRows = db.createStatement().executeQuery("select * from Zoo");
``` 