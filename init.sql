-- Create the database and select it
CREATE DATABASE IF NOT EXISTS slop-shop;
USE slop-shop;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(64),
    lastName VARCHAR(64),
    email VARCHAR(255),
    hashedPassword VARCHAR(128),
    lastLogin TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    width INT NOT NULL,
    height INT NOT NULL,
    operatingSystem VARCHAR(32),
    needsToChangePassword BOOLEAN DEFAULT TRUE,
    isOnline BOOLEAN DEFAULT FALSE
);

-- Products table
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0), -- Ensure non-negative quantity
    imageURL VARCHAR(255) DEFAULT NULL
);

INSERT INTO products(
    name,
    description,
    price,
    quantity,
    imageURL
) VALUES (
    'Vibe Coded website',
    "It probably won't work.",
    1999.99,
    10,
    '/images/code-1076536_640.jpg'
), (
    'Bucket of slop',
    '3 liters of slop made of the lowest quality ingredients',
    999.99,
    20,
    '/images/plastic-2755557_1280.jpg'
), (
    '5000 SlopShopAI tokens',
    "Tokens for our tech support AI. It will probably get confused and not actually help you",
    5000.00,
    99999,
    '/images/coin-2859345_640.png'
);

-- Carts table (links to users)
CREATE TABLE IF NOT EXISTS carts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE
);

-- CartItems table (links carts to products)
CREATE TABLE IF NOT EXISTS cartItems (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cartId INT NOT NULL,
    productId INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0), -- Quantity must be positive
    FOREIGN KEY (cartId) REFERENCES carts(id) ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES products(id) ON DELETE CASCADE
);

-- Orders table (stores completed orders)
CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL,
    totalAmount DECIMAL(10, 2) NOT NULL,
    shippingCost DECIMAL(10, 2) NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE
);

-- OrderItems table (links orders to products)
CREATE TABLE IF NOT EXISTS orderItems (
    id INT AUTO_INCREMENT PRIMARY KEY,
    orderId INT NOT NULL,
    productId INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0), -- Quantity must be positive
    priceAtPurchase DECIMAL(10, 2) NOT NULL, -- Price of product at the time of purchase
    FOREIGN KEY (orderId) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES products(id) ON DELETE CASCADE
);
