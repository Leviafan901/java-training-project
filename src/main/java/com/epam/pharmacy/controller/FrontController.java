package com.epam.pharmacy.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.epam.pharmacy.command.commandsmanage.Command;
import com.epam.pharmacy.command.commandsmanage.CommandFactory;
import com.epam.pharmacy.command.commandsmanage.CommandResult;
import com.epam.pharmacy.command.commandsmanage.PageNavigator;
import com.epam.pharmacy.connection.ConnectionPool;
import com.epam.pharmacy.exceptions.ConnectionException;
import com.epam.pharmacy.exceptions.ServiceException;
import com.epam.pharmacy.util.ErrorPageHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet class, the main and only servlet, a single entry point for all queries
 *
 * @author Sosenkov Alexei
 */
public class FrontController extends HttpServlet {
    
	private static final Logger LOGGER = LoggerFactory.getLogger(FrontController.class);
    private CommandFactory commandFactory;
    private ConnectionPool connectionPool;

    @Override
    public void init() throws ServletException {
        LOGGER.info("The servlet/app start working");
        commandFactory = new CommandFactory();
        try {
			connectionPool = ConnectionPool.getInstance();
		} catch (ConnectionException e) {
			LOGGER.warn("Can't get the connectionPool Instanse!", e);
		}
        LOGGER.info("Connection pool size : {}", connectionPool.size());
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) {
    	
    	String method = request.getMethod();
        String pathInfo = request.getPathInfo();
        String commandString = method + pathInfo;
        try {
    	Command command = commandFactory.getCommand(commandString);
        CommandResult result = command.execute(request, response);
        PageNavigator view = new PageNavigator(request, response);
        view.navigate(result);
    	} catch (Exception e) {
    		ErrorPageHandler.handleError(e, request, response);
    	}
    }
    
    @Override
    public void destroy() {
        LOGGER.info("The servlet/app stopped working");
        connectionPool.closeAllConnections();
    }
}