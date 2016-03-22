<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Application Info</title>
</head>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

<body>
<sec:authorize access="(hasRole('ROLE_ADMIN') or hasRole('ROLE_REVIEWER') or hasRole('ROLE_APPLICANT')) and (principal.username == '${user.email}')" >
	<div class="container" style="margin-top: 2%;">
		
		<div class="well">
			<div class="pull-right">
				<form action="<c:url value='/logout'/>" method="POST">
			  		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			  		<input name="submit" type="submit" class="btn btn-primary" value="Logout" />
				</form>
			</div>

			<ol class="breadcrumb">

				<c:if test="${isAdmin == true}">
					<li><a href="<c:url value='dashboard.html'/>"><b>${user.firstName } ${user.lastName }</b></a></li>
					<li><a href="<c:url value='applications.html?id=${job.id}'/>"><b>Applications</b></a></li>
					<li class="active"><b>Application Info</b></li>
				</c:if>
				<c:if test="${isReviewer == true}">
					<li><a href="<c:url value='dashboard.html'/>"><b>${user.firstName } ${user.lastName }</b></a></li>
					<li><a href="<c:url value='applications.html?id=${job.id}'/>"><b>Applications</b></a></li>
					<li class="active"><b>Application Info</b></li>
				</c:if>
				<c:if test="${isApplicant == true}">
					<li><a href="<c:url value='dashboard.html'/>"><b>${user.firstName } ${user.lastName }</b></a></li>
					<li class="active"><b>Application Info</b></li>
				</c:if>
			</ol>
			
			<p class="text-left lead"><u>Work Experience:</u></p>
		
			<h4>Job Designation: <small>${application.currentJobTitle}</small></h4>
			<h4>Company: <small>${application.currentJobInstitution}</small></h4>
			<h4>From: <small>${application.currentJobYear}</small></h4>
			<p class="text-left lead"><u>Applied To:</u></p>
	
			<h4>Job Title: <small>${job.title}</small></h4>
			<h4>Job Description: <small>${job.description}</small></h4>
			<h4>Submitted On: <small><fmt:formatDate pattern="M/dd/yyyy" value="${application.submitDate}"/></small></h4>
			
			<c:if test="${not empty application.cv}">
				<label>CV:<a href="download.html?fileId=${application.cv.id}">${application.cv.name}</a></label>
			</c:if>
			
			<c:if test="${not empty application.researchStatement}">
				<label>Research Statement:<a href="download.html?fileId=${application.researchStatement.id}">${application.researchStatement.name}</a></label>
			</c:if>
			
			<c:if test="${not empty application.teachingStatement}">
				<label>Teaching Statement:<a href="download.html?fileId=${application.teachingStatement.id}">${application.teachingStatement.name}</a></label>
			</c:if>

		</div>
		
		

		<p class="text-left lead"><u>Education:</u></p>		
		<table class="table table-condensed table-striped table-hover table-bordered">
					<tr>
						<th>Degree</th>
						<th>University</th>
						<th>Year Of Completion</th>
					</tr>
					<c:forEach items="${application.degrees}" var="degree">
						<tr>
							<td>${degree.name}</td>
							<td>${degree.school}</td>
							<td>${degree.year}</td>
						</tr>
					</c:forEach>
				</table>
		
			
	</div>
</sec:authorize>

<c:if test="${inValidUser == true }">
<p class="text-center lead"><label style="color: red;"> Sorry, you are not allowed to view this content. </label></p>

</c:if>
	
</body>
</html>