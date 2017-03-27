
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
        $('#txtCod').text(productos[0].codigo);
        $('#txtNombre').text('Nombre:' + productos[0].nombre);
        $('#txtCategoria').text(productos[0].categoria);
        $('#txtMarca').text(productos[0].marca);
        $('#txtCantidad').text(productos.length);


        var thead = '<thead><tr><th>Producto</th><th>Acciones</th></tr></thead>';
        var data = '<tbody>',
                cb = $('#tablaDetalle');
        for (var i = 0; i < productos.length; i++) {
            var fecha = productos[i].fecha;
            var serie = productos[i].serie;
            var categoria = productos[i].categoria;
            var ubicacion = productos[i].ubicacion;
            var cantidad = productos[i].cantidad;


            var acciones = '<a onclick="eliminarCliente(' + productos[i].codigo + ')"  data-toggle="tooltip" title="Eliminar!" class="btn btn-danger  btn-outline" ><span class="fa fa-truck fa-lg"></span> Registrar salida</a>';
            data += '<tr>\n\
                        <td> \n\
                        <strong>Número de serie: </strong>' + serie + '<br>\
                        <strong>Fecha de ingreso: </strong>' + fecha + '<br>\
                        <strong>Ubicación: </strong>' + ubicacion + '<br>\
                        </td\n\
                        >\n\
                        <td>' + acciones + '</td>\n\
                    </tr>';
        }

        $('#txtCodigo').val(productos[0].codigo);
        $('#categoria').val(productos[0].categoria);
        $('#txtNombre').val(productos[0].nombre);
        $('#txtCantidad').val(productos.length);
        $('#txtTitulo').text(productos[0].nombre);
        $('#txtNombre').text(productos[0].nombre);

        cb.html(thead + data + '</tbody>');

        $(cb).dataTable({
            destroy: true,
            responsive: true,
            "oLanguage": {
                "sLengthMenu": "Abrir _MENU_ Elementos",
                "sSearch": "Buscar: ",
                "sZeroRecords": "Ningún elemento encontrado",
                "sNextButton": "Siguiente",
                "sInfo": "Registros del _START_ al _END_ de _TOTAL_ registros",
                "sPrevious": "Anterior",
                "sInfoFiltered": "(filtrado de _MAX_  registros)",
            }

        });
        document.getElementById('btnNuevo').style.visibility = "visible";

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
        socket.emit('Busqueda global', terminoBusqueda.toLowerCase(), function (productos) {
            $('#mensaje').text(productos.productos.length + ' registros encontrados de busqueda: ' + terminoBusqueda);
            w3.displayObject("listaProductos", productos);
            if (productos.productos.length > 0) {
                w3.show('#listaProductos');
            }
        });
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




$(document).ready(function () {
    w3.hide('#listaProductos')
    $('#txtBuscar').keypress(function (e) {
        if (e.keyCode == 13)
            buscar();
    });


    cargarCategoria();
    cargarMarca();
    cargarAlmacen();


});

