<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Actualizar Cliente</title>
    <!-- Agrega las referencias a los archivos CSS de Bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<!-- Incluye el navbar -->
<%@ include file="navbar.jsp" %>

<div class="container mt-4">
    <h2>Listado de Clientes</h2>

    <!-- Agrega un campo de búsqueda por código -->
    <div class="form-group">
        <label for="codigoBusqueda">Buscar por Código:</label>
        <input type="text" class="form-control" id="codigoBusqueda">
    </div>
    <button class="btn btn-primary" onclick="buscarClientePorCodigo()">Buscar</button>

    <div></div>

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
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody id="datosClientes">
        <!-- Aquí se llenarán las filas de datos -->
        </tbody>
    </table>
</div>

<!-- Modal de Edición de Cliente -->
<div class="modal fade" id="editarClienteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Editar Cliente</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- Formulario de Edición de Cliente -->
                <form id="editarClienteForm">
                    <input type="hidden" id="codigoCliente" name="codigoCliente">
                    <div class="form-group">
                        <label for="nombre">Nombre:</label>
                        <input type="text" class="form-control" id="nombre" name="nombre">
                    </div>
                    <div class="form-group">
                        <label for="apellido">Apellido:</label>
                        <input type="text" class="form-control" id="apellido" name="apellido">
                    </div>
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" class="form-control" id="email" name="email">
                    </div>
                    <div class="form-group">
                        <label for="telefono">Teléfono:</label>
                        <input type="tel" class="form-control" id="telefono" name="telefono">
                    </div>
                    <div class="form-group">
                        <label for="fechaRegistro">Fecha de Registro:</label>
                        <input type="date" class="form-control" id="fechaRegistro" name="fechaRegistro"
                               data-date-format="yyyy-mm-dd">
                    </div>
                    <div class="form-group">
                        <label for="totalCompras">Total Compras:</label>
                        <input type="text" class="form-control" id="totalCompras" name="totalCompras">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary" onclick="guardarCambios()">Guardar Cambios</button>
            </div>
        </div>
    </div>
</div>

