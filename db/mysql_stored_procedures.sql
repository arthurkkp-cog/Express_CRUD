-- MySQL Stored Procedures for Express_CRUD Application
-- Database: crud_express
-- Table: users (id INT AUTO_INCREMENT, name VARCHAR(256), email VARCHAR(256), phone_no VARCHAR(26))

-- Drop existing procedures if they exist
DROP PROCEDURE IF EXISTS sp_get_all_users;
DROP PROCEDURE IF EXISTS sp_get_user_by_id;
DROP PROCEDURE IF EXISTS sp_insert_user;
DROP PROCEDURE IF EXISTS sp_update_user;
DROP PROCEDURE IF EXISTS sp_delete_user;

DELIMITER //

-- Procedure to get all users
CREATE PROCEDURE sp_get_all_users()
BEGIN
    SELECT * FROM users;
END //

-- Procedure to get a user by ID
CREATE PROCEDURE sp_get_user_by_id(IN p_user_id INT)
BEGIN
    SELECT * FROM users WHERE id = p_user_id;
END //

-- Procedure to insert a new user
CREATE PROCEDURE sp_insert_user(
    IN p_name VARCHAR(256),
    IN p_email VARCHAR(256),
    IN p_phone_no VARCHAR(26)
)
BEGIN
    INSERT INTO users (name, email, phone_no) VALUES (p_name, p_email, p_phone_no);
END //

-- Procedure to update an existing user
CREATE PROCEDURE sp_update_user(
    IN p_user_id INT,
    IN p_name VARCHAR(256),
    IN p_email VARCHAR(256),
    IN p_phone_no VARCHAR(26)
)
BEGIN
    UPDATE users 
    SET name = p_name, email = p_email, phone_no = p_phone_no 
    WHERE id = p_user_id;
END //

-- Procedure to delete a user by ID
CREATE PROCEDURE sp_delete_user(IN p_user_id INT)
BEGIN
    DELETE FROM users WHERE id = p_user_id;
END //

DELIMITER ;
