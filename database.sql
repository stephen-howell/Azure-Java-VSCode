/* Create a simple table called Zoo with 4 columns. 
Mockaroo.com was used to create the initial table SQL (and some of the other statements below.) */

create table Zoo (
	id INT NOT NULL IDENTITY(1, 1),
	animal VARCHAR(50),
	colour VARCHAR(50),
	amount INT
);

/* SQL query to check the what columns are in the table 'Zoo' */
select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'Zoo';

/* Insert some rows into the Zoo table */
insert into Zoo (animal, colour, amount) values ('Cow', 'Turquoise', 72);
insert into Zoo (animal, colour, amount) values ('Fox', 'Red', 37);
insert into Zoo (animal, colour, amount) values ('Raccoon', 'Orange', 91);
insert into Zoo (animal, colour, amount) values ('Snake', 'Orange', 32);
insert into Zoo (animal, colour, amount) values ('Stork', 'Indigo', 24);
insert into Zoo (animal, colour, amount) values ('Spoonbill', 'Orange', 68);
insert into Zoo (animal, colour, amount) values ('Armadillo', 'Crimson', 10);
insert into Zoo (animal, colour, amount) values ('Rhinoceros', 'Khaki', 44);
insert into Zoo (animal, colour, amount) values ('Antelope', 'Orange', 47);
insert into Zoo (animal, colour, amount) values ('Cockatoo', 'Green', 18);
insert into Zoo (animal, colour, amount) values ('Cockatoo', 'Blue', 2);

/* SQL to select all the data from the table */
select * from Zoo;

/* SQL to select all the data from the table ordered by amount of animals of each type */
select * from Zoo order by amount;

/* SQL to select all the data from the table matching the colour 'Orange' */
select * from Zoo where colour = 'Orange';

/* SQL to select all the data from the table where the amount is greater than 50 */
select * from Zoo where amount > 50;