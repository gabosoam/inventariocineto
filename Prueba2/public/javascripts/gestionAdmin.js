var socket = io.connect();

$(document).ready(function () {

    cargarTabla();
    cargarTablaContratos();
    cargarTablaUsuarios();
    cargarTablaLogs();


});

function cargarTabla() {
    socket.emit('Cargar eventos', function (actas) {
        w3.removeClass('#tablaEventos', 'w3-hide');
        w3.displayObject("tablaEventos", actas);
    });




}

function cargarTablaContratos() {

    socket.emit('Cargar contratos', function (contratos) {

        w3.displayObject("listaContratos", contratos);
        w3.removeClass('#listaContratos', 'w3-hide');
    });
}

function cargarTablaContratos() {

    socket.emit('Cargar contratos', function (contratos) {

        w3.displayObject("listaContratos", contratos);
        w3.removeClass('#listaContratos', 'w3-hide');
    });
}

function cargarTablaUsuarios() {

    socket.emit('Cargar usuarios', function (contratos) {

        w3.displayObject("listaUsuarios", contratos);
        w3.removeClass('#listaUsuarios', 'w3-hide');
    });
}

function cargarTablaLogs() {

    socket.emit('Cargar logs', function (contratos) {

        w3.displayObject("listaLog", contratos);
        w3.removeClass('listaLog', 'w3-hide');
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
        cliente: document.getElementById("cliente").value,
        usuario: document.getElementById("nombreUsuario").value

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

function guardarUsuario() {


    var datos = {

        nickUser: document.getElementById("nickUser").value,
        nombreUser: document.getElementById("nombreUser").value,
        cedulaUser: document.getElementById("cedulaUser").value,
        rolUser: document.getElementById("rolUser").value
    };
    

    if (datos.nickUser == '' || datos.nickUser == null) {
        swal("Error", "Ingrese el nombre de usuario", "error");
    } else if (datos.nombreUser == '' || datos.nombreUser == null) {
        swal("Error", "Ingrese los nombres del usuario", "error");
    } else if (datos.cedulaUser == '' || datos.cedulaUser == null) {
        swal("Error", "Ingrese el número de cédula del usuario", "error");
    } else if (datos.rolUser == '' || datos.rolUser == null) {
        swal("Error", "Escoja el rol del usuario", "error");
    } else {
        socket.emit('Guardar usuario', datos, function (mensaje) {

            var mensaje = mensaje[0].nota;

            if (mensaje == 'El usuario ha sido registrado') {
                swal('Bien', mensaje, "success");
                document.getElementById('modalNuevo').style.display = 'none';
                cargarTabla();
            } else {
                swal('Error', mensaje, "error");
            }

        });

    }
}