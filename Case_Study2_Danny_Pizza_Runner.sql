DROP DATABASE IF EXISTS CASE_STUDY_2_DANNY;
CREATE DATABASE CASE_STUDY_2_DANNY;
USE CASE_STUDY_2_DANNY;
DROP TABLE IF EXISTS runners;
CREATE TABLE runners (
  runner_id INTEGER,
  registration_date DATE
);
INSERT INTO runners
  (runner_id, registration_date)
VALUES
  (1, '2021-01-01'),
  (2, '2021-01-03'),
  (3, '2021-01-08'),
  (4, '2021-01-15');


DROP TABLE IF EXISTS customer_orders;
CREATE TABLE customer_orders (
  order_id INTEGER,
  customer_id INTEGER,
  pizza_id INTEGER,
  exclusions VARCHAR(4),
  extras VARCHAR(4),
  order_time TIMESTAMP
);

INSERT INTO customer_orders
  (order_id, customer_id, pizza_id, exclusions, extras, order_time)
VALUES
  ('1', '101', '1', '', '', '2020-01-01 18:05:02'),
  ('2', '101', '1', '', '', '2020-01-01 19:00:52'),
  ('3', '102', '1', '', '', '2020-01-02 23:51:23'),
  ('3', '102', '2', '', NULL, '2020-01-02 23:51:23'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '2', '4', '', '2020-01-04 13:23:46'),
  ('5', '104', '1', 'null', '1', '2020-01-08 21:00:29'),
  ('6', '101', '2', 'null', 'null', '2020-01-08 21:03:13'),
  ('7', '105', '2', 'null', '1', '2020-01-08 21:20:29'),
  ('8', '102', '1', 'null', 'null', '2020-01-09 23:54:33'),
  ('9', '103', '1', '4', '1, 5', '2020-01-10 11:22:59'),
  ('10', '104', '1', 'null', 'null', '2020-01-11 18:34:49'),
  ('10', '104', '1', '2, 6', '1, 4', '2020-01-11 18:34:49');

select * from customer_orders;
DROP TABLE IF EXISTS CUSTOMERS_ORDERS1;
CREATE TABLE CUSTOMER_ORDERS1 AS SELECT ORDER_ID,CUSTOMER_ID, PIZZA_ID,
CASE WHEN EXCLUSIONS = "null" THEN  EXCLUSIONS IS NULL
ELSE EXCLUSIONS
END AS EXCLUSIONS,
CASE WHEN EXTRAS = "null" THEN EXTRAS IS NULL 
ELSE EXTRAS
END AS EXTRAS,
ORDER_TIME    FROM CUSTOMER_ORDERS ;
SELECT * FROM CUSTOMER_ORDERS1;

DROP TABLE IF EXISTS runner_orders;
CREATE TABLE runner_orders (
  order_id INTEGER,
  runner_id INTEGER,
  pickup_time VARCHAR(19),
  distance VARCHAR(7),
  duration VARCHAR(10),
  cancellation VARCHAR(23)
);


INSERT INTO runner_orders
  (order_id, runner_id, pickup_time, distance, duration, cancellation)
VALUES
  ('1', '1', '2020-01-01 18:15:34', '20km', '32 minutes', ''),
  ('2', '1', '2020-01-01 19:10:54', '20km', '27 minutes', ''),
  ('3', '1', '2020-01-03 00:12:37', '13.4km', '20 mins', NULL),
  ('4', '2', '2020-01-04 13:53:03', '23.4', '40', NULL),
  ('5', '3', '2020-01-08 21:10:57', '10', '15', NULL),
  ('6', '3', 'null', 'null', 'null', 'Restaurant Cancellation'),
  ('7', '2', '2020-01-08 21:30:45', '25km', '25mins', 'null'),
  ('8', '2', '2020-01-10 00:15:02', '23.4 km', '15 minute', 'null'),
  ('9', '2', 'null', 'null', 'null', 'Customer Cancellation'),
  ('10', '1', '2020-01-11 18:50:20', '10km', '10minutes', 'null');
