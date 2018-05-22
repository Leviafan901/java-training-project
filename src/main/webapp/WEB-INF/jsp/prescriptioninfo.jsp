<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="my" %>

<fmt:bundle basename="i18n">
	    <fmt:message key="prescriptions.creation_successed_message" var="creation_successed_message"/>
	    <fmt:message key="prescriptions.creation_fail_message" var="creation_fail_message"/>
</fmt:bundle>

<my:designPattern role="${sessionScope.role}">
    <div class="wrapper">
    	<c:if test="${not empty successed_message}">
			<p class="successed_message">${creation_successed_message}</p>
		</c:if>
		<c:if test="${not empty fail_message}">
			<p class="fail_message">${creation_fail_message}</p>
		</c:if>
    </div>
</my:designPattern>