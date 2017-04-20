var express = require('express');
var router = express.Router();
router.io = require('socket.io')();
var controllerModelo = require('../controller/modelo.js');
var controllerCliente = require('../controller/cliente.js');
var controllerContrato = require('../controller/contrato.js');
var controllerActa = require('../controller/acta.js');
var controllerUsuario = require('../controller/usuario.js');

/* GET users listing. */
router.get('/', function (req, res, next) {
    res.send('respond with a resource');
});

function crearLog(mensaje) {
    controllerUsuario.insertLog(mensaje, function (err) {
        console.log(err);
    });

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



    socket.on('Cargar clientes', function (callback) {
        controllerCliente.getTabla(function (err, clientes) {
            console.log(clientes);
            if (err) {
                crearLog(err);
                callback("");
            } else {
                //console.log(levels);
                callback(clientes);
            }
        });
    });

    socket.on('Cargar contratos', function (callback) {
        controllerContrato.getTabla(function (err, clientes) {
            console.log(clientes);
            if (err) {
                crearLog(err);
                callback("");
            } else {
                //console.log(levels);
                callback(clientes);
            }
        });
    });

    socket.on('Cargar usuarios', function (callback) {
        controllerUsuario.getTabla(function (err, clientes) {
            console.log(clientes);
            if (err) {
                crearLog(err);
                callback("");
            } else {
                //console.log(levels);
                callback(clientes);
            }
        });
    });
    socket.on('Cargar logs', function (callback) {
        controllerUsuario.getTablaLogs(function (err, clientes) {
            console.log(clientes);
            if (err) {
                crearLog(err);
                callback("");
            } else {
                //console.log(levels);
                callback(clientes);
            }
        });
    });


    socket.on('Cargar eventos', function (callback) {
        controllerModelo.getAllTabla('v_evento', function (err, clientes) {
            console.log(clientes);
            if (err) {
                crearLog(err);
                callback("");
            } else {
                //console.log(levels);
                callback(clientes);
            }
        });
    });

    socket.on('Cargar contratos', function (callback) {
        controllerContrato.getTabla(function (err, clientes) {

            if (err) {
                crearLog(err);
                callback("");
            } else {
                //console.log(levels);
                callback(clientes);
            }
        });
    });

    socket.on('Cargar actas', function (callback) {
        controllerActa.getTabla(function (err, actas) {

            if (err) {
                crearLog(err);
                callback("");
            } else {
                //console.log(levels);
                callback(actas);
            }
        });
    });

    socket.on('Abrir detalle', function (req, res) {
        res.redirect('/cliente/cliente');
    });


    socket.on('Cargar estados', function (callback) {
        controllerCliente.getComboEstado(function (err, estados) {

            if (err) {
                crearLog(err);
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
                crearLog(error);
                callback({error: true});

            } else {
                console.log('registro eliminado: ', body);
                callback({error: false});
            }
        });

    });

    socket.on('Guardar articulo', function (datos, callback) {
        console.log('   LOS DATOS SOOOON: ' + datos);


        controllerModelo.insertArticulo(datos, function (error, body) {//envio los datos a insertar dentro de la funcion insert
            if (error) {
                crearLog(error);
                callback(0);

            } else {
                callback(body);
            }
        });

    });

    socket.on('Guardar contrato', function (datos, callback) {



        controllerContrato.insert(datos, function (error, mensaje) {//envio los datos a insertar dentro de la funcion insert
            if (error) {
                crearLog(error);
                callback(error);

            } else {
                callback(mensaje);
            }
        });

    });

    socket.on('Guardar usuario', function (datos, callback) {



        controllerUsuario.insert(datos, function (error, mensaje) {//envio los datos a insertar dentro de la funcion insert
            if (error) {
                crearLog(error);
                callback(error);

            } else {
                callback(mensaje);
            }
        });

    });

    socket.on('Guardar producto', function (datos, callback) {

        controllerModelo.insert(datos, function (error, mensaje) {//envio los datos a insertar dentro de la funcion insert
            if (error) {
                crearLog(error);
                callback(error);

            } else {
                callback(mensaje);
            }
        });

    });

    socket.on('Guardar acta', function (datos, callback) {

        controllerActa.insert(datos, function (error, mensaje) {//envio los datos a insertar dentro de la funcion insert
            if (error) {
                crearLog(error);
                callback(error);

            } else {
                callback(mensaje);
            }
        });

    });

    socket.on('Guardar acta prod', function (datos, callback) {
        controllerActa.insertProd(datos, function (error, mensaje) {//envio los datos a insertar dentro de la funcion insert
            if (error) {
                crearLog(error);
                callback(error);

            } else {
                callback(mensaje);
            }
        });

    });


    socket.on('Guardar cliente', function (datos, callback) {
        console.log('   LOS DATOS SOOOON: ' + datos);


        controllerCliente.insert(datos, function (error, mensaje) {//envio los datos a insertar dentro de la funcion insert
            if (error) {
                crearLog(error);
                callback(error);

            } else {
                callback(mensaje);
            }
        });

    });

    socket.on('Productos', function (categoria, callback) {

        controllerModelo.getTabla(categoria, function (error, productos) {
            if (error) {
                crearLog(error);
                callback();

            } else {

                callback(productos);
            }
        });

    });

    socket.on('Cargar tabla ubicacion', function (almacen, callback) {

        controllerModelo.getUbicacion(almacen, function (error, productos) {
            if (error) {
                crearLog(error);
                callback();

            } else {

                callback(productos);
            }
        });

    });

    socket.on('Cargar tabla marca', function (marca, callback) {

        controllerModelo.getTablaMarca(marca, function (error, productos) {
            if (error) {
                crearLog(error);
                callback();

            } else {

                callback(productos);
            }
        });

    });

    socket.on('Busqueda global', function (terminoBusqueda, callback) {
        console.log(terminoBusqueda);

        controllerModelo.getGlobal(terminoBusqueda, function (error, productos) {
            if (error) {
                crearLog(error);
                callback();

            } else {

                callback(productos);
            }
        });

    });

    socket.on('Busqueda global Acta', function (terminoBusqueda, callback) {
        console.log(terminoBusqueda);

        controllerModelo.getGlobalActa(terminoBusqueda, function (error, productos) {
            if (error) {
                crearLog(error);
                callback();

            } else {

                callback(productos);
            }
        });

    });

    socket.on('Lugar', function (ubicacion, callback) {

        controllerModelo.getTablaUbicacion(ubicacion, function (error, productos) {
            if (error) {
                crearLog(error);
                callback();

            } else {

                callback(productos);
            }
        });

    });

    socket.on('Cargar fecha', function (rango, callback) {

        controllerModelo.getTablaFecha(rango, function (error, productos) {
            if (error) {
                crearLog(error);
                callback();

            } else {

                callback(productos);
            }
        });

    });

    socket.on('Detalle', function (codigo, callback) {
        console.log('EL CODIGO ES:' + codigo);

        controllerModelo.getDetalle(codigo, function (error, productos) {
            if (error) {
                crearLog(error);
                callback();

            } else {

                callback(productos);
            }
        });

    });

    socket.on('Detalle Acta', function (codigo, callback) {
        console.log('EL CODIGO ES:' + codigo);

        controllerActa.getDetalle(codigo, function (error, productos) {
            if (error) {
                crearLog(error);
                callback();

            } else {

                callback(productos);
            }
        });

    });

    socket.on('Cargar productos', function (callback) {

        controllerModelo.getAllTabla('v_modelo', function (error, productos) {
            if (error) {
                crearLog(error);
                callback();

            } else {

                callback(productos);
            }
        });

    });

    socket.on('Cargar ultimos', function (callback) {

        controllerModelo.getAllTabla('v_ultimosAgregados', function (error, productos) {
            if (error) {
                crearLog(error);
                callback();

            } else {

                callback(productos);
            }
        });

    });

    socket.on('Cargar categoria', function (callback) {

        controllerModelo.getAllTabla('v_categoria', function (error, productos) {
            if (error) {
                crearLog(error);
                callback();

            } else {

                callback(productos);
            }
        });

    });

    socket.on('Cargar categoria chart', function (callback) {

        controllerModelo.getAllTablaChart('v_categoriaChart', function (error, productos) {
            if (error) {
                crearLog(error);
                callback();

            } else {

                callback(productos);
            }
        });

    });

    socket.on('Cargar almacen chart', function (callback) {

        controllerModelo.getAllTablaChart('v_almacenchart', function (error, productos) {
            if (error) {
                crearLog(error);
                callback();

            } else {

                callback(productos);
            }
        });

    });

    socket.on('Cargar almacen', function (callback) {

        controllerModelo.getAllTabla('v_ubicacion', function (error, productos) {
            if (error) {
                crearLog(error);
                callback();

            } else {

                callback(productos);
            }
        });

    });

    socket.on('Cargar almacen', function (callback) {

        controllerModelo.getAllTabla('v_ubicacion', function (error, productos) {
            if (error) {
                crearLog(error);
                callback();

            } else {

                callback(productos);
            }
        });

    });

    socket.on('Cargar proveedor', function (callback) {

        controllerModelo.getAllTabla('v_proveedor', function (error, marcas) {
            if (error) {
                crearLog(error);
                callback();

            } else {

                callback(marcas);
            }
        });

    });

    socket.on('Cargar marca', function (callback) {

        controllerModelo.getAllTabla('v_marca', function (error, marcas) {
            if (error) {
                crearLog(error);
                callback();

            } else {

                callback(marcas);
            }
        });

    });

    socket.on('Cargar codigos', function (callback) {

        controllerModelo.getAllTabla('v_modelo', function (error, productos) {
            if (error) {
                crearLog(error);
                callback();

            } else {

                callback(productos);
            }
        });

    });

    socket.on('Cargar ubicacion', function (callback) {

        controllerModelo.getAllTabla('v_ubicacion', function (error, productos) {
            if (error) {
                crearLog(error);
                callback();

            } else {

                callback(productos);
            }
        });

    });

    socket.on('disconnect', function () {
        console.log("Desconectado");
    });
});

module.exports = router;
