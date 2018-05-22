<%@ page contentType="text/html;charset=UTF-8" language="java"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="my"%>
<c:url var="change_medicine" value="/dir/change-medicine" />
<c:url var="create_medicine" value="/dir/create-medicine" />

<fmt:bundle basename="i18n">
	<fmt:message key="medicines.dosage" var="dosage" />
	<fmt:message key="medicines.create" var="create" />
	<fmt:message key="medicines.change" var="change" />
	<fmt:message key="medicines.count" var="medicine_count" />
	<fmt:message key="medicines.count_in_store" var="count_in_store" />
	<fmt:message key="medicines.price" var="price" />
	<fmt:message key="medicines.need_prescription" var="need_prescription" />
	<fmt:message key="medicines.change_need_prescription"
		var="change_need_prescription" />
	<fmt:message key="medicines.has_prescription" var="has_prescription" />
	<fmt:message key="medicines.no_prescription" var="no_prescription" />
	<fmt:message key="medicines.medicine_name" var="medicine_name" />
	<fmt:message key="medicines.change_form" var="change_form" />
	<fmt:message key="medicines.creation_form" var="creation_form" />
	<fmt:message key="medicines.has_prescription" var="has_prescription" />
	<fmt:message key="medicines.no_prescription" var="no_prescription" />
</fmt:bundle>

<my:designPattern role="ADMIN">
	<c:if test="${requestScope.actualForm == 'changeForm'}">
		<c:set var="medicine" value="${requestScope.medicine}" />
		<div class="wrapper">
			<form name="medicine-form" class="medicine-form"
				action="${change_medicine}" method="POST" onsubmit="return validateCreationMedicineForm()">
				<div class="medicine_form_header">${change_form}</div>
				<div class="medicine_content">
					<div class="medicine-input">
						<label for="name">${medicine_name}</label> <input name="name" id="name" 
							type="text" value="${medicine.name}" required pattern="\D{2,13}"/>
					</div>
					<div class="medicine-input">
						<label for="countInStore">${count_in_store}</label> <input
							name="countInStore" type="text" value="${medicine.countInStore}" id="countInStore"
							required pattern="^\d+$"/>
					</div>
					<div class="medicine-input">
						<label for="count">${medicine_count}</label> <input name="count" id ="count"
							type="text" value="${medicine.count}" required pattern="^\d+$"/>
					</div>
					<div class="medicine-input">
						<label for="dosageMg">${dosage}</label> <input name="dosageMg" id="dosageMg"
							type="text" value="${medicine.dosageMg}" required pattern="^\d+$"/>
					</div>
					<div class="medicine-input">
						<label for="price">${price}</label> <input name="price" id="price"
							type="text" value="${medicine.price}" required pattern="^[0-9.,]+$"/>
					</div>
					<div class="medicine-input">${need_prescription}:
						<c:if test="${medicine.needPrescription == false}">
	  				  ${no_prescription}
	  				</c:if>
						<c:if test="${medicine.needPrescription == true}">
	  				  ${has_prescription}
	  				</c:if>
					</div>
					<div class="medicine-input">
						<label for="" choice>${change_need_prescription}:</label>
						<div class="choice" name="choice">
							<c:if test="${medicine.needPrescription == true}">
								<input type="radio" name="needPrescription" value="true" checked>
								<label for="contactChoice1">${has_prescription}</label>
								<input type="radio" id="contactChoice2" name="needPrescription"
									value="false">
								<label for="contactChoice2">${no_prescription}</label>
							</c:if>
							<c:if test="${medicine.needPrescription == false}">
								<input type="radio" name="needPrescription" value="true">
								<label for="contactChoice1">${has_prescription}</label>
								<input type="radio" id="contactChoice2" name="needPrescription"
									value="false" checked>
								<label for="contactChoice2">${no_prescription}</label>
							</c:if>
						</div>
					</div>
				</div>
				<input name="medicine_id" type="text" value="${medicine.id}"
					hidden="hidden" />
				<div class="medicine_footer">
					<input type="submit" value="${change}" class="medicine_button" />
				</div>
			</form>
		</div>
	</c:if>
	<c:if test="${requestScope.actualForm == 'creationForm'}">
		<div class="wrapper">
			<form name="medicine-form" class="medicine-form"
				action="${create_medicine}" method="POST" onsubmit="return validateCreationMedicineForm()">
				<div class="medicine_form_header">${creation_form}</div>
				<div class="medicine_content">
					<div class="medicine-input">
						<label for="name">${medicine_name}</label> <input name="name" id="name"
							type="text" required pattern="\D{2,13}"/>
					</div>
					<div class="medicine-input">
						<label for="countInStore">${count_in_store}</label> <input
							name="countInStore" id="countInStore" type="text" required pattern="^\d+$"/>
					</div>
					<div class="medicine-input">
						<label for="count">${medicine_count}</label> <input name="count" id="count"
							type="text" required pattern="^\d+$"/>
					</div>
					<div class="medicine-input">
						<label for="dosageMg">${dosage}</label> <input name="dosageMg" id="dosageMg"
							type="text" required pattern="^\d+$"/>
					</div>
					<div class="medicine-input">
						<label for="price">${price}</label> <input name="price" id="price"
							type="text" required pattern="^[0-9.,]+$"/>
					</div>
					<div class="medicine-input">
						<label for="" choice>${change_need_prescription}:</label>
						<div class="choice" name="choice">
							<input type="radio" name="needPrescription" value="true">
							<label for="contactChoice1">${has_prescription}</label> <input
								type="radio" id="contactChoice2" name="needPrescription"
								value="false" checked> <label for="contactChoice2">${no_prescription}</label>
						</div>
					</div>
				</div>
				<div class="medicine_footer">
					<input type="submit" value="${create}" class="medicine_button"/>
				</div>
			</form>
		</div>
	</c:if>
</my:designPattern>