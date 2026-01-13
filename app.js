const path = require('path');
const express = require('express');
const ejs = require('ejs');
const mysql = require('mysql2');
const { maxHeaderSize } = require('http');
const app = express();
require('dotenv').config()

const connection = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: 'crud_express'
});

connection.connect(function(error) {
    error ? console.log(error) : console.log('Database connected!');
});

//static files
app.use(express.static('public'));
app.use('/css', express.static(__dirname + 'public/css'));
app.use('/js', express.static(__dirname + 'public/js'));
app.use('/img', express.static(__dirname + 'public/img'));

//this sets the views to be directed to the views folder, try removing the 's' from views and try it out
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(express.json());
app.use(express.urlencoded({ extended: false }))


app.get('/', (req, res) => {
    connection.query('CALL sp_get_all_users()', (err, results) => {
        if(err) throw err;
        res.render('user_index', {
            title : 'This is the user_index page',
            users : results[0]
        });
    });
});

app.get('/frontend', (req,res) => {
    res.render('frontend_page', {
        title: 'testing front end'
    })
});

app.get('/add', (req, res) => {
    res.render('user_add', {
        title: 'This is the create user page',
    });
});

app.post('/save', (req , res) => {
    const { name, email, phone_no } = req.body;
    connection.query('CALL sp_insert_user(?, ?, ?)', [name, email, phone_no], (err, results) => {
        if (err) throw err;
        res.redirect('/');
    });
});

app.get('/delete/:userId', (req,res) => {
    const userID = req.params.userId;
    connection.query('CALL sp_delete_user(?)', [userID], (err, result) => {
        if (err) throw err;
        res.redirect('/');
    });
});

app.get('/edit/:userId', (req, res) => {
    const userID = req.params.userId;
    connection.query('CALL sp_get_user_by_id(?)', [userID], (err, results) => {
        if (err) throw err;
        console.log(results[0][0])
        res.render('user_edit', {
            title: 'This is edit user page',
            user: results[0][0]
        });
    });
});

app.post('/update', (req, res) => {
    const { id, name, email, phone_no } = req.body;
    connection.query('CALL sp_update_user(?, ?, ?, ?)', [id, name, email, phone_no], (err, result) => {
        if (err) throw err;
        res.redirect('/');
    })
})

//listen to server
app.listen(3000, () => {
    console.log('server is running at port 3000');
});
