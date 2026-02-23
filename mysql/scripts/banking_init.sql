CREATE DATABASE IF NOT EXISTS banking_db;
USE banking_db;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    balance DECIMAL(15, 2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(15, 2) NOT NULL,
    type VARCHAR(20) NOT NULL, -- CREDIT, DEBIT
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS compliance_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_id INT,
    check_status VARCHAR(50),
    checked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create a dedicated user
CREATE USER IF NOT EXISTS 'bank_user'@'%' IDENTIFIED BY 'SecurePass123!';
GRANT ALL PRIVILEGES ON banking_db.* TO 'bank_user'@'%';
FLUSH PRIVILEGES;

-- Seed Data using a stored procedure to generate 100 users
DELIMITER $$
CREATE PROCEDURE SeedUsers()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 100 DO
        INSERT INTO users (username, email, balance) 
        VALUES (CONCAT('user', i), CONCAT('user', i, '@example.com'), 1000.00)
        ON DUPLICATE KEY UPDATE balance = balance;
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL SeedUsers();
DROP PROCEDURE SeedUsers;

