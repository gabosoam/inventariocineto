$(document).ready(function () {

    cargarTabla();
    cargarGeneros();
    cargarEstados();

    $('#reporte').on('click', function () {
        var load = '<img src="images/loading.gif"  width="30px" height="30px" style="margin-top:15px">';


        $('#miReporte').css("display", "none");

    });



});


var socket = io.connect();

function guardarCliente() {

    var datos = {

        cedula: document.getElementById("cedula").value,
        nombre: document.getElementById("nombre").value,
        apellido: document.getElementById("apellido").value,
        genero: document.getElementById("genero").value,
        estado: document.getElementById("estado").value,
        domicilio: document.getElementById("domicilio").value,
        celular: document.getElementById("celular").value,
        correo: document.getElementById("correo").value,
        fecha: document.getElementById("fecha").value,
        pais: document.getElementById("pais").value,
        ciudad: document.getElementById("ciudad").value,
        direccion: document.getElementById("direccion").value

    };
    if (datos.cedula == '' || datos.cedula == null) {
        swal("Error", "Ingrese la cedula", "error");
    } else if (datos.nombre == '' || datos.nombre == null) {
        swal("Error", "Ingrese los nombres", "error");
    } else if (datos.apellido == '' || datos.apellido == null) {
        swal("Error", "Ingrese los apellidos", "error");
    } else if (datos.genero == '' || datos.genero == null) {
        swal("Error", "Escoja el género", "error");
    } else if (datos.estado == '' || datos.estado == null) {
        swal("Error", "Escoja el estado civil", "error");
    } else if (datos.domicilio == '' || datos.domicilio == null) {
        swal("Error", "Ingrese el teléfono de domicilio", "error");
    } else if (datos.celular == '' || datos.celular == null) {
        swal("Error", "Ingrese el celular", "error");
    } else if (datos.correo == '' || datos.correo == null) {
        swal("Error", "Ingrese el correo", "error");
    } else if (datos.fecha == '' || datos.fecha == null) {
        swal("Error", "Escoja la fecha de nacimiento", "error");
    } else if (datos.pais == '' || datos.pais == null) {
        swal("Error", "Ingrese el país", "error");
    } else if (datos.ciudad == '' || datos.ciudad == null) {
        swal("Error", "Ingrese la ciudad", "error");
    } else if (datos.direccion == '' || datos.direccion == null) {
        swal("Error", "Ingrese la dirección", "error");
    } else {
        socket.emit('Guardar cliente', datos, function (mensaje) {

            var mensaje = mensaje[0].mensaje;

            if (mensaje == 'El cliente ha sido guardado') {
                swal('Bien', mensaje, "success");
                document.getElementById('id01').style.display = 'none';
                cargarTabla();
            } else {
                swal('Error', mensaje, "error");
            }

        });
    }

}

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
function enviarCateg() {
    jsreport.data.productcategory = document.getElementById("selectCateg").value;
    jsreport.download('Categoria ' + jsreport.data.productcategory + '.pdf', {
        template: {
            name: 'pdf prods',
            workspaceShortid: jsreport.template.workspaceShortid,
            workspaceVersion: jsreport.template.workspaceVersion
        },
        data: {
            productcategory: jsreport.data.productcategory
        }
    })
}


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
        w3.removeClass('#listaClientes', 'w3-hide');

    });


}


function cambiar() {
  
    socket.emit('Cambiar', function () {
  

    });
}

