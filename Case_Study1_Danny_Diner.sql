DROP DATABASE IF EXISTS CASE_STUDY_1;
CREATE DATABASE CASE_STUDY_1;
USE CASE_STUDY_1;	
CREATE TABLE sales (
  customer_id VARCHAR(1),
  order_date DATE,
  product_id INTEGER
);

INSERT INTO sales
  (customer_id, order_date,product_id)
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 

CREATE TABLE menu (
  product_id INTEGER,
  product_name VARCHAR(5),
  price INTEGER
);

INSERT INTO menu
  (product_id, product_name, price)
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  

CREATE TABLE members (
  customer_id VARCHAR(1),
  join_date DATE
);

INSERT INTO members
  (customer_id, join_date)
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');
  

 ################## Question 1 : - What is the total amount each customer spent at the restaurant?

    Select s.customer_id,sum(m.price) as total_sales from sales s inner join menu m on s.product_id = m.product_id group by s.customer_id;

 ################## Question 2 : - How many days has each customer visited the restaurant?

select customer_id,count( distinct order_date) as count_visit from sales group by customer_id;

 ################## Question 3 : -  What was the first item from the menu purchased by each customer?
 
    with order_cte as (select s.customer_id,s.order_date,m.product_name,  
	dense_rank() over( partition by s.customer_id order by order_date ) as drnk
    from sales s inner join menu m on s.product_id = m.product_id)
	Select * from order_cte where drnk =1;

 ################## Question 4 : - What is the most purchased item on the menu and how many times was it purchased by all customers?
 
     with product_cte as (select m.product_name, count(m.product_name) as product_count from sales s left outer join menu m on  s.product_id= m.product_id 
	 group by product_name order by product_count desc)
	 SELECT * from product_cte limit 1;

 ################## Question 5 : -  Which item was the most popular for each customer?
 
    with cnt_cte as (Select s.customer_id, m.product_name,  count(m.product_name) as cnt from sales s left outer join menu m on  s.product_id= m.product_id 
	group by 1,2 order by customer_id,cnt desc),
	rnk_cte as (select *, dense_rank() over(partition by customer_id order by cnt desc) rnk from cnt_cte)
	select * from rnk_cte where rnk =1;

 ################## Question 6 : - Which item was purchased first by the customer after they became a member?

    with cust_cte as (Select s.order_date,m.*,ms.* from sales s left outer join menu m on  s.product_id= m.product_id
                       left outer join members ms on s.customer_id = ms.customer_id where join_date <= order_date),
    rnk_cte as (select *, dense_rank() over ( partition by customer_id order by order_date) as rnk from cust_cte)
    select customer_id,order_date,product_name from rnk_cte where rnk =1;

 ################## Question 7 : -  Which item was purchased just before the customer became a member?
 
    with cust_cte as (Select s.order_date,m.*,ms.* from sales s left outer join menu m on  s.product_id= m.product_id
                       left outer join members ms on s.customer_id = ms.customer_id where join_date > order_date),
    rnk_cte as (select *, dense_rank() over(partition by customer_id order by order_date desc) as rnk from cust_cte)
    select customer_id, order_date, product_name from rnk_cte where rnk=1;

 ################## Question 8 : -  What is the total items and amount spent for each member before they became a member?
 
    with cust_cte as (Select s.order_date,m.*,ms.* from sales s left outer join menu m on  s.product_id= m.product_id
                       left outer join members ms on s.customer_id = ms.customer_id where join_date > order_date)
    Select customer_id, count(distinct product_name) as items, SUM(price) as total_exp from cust_cte group by 1;

 ################## Question 9 : -  If each $1 spent equates to 10 points and sushi has a 2x points multiplier — how many points would each customer have?
 
    with point_cte as (Select s.customer_id,s.order_date,m.*,ms.join_date , case when product_name = "sushi" then price * 20
					else price*10 end as points
					from sales s left outer join menu m on  m.product_id= s.product_id
					left outer join members ms on ms.customer_id = s.customer_id)
   Select customer_id, SUM(points) as total_points from point_cte group by customer_id;

 ################## Question 10 : -  In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi — how many points do customer A and B have at the end of January?

    with cust_cte as (Select s.order_date,m.*,ms.*, case when order_date between join_date and join_date + 7 then 20* price
    else  10* price end as points from sales s left outer join menu m on  s.product_id= m.product_id
                       left outer join members ms on s.customer_id = ms.customer_id)
    select customer_id, sum(points) from cust_cte where order_date < "2021-01-31" group by 1 ;

 ################## Question 2 : - Bonus question

    with mem_cte as (select s.customer_id,s.order_date,s.product_id,m.product_name,ms.join_date , case when join_date > order_date then "N" else "Y" end as members  from sales s left outer join menu m on  s.product_id= m.product_id
                       left outer join members ms on s.customer_id = ms.customer_id)
    select *, case when members = "N" then null 
    else  rank() over( partition by customer_id, members order by order_date)  end as rnk from mem_cte;

 # The above solutions are in MySQL