<!-- Agrega las referencias a los archivos JavaScript de Bootstrap y jQuery (opcional) -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- Agrega un script para cargar los datos JSON en la tabla y abrir el modal de edición -->
<script>
    $(document).ready(function () {
        // Realiza una solicitud AJAX para obtener los datos JSON de los clientes
        cargarDatosClientes();

    });

    // Convierte la fecha al formato 'yyyy-mm-dd'
    function formatDate(fecha) {
        var d = new Date(fecha);
        var year = d.getFullYear();
        var month = (d.getMonth() + 1).toString().padStart(2, '0');
        var day = d.getDate().toString().padStart(2, '0');
        return year + '-' + month + '-' + day;
    }

    // Función para cargar los datos del cliente en el modal de edición
    function editarCliente(codigo, nombre, apellido, email, telefono, fechaRegistro, totalCompras) {
        // Llena los campos del formulario de edición con los datos de la fila de la tabla, incluyendo la fecha convertida
        $("#codigoCliente").val(codigo);
        $("#nombre").val(nombre);
        $("#apellido").val(apellido);
        $("#email").val(email);
        $("#telefono").val(telefono);
        // Convierte la fecha al formato 'yyyy-mm-dd'
        var fechaFormateada = formatDate(fechaRegistro);
        $("#fechaRegistro").val(fechaFormateada); // Aquí se establece la fecha convertida
        $("#totalCompras").val(totalCompras);

        // Abre el modal de edición
        $('#editarClienteModal').modal('show');
    }

    // Esta función se llama cuando se hace clic en "Guardar Cambios" en el modal de edición
    function guardarCambios() {
        // Obtén los datos del formulario
        var codigoCliente = $("#codigoCliente").val();
        var nombre = $("#nombre").val();
        var apellido = $("#apellido").val();
        var email = $("#email").val();
        var telefono = $("#telefono").val();
        var fechaRegistro = $("#fechaRegistro").val();
        var totalCompras = $("#totalCompras").val();

        // Crea un objeto con los datos del cliente
        var cliente = {
            codigo: codigoCliente,
            nombre: nombre,
            apellido: apellido,
            email: email,
            telefono: telefono,
            fechaRegistro: fechaRegistro,
            totalCompras: totalCompras
        };

        // Realiza una solicitud AJAX para enviar los datos al servlet de actualización
        $.ajax({
            url: "ActualizarClienteServlet", // Reemplaza con la URL de tu servlet de actualización
            type: "POST",
            data: JSON.stringify(cliente), // Convierte el objeto a JSON
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                // Aquí puedes manejar la respuesta del servidor, por ejemplo, mostrar un mensaje de éxito
                alert("Los cambios se han guardado correctamente");

                // Cierra el modal de edición
                $('#editarClienteModal').modal('hide');

                // Actualiza la tabla con los nuevos datos de los clientes
                cargarDatosClientes();
            },
            error: function (xhr, status, error) {
                // Maneja errores en caso de que la solicitud AJAX falle
                console.error("Error al guardar los cambios: " + error);
            }
        });
    }

    // Función para actualizar la tabla de clientes
    function cargarDatosClientes() {
        // Realiza una solicitud AJAX para obtener los datos JSON de los clientes
        $.ajax({
            url: "ListarClientes",
            type: "GET",
            dataType: "json",
            success: function (data) {
                // Obtén el cuerpo de la tabla donde se insertarán los datos
                var tbody = $("#datosClientes");

                // Limpia el contenido actual del cuerpo de la tabla
                tbody.empty();

                // Llena la tabla con los datos JSON obtenidos
                $.each(data, function (index, cliente) {
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

                    // Crea un botón de editar y pasa los datos del cliente a la función editarCliente
                    var editarBtn = $("<button class='btn btn-primary' onclick='editarCliente(" +
                        cliente.codigo + ", \"" +
                        cliente.nombre + "\", \"" +
                        cliente.apellido + "\", \"" +
                        cliente.email + "\", \"" +
                        cliente.telefono + "\", \"" +
                        cliente.fechaRegistro + "\", \"" +
                        cliente.totalCompras + "\")'>Editar</button>");

                    var tdAcciones = $("<td>");
                    tdAcciones.append(editarBtn);
                    row.append(tdAcciones);

                    // Agrega la fila al cuerpo de la tabla
                    tbody.append(row);
                });
            }
        });
    }


    function buscarClientePorCodigo() {
        // Obtiene el código de cliente ingresado en el campo de búsqueda
        var codigoBusqueda = $("#codigoBusqueda").val();

        // Realiza una solicitud AJAX para buscar el cliente por código
        $.ajax({
            url: "BuscarClienteServlet?codigo=" + codigoBusqueda, // Reemplaza con la URL de tu servlet de búsqueda
            type: "GET",
            dataType: "json",
            success: function (cliente) {
                // Limpia el contenido actual del cuerpo de la tabla
                $("#datosClientes").empty();

                // Verifica si se encontró un cliente
                if (cliente) {
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

                    // Crea un botón de editar y pasa los datos del cliente a la función editarCliente
                    var editarBtn = $("<button class='btn btn-primary' onclick='editarCliente(" +
                        cliente.codigo + ", \"" +
                        cliente.nombre + "\", \"" +
                        cliente.apellido + "\", \"" +
                        cliente.email + "\", \"" +
                        cliente.telefono + "\", \"" +
                        cliente.fechaRegistro + "\", \"" +
                        cliente.totalCompras + "\")'>Editar</button>");

                    var tdAcciones = $("<td>");
                    tdAcciones.append(editarBtn);
                    row.append(tdAcciones);

                    // Agrega la fila al cuerpo de la tabla
                    $("#datosClientes").append(row);
                } else {
                    // Si no se encuentra el cliente, muestra un mensaje de error o un aviso al usuario
                    alert("Cliente no encontrado.");
                }
            },
            error: function (xhr, status, error) {
                // Maneja errores en caso de que la solicitud AJAX falle
                console.error("Error al buscar el cliente: " + error);
            }
        });
    }




</script>
</body>
</html>
