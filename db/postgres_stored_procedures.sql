-- PostgreSQL Stored Procedures (Functions) for Express_CRUD Application
-- Database: crud_db (or as configured)
-- Table: users (id SERIAL PRIMARY KEY, name VARCHAR(256), email VARCHAR(256), phone_no VARCHAR(26))

-- Drop existing functions if they exist
DROP FUNCTION IF EXISTS sp_get_all_users();
DROP FUNCTION IF EXISTS sp_get_user_by_id(INTEGER);
DROP FUNCTION IF EXISTS sp_insert_user(VARCHAR, VARCHAR, VARCHAR);
DROP FUNCTION IF EXISTS sp_update_user(INTEGER, VARCHAR, VARCHAR, VARCHAR);
DROP FUNCTION IF EXISTS sp_delete_user(INTEGER);

-- Function to get all users
CREATE OR REPLACE FUNCTION sp_get_all_users()
RETURNS TABLE(id INTEGER, name VARCHAR(256), email VARCHAR(256), phone_no VARCHAR(26))
AS $$
BEGIN
    RETURN QUERY SELECT u.id, u.name, u.email, u.phone_no FROM users u;
END;
$$ LANGUAGE plpgsql;

-- Function to get a user by ID
CREATE OR REPLACE FUNCTION sp_get_user_by_id(p_user_id INTEGER)
RETURNS TABLE(id INTEGER, name VARCHAR(256), email VARCHAR(256), phone_no VARCHAR(26))
AS $$
BEGIN
    RETURN QUERY SELECT u.id, u.name, u.email, u.phone_no FROM users u WHERE u.id = p_user_id;
END;
$$ LANGUAGE plpgsql;

-- Function to insert a new user
CREATE OR REPLACE FUNCTION sp_insert_user(
    p_name VARCHAR(256),
    p_email VARCHAR(256),
    p_phone_no VARCHAR(26)
)
RETURNS VOID
AS $$
BEGIN
    INSERT INTO users (name, email, phone_no) VALUES (p_name, p_email, p_phone_no);
END;
$$ LANGUAGE plpgsql;

-- Function to update an existing user
CREATE OR REPLACE FUNCTION sp_update_user(
    p_user_id INTEGER,
    p_name VARCHAR(256),
    p_email VARCHAR(256),
    p_phone_no VARCHAR(26)
)
RETURNS VOID
AS $$
BEGIN
    UPDATE users 
    SET name = p_name, email = p_email, phone_no = p_phone_no 
    WHERE id = p_user_id;
END;
$$ LANGUAGE plpgsql;

-- Function to delete a user by ID
CREATE OR REPLACE FUNCTION sp_delete_user(p_user_id INTEGER)
RETURNS VOID
AS $$
BEGIN
    DELETE FROM users WHERE id = p_user_id;
END;
$$ LANGUAGE plpgsql;
