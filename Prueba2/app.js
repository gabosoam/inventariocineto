var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var session = require('express-session');

var app = express();



var winston = require('winston');

winston.log('info', 'Hello distributed log files!');
winston.info('Hello again distributed logs');

winston.level = 'debug';
winston.log('debug', 'Now my debug messages are written to console!');


var index = require('./routes/index');
var users = require('./routes/users');
var cliente = require('./routes/cliente');
var modelo = require('./routes/modelo');





// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.engine("html", require("ejs").renderFile);
app.set('view engine', 'html');
app.use(express.static('public'));

// uncomment after placing your favicon in /public
app.use(favicon(path.join(__dirname, 'public', 'icono.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));
app.use(cookieParser());
app.use(require('less-middleware')(path.join(__dirname, 'public')));
app.use(express.static(path.join(__dirname, 'public')));
app.use(session({
    secret: '4587controlMedico14685',
    cookie: {maxAge: 6000000000000000000},
    resave: false,
    saveUninitialized: true
}));

app.use('/', index);
app.use('/users', users);
app.use('/cliente', cliente);
app.use('/modelo', modelo);

// catch 404 and forward to error handler
app.use(function (req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});

// error handler
app.use(function (err, req, res, next) {
    // set locals, only providing error in development
    res.locals.message = err.message;
    res.locals.error = req.app.get('env') === 'development' ? err : {};

    // render the error page
    res.status(err.status || 500);
    res.render('error');
});

module.exports = app;
