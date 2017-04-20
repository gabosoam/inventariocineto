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
                connection.query('SELECT  * FROM v_usuario', function (error, results, fields) {//
                    if (error) {
                        callback('error en la consulta: ' + error, null);
                    } else {
                        callback(null, {usuarios: results});
                        connection.release(); //Da por finalizado la consulta
                    }
                });
            }
        });
    },
    getTablaLogs: function (callback) {
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(err, null)
            } else {
                connection.query('SELECT  * FROM v_log', function (error, results, fields) {//
                    if (error) {
                        callback('error en la consulta: ' + error, null);
                    } else {
                        callback(null, {log: results});
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
                connection.query("SELECT sp_usuario('"
                        +datos.nickUser
                        +"','"
                        +datos.nombreUser
                        +"','"
                        +datos.cedulaUser
                        +"','"
                        +datos.rolUser           
                        +"') AS nota", datos, function (error, results, rows) {

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
    
        insertLog: function (mensaje, callback) {//la variable datos contiene todo lo que se va a insertar en formato json
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(err, null);
            } else {
                connection.query("INSERT INTO `error` (`hora_error`, `fecha_error`, `mensaje_error`) VALUES (CURRENT_TIME(), CURRENT_DATE(), '"+mensaje+"')", mensaje, function (error, results, rows) {

                    if (error) {
                        callback('error en la insercion: ' + error, null);
                    } else {
                      

                        callback(results);
                        //indica el numero de filas afectadas
                        connection.release();
                    }
                });
            }
        });
    }


};