SELECT * FROM RUNNER_ORDERS;
DESCRIBE RUNNER_ORDERS;
DROP TABLE IF EXISTS RUNNER_ORDERS1;
CREATE TABLE RUNNER_ORDERS1 AS SELECT ORDER_ID,RUNNER_ID,PICKUP_TIME,
CASE WHEN DISTANCE LIKE '%KM' THEN TRIM('km' from DISTANCE) 
ELSE DISTANCE
END AS DISTANCE,
CASE WHEN DURATION LIKE '%minutes' THEN TRIM('minutes' FROM DURATION)
WHEN DURATION LIKE '%mins' THEN TRIM('mins' FROM DURATION)
WHEN DURATION LIKE '%minute' THEN TRIM('minute' FROM DURATION)
ELSE DURATION
END AS DURATION,
 CANCELLATION
FROM RUNNER_ORDERS;
DROP TABLE IF EXISTS RUNNER_ORDER1;
CREATE TABLE RUNNER_ORDER1 AS SELECT ORDER_ID,RUNNER_ID, 
CASE WHEN DISTANCE = 'null' THEN NULL ELSE DISTANCE END AS DISTANCE,
CASE WHEN DURATION = 'null' THEN NULL ELSE DURATION END AS DURATION,
CASE WHEN CANCELLATION = 'null' THEN NULL ELSE CANCELLATION END AS CANCELLATION,
CASE WHEN PICKUP_TIME = 'null' THEN NULL ELSE PICKUP_TIME END AS PICKUP_TIME FROM RUNNER_ORDERS1;
SELECT * FROM RUNNER_ORDER1;
####### Update the column ######

ALTER TABLE RUNNER_ORDER1
MODIFY COLUMN PICKUP_TIME DATETIME NULL,
MODIFY COLUMN DISTANCE DECIMAL (5,2) NULL,
MODIFY COLUMN DURATION INT NULL;
SELECT * FROM RUNNER_ORDER1;
SELECT * FROM CUSTOMER_ORDERS;
DESCRIBE RUNNER_ORDER1;


DROP TABLE IF EXISTS pizza_names;
CREATE TABLE pizza_names (
  pizza_id INTEGER,
  pizza_name TEXT
);
INSERT INTO pizza_names
  (pizza_id, pizza_name)
VALUES
  (1, 'Meatlovers'),
  (2, 'Vegetarian');


DROP TABLE IF EXISTS pizza_recipes;
CREATE TABLE pizza_recipes (
  pizza_id INTEGER,
  toppings TEXT
);
INSERT INTO pizza_recipes
  (pizza_id, toppings)
VALUES
  (1, '1, 2, 3, 4, 5, 6, 8, 10'),
  (2, '4, 6, 7, 9, 11, 12');


DROP TABLE IF EXISTS pizza_toppings;
CREATE TABLE pizza_toppings (
  topping_id INTEGER,
  topping_name TEXT
);
INSERT INTO pizza_toppings
  (topping_id, topping_name)
VALUES
  (1, 'Bacon'),
  (2, 'BBQ Sauce'),
  (3, 'Beef'),
  (4, 'Cheese'),
  (5, 'Chicken'),
  (6, 'Mushrooms'),
  (7, 'Onions'),
  (8, 'Pepperoni'),
  (9, 'Peppers'),
  (10, 'Salami'),
  (11, 'Tomatoes'),
  (12, 'Tomato Sauce');
  
  select count(*) from customer_orders;  # 14
  select count(*) from pizza_names; #2
  select count(*) from pizza_recipes; #2
  select count(*) from pizza_toppings;  # 12
  select count(*) from runner_orders; # 10
  select count(*) from runners; # 4
  ###################               A. Pizza Metrics                ############################
 ################## Question 1 : - How many pizzas were ordered?
 
     select count(order_id) from customer_orders;   # Ans :- 14
  
 ################## Question 2 : - How many unique customer orders were made?
  
    select count(distinct (order_id)) from customer_orders;    # Ans :- 10
  
 ################## Question 3 : - How many successful orders were delivered by each runner?
 
    select runner_id, count(order_id) from runner_orders where pickup_time <> "null"  group by (runner_id);
	
 ################## CREATING MASTER TABLE #####################################

    DROP TABLE IF EXISTS TK_MASTER_PIZZA_RUNNER;
    CREATE TABLE TK_MASTER_PIZZA_RUNNER as select co.customer_id,co.order_id, co.pizza_id, pn.pizza_name,pr.toppings,
	rr.runner_id, ro.distance, ro.duration,co.exclusions,co.extras,co.order_time,
	ro.pickup_time, rr.registration_date, ro.cancellation  from customer_orders1 co
    left outer join runner_order1 ro on co.order_id=ro.order_id
    left outer join runners rr on rr.runner_id = ro.runner_id
    left outer join pizza_names pn on co.pizza_id = pn.pizza_id
    left outer join pizza_recipes pr on co.pizza_id = pr.pizza_id;
    SELECT count(*) FROM tk_master_pizza_runner;
	
