<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Buscar Cliente</title>
    <!-- Agrega las referencias a los archivos CSS de Bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<!-- Incluye el navbar si lo tienes -->
<jsp:include page="navbar.jsp" />
<div class="container mt-4">
    <h2>Buscar Cliente por Código</h2>
    <form id="buscarClienteForm">
        <div class="form-group">
            <label for="codigo">Código del Cliente:</label>
            <input type="text" class="form-control" id="codigo" name="codigo">
        </div>
        <button type="submit" class="btn btn-primary">Buscar Cliente</button>
    </form>

<%--    <h3>Datos del Cliente</h3>--%>
    <table class="table mt-4">
        <thead>
        <tr>
            <th>Código</th>
            <th>Nombre</th>
            <th>Apellido</th>
            <th>Email</th>
            <th>Teléfono</th>
            <th>Fecha de Registro</th>
            <th>Total Compras</th>
        </tr>
        </thead>
        <tbody id="datosCliente">
        <!-- Aquí se llenarán los datos del cliente -->
        </tbody>
    </table>
</div>

<!-- Agrega las referencias a los archivos JavaScript de Bootstrap y jQuery (opcional) -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- Agrega un script para manejar la búsqueda de cliente y mostrar los resultados -->
<script>
    $(document).ready(function() {
        $("#buscarClienteForm").submit(function(event) {
            event.preventDefault();

            // Obtiene el código del cliente desde el formulario
            var codigo = $("#codigo").val();

            // Realiza una solicitud AJAX para buscar al cliente por código
            $.ajax({
                url: "BuscarClienteServlet",
                type: "GET",
                data: { codigo: codigo },
                dataType: "json",
                success: function(data) {
                    // Limpia el contenido actual de los datos del cliente
                    $("#datosCliente").empty();

                    // Verifica si se encontró un cliente
                    if (data != null) {
                        // Crea una nueva fila para mostrar los datos del cliente
                        var row = $("<tr>");
                        row.append("<td>" + data.codigo + "</td>");
                        row.append("<td>" + data.nombre + "</td>");
                        row.append("<td>" + data.apellido + "</td>");
                        row.append("<td>" + data.email + "</td>");
                        row.append("<td>" + data.telefono + "</td>");
                        row.append("<td>" + data.fechaRegistro + "</td>");
                        row.append("<td>" + data.totalCompras + "</td>");

                        // Agrega la fila a la tabla
                        $("#datosCliente").append(row);
                    }
                    else {
                        // Si no se encontró ningún cliente, muestra un mensaje de error
                        $("#datosCliente").html("<tr><td colspan='6'>Cliente no encontrado.</td></tr>");

                        // $("#datosCliente").html("<tr><td colspan='6'>" + mensajeError + "</td></tr>");
                    }
                }
            });
        });
    });
</script>

<!-- Agrega un script para cargar los datos JSON en la tabla al cargar la página -->
<script>
    $(document).ready(function() {
        // Realiza una solicitud AJAX para obtener los datos JSON de los clientes al cargar la página
        $.ajax({
            url: "ListarClientes",
            type: "GET",
            dataType: "json",
            success: function(data) {
                // Obtén el cuerpo de la tabla donde se insertarán los datos
                var tbody = $("#datosCliente");

                // Limpia el contenido actual del cuerpo de la tabla
                tbody.empty();

                // Llena la tabla con los datos JSON obtenidos
                $.each(data, function(index, cliente) {
                    // Crea una nueva fila
                    var row = $("<tr>");

                    // Agrega las celdas de datos a la fila
                    row.append("<td>" + cliente.codigo + "</td>");
                    row.append("<td>" + cliente.nombre + "</td>");
                    row.append("<td>" + cliente.apellido + "</td>");
                    row.append("<td>" + cliente.email + "</td>");
                    row.append("<td>" + cliente.telefono + "</td>");
                    row.append("<td>" + cliente.fechaRegistro + "</td>");
                    row.append("<td>" + cliente.totalCompras + "</td>");

                    // Agrega la fila al cuerpo de la tabla
                    tbody.append(row);
                });
            },
            error: function() {
                // En caso de error en la solicitud AJAX
                alert("Error al cargar los clientes.");
            }
        });
    });
</script>
</body>
</html>
