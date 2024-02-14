-- SQL EASY (www.sql-easy.com/pt)

-- Lesson 8: IN

-- Using the WHERE clause, we can find rows where a value is in a list of several possible values.

-- SELECT * FROM friends_of_pickles WHERE species IN ('cat', 'human'); would return the friends_of_pickles that are either a cat or a human.

-- To find rows that are not in a list, you use NOT IN instead of IN.

-- Can you run a query that would return the rows that are not cats or dogs? 

-- SQL:

SELECT * FROM friends_of_pickles WHERE species NOT IN ('cat', 'dog');


-- Lesson 9: DISTINCT

-- By putting DISTINCT after SELECT, you do not return duplicates.

-- For example, if you run

-- SELECT DISTINCT gender, species FROM friends_of_pickles WHERE height_cm < 100;, you will get the gender/species combinations of the animals less than 100cm in height.

-- Note that even though there are multiple male dogs under that height, we only see one row that returns "male" and "dog".

-- Can you return a list of the distinct species of animals greater than 50cm in height?

-- SQL:

SELECT DISTINCT species FROM friends_of_pickles WHERE height_cm > 50;


-- Lesson 10: ORDER BY

-- If you want to sort the rows by some kind of attribute, you can use the ORDER BY keyword. For example, if you want to sort the friends_of_pickles by name, you would run: SELECT * FROM friends_of_pickles ORDER BY name;. That returns the names in ascending alphabetical order.

-- In order to put the names in descending order, you would add a DESC at the end of the query.

-- Can you run a query that sorts the friends_of_pickles by height_cm in descending order?

-- SQL:

SELECT * FROM friends_of_pickles ORDER BY height_cm DESC;


-- Lesson 11: LIMIT # of returned rows

-- Often, tables contain millions of rows, and it can take a while to grab everything. If we just want to see a few examples of the data in a table, we can select the first few rows with the LIMIT keyword. If you use ORDER BY, you would get the first rows for that order.

-- If you wanted to see the two shortest friends_of_pickles, you would run: SELECT * FROM friends_of_pickles ORDER BY height_cm LIMIT 2;

-- Can you return the single row (and all columns) of the tallest friends_of_pickles?

-- Note:

-- - Some variants of SQL do not use the LIMIT keyword.
-- - The LIMIT keyword comes after the DESC keyword.

-- SQL:

SELECT * FROM friends_of_pickles ORDER BY height_cm DESC LIMIT 1;


-- Lesson 12: COUNT(*)

-- Another way to explore a table is to check the number of rows in it. For example, if we are querying a table states_of_us, we'd expect 50 rows, or 500 rows in a table called fortune_500_companies.

-- SELECT COUNT(*) FROM friends_of_pickles; returns the total number of rows in the table friends_of_pickles. Try this for yourself.

-- SQL:

SELECT COUNT(*) FROM friends_of_pickles;


-- Lesson 13: COUNT(*) ... WHERE

-- We can combine COUNT(*) with WHERE to return the number of rows that matches the WHERE clause.

-- For example, SELECT COUNT(*) FROM friends_of_pickles WHERE species = 'human'; returns 2.

-- Can you return the number of rows in friends_of_pickles where the species is a dog?

-- SQL:

SELECT COUNT(*) FROM friends_of_pickles WHERE species = 'dog';


-- Lesson 14: SUM

-- We can use the SUM keyword in order to find the sum of a given value.

-- For example, running SELECT SUM(num_legs) FROM family_members; returns the total number of legs in the family.

-- Can you find the total num_books_read made by this family?

-- SQL:

SELECT SUM(num_books_read) FROM family_members;


-- Lesson 15: AVG

-- We can use the AVG keyword in order to find the average of a given value.

-- For example, running SELECT AVG(num_legs) FROM family_members; returns the average number of legs of each family member.

-- Can you find the average num_books_read made by each family member?

-- Note:
-- - Because of the way computers handle numbers, averages will not always be completely exact.

-- SQL:

SELECT AVG(num_books_read) FROM family_members;


-- Lesson 16: MAX and MIN

-- We can use the MAX and MIN to find the maximum or minimum value of a table.

-- To find the least number of legs in a family member (2), you can run
-- SELECT MIN(num_legs) FROM family_members;

-- Can you find the highest num_books_read that a family member makes?

-- SQL:

SELECT MAX(num_legs) FROM family_members;


-- Lesson 17: GROUP BY

-- You can use aggregate functions such as COUNT, SUM, AVG, MAX, and MIN with the GROUP BY clause.

-- When you GROUP BY something, you split the table into different piles based on the value of each row.

-- For example,
-- SELECT COUNT(*), species FROM friends_of_pickles GROUP BY species; would return the number of rows for each species.

-- Can you return the tallest height for each species? Remember to return the species name next to the height too, like in the example query.

-- SQL:

SELECT MAX(height_cm), species FROM friends_of_pickles GROUP BY species;


-- Lesson 18: Nested queries

-- In SQL, you can put a SQL query inside another SQL query.

-- For example, to find the family members with the least number of legs,
-- you can run:
-- SELECT * FROM family_members WHERE num_legs = (SELECT MIN(num_legs) FROM family_members);

-- The SELECT query inside the parentheses is executed first, and returns the minimum number of legs. Then, that value (2) is used in the outside query, to find all family members that have 2 legs.

