package servlets;

import com.google.gson.Gson;
import dao.ClienteDAO;
import dao.ClienteDAOImpl;
import util.ConexionMySQL;
import model.Cliente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/ActualizarClienteServlet")
public class ActualizarClienteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Configura la respuesta HTTP
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        // Obtén los datos del cliente desde la solicitud JSON
        Gson gson = new Gson();
        Cliente cliente = gson.fromJson(request.getReader(), Cliente.class);

        // Crea una instancia de ClienteDAO y actualiza el cliente en la base de datos
        ClienteDAO clienteDAO = new ClienteDAOImpl(ConexionMySQL.getInstance());
        boolean actualizacionExitosa = clienteDAO.actualizarCliente(cliente);

        // Prepara la respuesta JSON
        String jsonResponse;
        if (actualizacionExitosa) {
            jsonResponse = gson.toJson("La actualización se ha realizado con éxito.");
        } else {
            jsonResponse = gson.toJson("No se pudo actualizar el cliente.");
        }

        // Envía la respuesta JSON al cliente
        out.print(jsonResponse);
        out.flush();
    }
}
