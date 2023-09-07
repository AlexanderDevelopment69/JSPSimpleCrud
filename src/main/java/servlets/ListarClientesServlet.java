package servlets;

import com.google.gson.Gson;
import dao.ClienteDAO;
import dao.ClienteDAOImpl;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Cliente;
import util.ConexionMySQL;

import java.io.IOException;
import java.util.List;

@WebServlet("/ListarClientes")
public class ListarClientesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Crear una instancia de ClienteDAO y obtener la lista de clientes desde la base de datos
        ClienteDAO clienteDAO = new ClienteDAOImpl(ConexionMySQL.getInstance());
        // Lógica para obtener la lista de clientes desde la base de datos
        List<Cliente> clientes = clienteDAO.obtenerTodosLosClientes(); // Reemplaza esto con tu lógica real
//        System.out.println(clientes);

        // Convertir la lista de clientes a formato JSON
        Gson gson = new Gson();
        String jsonClientes = gson.toJson(clientes);

        // Establecer el tipo de contenido de la respuesta como JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Enviar la respuesta JSON al cliente
        response.getWriter().write(jsonClientes);
    }
}
