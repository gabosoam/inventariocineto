var express = require('express');
var router = express.Router();
var controllerCliente = require('../controller/cliente.js');
var winston = require('winston');

router.io = require('socket.io')();



router.io = require('socket.io')();
router.get('/', function (req, res, next) {
    res.send('respond with a resource');
});

function isLoggedIn(req, res, next) {
    sess = req.session;
    if (sess.usuarioDatos)
        return next();
    sess.originalUrl = req.originalUrl;
    res.redirect('/login');
}

router.io.on('connection', function (socket) {
    console.log('usuario conectado');
    socket.on('Cargar generos', function (callback) {
        controllerCliente.getComboGenero(function (err, generos) {
            console.log(generos);
            if (err) {
                console.log("Ocurrio un error", err);
                callback("");
            } else {
                //console.log(levels);
                callback(generos);
            }
        });
    });

    socket.on('Cargar tabla', function (callback) {
        controllerCliente.getTabla(function (err, clientes) {
            console.log(clientes);
            if (err) {
                console.log("Ocurrio un error", err);
                callback("");
            } else {
                console.log(clientes);
                callback(clientes);
            }
        });
    });

    socket.on('Abrir detalle', function (req, res) {
        res.redirect('/cliente/cliente');
    });


    socket.on('Cargar estados', function (callback) {
        controllerCliente.getComboEstado(function (err, estados) {
            console.log(estados);
            if (err) {
                console.log("Ocurrio un error", err);
                callback("");
            } else {
                //console.log(levels);
                callback(estados);
            }
        });
    });



    socket.on('Borrar cliente', function (cedula, callback) {

        controllerCliente.eliminar(cedula, function (error, body) {//llama a la funcion eliminar
            if (error) {

                callback({error: true});

            } else {



                var logger = new (winston.Logger)({
                    transports: [
                        new (winston.transports.Console)(),
                        new (winston.transports.File)({filename: 'C:\.log.txt'})
                    ]
                });
                callback({error: false});
            }
        });

    });



    socket.on('disconnect', function () {
        console.log("Desconectado");
    });
});




//fin
//actualiza la tabla cliente
router.get('/cliente', isLoggedIn, function (req, res) {
    controllerCliente.getTabla(function (error, filas) {
        if (error) {
            console.log('ocurrio un error: ', error);//muestra el error por consola
        } else {
            res.render('cliente.html', {usuario: sess.usuarioDatos, title: 'Hola gabo', registro: filas});



        }
    });
});
//Fin




//Insertar datos en la tabla
router.post('/nuevoRegistro', function (req, res) {
    var datos = {// variable json que captura los valores de los input que estan en el html para eso los input deven tener el atributo name
        cedula: req.body.cedula,
        nombre: req.body.nombre,
        apellido: req.body.apellido,
        genero: req.body.genero,
        estado: req.body.estado,
        domicilio: req.body.domicilio,
        celular: req.body.celular,
        correo: req.body.correo,
        fecha: req.body.fecha,
        pais: req.body.pais,
        ciudad: req.body.ciudad,
        direccion: req.body.direccion
    };
    console.log('los datos a insertar son: ', datos);
    controllerCliente.insert(datos, function (error, body) {//envio los datos a insertar dentro de la funcion insert
        if (error) {
            res.send(error);

        } else {
            console.log('Datos insertados: ', body);//body tiene el numero de fiñas afectadas
            //  res.render('index.html',{title:'Node-Express', registro: [] });
            res.redirect('/cliente/cliente');
        }
    });
});
//Fin
//Eliminar una fila
router.get('/eliminar/:cedula', isLoggedIn, function (req, res) {
    var cedula = req.params.cedula;//captura la cedula enviada como parametro(/eliminar/:cedula) desde el html en el campo acciones de la tabla
    console.log("La cedula a eliminar es: " + cedula);
    controllerCliente.eliminar(cedula, function (error, body) {//llama a la funcion eliminar
        if (error) {
            console.log(error);
            res.send(true);

        } else {
            console.log('registro eliminado: ', body);
            res.send(false);
        }
    });
});

router.get('/editar/:cedula', isLoggedIn, function (req, res) {
    var cedula = req.params.cedula;//captura la cedula enviada como parametro(/eliminar/:cedula) desde el html en el campo acciones de la tabla
    console.log("La cedula a eliminar es: " + cedula);
    controllerCliente.editar(cedula, function (error, body) {//llama a la funcion eliminar
        if (error) {

            console.log('Ocurrio un error: ', error);

            res.render('cliente.html', {title: 'No se puede eliminar', registro: [], genero: [], estadocivil: []});
        } else {
            controllerCliente.getComboGenero(function (error, genero) {
                if (error) {
                    console.log('ocurrio un error: ', error);//muestra el error por consola
                } else {

                    controllerCliente.getComboEstado(function (error, estadocivil) {
                        if (error) {
                            console.log('ocurrio un error: ', error);//muestra el error por consola
                        } else {


                            res.render('clienteEd.html', {usuario: sess.usuarioDatos, title: 'Editar', registro: body, genero: genero, estadocivil: estadocivil});
                        }
                    });


                }
            });




        }
    });
});


//actualiza la tabla cliente
router.get('/cliente', function (req, res) {
    res.render('cliente.html', {title: 'Hola gabo'});
});





//Fin
//
module.exports = router;
