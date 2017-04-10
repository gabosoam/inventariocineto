var socket = io.connect();

$(document).ready(function () {

    cargarTabla();

});

function cargarTabla() {
   
    socket.emit('Cargar contratos', function (contratos) {
     
        w3.displayObject("listaContratos", contratos);
        w3.removeClass('#listaContratos','w3-hide');
    });
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