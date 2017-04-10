
var socket = io.connect();


function cargarTabla() {
    socket.emit('Cargar eventos', function (clientes) {


        w3.removeClass('#tablaEventos', 'w3-hide')
        w3.displayObject("tablaEventos", clientes);

        paginar();
        destruir();


    });



}

function destruir() {
    w3.removeClass('#paging_container11', 'container');
    w3.removeClass('#lblInfo', 'info_text');

}

function redireccionarAdmin() {
     window.location="/admin";
  //  window.locationf = "/home";
}


function buscar() {
    w3.filterHTML('#tablaEventos', 'li', $('#txtBuscar').val());


}

function cargarCategoria() {

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
                text: 'Catetorías'
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
                    showInLegend: false
                }
            },
            series: [{
                    name: 'Brands',
                    colorByPoint: true,
                    data: categoria
                }]
        });


    });
}

function paginar() {

    $('#paging_container11').pajinate();
}

$(document).ready(function () {



    cargarTabla();
    cargarCategoria();






});

