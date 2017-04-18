var mysql = require('mysql'); //libreria para manejar la base de datos mysql
var config = require('../config/index.js');// me permite acceder a las variables que esta en el archivo congif/index.js
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
                callback(err, null);//retorno el error de la conexion
            } else {
                callback(null, connection.threadId); //conexion exitosa  retorna el id de la conecion realizada
            }
        });
    },
    //Traigo informacion de la tabla datos
    getTabla: function (categoria, callback) {
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(error, null)
            } else {
                connection.query('SELECT  * FROM v_modelo WHERE categoria =?', categoria, function (error, results, fields) {//
                    if (error) {
                        callback('error en la consulta: ' + error, null);
                    } else {
                        callback(null, {productos: results});
                        connection.release();//Da por finalizado la consulta
                    }
                });
            }
        });
    },
    //Traigo informacion de la tabla datos
    getTablaMarca: function (marca, callback) {
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(err, null)
            } else {
                connection.query('SELECT  * FROM v_modelo WHERE marca =?', marca, function (error, results, fields) {//
                    if (error) {
                        callback('error en la consulta: ' + error, null);
                    } else {
                        callback(null, {productos: results});
                        connection.release();//Da por finalizado la consulta
                    }
                });
            }
        });
    },

    //Traigo informacion de la tabla datos
    getUbicacion: function (almacen, callback) {
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(error, null)
            } else {
                connection.query('SELECT  * FROM v_modelo_ubicacion WHERE ubicacion =?', almacen, function (error, results, fields) {//
                    if (error) {
                        callback('error en la consulta: ' + error, null);
                    } else {
                        callback(null, {productos: results});
                        connection.release();//Da por finalizado la consulta
                    }
                });
            }
        });
    },

    getGlobal: function (termino, callback) {
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(err, null)
            } else {
                connection.query('SELECT * FROM v_modelo WHERE codigo LIKE \'%' + termino + '%\' OR nombre LIKE \'%' + termino + '%\' OR categoria LIKE \'%' + termino + '%\'', function (error, results, fields) {//
                    if (error) {
                        callback('error en la consulta: ' + error, null);
                    } else {
                        callback(null, {productos: results});
                        connection.release();//Da por finalizado la consulta
                    }
                });
            }
        });
    },

    getGlobalActa: function (termino, callback) {
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(err, null)
            } else {
                connection.query('SELECT * FROM v_productos WHERE serie LIKE \'%' + termino + '%\' OR nombre LIKE \'%' + termino + '%\' OR categoria LIKE \'%' + termino + '%\'', function (error, results, fields) {//
                    if (error) {
                        callback('error en la consulta: ' + error, null);
                    } else {
                        callback(null, {productos: results});
                        connection.release();//Da por finalizado la consulta
                    }
                });
            }
        });
    },

    //Traigo informacion de la tabla datos
    getTablaUbicacion: function (ubicacion, callback) {
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(error, null)
            } else {
                connection.query('SELECT  * FROM v_lugar WHERE ubicacion =?', ubicacion, function (error, results, fields) {//
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

    getTablaFecha: function (rango, callback) {
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(err, null)
            } else {
                connection.query('SELECT  * FROM v_producto WHERE fecha BETWEEN \'' + rango[0].inicio + '\' AND \'' + rango[0].fin + '\'', function (error, results, fields) {//
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
    getDetalle: function (codigo, callback) {
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(err, null)
            } else {
                connection.query('SELECT  * FROM v_producto WHERE codigo=?', codigo, function (error, results, fields) {//
                    if (error) {
                        callback('error en la consulta: ' + error, null);
                    } else {
                        callback(null, {productos: results});
                        connection.release();//Da por finalizado la consulta
                    }
                });
            }
        });
    },

    getAllTabla: function (view, callback) {
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(err, null)
            } else {
                connection.query('SELECT  * FROM ' + view, function (error, results, fields) {//
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

    getAllTabla: function (view, callback) {
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(err, null)
            } else {
                connection.query('SELECT  * FROM ' + view, function (error, results, fields) {//
                    if (error) {
                        callback('error en la consulta: ' + error, null);
                    } else {


                        callback(null, {resultados: results});
                        connection.release();//Da por finalizado la consulta
                    }
                });
            }
        });
    },
    getAllTablaChart: function (view, callback) {
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(err, null)
            } else {
                connection.query('SELECT  * FROM ' + view, function (error, results, fields) {//
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

    //Traigo informacion de la tabla datos
    getCodigos: function (callback) {
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(err, null)
            } else {
                connection.query('SELECT  * FROM v_marca', function (error, results, fields) {//
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
    editar: function (codigo, callback) {




        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(error, null)
            } else {
                connection.query('SELECT * FROM v_producto WHERE REPLACE (codigo,\'/\',\'\')=?', codigo, function (error, results, fields) {//
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
    getUsuarios: function (callback) {
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(error, null);
            } else {
                connection.query('SELECT  * FROM v_usuario', function (error, results, fields) {//
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
                connection.query("select guardar_producto("
                        + "'" + datos.codigo + "',"
                        + "'" + datos.nombre + "',"
                        + "'" + datos.categoria + "',"
                        + "'" + datos.marca + "',"
                        + "'" + datos.usuario + "'"
                        + ") AS mensaje", datos, function (error, results, rows) {

                            if (error) {
                                callback('error en la insercion: ' + error, null);
                            } else {
                             

                                callback(null, results);
                                //indica el numero de filas afectadas
                                connection.release();
                            }
                        });
            }
        });
    },

    insertArticulo: function (datos, callback) {//la variable datos contiene todo lo que se va a insertar en formato json
        iniciar.getConnection(function (err, connection) {
            if (err) {
                callback(err, null)
            } else {
                connection.query("call sp_articulo("
                        + "'" + datos.serie + "',"
                        + "'" + datos.codigo + "',"
                        + "'" + datos.observacion + "',"
                        + "" + datos.meses + ","
                        + "" + datos.anio + ","
                        + "" + datos.peso + ","
                        + "'" + datos.fecha + "',"
                        + "'" + datos.ubicacion + "',"
                        + "'" + datos.proveedor + "',"
                        + "'" + datos.usuario + "'"
                        + ")", datos, function (error, results, rows) {

                            if (error) {
                                callback('error en la insercion: ' + error, null);
                            } else {
                                console.log(' DATOS AFECTADOS: ' + results.affectedRows);

                                callback(null, (results.affectedRows));
                                //indica el numero de filas afectadas
                                connection.release();
                            }
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
}
