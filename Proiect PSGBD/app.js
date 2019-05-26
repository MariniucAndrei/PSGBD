var express = require('express');
const http = require('http');
process.env.ORA_SDTZ = 'UTC';
var oracledb = require('oracledb');
const app = express();
const path = require('path');
const port = 3000;

const loginRoute = require('./routes/loginRoute');
const profesorRoute = require('./routes/profesorRoute');
const eleviRoute = require('./routes/eleviRoute');

var bodyParser = require('body-parser');
app.use( bodyParser.json() );
app.use(bodyParser.urlencoded({
  extended: true
}));
/*
async function run()  {
    try {
        connection = await oracledb.getConnection(  {
            user          : "ANDREI",
            password      : "ANDREI",
            connectString : "localhost:1521/xe"
          });
          console.log("Connected");
        }
    catch(err) {
        console.log(err);
    } finally {
      if (connection) {
        try {
          await connection.close();
        } catch(err) {
          console.log("Error when closing the database connection: ", err);
        }
      }
  }
  }
run();
*/
app.use(express.static(path.join(__dirname, '/views')));
app.use('/',loginRoute);
app.use('/profesor',profesorRoute);
app.use('/elevi',eleviRoute);

app.listen(port,function(){
  console.log("Server is running on port "+port);
})