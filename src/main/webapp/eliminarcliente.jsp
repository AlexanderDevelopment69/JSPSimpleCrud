<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eliminar Cliente</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="js/navbar.js"></script> <!-- Asegúrate de que la ruta sea correcta -->

    <style>
        /* Agrega tus estilos personalizados aquí */
    </style>
</head>
<body>
<!-- Navbar -->
<%@ include file="navbar.jsp" %>

<div class="container mt-4">
    <h2>Eliminar Cliente</h2>
    <form method="post" action="EliminarClienteServlet">
        <div class="form-group">
            <label for="clienteId">ID del Cliente:</label>
            <input type="text" class="form-control" id="clienteId" name="clienteId">
        </div>
        <button type="submit" class="btn btn-danger">Eliminar Cliente</button>
    </form>

    <!-- Aquí mostrar la tabla de clientes obtenidos desde la base de datos usando JSON -->
    <table class="table mt-4">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Apellido</th>
            <th>Email</th>
            <th>Teléfono</th>
            <th>Fecha de Registro</th>
            <th>Total Compras</th>
        </tr>
        </thead>
        <tbody id="datosClientes">
        <!-- Aquí se llenarán los datos de los clientes usando JavaScript -->
        </tbody>
    </table>
</div>

<!-- Modal para mostrar el mensaje de éxito -->
<div class="modal fade" id="eliminarClienteModal" tabindex="-1" role="dialog" aria-labelledby="eliminarClienteModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="eliminarClienteModalLabel">Cliente eliminado correctamente</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                El cliente ha sido eliminado correctamente.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>



<script>
    $(document).ready(function() {
        // Realiza una solicitud AJAX para obtener los datos JSON de los clientes
        $.ajax({
            url: "ListarClientes", // Asegúrate de que la URL sea la correcta
            type: "GET",
            dataType: "json",
            success: function(data) {
                // Llena la fila de la tabla con los datos JSON obtenidos
                var fila = $("#datosClientes");
                $.each(data, function(index, cliente) {
                    fila.append("<tr>" +
                        "<td>" + cliente.codigo + "</td>" +
                        "<td>" + cliente.nombre + "</td>" +
                        "<td>" + cliente.apellido + "</td>" +
                        "<td>" + cliente.email + "</td>" +
                        "<td>" + cliente.telefono + "</td>" +
                        "<td>" + cliente.fechaRegistro + "</td>" +
                        "<td>" + cliente.totalCompras + "</td>" +
                        "</tr>");
                });
            }
        });
    });
</script>
<script>
    // Verifica si el atributo "clienteEliminado" está presente en la solicitud
    if (${requestScope.clienteEliminado == true}) {
        // Muestra el modal de cliente eliminado correctamente
        $('#eliminarClienteModal').modal('show');
    }
</script>

</body>
</html>
