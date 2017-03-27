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
                callback(error, null)
            } else {
                connection.query('SELECT  * FROM v_cliente', function (error, results, fields) {//
                    if (error) {
                        callback('error en la consulta: ' + error, null);
                    } else {
                        callback(null, {clientes: results});
                        connection.release(); //Da por finalizado la consulta
                    }
                });
            }
        });
    },
    //Traigo informacion de la tabla datos
    getComboGenero: function (callback) {
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(error, null)
            } else {
                connection.query('SELECT  * FROM v_genero', function (error, results, fields) {//
                    if (error) {
                        callback('error en la consulta: ' + error, null);
                    } else {
                        callback(null, results);
                        connection.release(); //Da por finalizado la consulta
                    }
                });
            }
        });
    },
    //Traigo informacion de la tabla datos
    getComboEstado: function (callback) {
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(error, null)
            } else {
                connection.query('SELECT  * FROM v_estadocivil', function (error, results, fields) {//
                    if (error) {
                        callback('error en la consulta: ' + error, null);
                    } else {
                        callback(null, results);
                        connection.release(); //Da por finalizado la consulta
                    }
                });
            }
        });
    },
    
    //Traigo informacion de la tabla datos
    getUbicacion: function (callback) {
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(error, null)
            } else {
                connection.query('SELECT  * FROM v_ubicacion', function (error, results, fields) {//
                    if (error) {
                        callback('error en la consulta: ' + error, null);
                    } else {
                        callback(null, results);
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
                callback(err, null)
            } else {
                connection.query("select guardar_cliente("
                        + "'" + datos.cedula + "',"
                        + "'" + datos.nombre + "',"
                        + "'" + datos.apellido + "',"
                        + "'" + datos.genero + "',"
                        + "'" + datos.estado + "',"
                        + "'" + datos.domicilio + "',"
                        + "'" + datos.celular + "',"
                        + "'" + datos.correo + "',"
                        + "'" + datos.fecha + "',"
                        + "'" + datos.pais + "',"
                        + "'" + datos.ciudad + "',"
                        + "'" + datos.direccion + "'"
                        + ")", datos, function (error, results,rows) {

                            if (error) {
                                callback('error en la insercion: ' + error, null);
                            } else {
                                console.log('rows: '+rows[0].mensaje);
                           
                                callback(null, (results.affectedRows));
                                //indica el numero de filas afectadas
                                connection.release();
                            }
                        });
            }
        });
    },
    //insertar datos en la tabla datos
    insert2: function (datos, callback) {//la variable datos contiene todo lo que se va a insertar en formato json
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(err, null);
            } else {
                connection.query({sql: 'select guardar_cliente()', timeout: 40000, // 40s 
                    values: [datos.cedula, datos.nombre]}, function (error, results) {

                    if (error) {
                        callback('error en la insercion: ' + error, null);
                    } else {
                        console.log(results[0].mensaje);
                        callback(null, (results.affectedRows));
                        //indica el numero de filas afectadas
                        connection.release();
                    }
                });
            }
        }
        );
    },
    eliminar: function (cedula, callback) {//elimina una fila
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(err, null);
            } else {
                connection.query('DELETE FROM persona WHERE identificacion_persona=?', cedula, function (error, result) {
             
                    
                    if (error) {
                        
                        callback(error, null); //devuelve un error
                        

                    } else {

                        callback(null, result.affectedRows); //indica el numero de filas afectadas
                    }
                });
            }
        });
    },
    //Traigo informacion de la tabla datos
    editar: function (cedula, callback) {
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(error, null)
            } else {
                connection.query('SELECT  * FROM v_cliente WHERE cedula=?', cedula, function (error, results, fields) {//
                    if (error) {
                        callback('error en la consulta: ' + error, null);
                    } else {
                        callback(null, results);
                        connection.release(); //Da por finalizado la consulta
                    }
                });
            }
        });
    }
};
