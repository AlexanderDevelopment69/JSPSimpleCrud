package servlets;

import dao.ClienteDAO;
import dao.ClienteDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Cliente;
import util.ConexionMySQL;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/AgregarCliente")
public class AgregarClienteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener los parámetros del formulario
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String email = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        String fechaRegistroStr = request.getParameter("fechaRegistro");
        String totalComprasStr = request.getParameter("totalCompras");


        try {
            // Convertir la fecha de registro a tipo Date
            Date fechaRegistro = Date.valueOf(fechaRegistroStr);

            double totalCompras = Double.parseDouble(totalComprasStr);

            // Crear un objeto Cliente con los datos del formulario
            Cliente cliente = new Cliente(nombre, apellido, email, telefono, fechaRegistro, totalCompras);

            // Crear una instancia del DAO de Cliente y agregar el cliente a la base de datos
            ClienteDAO clienteDAO = new ClienteDAOImpl(ConexionMySQL.getInstance());
            boolean exito = clienteDAO.agregarCliente(cliente);

            if (exito) {
                // Si la inserción fue exitosa, configura un atributo de solicitud para mostrar el mensaje de éxito
                request.setAttribute("registroExitoso", true);
            } else {
                // Si hubo un error en la inserción, configura un atributo de solicitud para mostrar un mensaje de error
                request.setAttribute("registroError", true);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Manejo de errores aquí
        }
        // Redirige de vuelta a la página de registro (AgregarCliente.jsp)
        request.getRequestDispatcher("agregarcliente.jsp").forward(request, response);

    }
}
