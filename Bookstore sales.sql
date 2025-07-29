select * from Orderss
select * from Customerss
select * from Books

--EASY ------------

-- 1) Retrieve all books in the "Fiction" genre:
select * from books
where genre = 'fiction'

-- 2) Find books published after the year 1950:
select * from books
where Published_Year > 1950

-- 3) List all customers from the Canada:
select * FROM Customerss
WHERE country = 'canada';

-- 4) Show orders placed in November 2023:
SELECT * FROM orderss
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30'

-- 5) Retrieve the total stock of books available:
SELECT SUM(stock) as Total_Stock
FROM Books

-- 6) Find the details of the most expensive book:
SELECT TOP 3 * FROM Books
Order by Price Desc

-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM Orderss
WHERE Quantity > 1

-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orderss
WHERE Total_Amount > 20

-- 9) List all genres available in the Books table:
SELECT DISTINCT genre
FROM Books

-- 10) Find the book with the lowest stock:
SELECT TOP 10 * FROM Books
Order By Stock ASC

-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(total_amount) as Revenue
FROM Orderss



--ADVANCE -------------------

-- 1) Retrieve the total number of books sold for each genre:

SELECT b.Genre, SUM(o.Quantity) AS Total_Books_sold
FROM Orderss o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.Genre;


-- 2) Find the average price of books in the "Fantasy" genre:

SELECT AVG(Price)  as Avg_price
FROM books
WHERE genre='fantasy'


-- 3) List customers who have placed at least 2 orders:

WITH OrderCounts AS (
    SELECT customer_id, COUNT(order_id) AS order_count
    FROM Orderss
    GROUP BY customer_id
)
SELECT c.customer_id, c.name, o.order_count
FROM Customerss c
JOIN OrderCounts o ON c.customer_id = o.customer_id
WHERE o.order_count >= 2;



-- 4) Find the most frequently ordered book:

SELECT TOP 5 o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM Orderss o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC 


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :

SELECT Top 3 * FROM Books
WHERE Genre = 'fantasy'
Order By Price DESC


-- 6) Retrieve the total quantity of books sold by each author:

SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
FROM Orderss o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.Author;


-- 7) List the cities where customers who spent over $30 are located:

SELECT DISTINCT c.city, total_amount
FROM orderss o
JOIN Customerss c ON o.customer_id=c.customer_id
WHERE o.total_amount > 30;


-- 8) Find the customer who spent the most on orders:

SELECT TOP 5 c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM Orderss o
JOIN customerss c ON o.customer_id=c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_spent Desc;


--9) Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orderss o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;
