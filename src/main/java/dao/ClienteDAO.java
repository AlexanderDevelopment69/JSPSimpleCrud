package dao;

import model.Cliente;

import java.util.List;

public interface ClienteDAO {
    boolean agregarCliente(Cliente cliente);
    boolean actualizarCliente(Cliente cliente);
    void eliminarCliente(int codigo);
    Cliente obtenerClientePorCodigo(int codigo);
    List<Cliente> obtenerTodosLosClientes();
}
