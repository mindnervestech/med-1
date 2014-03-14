<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
<title>Time</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Bootstrap -->
<script src="resources/javascripts/jquery-1.9.0.min.js" type="text/javascript"></script>
<link rel="stylesheet" media="screen" href="resources/stylesheets/bootstrap.css">
<link rel="stylesheet" href="resources/stylesheets/bootstrap-responsive.css">
<link rel="stylesheet"  href="resources/stylesheets/select2.css" />
</head>

<body>

	<div class="container">
		<legend></legend>
		<div class="container">
			<div class="heading">
				<form:form action="registration" method="POST" id="createUserForm">
					<a href="/"><img alt="" src="resources/images/custom/logo.png"></a>
					<legend></legend>
					<br>
					<br>
					<br>
					<div class="row">
						<div class="span8">
							<fieldset id="registerHere">
								<c:if test="${not empty registered}">
									<p class="registered" class="serif" style="color: #00ff00;">
										${registered}</p>
								</c:if>

								<div class="well">
									<input type="hidden" id="companyId" name="companyId">

									<p>
										<input type="text" id="firstName" name="firstName"
											placeholder="First Name" required rel="popover"
											data-content="Enter Your First Name">

									</p>
									<p>
										<input type="text" id="middleName" name="middleName"
											placeholder="Middle Name" rel="popover"
											data-content="Enter Your Middle Name">
									</p>
									<p>
										<input type="text" id="lastName" name="lastName"
											placeholder="Last Name" required rel="popover"
											data-content="Enter Your Last Name">
									</p>

									<div class="control-group">
										<div class="controls">
											<input type="email" id="email" name="email"
												placeholder="Email" required value="" rel="popover"
												data-content="Enter Desired LoginName">
										</div>
									</div>
									<div class="control-group">
										<div class="controls">
											<input type="password" id="password" name="password"
												placeholder="Password" required value="" rel="popover"
												data-content="Enter Password Containig A-Z and 0-9">
										</div>
									</div>
									<p>
										<input type="password" id="cpassword" name="cpassword"
											placeholder="Confirm Password" required rel="popover"
											data-content="Please Re-Confirm your Password">
									</p>
									<p>
										<select id="employeeStatus" name="status" required
											data-content="Please Select Category">
											<option value="OnRolls">Employee</option>
											<option value="OffRolls">Non-Employee</option>
										</select>
									</p>
									<br>
									<p>

										<button type="submit" onClick="popupWin()"
											class="btn btn-success">Register</button>
										<a href="login" class="btn btn-info">Back</a>
									</p>
									<p>
										Don't have a Company Domain yet? <a href="register"
											class="btn btn-warning">Register Your Company</a>
									</p>
								</div>
							</fieldset>
						</div>
					</div>
				</form:form>
			</div>

			<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-header">
					<h3 id="myModalLabel">Privacy & Terms</h3>
				</div>
				<div class="modal-body">
					<p>
					<h4>Time Trotter Website Privacy Policy</h4>
										</p>
				</div>
				<div class="modal-footer">
					<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
				</div>
			</div>
			
			<footer>
				<p>
					&copy; 2013 Comapny, Inc. &middot; <a href="#myModal"
						data-toggle="modal">Privacy & Terms</a>
				</p>
			</footer>
		</div>
		<script src="resources/javascripts/bootstrap.min.js"></script>
		<script type="text/javascript" src="resources/javascripts/jquery.validate.min.js"></script>
		<script type="text/javascript" src="resources/javascripts/jquery.alphanumeric.pack.js"></script>
		<script type="text/javascript" src="resources/javascripts/jquery.alphanumeric.js"></script>
		<script type="text/javascript" src="resources/javascripts/select2.js"></script>
		<script type="text/javascript" src="resources/javascripts/select2_locale_en.js.template"></script>

	</div>

	<script type="text/javascript">
		$(document).ready(function() {
					// Popover  show
					$('#registerHere input').on('mouseenter',function() {
								$(this).popover('show');
					});
					//Popover hide
					$('#registerHere input').on('mouseleave',function() {
								$(this).popover('hide');
					});

					// Validation
					$("#createUserForm").validate({
							rules : {
								password : {
									required : true,
									passwordCheck : true,
									minlength : 6
								},
								cpassword : {
									required : true,
									equalTo : "#password"
								},
								email : {
									remote : {
										url : "/checkUserEmail",
										type : "post",
										data : {
											q : function() {
												return $("#email").val();
											}
										}
									}
								}
							},

							messages : {
								password : {
									required : "Enter your password",
									passwordCheck : "Password must contain atleast one A-Z and 0-9",
									minlength : "Password must be minimum 6 characters"

								},
								cpassword : {
									required : "Enter confirm password",
									equalTo : "Password and Confirm Password must match"
								},
								email : {
									remote : "Not Available or Wrong Domain"
								}
							},

							errorClass : "help-inline",
							errorElement : "span",
							highlight : function(element) {
								console.log(element);
								$(element).closest('.control-group').removeClass('success').addClass('error');
							},
							success : function(element) {
								console.log(element);
								$(element).addClass('valid').closest('.control-group').removeClass('error')
										.addClass('success');
							}
					});

		});
	</script>

	<script type="text/javascript" lang="javascript">
		function popupWin() {
			console.log("inside Console");
			isFormValid = $("#createUserForm").valid();
			if(isFormValid){
				localStorage.setItem("notification_mesg", 'Your Registration request is recieved. We are currently reviewing it.');	
			}
			return isFormValid;
		}
		
		$(document).ready(function(){
			jQuery.validator.addMethod("passwordCheck", function(value, element) {
				var pattern = /^[A-Za-z0-9]*?([A-Za-z][0-9]|[0-9][A-Za-z])[A-Za-z0-9]*$/;
				var pwd = value;
				 if (pattern.test(pwd)) {
					 return true;
				 }
				 else
				 {	 
					 return false;
				 } 
			},"");
			
		});
	</script>

</body>