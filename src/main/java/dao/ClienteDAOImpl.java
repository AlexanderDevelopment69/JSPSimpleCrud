package dao;

import model.Cliente;
import util.ConexionMySQL;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAOImpl implements ClienteDAO {
    private ConexionMySQL conexionDB;

    public ClienteDAOImpl(ConexionMySQL conexionDB) {
        this.conexionDB = conexionDB;
    }

    @Override
    public boolean agregarCliente(Cliente cliente) {
        try (Connection conexion = conexionDB.getConnection();
             CallableStatement callableStatement = conexion.prepareCall("{call AgregarCliente(?, ?, ?, ?, ?,?)}")) {

            callableStatement.setString(1, cliente.getNombre());
            callableStatement.setString(2, cliente.getApellido());
            callableStatement.setString(3, cliente.getEmail());
            callableStatement.setString(4, cliente.getTelefono());
            callableStatement.setDate(5, new java.sql.Date(cliente.getFechaRegistro().getTime()));
            callableStatement.setDouble(6, cliente.getTotalCompras());

            callableStatement.execute();
        } catch (SQLException e) {
            // Manejo adecuado de excepciones, como registro o lanzamiento de excepciones personalizadas
            e.printStackTrace();
        }
        return true;
    }

    @Override
    public boolean actualizarCliente(Cliente cliente) {
        try (Connection conexion = conexionDB.getConnection();
             CallableStatement callableStatement = conexion.prepareCall("{call ActualizarCliente(?, ?, ?, ?, ?,?,?)}")) {

            callableStatement.setInt(1, cliente.getCodigo());
            callableStatement.setString(2, cliente.getNombre());
            callableStatement.setString(3, cliente.getApellido());
            callableStatement.setString(4, cliente.getEmail());
            callableStatement.setString(5, cliente.getTelefono());
            callableStatement.setDate(6, new java.sql.Date(cliente.getFechaRegistro().getTime()));
            callableStatement.setDouble(7, cliente.getTotalCompras());

            callableStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public void eliminarCliente(int codigo) {
        try (Connection conexion = conexionDB.getConnection();
             CallableStatement callableStatement = conexion.prepareCall("{call EliminarClientePorCodigo(?)}")) {

            callableStatement.setInt(1, codigo);
            callableStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Cliente obtenerClientePorCodigo(int codigo) {
        Cliente cliente = null;

        try (Connection conexion = conexionDB.getConnection();
             CallableStatement callableStatement = conexion.prepareCall("{call BuscarClientePorCodigo(?)}")) {

            callableStatement.setInt(1, codigo);
            ResultSet resultSet = callableStatement.executeQuery();

            if (resultSet.next()) {
                cliente = new Cliente();
                cliente.setCodigo(resultSet.getInt("codigo"));
                cliente.setNombre(resultSet.getString("nombre"));
                cliente.setApellido(resultSet.getString("apellido"));
                cliente.setEmail(resultSet.getString("email"));
                cliente.setTelefono(resultSet.getString("telefono"));
                cliente.setFechaRegistro(resultSet.getDate("fechaRegistro"));
                cliente.setTotalCompras(resultSet.getDouble("totalCompras"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cliente;
    }

    @Override
    public List<Cliente> obtenerTodosLosClientes() {
        List<Cliente> clientes = new ArrayList<>();

        try (Connection conexion = conexionDB.getConnection();
             CallableStatement callableStatement = conexion.prepareCall("{call ListarClientes()}");
             ResultSet resultSet = callableStatement.executeQuery()) {

            while (resultSet.next()) {
                Cliente cliente = new Cliente();
                cliente.setCodigo(resultSet.getInt("codigo"));
                cliente.setNombre(resultSet.getString("nombre"));
                cliente.setApellido(resultSet.getString("apellido"));
                cliente.setEmail(resultSet.getString("email"));
                cliente.setTelefono(resultSet.getString("telefono"));
                cliente.setFechaRegistro(resultSet.getDate("fechaRegistro"));
                cliente.setTotalCompras(resultSet.getDouble("totalCompras"));
                clientes.add(cliente);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return clientes;
    }
}
