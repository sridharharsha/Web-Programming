<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add</title>
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
		  		<li class="active"><b>Add</b></li>
			</ol>

		<form action="addJob.html?${_csrf.parameterName}=${_csrf.token}" method="post">
			
			<input type="text" name="title" placeholder="Title" value="" class="form-control" style="width:30%;"/><br>
			
			<textarea rows="3" cols="3" name="description" placeholder="Description" class="form-control" style="width:30%;"></textarea><br>
			
			<input type="text" id="publishDate" name="publishDate" placeholder="Publish Date" value="" class="form-control" style="width:24%;"/><br>

			<input type="text" id="closeDate" name="closeDate" placeholder="Close Date" value="" class="form-control" style="width:24%;"/><br>
			
			<p class="text-left lead"><u>Committee Chair:</u></p>
			<div class="dropdown">
			<select name="committeeChair" class="form-control" style="width:15%;">
				<option value=""></option>
				<c:forEach items="${reviewers }" var="reviewer">
				<option value="${reviewer.id}">${reviewer.firstName } ${reviewer.lastName }</option>
				</c:forEach>
			</select>
			</div>
			<br>
			<p class="text-left lead"><u>Committee Members:</u></p>
			<c:forEach items="${reviewers }" var="reviewer">
				<div class="checkbox">
					<label><input type="checkbox" name="chkRev" value="${reviewer.id}"><b>${reviewer.firstName } ${reviewer.lastName }</b></label>
				</div>	
			</c:forEach>
			<br>
			<input type="submit" value="Create" name="Create" class="btn btn-success">
			
		</form>
			
			
			
		</div>
	</div>

	
</body>
</html>