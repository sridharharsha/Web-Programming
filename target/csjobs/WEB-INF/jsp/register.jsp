<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registration</title>
</head>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

<body>

	<div class="container" style="margin-top: 2%;">
	
		<div class="well">
			<ol class="breadcrumb">
				<li><a href="home.html"><b>CS Jobs</b></a></li>
		  		<li class="active"><b>Registration</b></li>
			</ol>
			
			<form:form modelAttribute="user">
				
				<form:input path="firstName" placeholder="First Name" class="form-control" style="width:30%;"/><label style="color: red;"><form:errors path="firstName"/></label><br/><br/> 
				
				<form:input path="lastName" placeholder="Last Name" class="form-control" style="width:30%;"/><label style="color: red;"><form:errors path="lastName"/></label><br/><br/>

				<form:input path="email" placeholder="E-mail" class="form-control" style="width:30%;"/><label style="color: red;"><form:errors path="email"/></label><br/><br/>

				<form:input type = "password" path="password" placeholder="Password" class="form-control" style="width:30%;"/><label style="color: red;"><form:errors path="password"/></label><br/><br/>

				<form:input type = "password" path="password2" placeholder="Confirm Password" class="form-control" style="width:30%;"/><label style="color: red;"><form:errors path="password2"/></label><br/><br/>
				
				<form:input path="phone" placeholder="Phone" class="form-control" style="width:30%;"/><label style="color: red;"><form:errors path="phone"/></label><br/><br/>
				
				<form:textarea rows="4" cols="3" path="address" class="form-control" style="width:30%;" placeholder="Address"/><label style="color: red;"><form:errors path="address"/></label><br/><br/>

				<input type="submit" class="btn btn-success" value="Register">

			</form:form>	
			
		</div>
	
	</div>

</body>
</html>