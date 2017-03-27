var express = require('express');
var router = express.Router();
var indexController = require('../controllers/login.js');

/* Armar la sesion . */
router.post('/login', function (req, res) {
    var sess = req.session;
    var user = {
        nombre_usuario: req.body.nombre_usuario,
        password_usuario: req.body.nombre_usuario
    };
    console.log('datos del usuario: ', user);
    indexController.login(user, function (err, usuario) {
        if (err) {
            res.status(500).render('index.html', {error: true, msg: "error del servidor intentelo luego"});
            console.log(err);
        } else {
            if (usuario === "") {
                res.status(403).render('index.html', {error: true, msg: 'Credenciales incorrectas'});
                console.log("Credenciales incorrectas");
            } else {
                sess.usuarioDatos = usuario;
                console.log("db: ", usuario);
                res.redirect('/home');
            }
        }
    });
});