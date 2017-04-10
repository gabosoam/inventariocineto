var socket = io.connect();

$(document).ready(function () {

    cargarTabla();


});

function cargarTabla() {
    socket.emit('Cargar eventos', function (actas) {
        w3.removeClass('#tablaEventos', 'w3-hide');
        w3.displayObject("tablaEventos", actas);
    });

   


}

function openCity(evt, cityName) {
    var i, x, tablinks;
    x = document.getElementsByClassName("city");
    for (i = 0; i < x.length; i++) {
        x[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablink");
    for (i = 0; i < x.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" w3-teal", "");
    }
    document.getElementById(cityName).style.display = "block";
    evt.currentTarget.className += " w3-teal";
}

function guardarContrato() {

    var datos = {

        id: document.getElementById("id").value,
        inicio: document.getElementById("inicio").value,
        final: document.getElementById("final").value,
        descripcion: document.getElementById("descripcion").value,
        cliente: document.getElementById("cliente").value

    };
    if (datos.id == '' || datos.id == null) {
        swal("Error", "Ingrese la cantidad", "error");
    } else if (datos.inicio == '' || datos.inicio == null) {
        swal("Error", "Inserte un numero de serie", "error");
    } else if (datos.final == '' || datos.final == null) {
        swal("Error", "Inserte los meses de garantíá del producto", "error");
    } else if (datos.descripcion == '' || datos.descripcion == null) {
        swal("Error", "Inserte el año de fabricación del producto", "error");
    } else if (datos.cliente == '' || datos.cliente == null) {
        swal("Error", "Inserte una observación del producto", "error");
    } else {
        socket.emit('Guardar contrato', datos, function (mensaje) {

            var mensaje = mensaje[0].nota;

            if (mensaje == 'El contrato ha sido registrado') {
                swal('Bien', mensaje, "success");
                document.getElementById('modalNuevo').style.display = 'none';
                cargarTabla();
            } else {
                swal('Error', mensaje, "error");
            }

        });

    }
}