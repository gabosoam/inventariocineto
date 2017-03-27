var mysql = require('mysql'); //libreria para manejar la base de datos mysql
var config = require('../config/index.js');// me permite acceder a las variables que esta en el archivo congif/index.js
var host = config.host;
var user = config.user;
var password = config.password;
var port = config.port;
var database = config.database;
var iniciar = mysql.createPool({//en la variable iniciar ya utilizo la libreria mysql para la conexion
    host: host,
    user: user,
    password: password,
    database: database,
    port: port
});

module.exports = {//module.exports me permite utilizar todas las funciones en otros archivos JS
    //en esta funcion verifico que la conexion a mi db y retorno el resultado
    getConexion: function (callback) {
        iniciar.getConnection(function (err, connection) {//getConnection establesco la conexio y me devuelve dos variables err si ocurrio algun error o connection que es el enganche para hacer las consultas a la base como buscar actualizar eliminar ollamar procedimientos almacenados
            if (err) {
                callback(err, null);//retorno el error de la conexion
            } else {
                callback(null, connection.threadId); //conexion exitosa  retorna el id de la conecion realizada
            }
        });
    },

    //Traigo informacion de la tabla datos
    getTabla: function (callback) {
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(err, null);
            } else {
                connection.query('SELECT  * FROM v_count', function (error, results, fields) {//
                    if (error) {
                        callback('error en la consulta: ' + error, null);
                    } else {
                        callback(null, results);
                        connection.release();//Da por finalizado la consulta
                    }
                });
            }
        });
    },

    //insertar datos en la tabla datos
    insert: function (datos, callback) {//la variable datos contiene todo lo que se va a insertar en formato json
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(err, null)
            } else {
                connection.query('INSERT INTO datos SET ?', datos, function (error, result) {
                    if (error) {
                        callback('error en la insercion: ' + error, null);
                    } else {
                        callback(null, result.affectedRows);//indica el numero de filas afectadas
                        connection.release();
                    }
                });
            }
        });
    },
    login: function (user, callback) {
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(err, null);
            } else {
                connection.query('SELECT * FROM usuario Where nombre_usuario = ?', user.nombre_usuario, function (error, results, fields) {//
                    if (error) {
                        callback('error en la consulta: ' + error, null);
                        console.log(err);
                    } else {
                        var usuarioDatos = {};
                        if (results[0]) {
                            
                            
                            if (user.password_usuario === results[0].password_usuario) {
                               console.log('contrasena');
                               console.log(user.password_usuario);
                               console.log(results[0].password_usuario);
                                
                                usuarioDatos = {
                                    nombre_usuario: results[0].nombre_usuario,
                                    password_usuario: results[0].password_usuario,
                                    nombres_usuario: results[0].nombres_usuario
                                };
                               msg = usuarioDatos;
                            
                            } else {
                                msg = "";
                                console.log("Contraseña incorrecta"+error);
                            }
                            //console.log("La contraseña es: ",generateHash(results[0].password));
                        } else {
                            msg = "";
                            console.log("El usuario no existe");
                        }
                    }
                    callback(null, msg);
                    connection.release();
                });
            }
        });
    },

    eliminar: function (cedula, callback) {//elimina una fila
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(err, null);
            } else {
                connection.query('DELETE FROM persona WHERE identificacion_persona=?', cedula, function (error, result) {
                    if (error) {
                        callback(error, null);//devuelve un error


                    } else {
                        callback(null, result.affectedRows);//indica el numero de filas afectadas
                    }
                });
            }
        });
    }
};