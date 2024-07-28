import mysql.connector
from mysql.connector import errorcode

try:
    # Establish the connection
    connection = mysql.connector.connect(
        host='localhost',  # or the host where your MySQL server is running
        user='your_username',  # replace with your MySQL username
        password='your_password',  # replace with your MySQL password
        database='alx_book_store'  # name of the database
    )

    if connection.is_connected():
        print("Successfully connected to the database")
        cursor = connection.cursor()

        # SQL queries to create the tables
        create_authors_table = 
        CREATE TABLE IF NOT EXISTS authors (
            author_id INT AUTO_INCREMENT PRIMARY KEY,
            author_name VARCHAR(215) NOT NULL
        )
        
        
        create_books_table = 
        CREATE TABLE IF NOT EXISTS books (
            book_id INT AUTO_INCREMENT PRIMARY KEY,
            title VARCHAR(130) NOT NULL,
            author_id INT,
            price DOUBLE,
            publication_date DATE,
            FOREIGN KEY (author_id) REFERENCES authors(author_id)
        )
        
        
        create_customers_table = 
        CREATE TABLE IF NOT EXISTS customers (
            customer_id INT AUTO_INCREMENT PRIMARY KEY,
            customer_name VARCHAR(215) NOT NULL,
            email VARCHAR(215),
            address TEXT
        )
        
        
        create_orders_table = 
        CREATE TABLE IF NOT EXISTS orders (
            order_id INT AUTO_INCREMENT PRIMARY KEY,
            customer_id INT,
            order_date DATE,
            FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        )
        
        
        create_order_details_table = 
        CREATE TABLE IF NOT EXISTS order_details (
            orderdetailid INT AUTO_INCREMENT PRIMARY KEY,
            order_id INT,
            book_id INT,
            quantity DOUBLE,
            FOREIGN KEY (order_id) REFERENCES orders(order_id),
            FOREIGN KEY (book_id) REFERENCES books(book_id)
        )
        

        # Execute the queries
        cursor.execute(create_authors_table)
        cursor.execute(create_books_table)
        cursor.execute(create_customers_table)
        cursor.execute(create_orders_table)
        cursor.execute(create_order_details_table)

        print("Tables created successfully!")

except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("Something is wrong with your user name or password")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("Database does not exist")
    else:
        print(err)
finally:
    if connection.is_connected():
        cursor.close()
        connection.close()
        print("MySQL connection is closed")
