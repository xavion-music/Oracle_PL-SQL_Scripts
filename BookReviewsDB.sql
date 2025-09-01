-- Create database
CREATE DATABASE IF NOT EXISTS bookreviewsdb
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_general_ci;
USE bookreviewsdb;

-- Table: my_user_details (for login/authentication)
CREATE TABLE IF NOT EXISTS my_user_details (
  id INT AUTO_INCREMENT PRIMARY KEY,
  account_non_expired BOOLEAN DEFAULT TRUE,
  account_non_locked BOOLEAN DEFAULT TRUE,
  credentials_non_expired BOOLEAN DEFAULT TRUE,
  enabled BOOLEAN DEFAULT TRUE,
  password VARCHAR(255) NOT NULL,
  roles VARCHAR(50) NOT NULL,
  username VARCHAR(50) NOT NULL UNIQUE
);

-- Insert the only required user (admin / password)
INSERT INTO my_user_details
(account_non_expired, account_non_locked, credentials_non_expired, enabled, password, roles, username)
VALUES (1, 1, 1, 1, '$2a$12$zc/fq6t5RwqQj3heiVT/x.sbo0a01n3Zbw7AeQ7yM23jWC3vPU0Wy', 'ROLE_USER', 'admin');

-- Table: users (for book reviews authoring)
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(100),
  fullname VARCHAR(100),
  email VARCHAR(100),
  enabled BOOLEAN DEFAULT TRUE
);

-- Table: books
CREATE TABLE IF NOT EXISTS books (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  authors VARCHAR(255) NOT NULL
);

-- Table: reviews
CREATE TABLE IF NOT EXISTS reviews (
  id INT AUTO_INCREMENT PRIMARY KEY,
  book_id INT NOT NULL,
  user_id INT,
  review TEXT NOT NULL,
  FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);
