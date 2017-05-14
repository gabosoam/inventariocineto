var mysql = require('mysql'); //librería para manejar la base de datos mysql
var config = require('../config/index.js'); //permite acceder a las variables que están en el archivo config/index.js
var host = config.host;
var user = config.user;
var password = config.password;
var database = config.database;
var iniciar = mysql.createPool({//en la variable iniciar 
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
    //Carga la información de la base de datos
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
    //insertar datos en la tabla acta
    insert: function (datos, callback) {
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
                  
                        connection.release();
                    }
                });
            }
        });
    },
    //insertar datos en la tabla actaEntrega
    insertProd: function (datos, callback) {
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(err, null);
            } else {
                connection.query("SELECT sp_actaEntrega('" + datos.acta + "','" + datos.serie + "','" + datos.codigo + "') AS nota", datos, function (error, results, rows) {

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
    //Carga la información de la tabla actaDetalle
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
