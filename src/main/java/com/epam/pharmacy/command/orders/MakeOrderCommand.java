package com.epam.pharmacy.command.orders;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.epam.pharmacy.command.commandsmanage.Command;
import com.epam.pharmacy.command.commandsmanage.CommandResult;
import com.epam.pharmacy.exceptions.ServiceException;
import com.epam.pharmacy.services.OrderService;

public class MakeOrderCommand implements Command {

	private static final Logger LOGGER = LoggerFactory.getLogger(MakeOrderCommand.class);
	
	private static final String ORDER_COUNT = "order_count";
	private static final String MEDICINE_ID = "medicine_id";
	private static final String ATTRIBUTE_USER_ID = "userId";
	private static final String ORDER_INFO_PAGE = "orderinfo";
	private static final String SUCCESSED_MESSAGE = "successed_message";
	private static final String FAIL_MESSAGE = "fail_message";
	private OrderService orderService;
	
	public MakeOrderCommand(OrderService orderService) {
		this.orderService = orderService;
	}
	
	@Override
	public CommandResult execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			HttpSession session = request.getSession();
			Long userId = (Long) session.getAttribute(ATTRIBUTE_USER_ID);
			Long orderedMedicineId = Long.valueOf(request.getParameter(MEDICINE_ID));
			Long orderedMedicinesCount = Long.valueOf(request.getParameter(ORDER_COUNT));
			boolean isMade = orderService.makeOrder(userId, orderedMedicineId, orderedMedicinesCount);
			if (isMade) {
				request.setAttribute(SUCCESSED_MESSAGE, true);
				return new CommandResult(ORDER_INFO_PAGE);
			} else {
				request.setAttribute(FAIL_MESSAGE, true);
				return new CommandResult(ORDER_INFO_PAGE);
			}
		}  catch (ServiceException e) {
			LOGGER.warn("Can't make order!", e);
		}
		return null;
	}
}
