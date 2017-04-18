var socket = io.connect();
var acta;

$(document).ready(function () {

    $('#txtBuscarProd').keypress(function (e) {
        if (e.keyCode == 13)
            buscar();
    });

    cargarTabla();

});

function cargarTabla() {
    socket.emit('Cargar actas', function (actas) {

        if (actas.actas.length > 0) {
            w3.displayObject("listaActas", actas);
            w3.removeClass('#listaActas', 'w3-hide');
        }


    });
}

function buscar() {
    var terminoBusqueda = $("#txtBuscarProd").val();

    if (terminoBusqueda === '') {
    } else {
        cargarTablaProducto(terminoBusqueda);

    }
}

function cargarTablaProducto(terminoBusqueda) {

    socket.emit('Busqueda global Acta', terminoBusqueda.toLowerCase(), function (productos) {

        w3.displayObject("listaProductos", productos);
        json = productos.productos;
        if (productos.productos.length > 0) {
            w3.removeClass('#listaProductos', 'w3-hide')
        }

    });
}

function anadirProducto(actaProd, tipo) {

    acta = actaProd;

    if (tipo == 'De entrega') {
        
    }

    switch (tipo) {
        case 'De entrega':
            document.getElementById('modalAnadir').style.display = 'block';
            break;
        case 'De retiro':
            alert('Muy pronto');
            break;
        default:
            
    }





}

function cargarTablaDetalle(codigo, cliente, contrato, descripcion, fecha, hora) {

    var myObject = { acta: codigo, cliente: cliente, contrato: contrato, descripcion: descripcion, fecha: fecha, hora: hora };


    socket.emit('Detalle Acta', codigo, function (productos) {



        if (productos.resultados.length > 0) {
            w3.displayObject("listaDetalle", productos);

            //    w3.displayObject("lblCodigo", productos);
            w3.displayObject("datosActa", myObject);
            $('#lblCodigo').text('Vista previa');
            //  $('#lblActa').text(codigo);
            document.getElementById('modalVer').style.display = 'block';
        } else {
            swal("Aviso", "No existen productos para mostrar", "info");
        }



    });


}

function printDiv(div) {
    var divToPrint = document.getElementById(div);
    var newWin = window.open('', 'Print-Window', 'width=100%,height=100%,top=100,left=100');
    newWin.document.
        newWin.document.open();
    newWin.document.write('<html><head><style>#in {display:none}</style></head><body onload="window.print()">' + divToPrint.innerHTML + '</body></html>');
    newWin.document.close();
    setTimeout(function () {
        newWin.close();
    }, 10);

}


function guardarActas() {


    var datos = {
        codigo: document.getElementById("codigo").value,
        tipo: document.getElementById("tipo").value,
        fecha: document.getElementById("fecha").value,
        hora: document.getElementById("hora").value,
        contrato: document.getElementById("contrato").value,
        descripcion: document.getElementById("descripcion").value,
        usuario: document.getElementById("nombreUsuario").value
    };


    if (datos.codigo == '' || datos.codigo == null) {
        swal('Error', 'Ingrese el código del producto');
    } else if (datos.tipo == '' || datos.tipo == null) {
        swal('Error', 'Escoja el tipo del producto');
    } else if (datos.fecha == '' || datos.fecha == null) {
        swal('Error', 'Escoja la fecha de creación del acta');
    } else if (datos.hora == '' || datos.hora == null) {
        swal('Error', 'Escoja la hora de creación del acta');
    } else if (datos.contrato == '' || datos.contrato == null) {
        swal('Error', 'Ingrese el número de contrato');
    } else if (datos.descripcion == '' || datos.descripcion == null) {
        swal('Error', 'Ingrese una drescripción');
    } else {
        socket.emit('Guardar acta', datos, function (mensaje) {

            var mensaje = mensaje[0].nota;

            if (mensaje == 'El acta ha sido generada') {
                swal('Bien', mensaje, "success");
                document.getElementById('modalNuevo').style.display = 'none';
                cargarTabla();
            } else {
                swal('Error', mensaje, "error");
            }

        });

    }

}


function guardarProductos(serie, codigo) {


    var datos = {
        serie: serie,
        codigo: codigo,
        acta: acta,

    };

    socket.emit('Guardar acta prod', datos, function (mensaje) {

        var mensaje = mensaje[0].nota;

        if (mensaje == 'El producto ha sido asignado correctamente') {
            swal('Bien', mensaje, "success");
            document.getElementById('modalAnadir').style.display = 'none';
            cargarTabla();
        } else {
            swal('Error', mensaje, "error");
        }

    });










}