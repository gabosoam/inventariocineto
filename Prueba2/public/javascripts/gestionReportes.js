
var socket = io.connect();




function destruir() {
    w3.removeClass('#paging_container11', 'container');
    w3.removeClass('#lblInfo', 'info_text');

}

function redireccionarAdmin() {
    window.location = "/admin";
    //  window.locationf = "/home";
}


function buscar() {
    w3.filterHTML('#tablaEventos', 'li', $('#txtBuscar').val());


}

function cargarReporte() {

    socket.emit('Cargar categoria chart', function (categoria) {

        // Build the chart
        Highcharts.chart('container', {
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                type: 'pie'
            },
            title: {
                text: 'Categorías'
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true
                    },
                    showInLegend: true
                }
            },
            series: [{
                name: 'Categorías',
                colorByPoint: true,
                data: categoria
            }]
        });


    });
}

function cargarReporteAlmacen() {

    socket.emit('Cargar almacen chart', function (categoria) {

        // Build the chart
        Highcharts.chart('container2', {
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                type: 'pie'
            },
            title: {
                text: 'Almacenes'
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true
                    },
                    showInLegend: true
                }
            },
            series: [{
                name: 'Almacen',
                colorByPoint: true,
                data: categoria
            }]
        });


    });
}

function cargarCategoria() {

    socket.emit('Cargar categoria', function (categoria) {


        w3.displayObject('cbxCategoria', categoria);





    });
}

function cargarMarca() {



    socket.emit('Cargar marca', function (marcas) {


        w3.displayObject("cbxMarca", marcas);



    });
}

function cargarAlmacen() {

    socket.emit('Cargar almacen', function (marcas) {


        w3.displayObject("cbxAlmacen", marcas);
        w3.displayObject("cbxAlmacen2", marcas);


    });


}

function cargarTablaDetalle(opcion) {





    if (opcion == 'categoria') {


        var datos = { valor: document.getElementById('cbxCategoria').value, opcion: 'Categoría' };

        socket.emit('Productos', datos.valor, function (productos) {
            datos = { valor: document.getElementById('cbxCategoria').value, opcion: 'Categoría', cantidad: productos.productos.length };

            w3.displayObject("listaDetalle", productos);
            document.getElementById('modalVer').style.display = 'block';
            w3.displayObject("datosActa", datos);



        });



    }

    if (opcion == 'marca') {
        var datos = { valor: document.getElementById('cbxMarca').value, opcion: 'Marca' };
        socket.emit('Cargar tabla marca', datos.valor, function (productos) {
 var datos = { valor: document.getElementById('cbxMarca').value, opcion: 'Marca', cantidad: productos.productos.length };

            w3.displayObject("listaDetalle", productos);
            document.getElementById('modalVer').style.display = 'block';
            w3.displayObject("datosActa", datos);



        });
    }

    if (opcion == 'almacen') {
        var datos = { valor: document.getElementById('cbxAlmacen').value, opcion: 'Almacen', cantidad: 0 };
        socket.emit('Cargar tabla ubicacion', datos.valor, function (productos) {
datos = { valor: document.getElementById('cbxAlmacen').value, opcion: 'Almacen', cantidad: productos.productos.length };

            w3.displayObject("listaDetalle", productos);
            document.getElementById('modalVer').style.display = 'block';
            w3.displayObject("datosActa", datos);



        });
    }

    


}




function paginar() {

    $('#paging_container11').pajinate();
}

$(document).ready(function () {

    cargarReporte();
    cargarReporteAlmacen();
    cargarCategoria();
    cargarMarca();
    cargarAlmacen();






});

