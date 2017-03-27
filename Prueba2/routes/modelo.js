var express = require('express');
var router = express.Router();
var controllerModelo = require('../controller/modelo.js');



function isLoggedIn(req, res, next) {
    sess = req.session;
    if (sess.usuarioDatos)
        return next();
    sess.originalUrl = req.originalUrl;
    res.redirect('/login');
}




//actualiza la tabla modelo
router.get('/modelo', isLoggedIn, function (req, res) {
    controllerProducto.getTabla(function (error, filas) {
        if (error) {
            console.log('ocurrio un error: ', error);//muestra el error por consola
        } else {

            res.render('producto.html', {usuario: sess.usuarioDatos, title: 'Hola gabo', producto: filas});

        }
    });
});



router.post('/nuevoProducto', isLoggedIn, function (req, res) {
    var datos = {// variable json que captura los valores de los input que estan en el html para eso los input deven tener el atributo name
        codigo: req.body.codigo,
        nombre: req.body.nombre,
        categoria: req.body.categoria,
        marca: req.body.marca

    };
    console.log('los datos a insertar son: ', datos);
    controllerModelo.insert(datos, function (error, body) {//envio los datos a insertar dentro de la funcion insert
        if (error) {
            res.send(error);

        } else {
             res.redirect('/inventario');
        }
    });
});

router.post('/ingreso', isLoggedIn, function (req, res) {
     console.log('OLIS   ');
    // variable json que captura los valores de los input que estan en el html para eso los input deven tener el atributo name
    var codigo= req.body.codigo;
  
   console.log('ÉL CODIGO ES   '+codigo);
    res.render('ingreso.html', {usuario: sess.usuarioDatos,codigo: codigo});

});



//Fin
router.get('/detalle/:codigo', isLoggedIn, function (req, res) {

    var codigo = req.params.codigo;//captura la cedula enviada como parametro(/eliminar/:cedula) desde el html en el campo acciones de la tabla





    controllerModelo.editar(codigo, function (error, body) {//llama a la funcion eliminar
        if (error) {

            console.log('Ocurrio un error: ', error);

            res.render('cliente.html', {title: 'No se puede eliminar', registro: [], genero: [], estadocivil: []});
        } else {
            controllerModelo.getDatos(codigo, function (error, datos) {//llama a la funcion eliminar
                if (error) {

                    console.log('Ocurrio un error: ', error);

                    res.render('cliente.html', {title: 'No se puede eliminar', registro: [], genero: [], estadocivil: []});
                } else {
                    console.log('DETALLEEEEEEEEEEEEEEEE');
                    console.log(datos);
                    res.render('productoDetalle.html', {usuario: sess.usuarioDatos, title: 'Editar', datos: datos, registro: body, marca: [], categoria: []});



                }
            });





        }
    });
});





//Fin
//
module.exports = router;
