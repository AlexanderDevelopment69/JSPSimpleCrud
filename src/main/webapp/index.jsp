<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Página Principal</title>
    <!-- Incluye tus enlaces a CSS de Bootstrap y otros recursos aquí -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Agrega la referencia a Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


    <!-- Agrega más enlaces a CSS y recursos según sea necesario -->
</head>
<body>
<jsp:include page="navbar.jsp"/>

<div class="container">
    <!-- Contenido de tu página index.jsp -->
    <h1 class="mt-5">Bienvenido a Mi Sitio Web</h1>
    <p>Selecciona una opción en el menú de arriba.</p>
    <h2>Gráfico Chart</h2>

    <!-- Agrega un contenedor para el gráfico -->
    <div style="width: 600px; height: 600px;">
        <canvas id="pieChart"></canvas>
    </div>


</div>

<!-- Agrega las referencias a los archivos JavaScript de Bootstrap y jQuery (opcional) -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- Script para obtener datos y crear el gráfico -->
<script>
    $(document).ready(function () {
        $.ajax({
            url: "ListarClientes", // URL del servlet
            type: "GET", // Método de solicitud HTTP
            dataType: "json", // Tipo de datos esperados en la respuesta
            success: function (data) {
                // Obtén los datos de clientes del JSON
                var codigos = data.map(function (cliente) {
                    return cliente.nombre;
                });

                var totalCompras = data.map(function (cliente) {
                    return cliente.totalCompras;
                });

                // Configura los datos del gráfico
                var ctx = document.getElementById("pieChart").getContext("2d");
                var pieChart = new Chart(ctx, {
                    type: "pie",
                    data: {
                        labels: codigos,
                        datasets: [
                            {
                                data: totalCompras,
                                backgroundColor: totalCompras.map(function () {
                                    return generarColorAleatorio();
                                }),
                            },
                        ],
                    },
                });

            },


            error: function (xhr, status, error) {
                // Manejo de errores si la solicitud falla
                console.error(error);
            },
        });
    });

    function generarColorAleatorio() {
        var letras = "0123456789ABCDEF";
        var color = "#";
        for (var i = 0; i < 6; i++) {
            color += letras[Math.floor(Math.random() * 16)];
        }
        return color;
    }


</script>


</body>
</html>
