<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<jsp:include page="menuContext.jsp" />

<!--  <h1 align="center">
	<i>Welcome</i>
</h1>
 -->
<style>
.textResponse {
	font-weight: bold;
	float: left;
}

.dataResponse {
	margin-left: 5%;
}

.container {
	width: 0px!importent;
}

h5 {
	margin-bottom: 0%;
	margin-top: 0%;
}

body {
	font-size: 11px !important;
	/* background-image: url(resources/images/1.jpg); */
}
</style>

<div class="row">
	<div class="col-lg-9 col-md-8">

		<div class="timeline-cover">
			<div class="widget cover">
				<div class="widget-body padding-none margin-none">
					<!-- <div class="top">
						<img src="/resources/images/1.jpg" class="img-responsive"
							style="width: 942px; height: -29%; height: 205px; margin-top: -6%; margin-left: 2%;" />
					</div>
 -->
					<div class="status innerAll" style="margin-left: 3%;">
						<i class="fa fa-quote-left text-muted pull-left fa-fw"></i>
						<p class="lead margin-none">Welcome
							${user.firstName.toUpperCase()} ${user.lastName.toUpperCase()}</p>
					</div>
				</div>
			</div>
		</div>



		<div class="container">
		
			
			<div style="float: left; margin-left: 2%;background: rgb(238, 238, 238); width: 60%; border: 1px solid #4387bf;">
				<div  class="col-sm-6 ui-jqgrid-titlebar ui-widget-header ui-corner-top ">
					<div style="margin-left: 5%;" class="innerAll bg-white">
						<h5>User Profile</h5>
						<div style="float: left;" class="media innerB ">
							<a href="" class="pull-left"> <img
								src="/time/resources/images/user.png" style="margin-left: 2%;"
								width="75" />
							</a>

					</div>
				</div>
			</div>
			
				<div class="" style="width: 50%; margin: 0 auto; float: left;">
					
					<form:form
						action="<%=com.mnt.time.controller.routes.Application.changePassword.url%>"
						id="changePassword">
						<%-- 			
				<div class="span6 form-inline" >
					<h5 align="left" class="textResponse">
						<span class="text-info span3" style="color: #797979">First Name :</span>
						<span>${user.firstName.toUpperCase()}</span>
					</h5>
					
				</div>
				<c:if test="${user.lastName != null}">
					<div class="span6 form-inline">
						<h5 align="left" class="textResponse">
							<span class="text-info span3"style="color: #797979">Last Name :</span>
							<span>${user.lastName.toUpperCase()}</span>
						</h5>
						
						
					</div>
				</c:if>
 --%>
						<div class="span6 form-inline">
							<h5 align="left" class="textResponse">
								<span class="text-info span3" style="color: #797979">Email
									:</span> <span>${user.email}</span>
							</h5>


						</div>
						<div class="span6 form-inline">
							<h5 align="left" class="textResponse">
								<span class="text-info span3" style="color: #797979">Employee
									Id :</span> <span>${user.employeeId}</span>
							</h5>


						</div>
						<c:if test="${user.companyobject != null}">
							<div class="span6 form-inline">
								<h5 align="left" class="textResponse">
									<span class="text-info span3" style="color: #797979">Company
										:</span> <span>${user.companyobject.companyName.toUpperCase()}</span>
								</h5>


							</div>
						</c:if>

						<div class="span6 form-inline">
							<h5 align="left" class="textResponse">
								<span class="text-info span3" style="color: #797979">Role
									:</span> <span>${user.designation}</span>
							</h5>

						</div>

						<c:if
							test="${user.manager != null && user.manager.lastName != null}">
							<div class="span6 form-inline">
								<h5 align="left" class="textResponse">
									<span class="text-info span3" style="color: #797979">Reporting
										Manager :</span> <span>${user.manager.firstName.toUpperCase()}
										${user.manager.lastName.toUpperCase()}</span>
								</h5>


							</div>

						</c:if>

						<div class="control-group">
							<div class="controls">
								<div class="span6 form-inline">
									<h5 align="left" class="textResponse">
										<span class="text-info span3" style="color: #797979">New
											Password</span>
									</h5>
									<input class="dataResponse span3"
										style="width: 143px; margin-right: 16%; padding: 0%; margin-bottom: 1%;"
										type="password" id="password" name="password"
										placeholder="New Password" required value="">
								</div>
							</div>
						</div>
						<div class="span6 form-inline">
							<h5 align="left" class="textResponse">
								<span class="text-info span3" style="color: #797979">Confirm
									New Password</span>
							</h5>
							<input class="dataResponse span3"
								style="padding: 0%; margin-right: 16%; width: 143px;"
								type="password" id="cpassword" name="cpassword"
								placeholder="Confirm New Password" required value="">
						</div>

						<button type="submit" class="btn btn-success"
							style="margin-left: 46%; margin-top: 2%;">Submit</button>
					</form:form>
				</div>
			</div>

			<div
				style="float: right;background: rgb(238, 238, 238); margin-right: 0%; width: 32%; height: 230px; border: 1px solid #4387bf;">
				<h4 class="ui-jqgrid-titlebar ui-widget-header ui-corner-top"
					style="border-bottom: 1px solid black; width: 100%; padding-bottom: 4%; margin-top: 0%; padding-top: 2%; text-align: center;">Notifications</h4>
			    <% int count0 =com.mnt.time.controller.Application.count0(((models.User)request.getAttribute("user")).getEmail());	
				
			 	if(count0 != 0) { %>
			
						<h5 style="text-align: center; margin-right: 10%;">
						    Pending User Request :
							<%=count0 %>
							
						</h5>
						<%} else
						{%>
							<h5 style="margin-left: 10%;"> </h5>
						<%}
			 			%>  
			 
			 
			  <% int count1 =com.mnt.time.controller.Application.count1(((models.User)request.getAttribute("user")).getEmail());	
				
			 	if(count1 != 0) { %>
			
						<h5 style="text-align: center; margin-right: 2%;">
							 Pending Company Request :
							<%=count1 %>
							
						</h5>
						<%} else
						{%>
							<h5 style="margin-left: 10%;"> </h5>
						<%}
			 			%> 
			 			
			 			
			 			<%  int count2 =com.mnt.time.controller.Application.count2(((models.User)request.getAttribute("user")).getEmail());
				  if(count2 != 0) { %>
						<h5 style="text-align: center;">
						   Pending Timesheet Request :
						<%=count2 %>
						</h5>
						<%} else
						{%>
						<h5 style="margin-left: 10%;"> </h5>
						<%}%>  
				  
			 
			 
			  <% int count3 =com.mnt.time.controller.Application.count3(((models.User)request.getAttribute("user")).getEmail()); 
				  
				   if(count3 != 0) { %>
						<h5 style="text-align: center; margin-right: 6%;">
					     Pending Leaves Request :
						<%=count3 %>
						</h5>
						<%}  else
									{%>
									<h5 style="margin-left: 10%;"> </h5>
									<%}%> 
				   
				 
			</div>



		</div>
		<div class="container">
 				<div style="float: right;margin-top: 2%;background: rgb(238, 238, 238); width:32%; height: 225px; border: 1px solid #4387bf;">
		 					<h4 class="ui-jqgrid-titlebar ui-widget-header ui-corner-top" style="border-bottom: 1px solid black; width: 100%;padding-bottom: 4%;margin-top: 0%; padding-top: 2%;text-align: center;">Leaves Balance</h4>
		
					<div class="clearfix"
						style="margin-right: 4%; float: left; width: 100%;">
						<c:forEach var="leave" items="${leaves}" varStatus='loopIndex'>
							<label style="float: left;text-align: center;margin-left: 15%;font-weight: bold;font-size: 12px;"
								for="leave_${loopIndex.index}_leave_name">
								${leaves.get(loopIndex.index).getLeaveLevel().getLeave_type()} : ${leaves.get(loopIndex.index).getBalance()}
							</label>
						</c:forEach>
		
					</div>
		</div>		


		</div>

		</div>

	</div>



	<script type="text/javascript"
		src='<c:url value="resources/javascripts/jquery.validate.min.js"/>'></script>
	<script src='<c:url value="resources/javascripts/bootstrap.min.js"/>'></script>
	<script type="text/javascript" src='<c:url value="resources/javascripts/select2.js"/>'>
	<script type="text/javascript"
		src='<c:url value="resources/javascripts/select2_locale_en.js.template"/>'></script>




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
															.removeClass(
																	'success')
															.addClass('error');
												},
												success : function(element) {
													element
															.addClass('valid')
															.closest(
																	'.control-group')
															.removeClass(
																	'error')
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
