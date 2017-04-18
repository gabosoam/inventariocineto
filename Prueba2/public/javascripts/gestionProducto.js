var json;

function imprimir() {

    if (json.length == 0) {


    } else {
        JSONToCSVConvertor(json, "Reporte", true);
    }


}

function abrirModal(codigo) {

    var myObject = {
        codigo: codigo
    };
    w3.displayObject("lblCodigo", myObject);
    w3.displayObject("txtCodigo", myObject);
    document.getElementById('modalAnadir').style.display = 'block'

}

var socket = io.connect();

function cargarUbicacion() {

    socket.emit('Cargar ubicacion', function (ubicacion) {


        var data = '<option value="">Seleccionar una ubicación...</option>',
                cb = $('#ubicacion');
        for (var i = 0; i < ubicacion.length; i++) {

            var codigo = ubicacion[i].codigo;
            var nombre = ubicacion[i].label;
            data += '<option name="' + codigo + '">' + nombre + '</option>';

        }

        cb.html(data);
        cb.trigger("chosen:updated");
        $('#ubicacion').on('change', function () {

            var ubicacion = $(this).val();
            if (ubicacion) {


                cargarTablaUbicacion(ubicacion);
            } else {
                console.log("Seleccione ubicación");
            }
        });
        generarGraficoUbicacion(ubicacion);


    });


}






function cargarCategoria() {

    socket.emit('Cargar categoria', function (categoria) {


        w3.displayObject('cbxCategoria', categoria);
        w3.displayObject('cbxCategoria2', categoria);

        $('#cbxCategoria').on('change', function () {
            var lod = $('#load');
            var categoria = $(this).val();
            if (categoria) {

                cargarTablaCategoria(categoria);
            } else {
                console.log("Seleccione categoria");
            }
        });


    });
}


function cargarMarca() {



    socket.emit('Cargar marca', function (marcas) {


        w3.displayObject("cbxMarca", marcas);
        w3.displayObject("cbxMarca2", marcas);
        $('#cbxMarca').on('change', function () {


            var marca = $(this).val();

            if (marca) {


                cargarTablaMarca(marca);

            } else {
                console.log("Seleccione categoria");
            }
        });

    });
}

function cargarAlmacen() {

    socket.emit('Cargar almacen', function (marcas) {


        w3.displayObject("cbxAlmacen", marcas);
        w3.displayObject("cbxAlmacen2", marcas);
        $('#cbxAlmacen').on('change', function () {
            var almacen = $(this).val();

            if (almacen) {


                cargarTablaAlmacen(almacen);
            } else {
                console.log("Seleccione categoria");
            }
        });

    });


}
;

function cargarProveedor() {

    socket.emit('Cargar proveedor', function (proovedores) {

        w3.displayObject("txtProveedor", proovedores);
    });

}
;




function cargarTablaDetalle(codigo, producto, cantidad) {



    var myObject = {codigo2: codigo, producto: producto, cantidad: cantidad};




    socket.emit('Detalle', codigo, function (productos) {
        w3.displayObject("listaDetalle", productos);
       




        document.getElementById('modalVer').style.display = 'block';
         w3.displayObject("datosActa", myObject);

    });


}
;


function prueba(codigo) {
    cargarTablaDetalle(codigo);
    document.getElementById('id01').style.display = 'block'

}



function buscarFecha() {
    var fechaInicio = $('#inicio').val();
    var fechaFin = $('#fin').val();
    var rango = [{inicio: fechaInicio, fin: fechaFin}];


    $('#mensaje').text("Mostrando: Del: " + fechaInicio + " al: " + fechaFin);
    socket.emit('Cargar fecha', rango, function (productos) {





        JSONToCSVConvertor(productos, "Del: " + fechaInicio + " al: " + fechaFin, true);

    });
}
;

function buscar() {
    var terminoBusqueda = $("#txtBuscar").val();
    if (terminoBusqueda === '') {
    } else {
        cargarTabla(terminoBusqueda);

    }
}

function cargarTabla(terminoBusqueda) {
    w3.removeClass('#cargando', 'w3-hide');
    socket.emit('Busqueda global', terminoBusqueda.toLowerCase(), function (productos) {
        $('#mensaje').text(productos.productos.length + ' registros encontrados de busqueda: ' + terminoBusqueda);
        w3.displayObject("listaProductos", productos);
        json = productos.productos;
        if (productos.productos.length > 0) {
            w3.removeClass('#listaProductos', 'w3-hide')
        }
        w3.addClass('#cargando', 'w3-hide');
    });
}

