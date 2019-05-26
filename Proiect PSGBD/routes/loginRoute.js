const router = require('express').Router();
const express = require('express');
const app = express();
const path = require('path');
const oracledb = require('oracledb');
const passport = require('passport');

router.get('/', function (req, res) {
    res.sendFile(path.join(__dirname + '/../views/html/logare.html'));
});

router.post('/', function (req, res) {
    console.log(req.body);
    console.log(req.body.Email);
    var usernamePost = req.body.Email;
    var parolaPost = req.body.Password;


    connection = oracledb.getConnection({
            user: "ANDREI",
            password: "ANDREI",
            connectString: "localhost:1521/xe"
        },
        // console.log("Connected")
        function (err, connection) {
            connection.execute(
                `select * from cont where username=:username and parola=:parola`,
                [username = usernamePost, parola = parolaPost],
                function (err, result) {
                    if (err) {
                        console.error(err.message);
                        doRelease(connection);
                    }
                    console.log("am AJUNS AICI");
                    console.log(result.rows);
                    if (result.rows.length > 0) {
                        var rowData = {
                            id: result.rows[0][0],
                            username: result.rows[0][1],
                            parola: result.rows[0][2]
                        };
                    }
                    console.log(rowData);
                    if(rowData.id<=1000000){
                        passport.authenticate('local', { successRedirect: '/elevi',
                            failureRedirect: '/logare' });
                        res.redirect('/elevi/'+rowData.id);
                    }
                    else {
                        passport.authenticate('local', { successRedirect: '/profesor',
                            failureRedirect: '/logare' });
                        res.redirect('/profesor/'+rowData.id);
                    }
                    doRelease(connection);
                }
            );
        }
    );
    function doRelease(connection) {
        connection.release(
            function (err) {
                if (err) {
                    console.error(err.message);
                }
            });
    }
});


module.exports = router;