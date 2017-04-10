var express = require('express');
var router = express.Router();
var controllers = require('../controller/index.js'); //funciones de la base de datos

//esta es la ruta raiz la que se ejecuta al iniciar  el servidor
router.get('/', function (req, res, next) {
    controllers.getConexion(function (error, conexion) {//controllers contiene todas las funciones de la base de datos que esta ubicado en la carpeta controllers/index.js
        if (error) {//si hay algun error en la conexion
            console.log("Error de conexion: ", error);
            res.status(500).send('error del servidor');
        } else {
            console.log("conexion exitosaaaaaa: ", conexion, " session es: ", req.session);
            res.redirect('/home');//permite cargar la  pagina con los datos actualizados
            //   res.render('index.html',{title:'Node-Express', registro:[] });//me permite abrir un html y mandar cualquier informacion
        }
    });
});

function isLoggedIn(req, res, next) {
    sess = req.session;
    if (sess.usuarioDatos)
        return next();
    sess.originalUrl = req.originalUrl;
    res.redirect('/login');
}


router.get('/login', function (req, res) {
    res.render('login.html', {error: false, msg: 'Credenciales incorrectas'});
});





router.get('/logout', function (req, res) {
    req.session.destroy(function (err) {
        if (err) {
            console.log(err);
        } else {
            console.log('Cerrando session');
            res.redirect('/home');
        }
    });
});

router.get('/home', isLoggedIn, function (req, res, next) {
    res.render('index', {usuario: sess.usuarioDatos});
});
router.get('/cliente', isLoggedIn, function (req, res, next) {
    res.render('cliente', {usuario: sess.usuarioDatos});
});
router.get('/inventario', isLoggedIn, function (req, res, next) {
    res.render('inventario', {usuario: sess.usuarioDatos});
});
router.get('/contrato', isLoggedIn, function (req, res, next) {
    res.render('contrato', {usuario: sess.usuarioDatos});
});
router.get('/acta', isLoggedIn, function (req, res, next) {
    res.render('acta', {usuario: sess.usuarioDatos});
});

router.get('/ingresos', isLoggedIn, function (req, res, next) {
    res.render('ingreso', {usuario: sess.usuarioDatos});
});

router.get('/prueba', isLoggedIn, function (req, res, next) {
    controllerProducto.getTabla(function (error, filas) {
        if (error) {
            console.log('ocurrio un error: ', error);//muestra el error por consola
        } else {
            console.log(filas);
            res.render('cliente2.html', {usuario: sess.usuarioDatos, producto: filas});
        }
    });

});

router.get('/release', isLoggedIn, function (req, res, next) {
    res.render('release.html', {title: 'CRM', usuario: sess.usuarioDatos});
});

router.get('/admin', isLoggedIn, function (req, res, next) {
    res.render('admin', {usuario: sess.usuarioDatos});
});

router.post('/loginPass', function (req, res) {
    var sess = req.session;
    var user = {
        nombre_usuario: req.body.nombre_usuario,
        password_usuario: req.body.password_usuario
    }

    controllers.login(user, function (err, usuario) {


        if (err) {
            console.log(err);
            res.render('login.html', {error: true, msg: 'Credenciales incorrectas'});

        } else {
            if (usuario === "") {
                console.log("Credenciales incorrectas");
                res.render('login.html', {error: true, msg: 'Credenciales incorrectas'});

            } else {
                console.log(req.session);
                sess.usuarioDatos = usuario;
                console.log("db: ", usuario);
                res.redirect('/home');
            }
        }
    });
});



module.exports = router;
