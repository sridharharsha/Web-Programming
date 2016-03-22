<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit</title>
</head>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
 
<script type="text/javascript">
$(document).ready(function(){
	
	$( "#publishDate" ).datepicker();
	$( "#closeDate" ).datepicker();
});

</script> 

<body>

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
		  		<li class="active"><b>Edit</b></li>
			</ol>

		<form action="edit.html?${_csrf.parameterName}=${_csrf.token}" method="post">
			
			<label>Title:</label><input type="text" name="title" value="${job.title}" class="form-control" style="width:30%;"/><br>
			
			<label>Description:</label><textarea rows="3" cols="3" name="description" class="form-control" style="width:30%;">${job.description}</textarea><br>
			
			<label>Published On:</label><input type="text" id="publishDate" name="publishDate" class="form-control" style="width:24%;" value="<fmt:formatDate value="${job.publishDate}" pattern="M/d/yyyy" />"><br>

			<label>Closes On:</label><input type="text" id="closeDate" name="closeDate" class="form-control" style="width:24%;" value="<fmt:formatDate value="${job.closeDate}" pattern="M/d/yyyy" />"><br>
			
			<p class="text-left lead"><u>Committee Chair:</u></p>
			<div class="dropdown">
				<select name="committeeChair" class="form-control" style="width:15%;">
	
					<option value="${job.committeeChair.id }" selected="selected">${job.committeeChair.firstName } ${job.committeeChair.lastName }</option>
					<option value=""></option>
					<c:forEach items="${allReviewers }" var="reviewer">
						<c:if test="${reviewer.id != job.committeeChair.id }">
							<option value="${reviewer.id}">${reviewer.firstName } ${reviewer.lastName }</option>
						</c:if>
					</c:forEach>
				</select>
			</div>
			
			<br>
			<p class="text-left lead"><u>Committee Members:</u></p>
			<c:forEach items="${committee }" var="committee">
				<label><input type="checkbox" checked="checked" name="chkRev" value="${committee.id}">${committee.firstName } ${committee.lastName }</label>
			</c:forEach>

			<p class="text-left lead"><u>Non-Committee Members:</u></p>
			<c:forEach items="${reviewers }" var="reviewer">
				<label><input type="checkbox" name="chkRev" value="${reviewer.id}">${reviewer.firstName } ${reviewer.lastName }</label>
			</c:forEach>
			<br><br>
			<input type="submit" value="Update" name="Update" class="btn btn-success">
			<input type="hidden" value="${job.id}" name="id">
		</form>
		</div>
	</div>

	
</body>
</html>