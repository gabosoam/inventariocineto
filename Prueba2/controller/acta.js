var mysql = require('mysql'); //libreria para manejar la base de datos mysql
var config = require('../config/index.js'); // me permite acceder a las variables que esta en el archivo congif/index.js
var host = config.host;
var user = config.user;
var password = config.password;
var database = config.database;
var iniciar = mysql.createPool({//en la variable iniciar ya utilizo la libreria mysql para la conexion
    host: host,
    user: user,
    password: password,
    database: database
});
module.exports = {//module.exports me permite utilizar todas las funciones en otros archivos JS
    //en esta funcion verifico que la conexion a mi db y retorno el resultado
    getConexion: function (callback) {
        iniciar.getConnection(function (err, connection) {//getConnection establesco la conexio y me devuelve dos variables err si ocurrio algun error o connection que es el enganche para hacer las consultas a la base como buscar actualizar eliminar ollamar procedimientos almacenados
            if (err) {
                callback(err, null); //retorno el error de la conexion
            } else {
                callback(null, connection.threadId); //conexion exitosa  retorna el id de la conecion realizada
            }
        });
    },
    //Traigo informacion de la tabla datos
    getTabla: function (callback) {
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(err, null)
            } else {
                connection.query('SELECT  * FROM v_acta', function (error, results, fields) {//
                    if (error) {
                        callback('error en la consulta: ' + error, null);
                    } else {
                        callback(null, { actas: results });
                        connection.release(); //Da por finalizado la consulta
                    }
                });
            }
        });
    },
    //insertar datos en la tabla datos
    insert: function (datos, callback) {//la variable datos contiene todo lo que se va a insertar en formato json
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(err, null);
            } else {
                connection.query("SELECT sp_acta('" + datos.codigo + "','" + datos.tipo + "','" + datos.fecha + "','" + datos.hora + "','" + datos.contrato + "','" + datos.descripcion +"','"+datos.usuario+ "') AS nota", datos, function (error, results, rows) {

                    if (error) {
                        callback('error en la insercion: ' + error, null);
                    } else {
                        console.log('LOS ROOOOOWS SON' + rows[0]);
                        console.log(results);

                        callback(results);
                        //indica el numero de filas afectadas
                        connection.release();
                    }
                });
            }
        });
    },

    getDetalle: function (acta, callback) {
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(err, null)
            } else {
                connection.query('SELECT  * FROM v_actaDetalle WHERE acta=?', acta, function (error, results, fields) {//
                    if (error) {
                        callback('error en la consulta: ' + error, null);
                    } else {
                        console.log(results);
                        callback(null, { resultados: results });
                        connection.release();//Da por finalizado la consulta
                    }
                });
            }
        });
    },


};
