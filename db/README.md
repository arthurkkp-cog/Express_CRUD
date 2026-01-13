# Database Stored Procedures

This folder contains stored procedures for the Express_CRUD application. The stored procedures replace inline SQL queries in `app.js` for better security, maintainability, and performance.

## Files

- `mysql_stored_procedures.sql` - Stored procedures for MySQL (current implementation)
- `postgres_stored_procedures.sql` - Stored procedures for PostgreSQL (for future migration)

## MySQL Setup

To use the stored procedures with MySQL, run the following in your MySQL client:

```sql
USE crud_express;
SOURCE /path/to/db/mysql_stored_procedures.sql;
```

Or copy and paste the contents of `mysql_stored_procedures.sql` into MySQL Workbench.

## PostgreSQL Setup

To use the stored procedures with PostgreSQL, run the following:

```sql
\c crud_db
\i /path/to/db/postgres_stored_procedures.sql
```

Or use psql:

```bash
psql -U postgres -d crud_db -f /path/to/db/postgres_stored_procedures.sql
```

## Stored Procedures

| Procedure | Description | Parameters |
|-----------|-------------|------------|
| `sp_get_all_users()` | Retrieves all users | None |
| `sp_get_user_by_id(user_id)` | Retrieves a user by ID | `user_id` (INT) |
| `sp_insert_user(name, email, phone_no)` | Inserts a new user | `name`, `email`, `phone_no` (VARCHAR) |
| `sp_update_user(user_id, name, email, phone_no)` | Updates an existing user | `user_id` (INT), `name`, `email`, `phone_no` (VARCHAR) |
| `sp_delete_user(user_id)` | Deletes a user by ID | `user_id` (INT) |

## Usage in app.js

The route handlers in `app.js` now call these stored procedures using the `CALL` statement:

```javascript
// Get all users
connection.query('CALL sp_get_all_users()', (err, results) => {
    // results[0] contains the user rows
});

// Get user by ID
connection.query('CALL sp_get_user_by_id(?)', [userId], (err, results) => {
    // results[0][0] contains the user object
});

// Insert user
connection.query('CALL sp_insert_user(?, ?, ?)', [name, email, phone_no], (err, results) => {
    // User inserted
});

// Update user
connection.query('CALL sp_update_user(?, ?, ?, ?)', [id, name, email, phone_no], (err, results) => {
    // User updated
});

// Delete user
connection.query('CALL sp_delete_user(?)', [userId], (err, results) => {
    // User deleted
});
```

## Notes

- MySQL stored procedures return results in a nested array format: `results[0]` contains the actual data rows
- PostgreSQL functions use `RETURNS TABLE` syntax for SELECT operations
- Both implementations use parameterized queries to prevent SQL injection
