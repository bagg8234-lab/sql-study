CREATE DATABASE shopping_mall;
USE shopping_mall;

CREATE TABLE users (
    user_id    INT PRIMARY KEY AUTO_INCREMENT,
    name       VARCHAR(50) NOT NULL,
    email      VARCHAR(100) UNIQUE NOT NULL,
    phone      VARCHAR(20),
    created_at DATETIME DEFAULT NOW()
);

CREATE TABLE categories (
    category_id   INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE products (
    product_id   INT PRIMARY KEY AUTO_INCREMENT,
    category_id  INT,
    product_name VARCHAR(100) NOT NULL,
    price        INT NOT NULL,
    stock        INT DEFAULT 0,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE orders (
    order_id     INT PRIMARY KEY AUTO_INCREMENT,
    user_id      INT,
    order_date   DATETIME DEFAULT NOW(),
    status       VARCHAR(20) DEFAULT 'pending',
    total_amount INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE order_items (
    item_id    INT PRIMARY KEY AUTO_INCREMENT,
    order_id   INT,
    product_id INT,
    quantity   INT NOT NULL,
    unit_price INT NOT NULL,
    FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE reviews (
    review_id  INT PRIMARY KEY AUTO_INCREMENT,
    user_id    INT,
    product_id INT,
    rating     INT CHECK (rating BETWEEN 1 AND 5),
    comment    TEXT,
    created_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (user_id)    REFERENCES users(user_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
