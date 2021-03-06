package com.epam.pharmacy.dao;


import java.sql.Connection;
import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.epam.pharmacy.connection.ConnectionPool;
import com.epam.pharmacy.exceptions.ConnectionException;
import com.epam.pharmacy.exceptions.DaoException;

/**
 * The class is intended for managing connections, namely the distribution and closing of connections.
 * Also creates instances of Dao objects and puts a connection in them.
 *
 * @author Sosenkov Alexei
 */
public class DaoCreator implements AutoCloseable {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(DaoCreator.class);
	
    /**
     * Field - contains a connection pool
     */
    private ConnectionPool connectionPool;
   
    /**
     * Field - Connect to the database.
     */
    private Connection connection;

    public DaoCreator()  {
        connectionPool = ConnectionPool.getInstance();
        connection = connectionPool.getConnection();
    }
    
    public UserDao getUserDao() throws DaoException {
        return new UserDao(connection);
    }
    
    public MedicineDao getMedicineDao() throws DaoException {
        return new MedicineDao(connection);
    }
    
    public OrderDao getOrderDao() throws DaoException {
        return new OrderDao(connection);
    }
    
    public OrderMedicineDao getOrderMedicineDao() throws DaoException {
        return new OrderMedicineDao(connection);
    }
    
    public PrescriptionDao getPrescriptionDao() throws DaoException {
        return new PrescriptionDao(connection);
    }
    
    public RequestDao getRequestDao() throws DaoException {
        return new RequestDao(connection);
    }
    
    /**
     * Puts the connection to the connection pool.
     */
    private void returnConnection() {
        connectionPool.returnConnection(connection);
    }
    
    /**
     * The method allows you to start a transaction.
     * @throws ConnectionException 
     */
    public void startTransaction() throws ConnectionException {
        try {
            connection.setAutoCommit(false);
        } catch (SQLException e) {
        	throw new ConnectionException("Can't starting date transaction", e);
        }
    }

    /**
     * The method allows you to perform a transaction.
     * @throws ConnectionException 
     **/
    public void commitTransaction() throws ConnectionException {
        try {
            connection.commit();
            connection.setAutoCommit(true);
        } catch (SQLException e) {
            throw new ConnectionException("Can't committing date transaction", e);
        }
    }

    /**
     * The method to cancel the transaction.
     * @throws ConnectionException 
     */
    public void rollbackTransaction() throws ConnectionException {
        try {
            LOGGER.debug("Call rollback transaction");
            connection.rollback();
        } catch (SQLException e) {
        	throw new ConnectionException("Can't rollback data transaction", e);
        }
    }
    
	@Override
	public void close() {
		returnConnection();
	}
}
