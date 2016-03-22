<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Administrator</title>
</head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

<script type="text/javascript">

$(document).ready(function(){
	
	$("#dialog-Jobs").dialog({autoOpen: false, width: 1000, height: 700, modal: true, buttons: {           

	}
	});
	$("#dialog-Jobs").dialog({ title: "Job Details" });
	

});

var jobId;

function viewJob( id ){
	$("#jobDetailsDiv"+jobId).hide();
	jobId = id;
	document.getElementById("dialog-Jobs").style.display = "";
	$("#dialog-Jobs").dialog("open");
	$("#jobDetailsDiv"+id).show();
				
}

</script>

<style type="text/css">

.ui-dialog-titlebar {
      background: #2874B2;
      border: #2874B2;
      color: white; 
}
</style>

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
		  		<li class="active"><b>${user.firstName } ${user.lastName }</b></li>
			</ol>
		</div>
		<p class="text-center lead"><a href="addJob.html">Create New Jobs</a></p>
		<p class="text-left lead"><u>Job Positions:</u></p>
		<table class="table table-condensed table-striped table-hover table-bordered" border="1">
			
			<tr>
				<th>Job</th>
				<th>Published On</th>
				<th>Closes On</th>
				<th>Operations</th>

			</tr>
										
			<c:forEach items="${jobs}" var="job">
				
				<tr>
					<td><a href="javascript:void(0);" onclick="javascript:viewJob('${job.id}');">${job.title}</a></td>
					<td><fmt:formatDate type="both" pattern="M/dd/yyyy" value="${job.publishDate}"/></td>
					<td><fmt:formatDate type="both" pattern="M/dd/yyyy" value="${job.closeDate}"/></td>
					<td><a href="edit.html?id=${job.id}" class="btn btn-default">Edit</a>
					<a href="applications.html?id=${job.id}" class="btn btn-default">Applications</a></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
	<div id="dialog-Jobs"  style="display:none;background-color:#ffffff;">
	<c:forEach items="${jobs}" var="job">
	
		<div id="jobDetailsDiv${job.id}" style="display: none;">
				
			<table class="table table-striped table-hover table-bordered">
				<tr>
					<th>Title</th><td>${job.title}</td>
				</tr>
				<tr>
					<th>Description</th><td>${job.description}</td>
				</tr>
				<tr>
					<th>Published On</th><td><fmt:formatDate type="both" pattern="M/dd/yyyy" value="${job.publishDate}"/></td>
				</tr>
				<tr>
					<th>Closes On</th><td><fmt:formatDate type="both" pattern="M/dd/yyyy" value="${job.closeDate}"/></td>
				</tr>
				<tr>
					<th>Committee Chair</th><td>${job.committeeChair.firstName} ${job.committeeChair.lastName}</td>
				</tr>
				<tr>
					<th>Committee Members</th>
						<td>
						<c:forEach items="${job.committeeMembers }" var="member">
								${member.firstName} ${member.lastName}<br/>
						</c:forEach>
						</td>
				</tr>
			</table>
					
		</div>
	
	
	</c:forEach>
</div>
</body>
</html>