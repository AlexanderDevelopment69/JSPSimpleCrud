package servlets;

import com.google.gson.Gson;
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

@WebServlet("/BuscarClienteServlet")
public class BuscarClienteServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtén el código del cliente enviado desde el formulario de búsqueda
        String codigo = request.getParameter("codigo");

        // Crea una instancia de ClienteDAO y obtén el cliente por código
        ClienteDAO clienteDAO = new ClienteDAOImpl(ConexionMySQL.getInstance());
        Cliente cliente = clienteDAO.obtenerClientePorCodigo(Integer.parseInt(codigo));

        // Convierte el objeto Cliente a formato JSON
        Gson gson = new Gson();
        String jsonCliente = gson.toJson(cliente);

        // Establece el tipo de contenido de la respuesta como JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Envía la respuesta JSON de vuelta a la página
        response.getWriter().write(jsonCliente);


    }


//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        // Obtén el código del cliente enviado desde el formulario de búsqueda
//        String codigoParam = request.getParameter("codigo");
//        // Verifica que el parámetro "codigo" no sea nulo ni esté vacío
//        if (codigoParam != null && !codigoParam.isEmpty()) {
//            try {
//                // Convierte el código a un entero
//                int codigoCliente = Integer.parseInt(codigoParam);
//
//                // Crea una instancia de ClienteDAO y obtén el cliente por código
//                ClienteDAO clienteDAO = new ClienteDAOImpl(ConexionMySQL.getInstance());
//                Cliente cliente = clienteDAO.obtenerClientePorCodigo(codigoCliente);
//
//                if (cliente != null) {
//                    // Convierte el objeto Cliente a formato JSON
//                    Gson gson = new Gson();
//                    String jsonCliente = gson.toJson(cliente);
//
//                    // Establece el tipo de contenido de la respuesta como JSON
//                    response.setContentType("application/json");
//                    response.setCharacterEncoding("UTF-8");
//
//                    // Envía la respuesta JSON de vuelta al cliente
//                    response.getWriter().write(jsonCliente);
//                } else {
//                    // El cliente no fue encontrado, envía un mensaje de error
//                    response.setStatus(HttpServletResponse.SC_NOT_FOUND); // 404 - No encontrado
//                    response.getWriter().write("{\"error\": \"Cliente no encontrado.\"}");
//                }
//            } catch (NumberFormatException e) {
//                // El parámetro "codigo" no es un número válido, envía un mensaje de error
//                response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400 - Solicitud incorrecta
//                response.getWriter().write("{\"error\": \"El parámetro 'codigo' no es un número válido.\"}");
//            }
//        } else {
//            // El parámetro "codigo" es nulo o está vacío, envía un mensaje de error
//            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400 - Solicitud incorrecta
//            response.getWriter().write("{\"error\": \"El parámetro 'codigo' es nulo o está vacío.\"}");
//        }

}
