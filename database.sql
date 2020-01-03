/* Create a simple table called Zoo with 4 columns. 
Mockaroo.com was used to create this table (and some of the other statements below.) */

create table Zoo (
	id INT,
	animal VARCHAR(50),
	colour VARCHAR(50),
	amount INT
);

/* SQL query to check the what columns are in the table 'Zoo' */
select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'Zoo';

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

/* SQL to select all the data from the table */
select * from Zoo;

/* SQL to select all the data from the table ordered by amount of animals of each type */
select * from Zoo order by amount;

/* SQL to select all the data from the table matching the colour 'Orange' */
select * from Zoo where colour = 'Orange';

/* SQL to select all the data from the table where the amount is greater than 50 */
select * from Zoo where amount > 50;