-- Can you return the family members that have the highest num_books_read?

-- SQL:

SELECT * FROM family_members WHERE num_books_read = (SELECT MAX(num_books_read) FROM family_members);


-- Lesson 19: NULL

-- Sometimes, in a given row, there is no value at all for a given column. For example, a dog does not have a favorite book, so in that case there is no point in putting a value in the favorite_book column, and the value is NULL. In order to find the rows where the value for a column is or is not NULL, you would use IS NULL or IS NOT NULL.

-- Can you return all of the rows of family_members where favorite_book is not null?

-- SQL:

SELECT * FROM family_members WHERE favorite_book IS NOT NULL;


-- Lesson 20: Date

-- Sometimes, a column can contain a date value. The first 4 digits represents the year, the next 2 digits represents the month, and the next 2 digits represents the day of the month. For example, 1985-07-20 would mean July 20, 1985.

-- You can compare dates by using < and >. For example, SELECT * FROM celebs_born WHERE birthdate < '1985-08-17'; returns a list of celebrities that were born before August 17th, 1985.

-- Can you return a list of celebrities that were born after September 1st, 1980?

-- SQL:

SELECT * FROM celebs_born WHERE birthdate > '1980-10-01';


-- Lesson 21: Inner joins

-- Different parts of information can be stored in different tables, and in order to put them together, we use INNER JOIN ... ON. Joining tables gets to the core of SQL functionality, but it can get very complicated. We will start with a simple example, and will start with an INNER JOIN.

-- As you can see below, there are 3 tables:
-- character: Each character is a row and is represented by a unique identifier (id), e.g. 1 is Doogie Howser
-- character_tv_show: For each character, which show is he/she in?
-- character_actor: For each character, who is the actor?

-- See that in character_tv_show, instead of storing both the character and TV show names (e.g. Willow Rosenberg and Buffy the Vampire Slayer), it stores the character_id as a substitute for the character name. This character_id refers to the matching id row from the character table.

-- This is done so data is not duplicated. For example, if the name of a character were to change, you would only have to change the name of the character in one row.

-- This allows us to "join" the tables together "on" that reference/common column.

-- To get each character name with his/her TV show name, we can write
-- SELECT character.name, character_tv_show.tv_show_name
-- FROM character
-- INNER JOIN character_tv_show
-- ON character.id = character_tv_show.character_id;
-- This puts together every row in character with the corresponding row in character_tv_show, or vice versa.

-- Note:
-- - We use the syntax table_name.column_name. If we only used column_name, SQL might incorrectly assume which table it is coming from.
-- - The example query above is written over multiple lines for readability, but that does not affect the query.

-- Can you use an inner join to pair each character name with the actor who plays them? Select the columns: character.name, character_actor.actor_name

-- SQL:

SELECT character.name, character_actor.actor_name 
FROM character 
INNER JOIN character_actor 
    ON character.id = character_actor.character_id;


-- Lesson 22: Multiple joins

-- In the previous exercise, we explained that TV show character names were not duplicated, so if the name of a character were to change, you would only have to change the name of the character in one row.

-- However, the previous example was a bit artificial because the TV show names and actor names were duplicated.

-- In order to not duplicate any names, we need to have more tables, and use multiple joins.

-- We have tables for characters, TV shows, and actors. Those tables represent things (also known as entities).

-- In addition those tables, we have the relationship tables character_tv_show and character_actor, which capture the relationship between two entities.

-- This is a flexible way of capturing the relationship between different entities, as some TV show characters might be in multiple shows, and some actors are known for playing multiple characters.

-- To get each character name with his/her TV show name, we can write
-- SELECT character.name, tv_show.name
-- FROM character
-- INNER JOIN character_tv_show
-- ON character.id = character_tv_show.character_id
-- INNER JOIN tv_show
-- ON character_tv_show.tv_show_id = tv_show.id;

-- Can you use two joins to pair each character name with the actor who plays them? Select the columns: character.name, actor.name

-- SQL:

SELECT character.name, actor.name
FROM character
INNER JOIN character_actor
    ON character_actor.character_id = character.id
INNER JOIN actor
    ON actor.id = character_actor.actor_id;


-- Lesson 23: Joins with WHERE

-- You can also use joins with the WHERE clause.

-- To get a list of characters and TV shows that are not in "Buffy the Vampire Slayer" and are not Barney Stinson, you would run:
-- SELECT character.name, tv_show.name
-- FROM character
-- INNER JOIN character_tv_show
-- ON character.id = character_tv_show.character_id
-- INNER JOIN tv_show
-- ON character_tv_show.tv_show_id = tv_show.id WHERE character.name != 'Barney Stinson' AND tv_show.name != 'Buffy the Vampire Slayer';

-- Can you return a list of characters and TV shows that are not named "Willow Rosenberg" and in the show "How I Met Your Mother"?

-- SQL:

SELECT character.name, tv_show.name
FROM character
INNER JOIN character_tv_show
    ON character_tv_show.character_id = character.id
INNER JOIN tv_show
    ON tv_show.id = character_tv_show.tv_show_id
WHERE character.name NOT IN ('Willow Rosenberg')
    AND tv_show.name != 'How I Met Your Mother';