function cargarTablaCategoria(categoria) {
    w3.removeClass('#cargando', 'w3-hide');
    socket.emit('Productos', categoria, function (productos) {
        json = productos.productos;
        $('#mensaje').text(productos.productos.length + ' registros encontrados de categoría: ' + categoria);
        w3.displayObject("listaProductos", productos);
        if (productos.productos.length > 0) {


            w3.removeClass('#listaProductos', 'w3-hide')

        }
        w3.addClass('#cargando', 'w3-hide');


    });
    w3_close();

}


function cargarTablaAlmacen(almacen) {

    w3.removeClass('#cargando', 'w3-hide');
    socket.emit('Cargar tabla ubicacion', almacen, function (productos) {
        json = productos.productos;
        $('#mensaje').text(productos.productos.length + ' registros encontrados en almacen: ' + almacen);
        w3.displayObject("listaProductos", productos);
        if (productos.productos.length > 0) {
            w3.removeClass('#listaProductos', 'w3-hide');
        }
        w3.addClass('#cargando', 'w3-hide');
    });
    w3_close();

}

function cargarTablaMarca(almacen) {
    // document.getElementById('modalCargando').style.display = 'block';

    w3.removeClass('#cargando', 'w3-hide');

    socket.emit('Cargar tabla marca', almacen, function (productos) {
        json = productos.productos;
        $('#mensaje').text(productos.productos.length + ' registros encontrados en marca: ' + almacen);
        w3.displayObject("listaProductos", productos);
        if (productos.productos.length > 0) {
            w3.removeClass('#listaProductos', 'w3-hide')
        }
        w3.addClass('#cargando', 'w3-hide');
    });

    w3_close();

}

