<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="my" %>
<c:url var="create_prescription" value="/dir/create-prescription"/>

<fmt:bundle basename="i18n">
	<fmt:message key="prescriptions.creation_form" var="creation_form"/>
	<fmt:message key="prescriptions.client_data" var="client_name"/>
	<fmt:message key="medicines.medicine_name" var="medicine_name"/>
	<fmt:message key="prescriptions.expiration_date" var="expiration_date"/>
	<fmt:message key="prescriptions.prescription_text" var="prescription_comment"/>
	<fmt:message key="prescriptions.create" var="create"/>
</fmt:bundle>

<my:designPattern role="DOCTOR">
<div class="wrapper">
<form name="prescription-form" class="prescription-form" action="${create_prescription}" method="POST" >
			<div class="prescription_form_header">
        <span>${creation_form}</span>
      </div>
      <ul>
  	    <li>
          <label for="client">${client_name}</label>
  			<select name="client_id" required>
  			  <c:forEach items="${clients}" var="client">
  			    <option value="${client.userId}">${client.userName} ${client.userLastname}</option>
  			  </c:forEach>
            </select>
        </li>
        <li>
  		  <label for="medicine">${medicine_name}</label>
            <select name="medicine_id" required>
              <c:forEach items="${medicines}" var="medicine">
  			    <option value="${medicine.medicineId}">${medicine.medicineName}</option>
  			  </c:forEach>
            </select>
        </li>
          <li>
  				<label for="date">${expiration_date}</label>
  				<input name="date" type="date" required />
          </li>
          <li>
  				<label for="comment">${prescription_comment}</label>
  				<textarea name="comment" cols="40" rows="6" required></textarea>
          </li>
          </ul>
			<div class="prescription_footer">
				<input type="submit" value="${create}" class="prescription_button" />
			</div>
		</form>
	</div>
</my:designPattern>