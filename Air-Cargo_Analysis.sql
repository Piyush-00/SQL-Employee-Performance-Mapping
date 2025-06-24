use AirCargo;

select * from customer;

select * from Passengers;

select * from routes;

select * from Tickets;

-- Write a query to display all the passengers who have traveled on routes 01 to 25 from the passengers_on_flights table. --

select customer_id, route_id from Passengers
where route_id between 1 and 25;

-- Write a query to identify the number of passengers and total revenue in business class from the ticket_details table. --

select count(no_of_tickets) as Number_of_passengers, sum((Price_per_ticket)*(no_of_tickets)) as total_revnue from Tickets
where class_id = 'Business';

-- Write a query to display the full name of the customer by extracting the first name and last name from the customer table. --

select Concat(first_name, ' ', last_name) as full_name from customer;

-- Write a query to extract the customers who have registered and booked a ticket from the customer and ticket_details tables.-- 

select distinct(customer_id), first_name, last_name from customer
inner join Tickets using (customer_id);

-- Write a query to identify the customer’s first name and last name based on their customer ID and brand (Emirates) from the ticket_details table. --

select t.customer_id, c.first_name, c.last_name, t.brand
from Tickets as t
inner join customer as c
on t.customer_id = c.customer_id
where brand = 'Emirates';

-- Write a query to identify the customers who have traveled by Economy Plus class using the sub-query on the passengers_on_flights table.--

select customer_id, class_id from Passengers
where class_id in ( 
Select class_id from Passengers
where class_id = 'Economy Plus');

-- Write a query to determine whether the revenue has crossed 10000 using the IF clause on the ticket_details table. --

select sum(Price_per_ticket)as TotalRev,
if(sum(Price_per_ticket) > 10000, "Yes", "No") as Target from Tickets;

-- Write a query to create and grant access to a new user to perform database operations. --

create user 'ab'@'localhost' identified by 'ab';
grant all privileges on AirCargo to 'ab'@'localhost';

-- Write a query to find the maximum ticket price for each class using window functions on the ticket_details table. --

select brand, class_id, Max(Price_per_ticket) over (Partition by brand) as Max_ticket
from Tickets;

-- Write a query to extract the passengers whose route ID is 4 by improving the speed and performance of the passengers_on_flights table using theindex. --

Select * from Passengers
where route_id='4';

create index route_id4 on Passengers(route_id);
Select * from Passengers
where route_id ='4';

-- For route ID 4, write a query to view the execution plan of the passengers_on_flights table.--

explain select * from Passengers
where route_id=4;

-- Write a query to calculate the total price of all tickets booked by a customer across different aircraft IDs using the rollup function.--

select customer_id, sum(Price_per_ticket) as t_price, count(aircraft_id) as No_aircrafts
from Tickets
group by customer_id with rollup;

-- Write a query to create a view with only business class customers and the airline brand. --

create view buss_class as 
select customer_id, class_id, brand from Tickets
where class_id = 'Business'
order by brand;

select * from buss_class;

-- Write a query to create a stored procedure that extracts all the details from the routes table where the traveled distance is more than 2000 miles. --

delimiter //
create procedure travelled_dist()
begin 
select * from routes
where distance_miles > 2000;
end //
delimiter ;
call travelled_dist;

-- Using GROUP BY, determine the total number of tickets purchased by each customer and the total price paid. --

Select customer_id, count(no_of_tickets) as Total_tickets, Sum(Price_per_ticket) as Total_Price from Tickets
group by customer_id;

-- Calculate the average distance and average number of passengers per aircraft, considering only those routes with more than one departure date. --

WITH multi_departure_routes AS (
    SELECT route_id
    FROM Passengers
    GROUP BY route_id
    HAVING COUNT(DISTINCT travel_date) > 1
),
filtered_flights AS (
    SELECT fb.aircraft_id, fb.route_id, r.distance_miles, fb.customer_id
    FROM Passengers as fb
    JOIN multi_departure_routes mdr ON fb.route_id = mdr.route_id
    JOIN routes r ON fb.route_id = r.route_id
)
SELECT
    aircraft_id,
    AVG(distance_miles) AS avg_distance,
    COUNT(DISTINCT customer_id) * 1.0 / COUNT(DISTINCT route_id) AS avg_passengers
FROM filtered_flights
GROUP BY aircraft_id;