################## Question 4 : - How many of each type of pizza was delivered?

    SELECT PIZZA_NAME ,COUNT(PIZZA_NAME) FROM ( SELECT * FROM TK_MASTER_PIZZA_RUNNER WHERE PICKUP_TIME IS NOT NULL) X GROUP BY PIZZA_NAME ;
  
################## Question 5 : - How many Vegetarian and Meatlovers were ordered by each customer?
  
    SELECT CUSTOMER_ID, PIZZA_NAME, COUNT(PIZZA_NAME) FROM TK_MASTER_PIZZA_RUNNER GROUP BY CUSTOMER_ID,PIZZA_NAME ORDER BY CUSTOMER_ID;
  
################## Question 6 : - What was the maximum number of pizzas delivered in a single order?
  
    SELECT ORDER_ID, COUNT(ORDER_ID) AS C FROM (SELECT * FROM TK_MASTER_PIZZA_RUNNER WHERE PICKUP_TIME IS NOT NULL) X GROUP BY ORDER_ID ORDER BY C DESC LIMIT 1;
   

################## Question 7: -How many pizzas were delivered that had both exclusions and extras?

    SELECT CUSTOMER_ID, COUNT(PIZZA_NAME) AS DELIVERY_WITH_BOTH FROM ( SELECT * FROM TK_MASTER_PIZZA_RUNNER WHERE exclusions <> 0 AND extras <> 0) X GROUP BY CUSTOMER_ID;

################## Question 8 : - What was the total volume of pizzas ordered for each hour of the day?

    SELECT X.ORDER_HOUR, COUNT(X.PIZZA_ID) AS TOTALPIZZAORDER  FROM  (SELECT *,HOUR(ORDER_TIME) AS ORDER_HOUR FROM TK_MASTER_PIZZA_RUNNER ) X GROUP BY X.ORDER_HOUR;

################## Question 9 : - What was the volume of orders for each day of the week?

    SELECT X.ORDER_DAY, COUNT(X.PIZZA_ID) AS TOTALPIZZAORDER  FROM  (SELECT *,DAYNAME(ORDER_TIME) AS ORDER_DAY FROM TK_MASTER_PIZZA_RUNNER ) X GROUP BY X.ORDER_DAY;

---------------------------------------#Step 3: Runner and Customer Experience-------------------------------------


################## Question 10 :How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)

    ###SELECT WEEKNUMBER,COUNT(RUNNER_ID) FROM (SELECT *, week(registration_date) AS WEEKNUMBER FROM TK_MASTER_PIZZA_RUNNER ) X GROUP BY WEEKNUMBER;
	

    SELECT week(registration_date) as weeknumber, count(runner_id) from runners group by weeknumber;

################## Question 11 : - What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pick up the order?

    SELECT runner_id, AVG(timestampdiff(minute,order_time,pickup_time)) from tk_master_pizza_runner group by runner_id;

