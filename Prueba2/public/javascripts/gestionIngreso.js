
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

function agregar() {
    var table = document.getElementById("tabla");
    var row = table.insertRow(1);
    var cell1 = row.insertCell(0);
    var cell2 = row.insertCell(1);
    cell1.innerHTML = "NEW CELL1";
    cell2.innerHTML = "NEW CELL2";
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

function cargarTablaDetalle(codigo) {

    socket.emit('Detalle', codigo, function (productos) {

        $('#mensaje').text(productos.productos.length + ' registros encontrados en almacen: ' + codigo);
        var myObject = {
            nombre: productos.productos[0].nombre,
            codigo: productos.productos[0].codigo,
            categoria: productos.productos[0].categoria,
            marca: productos.productos[0].marca
        };
        w3.displayObject("txtModelo", myObject);


        w3.displayObject("listaProductos", productos);

        if (productos.productos.length > 0) {
            w3.show('#listaProductos');
        }

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
        cargarTablaDetalle(terminoBusqueda);
    }
}

function cargarTablaCategoria(categoria) {
    socket.emit('Productos', categoria, function (productos) {
        $('#mensaje').text(productos.productos.length + ' registros encontrados de categoría: ' + categoria);
        w3.displayObject("listaProductos", productos);
        if (productos.productos.length > 0) {
            w3.show('#listaProductos');
        }
    });
    w3_close();

}
;

function cargarTablaAlmacen(almacen) {
    socket.emit('Cargar tabla ubicacion', almacen, function (productos) {
        $('#mensaje').text(productos.productos.length + ' registros encontrados en almacen: ' + almacen);
        w3.displayObject("listaProductos", productos);
        if (productos.productos.length > 0) {
            w3.show('#listaProductos');
        }
    });
    w3_close();

}

function cargarTablaMarca(almacen) {
    socket.emit('Cargar tabla marca', almacen, function (productos) {
        $('#mensaje').text(productos.productos.length + ' registros encontrados en marca: ' + almacen);
        w3.displayObject("listaProductos", productos);
        if (productos.productos.length > 0) {
            w3.show('#listaProductos');
        }
    });
    w3_close();

}

function limpiar() {
    var myObject = {
        nombre: '',
        codigo: '',
        categoria: '',
        marca: ''
    };
    w3.displayObject("txtModelo", myObject);
}
;




$(document).ready(function () {
    cargarAlmacen();
    limpiar();
    w3.hide('#listaProductos')
    $('#txtBuscar').keypress(function (e) {
        if (e.keyCode == 13)
            buscar();
    });






});

