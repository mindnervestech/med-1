<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<jsp:include page="menuContext.jsp" />

<h1 align="center">
	<i>Welcome</i>
</h1>

<style>
.textResponse {
	width: 27% !important;
	font-weight: bold;
	float: left;
}

.dataResponse {
	margin-left: 19%;
}
.container{
width: 0px !importent;
}


</style>

<div class="container">
	<div class="well" style="width: 53%; margin: 0 auto;">
		<form:form
			action="<%=com.mnt.time.controller.routes.Application.changePassword.url%>"
			id="changePassword">
			<fieldset>
				<div class="span7 form-inline">
					<h5 align="left" class="textResponse">
						<span class="text-info">Salutation</span>
					</h5>
					<input class="dataResponse" type="text" value="${user.salutation}"
						readonly="readonly">
				</div>
				<div class="span7 form-inline">
					<h5 align="left" class="textResponse">
						<span class="text-info">First Name</span>
					</h5>
					<input class="dataResponse" type="text" id="firstName"
						name="firstName" value="${user.firstName.toUpperCase()}"
						readonly="readonly">
				</div>
				<c:if test="${user.middleName != null}">
					<div class="span7 form-inline">
						<h5 align="left" class="textResponse">
							<span class="text-info">Middle Name</span>
						</h5>
						<input class="dataResponse" type="text" id="middleName"
							name="middleName" value="${user.middleName.toUpperCase()}"
							readonly="readonly">
					</div>
				</c:if>
				<c:if test="${user.lastName != null}">
					<div class="span7 form-inline">
						<h5 align="left" class="textResponse">
							<span class="text-info">Last Name</span>
						</h5>
						<input class="dataResponse" type="text" id="lastName"
							name="lastName" value="${user.lastName.toUpperCase()}"
							readonly="readonly">
					</div>
				</c:if>
				<div class="span7 form-inline">
					<h5 align="left" class="textResponse">
						<span class="text-info">Email</span>
					</h5>
					<input class="dataResponse" type="text" id="email" name="email"
						value="${user.email}" readonly="readonly">
				</div>
				<div class="span7 form-inline">
					<h5 align="left" class="textResponse">
						<span class="text-info">Employee Id</span>
					</h5>
					<input class="dataResponse" type="text" id="employeeId"
						name="employeeId" value="${user.employeeId}" readonly="readonly">
				</div>
				<c:if test="${user.companyobject != null}">
					<div class="span7 form-inline">
						<h5 align="left" class="textResponse">
							<span class="text-info">Company</span>
						</h5>
						<input class="dataResponse" type="text"
							value="${user.companyobject.companyName.toUpperCase()}"
							readonly="readonly">
					</div>
				</c:if>

				<div class="span7 form-inline">
					<h5 align="left" class="textResponse">
						<span class="text-info">Role</span>
					</h5>
					<input class="dataResponse" type="text" value="${user.designation}"
						readonly="readonly">
				</div>

				<c:if
					test="${user.manager != null && user.manager.lastName != null}">
					<div class="span7 form-inline">
						<h5 align="left" class="textResponse">
							<span class="text-info">Reporting Manager</span>
						</h5>
						<input class="dataResponse" type="text"
							value="${user.manager.firstName.toUpperCase()} ${user.manager.lastName.toUpperCase()}"
							readonly="readonly">
					</div>

				</c:if>

				<div class="control-group">
					<div class="controls">
						<div class="span7 form-inline">
							<h5 align="left" class="textResponse">
								<span class="text-info">New Password</span>
							</h5>
							<input class="dataResponse" type="password" id="password"
								name="password" placeholder="New Password" required value="">
						</div>
					</div>
				</div>
				<div class="span7 form-inline">
					<h5 align="left" class="textResponse">
						<span class="text-info">Confirm New Password</span>
					</h5>
					<input class="dataResponse" type="password" id="cpassword"
						name="cpassword" placeholder="Confirm New Password" required
						value="">
				</div>
			</fieldset>
			<button type="submit" class="btn btn-success"
				style="margin-left: 46%; margin-top: 2%;">Submit</button>
		</form:form>
	</div>
</div>

<script type="text/javascript"
	src="resources/javascripts/jquery.validate.min.js"></script>
<script src="resources/javascripts/bootstrap.min.js"></script>
<script type="text/javascript" src="resources/javascripts/select2.js"></script>
<script type="text/javascript"
	src="resources/javascripts/select2_locale_en.js.template"></script>




<script type="text/javascript">
	$('#changePasswordDiv').hide();
	$('#changePasswordClick').hide();
	$(document)
			.ready(
					function() {
						$("#changePassword")
								.validate(
										{
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
											},

											errorClass : "help-inline",
											errorElement : "span",
											highlight : function(element) {
												$(element).closest(
														'.control-group')
														.removeClass('success')
														.addClass('error');
											},
											success : function(element) {
												element
														.addClass('valid')
														.closest(
																'.control-group')
														.removeClass('error')
														.addClass('success');
											}
										});

					});

	$('#changePasswordButton').click(function() {
		$('#changePasswordDiv').show();
		$('#changePasswordClick').show();
	});
	$('#changePasswordClick').click(function() {
		$('#changePasswordDiv').hide();
		$('#changePasswordClick').hide();
	});

	$(document)
			.ready(
					function() {
						jQuery.validator
								.addMethod(
										"passwordCheck",
										function(value, element) {
											var pattern = /^[A-Za-z0-9]*?([A-Za-z][0-9]|[0-9][A-Za-z])[A-Za-z0-9]*$/;
											var pwd = value;
											if (pattern.test(pwd)) {
												return true;
											} else {
												return false;
											}
										}, "");

					});
</script>
