<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista de clientes</title>
    <!-- Agrega las referencias a los archivos CSS de Bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.15/jspdf.plugin.autotable.min.js"></script>


</head>
<body>
<!-- Incluye el navbar -->
<%@ include file="navbar.jsp" %>

<div class="container mt-4">

    <h2>Listado de Clientes</h2>
    <!-- Agrega un botón para generar y descargar el PDF -->
    <button id="generarPDF" class="btn btn-primary">Generar PDF</button>
    <!-- Agrega un botón para generar el reporte Excel -->
    <button id="generarExcel" class="btn btn-success">Generar Excel</button>

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
        <tbody id="tablaClientes">
        <!-- Aquí se llenarán las filas de datos -->
        </tbody>
    </table>
</div>

<!-- Agrega las referencias a los archivos JavaScript de Bootstrap y jQuery (opcional) -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- Agrega un script para cargar los datos JSON en la tabla -->
<script>
    $(document).ready(function () {
        // Realiza una solicitud AJAX para obtener los datos JSON de los clientes
        $.ajax({
            url: "ListarClientes",
            type: "GET",
            dataType: "json",
            success: function (data) {
                // Obtén el cuerpo de la tabla donde se insertarán los datos
                var tbody = $("#tablaClientes");

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
                    // Agrega la fila al cuerpo de la tabla
                    tbody.append(row);
                });
            }
        });
    });
</script>


<%--<script>--%>
<%--    document.getElementById('generarPDF').addEventListener('click', function () {--%>
<%--        window.jsPDF = window.jspdf.jsPDF;--%>
<%--        // Crea un objeto PDF--%>
<%--        var pdf = new jsPDF();--%>

<%--        // Agrega contenido al PDF (por ejemplo, el contenido de la tabla)--%>
<%--        pdf.autoTable({--%>
<%--            html: '#tablaClientes',--%>
<%--            showHead: 'firstPage'  // Muestra los encabezados en la primera página--%>
<%--        });--%>

<%--        // Guarda el PDF y lo descarga--%>
<%--        pdf.save('lista_clientes.pdf');--%>
<%--    });--%>
<%--</script>--%>


<script>
    document.getElementById('generarPDF').addEventListener('click', function () {
        window.jsPDF = window.jspdf.jsPDF;

        $.ajax({
            url: "ListarClientes",
            type: "GET",
            dataType: "json",
            success: function (data) {
                // Crea un objeto PDF con tamaño A4 (210mm x 297mm)
                var pdf = new jsPDF('p', 'mm', 'a4');
                // Agrega un título al PDF
                pdf.text("Lista de Clientes", 15, 35); // Puedes ajustar la posición y el estilo según tus necesidades

                // Agrega una imagen al PDF
                var logoImg = new Image();
                logoImg.style.opacity = 1;
                logoImg.src = 'image/LogoJava.png'; // Reemplaza con la ruta de tu imagen
                pdf.addImage(logoImg, 'PNG', 15, 5, 20, 20); // Ajusta las coordenadas y el tamaño

                // Define las columnas y filas de la tabla
                var columns = ['Código', 'Nombre', 'Apellido', 'Email', 'Teléfono', 'Fecha de Registro', 'Total Compras'];
                var rows = [];

                // Llena las filas de la tabla con los datos JSON
                data.forEach(function (cliente) {
                    var row = [
                        cliente.codigo,
                        cliente.nombre,
                        cliente.apellido,
                        cliente.email,
                        cliente.telefono,
                        cliente.fechaRegistro,
                        cliente.totalCompras
                    ];
                    rows.push(row);
                });

                // Agrega la tabla al PDF
                pdf.autoTable({
                    head: [columns],
                    body: rows,
                    startY: 40,
                });

                // Guarda el PDF y lo descarga
                pdf.save('Lista-Clientes.pdf');
            },
            error: function (error) {
                console.error("Error al cargar los datos: " + error.statusText);
            }
        });
    });


    //     // Crea un objeto PDF con tamaño A4 (210mm x 297mm)
    //     var pdf = new jsPDF('p', 'mm', 'a4');
    //
    //     // Agrega un título al PDF
    //     pdf.text("Lista de Clientes", 15, 35); // Puedes ajustar la posición y el estilo según tus necesidades
    //
    //     // Agrega una imagen al PDF
    //     var logoImg = new Image();
    //     logoImg.style.opacity = 1;
    //     logoImg.src = 'image/LogoJava.png'; // Reemplaza con la ruta de tu imagen
    //     pdf.addImage(logoImg, 'PNG', 15, 5,20,20); // Ajusta las coordenadas y el tamaño
    //
    //     // Agrega manualmente los encabezados
    //     var headers = ['Codigo', 'Nombre', 'Apellido', 'Email', 'Telefono', 'Fecha de registro', 'Total compra'];
    //     $('#tablaClientes th').each(function (index, item) {
    //         headers.push({title: $(item).text(), dataKey: $(item).text()});
    //     });
    //
    //     // Agrega contenido al PDF (por ejemplo, el contenido de la tabla)
    //     pdf.autoTable({
    //         html: '#tablaClientes',
    //         startY: 40,
    //         columns: headers  // Agrega los encabezados manualmente
    //     });
    //
    //     // Guarda el PDF y lo descarga
    //     pdf.save('lista_clientes.pdf');
    // });

</script>
<!-- Incluye la biblioteca SheetJS desde el CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.4/xlsx.full.min.js"></script>

<script>
    // Agrega un evento de clic al botón "Generar Excel"
    $("#generarExcel").click(function () {
        // Realiza una solicitud AJAX para obtener los datos JSON de los clientes
        $.ajax({
            url: "ListarClientes",
            type: "GET",
            dataType: "json",
            success: function (data) {

                //Crea una hoja de cálculo
                var ws = XLSX.utils.json_to_sheet(data);

                // Crea un libro de trabajo
                var wb = XLSX.utils.book_new();
                XLSX.utils.book_append_sheet(wb, ws, 'Clientes');

                // Genera el archivo Excel
                XLSX.writeFile(wb, 'Lista-Clientes.xlsx');


            }
        });
    });

</script>

</body>
</html>