################## Question 12 : - Is there any relationship between the number of pizzas and how long the order takes to prepare?

    WITH CTE AS (SELECT order_id, count(order_id) AS PIZZA_COUNT,AVG(timestampdiff(minute,order_time,pickup_time)) AS AVGTIME 
	FROM tk_master_pizza_runner WHERE DISTANCE != 0 GROUP BY order_id) SELECT PIZZA_COUNT, AVG(AVGTIME) FROM CTE GROUP BY PIZZA_COUNT;
	
	---------OR---------------------
	
    select PIZZA_COUNT, avg(AVGTIME) FROM (SELECT order_id, count(order_id) AS PIZZA_COUNT,AVG(timestampdiff(minute,order_time,pickup_time)) AS AVGTIME FROM
	tk_master_pizza_runner WHERE DISTANCE != 0 GROUP BY order_id) X GROUP BY PIZZA_COUNT;

################## Question 13 : - What was the average distance traveled for each customer?

    SELECT CUSTOMER_ID, AVG(DISTANCE) FROM tk_master_pizza_runner group by customer_id;

################## Question 14 : - What was the difference between the longest and shortest delivery times for all orders?

    WITH CTE AS (SELECT ORDER_ID, timestampdiff(minute,order_time,pickup_time) as DIFF FROM  tk_master_pizza_runner) SELECT MAX(DIFF)-MIN(DIFF) AS DIFFERENCE FROM CTE;
	
################## Question 15 : - What was the average speed for each runner for each delivery and do you notice any trend for these values?

    SELECT runner_id,order_id,round(distance*60/duration ) AS SPEED FROM tk_master_pizza_runner WHERE DISTANCE !=0 order by runner_id;
    select timestampdiff(minute,order_time,pickup_time) as diif, duration from tk_master_pizza_runner;
	
################## Question 16 : - What is the successful delivery percentage for each runner?

    select  runner_id,count(duration)/count(runner_id)*100 from tk_master_pizza_runner group by runner_id;
   
   DELETE S1 FROM tk_master_pizza_runner AS S1 INNER JOIN tk_master_pizza_runner AS S2   
   WHERE S1.runner_id < S2.runner_id AND S1.pizza_name = S2.pizza_name;  

-----------------------------# C. Ingredient Optimisation---------------------------------

################## Question 17 : - What are the standard ingredients for each pizza?

create table pizza_recipes1 
(
 pizza_id int,
    toppings int);
insert into pizza_recipes1
(pizza_id, toppings) 
values
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(1,8),
(1,10),
(2,4),
(2,6),
(2,7),
(2,9),
(2,11),
(2,12);
#Select * from pizza_recipes1;
#Select * from pizza_toppings;

    Select X.pizza_name,group_concat(X.topping_name) FROM (Select x.topping_name,x.topping_id, y.pizza_id,y.toppings,z.pizza_name from pizza_toppings x 
    Inner join pizza_recipes1 y on x.topping_id =y.toppings
    Inner join pizza_names z on y.pizza_id=z.pizza_id) X group by pizza_name;
	
################## Question 18 : - What was the most commonly added extra?
## Generate an order item for each record in the customers_orders table in the format of one of the following:

# Meat Lovers
# Meat Lovers - Exclude Beef
# Meat Lovers - Extra Bacon
# Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers
    select order_id,pizza_id,pizza_name, exclusions, extras, 
	case when exclusions = '4' and pizza_id = 1 Then 'Meat Lovers- Exclude Beef'
	when (exclusions = '2, 6'  or exclusions='6') and   (extras = '1, 4'  or extras='4') then 'Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers'
	when extras = '1' and pizza_id = 1 then 'Meat Lovers - Extra Bacon'
	when pizza_id=1 then 'Meat Lovers' 
	else 'Veg Lovers'
	end as order_item
    From tk_master_pizza_runner;

 # What was the most commonly added extra?
 #select distinct(substring_index(extras,',',1)),(substring_index(extras,',',-1)) from (select extras from tk_master_pizza_runner where extras is not NULL and extras <> '') X;
#select * from tk_master_pizza_runner;
select * from tk_master_pizza_runner where extras is not NULL and extras <> '' and extras != 0;
#select * ,substring_index(substring_index(extras,',',n),',',-1) as Value1 from (select * from tk_master_pizza_runner where extras is not NULL and extras <> '' and extras != 0) X
#Inner join	( SELECT 1 as n union all select 2 as n ) as numbers on CHAR_LENGTH(extras) - CHAR_LENGTH(REPLACE(extras, ',', '')) >= n - 1;
