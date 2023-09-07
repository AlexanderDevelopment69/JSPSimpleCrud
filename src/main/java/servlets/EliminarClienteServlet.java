package servlets;

import dao.ClienteDAO;
import dao.ClienteDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.ConexionMySQL;

import java.io.IOException;

@WebServlet("/EliminarClienteServlet")
public class EliminarClienteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtén el ID del cliente a eliminar desde el formulario
        int clienteId = Integer.parseInt(request.getParameter("clienteId"));

        // Llama al DAO para eliminar al cliente
        ClienteDAO clienteDAO = new ClienteDAOImpl(ConexionMySQL.getInstance());
        clienteDAO.eliminarCliente(clienteId);

        // Después de eliminar el cliente con éxito
        request.setAttribute("clienteEliminado", true);
        request.getRequestDispatcher("eliminarcliente.jsp").forward(request, response);

    }
}
