<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Agregar Cliente</title>
    <!-- Incluye tus enlaces a CSS de Bootstrap y otros recursos aquí -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Agrega más enlaces a CSS y recursos según sea necesario -->
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="container mt-4">
    <h2>Agregar Cliente</h2>
    <form action="AgregarCliente" method="post">
        <div class="form-group">
            <label for="nombre">Nombre:</label>
            <input type="text" class="form-control" id="nombre" name="nombre" required>
        </div>
        <div class="form-group">
            <label for="apellido">Apellido:</label>
            <input type="text" class="form-control" id="apellido" name="apellido" required>
        </div>
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="telefono">Teléfono:</label>
            <input type="tel" class="form-control" id="telefono" name="telefono" required>
        </div>
        <div class="form-group">
            <label for="fechaRegistro">Fecha de Registro:</label>
            <input type="date" class="form-control" id="fechaRegistro" name="fechaRegistro" required>
        </div>
        <div class="form-group">
            <label for="totalCompras">TotalCompras:</label>
            <input type="tel" class="form-control" id="totalCompras" name="totalCompras" required>
        </div>
        <button type="submit" class="btn btn-primary">Registrar</button>
    </form>
</div>

<!-- ... (código anterior) ... -->

<!-- Agrega un modal para mostrar el mensaje de registro exitoso -->
<div class="modal fade" id="registroExitosoModal" tabindex="-1" role="dialog" aria-labelledby="registroExitosoModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="registroExitosoModalLabel">Registrado correctamente</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                El cliente se ha registrado exitosamente.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<!-- ... (código posterior) ... -->


<!-- Incluye los scripts de Bootstrap y otros recursos aquí -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- ... (código anterior) ... -->

<script>
    // Verifica si el atributo de solicitud "registroExitoso" está presente
    var registroExitoso = <%= request.getAttribute("registroExitoso") %>;

    // Muestra el modal si el registro fue exitoso
    if (registroExitoso) {
        $('#registroExitosoModal').modal('show');
    }
</script>

<!-- ... (código posterior) ... -->




</body>
</html>
