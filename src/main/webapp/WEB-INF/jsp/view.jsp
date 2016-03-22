<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Job Details</title>
</head>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

<body>
	<div class="container" style="margin-top: 2%;">
	
	
		<div class="well">
			<ol class="breadcrumb">
				<c:choose>
					<c:when test="${empty user}">
						<li><a href="home.html"><b>CS Jobs</b></a></li>
		  				<li class="active"><b>Job</b></li>
					</c:when>
					<c:otherwise>
						<div class="pull-right">
							<form action="<c:url value='/logout'/>" method="POST">
				  				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				  				<input name="submit" type="submit" class="btn btn-primary" value="Logout" />
							</form>
						</div>
					
						<li><a href="dashboard.html"><b>${user.firstName} ${user.lastName}</b></a></li>
		  				<li class="active"><b>Job</b></li>
					</c:otherwise>
				</c:choose>
			</ol>
		</div>
		
		<table class="table table-striped table-hover table-bordered">
			
			<tr>
				<th>Title</th><td>${jobDetails.title}</td>
			</tr>
			
			<tr>
				<th>Description</th><td>${jobDetails.description}</td>
			</tr>
			
			<tr>
				<th>Published On</th><td><fmt:formatDate type="both" pattern="M/dd/yyyy" value="${jobDetails.publishDate}"/></td>
			</tr>
			
			<tr>
				<th>Closes On</th><td><fmt:formatDate type="both" pattern="M/dd/yyyy" value="${jobDetails.closeDate}"/></td>
			</tr>

			<tr>
				<th>Committee Chair</th><td>${jobDetails.committeeChair.firstName} ${jobDetails.committeeChair.lastName}</td>
			</tr>
			
			<tr>
				<th>Committee Members</th>
				<td>
				<c:forEach items="${jobDetails.committeeMembers }" var="member">
					${member.firstName} ${member.lastName}<br/>
				</c:forEach>
				</td>
			</tr>
			
							
		</table>
			
	</div>
	
</body>
</html>