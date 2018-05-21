##### Relationships

* Not where the term "relational" comes from
* It actually comes from the the concept of relational algebra
* EX: 1 customer can have MANY orders

##### JOIN

* Assemble tables together
* Joining can only be performed on a related column between two tables
* Whatever comes after the `FROM` is the left table and whatever comes after `JOIN` is the right table
```
SELECT *
FROM CustomerOrder AS o
LEFT JOIN Customer AS c
	ON c.id = o.customerid
```
* Four types of join:
	1. INNER JOIN
		* Will bring two tables together and will only give you things that exist in both tables
		* Will exclude non matches from left and right tables
		* Like if a customer exists in the customers table but doesn't have an order yet you wanna handle that case
	2. LEFT JOIN
		* Will ensure everything from the left table will be included but exclude non matches from the right table
		* Say you have Orders table on left and you want to add customername which is in the Customers table
			* LEFT JOIN would probably be the best fit because you want to include an order even if there is not a customer name match
	3. RIGHT JOIN
		* The opposite of LEFT JOIN
		* Some DBs don't support this like SQlite
	4. FULL JOIN
		* Will include non matches in both tables

* LEFT, RIGHT & FULL JOIN are known as OUTER JOINs
	* So OUTER JOINs allow for one or more rows to be partially empty because it doesn't have a corresponding match in anther table

##### JOIN Selecting Columns

* SELECT * is typically a bad idea because it can lead to duplicate columns like `id` which exists as a column usually in every table
* So it is better to SELECT only the columns you want using aliasing
* 

