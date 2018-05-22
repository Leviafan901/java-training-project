package com.epam.pharmacy.util;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/***
 * This class handle any exception in the frontcontroller class and redirect
 * to the error page and put in this page text cause of the exception
 * @author Alexei Sosenkov
 *
 */
public final class ErrorPageHandler {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(ErrorPageHandler.class);

	private static final String PATH_TO_JSP = "/WEB-INF/jsp/errors/";
	private static final String JSP_FORMAT = ".jsp";
	private static final String CAUSE_TEXT_DESCRIPTION = "cause_description";
	
	public static void handleError(Throwable exception, HttpServletRequest request,
			HttpServletResponse response) {
		try {
			Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
			String errorPath = pageChooser(statusCode);
			String testCause = exception.getLocalizedMessage();
			request.setAttribute(CAUSE_TEXT_DESCRIPTION, testCause);
			request.getRequestDispatcher(errorPath).forward(request, response);
		} catch (ServletException | IOException e) {
            LOGGER.error("Can't work redirect dispatcher", e);
        }
	}
	
	private static String pageChooser(Integer statusCode) {
		switch (statusCode) {
			case 500:
				return pagePattern("error-500");
			case 404:
				return pagePattern("error-404");
			case 403:
				return pagePattern("error-403");
			default:
				return pagePattern("error-500");
		}
	}
	
	private static String pagePattern(String pagePart) {
		return PATH_TO_JSP + pagePart + JSP_FORMAT;
	}
}
