


var socket = io.connect();

function cargarGeneros() {
    socket.emit('Cargar generos', function (generos) {
        var data = '<option value="">Seleccionar género...</option>',
                cb = $('#genero');
        for (var i = 0; i < generos.length; i++) {
            var lvl = generos[i].nombre;
            data += '<option name="' + lvl + '">' + lvl + '</option>'
        }
        cb.html(data);
    });

}
;

function cargarEstados() {

    socket.emit('Cargar estados', function (estados) {
        var data = '<option value="">Seleccionar estado civil...</option>',
                cb = $('#estado');
        for (var i = 0; i < estados.length; i++) {
            var lvl = estados[i].nombre;
            data += '<option name="' + lvl + '">' + lvl + '</option>'
        }
        cb.html(data);
    });

}





function eliminarCliente(cedula) {

    swal({
        title: "Está seguro?",
        text: "No se podra recuperar el cliente una vez borrado",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Si, eliminar!",
        cancelButtonText: "No, cancelar!",
        closeOnConfirm: false,
        closeOnCancel: false
    },
            function (isConfirm) {
                if (isConfirm) {
                    socket.emit('Borrar cliente', cedula, function (resultado) {

                        if (resultado.error) {
                            swal("Error!", "No se puede eliminar al cliente seleccionado", "error");
                        } else {
                            swal("Eliminado!", "Se ha eliminado correctamente al cliente con la cédula: " + cedula, "success");
                            cargarTabla();
                        }
                    });

                } else {
                    swal("Cancelado", "El cliente no ha sido eliminado", "error");
                }
            });


}


function cargarTabla() {
    socket.emit('Cargar clientes', function (clientes) {
        w3.displayObject("listaClientes", clientes);
    });


}
;

$(document).ready(function () {

    cargarTabla();
    cargarGeneros();
    cargarEstados();
});