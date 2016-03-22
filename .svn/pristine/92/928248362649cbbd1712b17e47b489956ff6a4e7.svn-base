<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Applications</title>
</head>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

<body>
<sec:authorize access="(hasRole('ROLE_ADMIN') or hasRole('ROLE_REVIEWER')) and (principal.username == '${user.email}')" >

	<div class="container" style="margin-top: 2%;">
		
		<div class="well">
			<div class="pull-right">
				<form action="<c:url value='/logout'/>" method="POST">
			  		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			  		<input name="submit" type="submit" class="btn btn-primary" value="Logout" />
				</form>
			</div>

			<ol class="breadcrumb">
		  		<li><a href="dashboard.html"><b>${user.firstName } ${user.lastName }</b></a></li>
		  		<li class="active"><b>Applications</b></li>
			</ol>

			<h4>Job Title: <small>${job.title}</small></h4>
			<h4>Job Description: <small>${job.description}</small></h4>

		</div>
		<c:choose>
		<c:when test="${empty applications}">
			<p class="text-left lead"><u>Sorry, no applications for this job.</u></p>
		</c:when>
		
		<c:otherwise>

		<p class="text-left lead"><u>Applications:</u></p>		
		<table class="table table-condensed table-striped table-hover table-bordered">
					<tr>
						<th>Applicant</th>
						<th>Applied On</th>
						
					</tr>
					<c:forEach items="${applications}" var="application">
						<tr>
							<td><a href="<c:url value='/application-info.html?id=${application.id}&jobId=${job.id}' />">${application.applicant.firstName} ${application.applicant.lastName}</a></td>
							<td><fmt:formatDate pattern="M/dd/yyyy" value="${application.submitDate}"/></td>
							
						</tr>
					</c:forEach>
				</table>
		</c:otherwise>		
		</c:choose>
			
	</div>
</sec:authorize>

<c:if test="${inValidUser == true }">
<p class="text-center lead"><label style="color: red;"> Sorry, you are not allowed to view this content. </label></p>

</c:if>
	
</body>
</html>