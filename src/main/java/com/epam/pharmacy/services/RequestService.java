package com.epam.pharmacy.services;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.epam.pharmacy.dao.DaoCreator;
import com.epam.pharmacy.dao.RequestDao;
import com.epam.pharmacy.domain.Request;
import com.epam.pharmacy.domain.enumeration.RequestStatus;
import com.epam.pharmacy.domain.enumeration.Role;
import com.epam.pharmacy.dto.RequestDto;
import com.epam.pharmacy.exceptions.DaoException;
import com.epam.pharmacy.exceptions.ServiceException;

public class RequestService {

    private static final Logger LOGGER = LoggerFactory.getLogger(RequestService.class);
	
	private static final RequestStatus REQUEST_STATUS = RequestStatus.PENDING;
	
	/***
	 * Method that allow's client to make new request to extend his prescription.
	 * 
	 * @param doctorId
	 * @param prescriptionId
	 * @return boolean
	 * @throws ServiceException
	 */
	public boolean makeRequest(Long doctorId, Long prescriptionId) throws ServiceException {
		try (DaoCreator daoCreator = new DaoCreator()) {
				RequestDao requestDao = daoCreator.getRequestDao();
				Request newRequest = createRequest(doctorId, prescriptionId);
				Request insertedRequest = requestDao.insert(newRequest);
				if (insertedRequest != null) {
					return true;
				} else {
					return false;
				}
			} catch (DaoException e) {
				throw new ServiceException("Can't make new request!", e);
			}
	}

	private Request createRequest(Long doctorId, Long prescriptionId) {
		Request newRequest = new Request();
		newRequest.setDoctorId(doctorId);
		newRequest.setPrescriptionId(prescriptionId);
		newRequest.setStatus(REQUEST_STATUS);
		return newRequest;
	}
	
	/**
	 * Method that return requestDtoList by user Id and his role
	 * (DTO - information about request, prescription and user name, lastname)
	 * 
	 * @param Long userId, String role
	 * @return RequestDtoList by user ID
	 * @throws ServiceException
	 */
	public List<RequestDto> getUserRequests(Long userId, Role role) throws ServiceException {
		List<RequestDto> requestList = new ArrayList<>();
		try (DaoCreator daoCreator = new DaoCreator()) {
			RequestDao requestDao = daoCreator.getRequestDao();
			if (role.equals(Role.CLIENT)) {
			    requestList = requestDao.getAllClientRequestDtoById(userId);
			}
			if (role.equals(Role.DOCTOR)) {
				requestList = requestDao.getAllDoctorRequestDtoById(userId);
			}
			Collections.reverse(requestList);
			LOGGER.info("Find and return all client = {} orders from DB", userId);
		} catch(DaoException e) {
		    throw new ServiceException("Can't return all client orders from DB", e);
		}
		return requestList;
	}
	
	/***
	 * Method allows to change Request status in the table to 'rejected'
	 * 
	 * @param requestId
	 * @return rejectRequest
	 * @throws ServiceException
	 */
	public boolean rejectRequest(Long requestId) throws ServiceException {
		try (DaoCreator daoCreator = new DaoCreator()) {
				RequestDao requestDao = daoCreator.getRequestDao();
				boolean isRejected = requestDao.rejectRequestById(requestId);
				return isRejected;
			} catch (DaoException e) {
				throw new ServiceException("Can't end transaction and cancel order!", e);
			}
	}
}