function guardarProducto() {
    alert(document.getElementById("nombreUsuario").value);

    var datos = {

        codigo: document.getElementById("codigo").value,
        nombre: document.getElementById("nombre").value,
        categoria: document.getElementById("cbxCategoria2").value,
        marca: document.getElementById("cbxMarca2").value,
        usuario: document.getElementById("nombreUsuario").value

    };

    if (datos.codigo == '' || datos.codigo == null) {
        swal("Error", "Ingrese el código", "error");
    } else if (datos.nombre == '' || datos.nombre == null) {
        swal("Error", "Inserte un nombre", "error");
    } else if (datos.categoria == '' || datos.categoria == null) {
        swal("Error", "Escoja la categoría", "error");
    } else if (datos.marca == '' || datos.marca == null) {
        swal("Error", "Escoja la categoría", "error");
    } else {
        socket.emit('Guardar producto', datos, function (mensaje) {


            var mensaje = mensaje[0].mensaje;

            if (mensaje == 'El producto ha sido registrado') {
                swal('Bien', mensaje, "success");
                document.getElementById('modalNuevo').style.display = 'none';
                cargarTabla(datos.codigo);
            } else {
                swal('Error', mensaje, "error");
            }

        });

    }
}
function guardarArticulo() {
    var opcion = $('input[name="opcion"]:checked').val();

    if (opcion == 'lotes') {
        var datos = {
            serie: 'S/N',
            codigo: $('#lblCodigo').text(),
            cantidad: document.getElementById("txtCantidad").value,
            usuario: document.getElementById("nombreUsuario").value,
            meses: document.getElementById("txtMeses").value,
            anio: document.getElementById("txtAnio").value,
            observacion: document.getElementById("txtObservacion").value,
            peso: document.getElementById("txtPeso").value,
            fecha: document.getElementById("txtFecha").value,
            ubicacion: document.getElementById("cbxAlmacen2").value,
            proveedor: document.getElementById("txtProveedor").value,

        };
        if (datos.cantidad == '' || datos.cantidad == null) {
            swal("Error", "Ingrese la cantidad", "error");
        } else if (datos.serie == '' || datos.serie == null) {
            swal("Error", "Inserte un numero de serie", "error");
        } else if (datos.meses == '' || datos.meses == null) {
            swal("Error", "Inserte los meses de garantíá del producto", "error");
        } else if (datos.anio == '' || datos.anio == null) {
            swal("Error", "Inserte el año de fabricación del producto", "error");
        } else if (datos.observacion == '' || datos.observacion == null) {
            swal("Error", "Inserte una observación del producto", "error");
        } else if (datos.peso == '' || datos.peso == null) {
            swal("Error", "Inserte el peso", "error");
        } else if (datos.fecha == '' || datos.fecha == null) {
            swal("Error", "Inserte la fecha del producto", "error");
        } else if (datos.ubicacion == '' || datos.ubicacion == null) {
            swal("Error", "Escoja la ubicación del producto", "error");
        } else if (datos.proveedor == '' || datos.proveedor == null) {
            swal("Error", "Escoja el proveedor del producto", "error");
        } else {
            for (var i = 0; i < datos.cantidad; i++) {
                socket.emit('Guardar articulo', datos, function (rows) {
                    if (rows == 1) {
                        document.getElementById('modalAnadir').style.display = 'none'
                        swal("", "El artículo ha sido registrado satisfactoriamente", "success");
                        cargarTabla(datos.codigo);
                    } else {

                        swal("Error", "El artículo ya existe", "error");
                    }


                });
            }


        }



    } else if (opcion == 'individual') {
        var datos = {
            serie: document.getElementById("txtSerie").value,
            codigo: $('#lblCodigo').text(),
            cantidad: document.getElementById("txtCantidad").value,
            usuario: document.getElementById("nombreUsuario").value,
            meses: document.getElementById("txtMeses").value,
            anio: document.getElementById("txtAnio").value,
            observacion: document.getElementById("txtObservacion").value,

            peso: document.getElementById("txtPeso").value,
            fecha: document.getElementById("txtFecha").value,
            ubicacion: document.getElementById("cbxAlmacen2").value,
            proveedor: document.getElementById("txtProveedor").value
        };

        if (datos.serie == '' || datos.serie == null) {
            swal("Error", "Inserte un numero de serie", "error");
        } else if (datos.meses == '' || datos.meses == null) {
            swal("Error", "Inserte los meses de garantíá del producto", "error");
        } else if (datos.anio == '' || datos.anio == null) {
            swal("Error", "Inserte el año de fabricación del producto", "error");
        } else if (datos.observacion == '' || datos.observacion == null) {
            swal("Error", "Inserte una observación del producto", "error");
        } else if (datos.peso == '' || datos.peso == null) {
            swal("Error", "Inserte el peso", "error");
        } else if (datos.fecha == '' || datos.fecha == null) {
            swal("Error", "Inserte la fecha del producto", "error");
        } else if (datos.ubicacion == '' || datos.ubicacion == null) {
            swal("Error", "Escoja la ubicación del producto", "error");
        } else if (datos.proveedor == '' || datos.proveedor == null) {
            swal("Error", "Escoja el proveedor del producto", "error");
        } else {

            socket.emit('Guardar articulo', datos, function (rows) {
                if (rows == 1) {
                    document.getElementById('modalAnadir').style.display = 'none'
                    swal("", "El artículo ha sido registrado satisfactoriamente", "success");
                    cargarTabla(datos.codigo);
                } else {

                    swal("Error", "El artículo ya existe", "error");
                }


            });


        }
    }















}


function paginar() {
    var monkeyList = new List('listar', {
        valueNames: ['name'],
        page: 10,
        pagination: true
    });
}

function myFunction2() {
    var input, filter, ul, li, a, i;
    input = document.getElementById("myInput");
    filter = input.value.toUpperCase();
    ul = document.getElementById("listaDetalle");
    li = ul.getElementsByTagName("li");
    for (i = 0; i < li.length; i++) {
        if (li[i].innerHTML.toUpperCase().indexOf(filter) > -1) {
            li[i].style.display = "";
        } else {
            li[i].style.display = "none";
        }
    }
}




$(document).ready(function () {
    // $('#listaProductos').hide();
    // $('#principal').hide();


    $('#lblSerie').hide();

    //  w3.hide('#listaProductos');
    //  w3.hide('#principal');
    $('#txtBuscar').keypress(function (e) {
        if (e.keyCode == 13)
            buscar();
    });

    $('input[type=radio][name=opcion]').change(function () {
        if (this.value == 'lotes') {

            $('#lblSerie').hide();
            $('#lblCantidad').show();

        } else if (this.value == 'individual') {
            $('#lblSerie').show();
            $('#lblCantidad').hide();
        }
    });


    cargarCategoria();
    cargarMarca();
    cargarAlmacen();
    cargarProveedor();


});

