
var socket = io.connect();

function cargarUbicacion() {

    socket.emit('Cargar ubicacion', function (ubicacion) {


        generarGraficoUbicacion(ubicacion);


    });


};

function cargarCategoria() {

    socket.emit('Cargar categoria', function (categoria) {


        generarGrafico(categoria);


    });
}

function generarGrafico(valores) {
    var plotObj = $.plot($("#flot-pie-chart"), valores, {
        series: {
            pie: {
                show: true,
                combine: {
                    color: '#999',
                    threshold: 0.1
                }
            }
        },

        grid: {
            hoverable: true,

        },
        tooltip: true,
        tooltipOpts: {
            content: "%p.0%, %s", // show percentages, rounding to 2 decimal places
            shifts: {
                x: 50,
                y: 0
            },
            defaultTheme: true
        }
    });
}
;

function generarGraficoUbicacion(valores) {

    var plotObj = $.plot($("#chart_ubicacion"), valores, {

        series: {
            pie: {
                show: true,
                combine: {
                    color: '#999',
                    threshold: 0.1
                }
            }
        },

        grid: {
            hoverable: true,

        },
        tooltip: true,
        tooltipOpts: {
            content: "%p.0%, %s", // show percentages, rounding to 2 decimal places
            shifts: {
                x: 50,
                y: 0
            },
            defaultTheme: true
        }
    });
}
;

$(document).ready(function () {
 
    cargarCategoria();
    cargarUbicacion();


});

