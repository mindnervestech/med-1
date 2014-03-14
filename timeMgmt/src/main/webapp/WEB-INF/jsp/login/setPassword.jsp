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

<script src="resources/javascripts/bootstrap.min.js"></script>
<script type="text/javascript" src="resources/javascripts/jquery.validate.min.js"></script>
<script type="text/javascript" src="resources/javascripts/select2.js"></script>
<script type="text/javascript" src="resources/javascripts/select2_locale_en.js.template"></script>
</head>

<body>

	<div class="container">
		<legend></legend>
		<div class="container">
			<div class="heading">
				<form:form action="changePassword" method="POST" id="changePassword">
					<a href="/"><img alt="" src="resources/images/custom/logo.png"></a>
					<legend></legend>
					<br>
					<br>
					<br>
					<div class="row">
						<div class="well" style="width: 45%">
							<h4>Please Set a New Password</h4>
							<div class="control-group">
								<div class="controls">
									<p>
										<input type="password" id="oldpassword" name="oldpassword"
											placeholder="Current Password" required value="">
									</p>
								</div>
							</div>
							<div class="control-group">
								<div class="controls">
									<input type="password" id="password" name="password"
										placeholder="Password" required value="">
								</div>
							</div>
							<p>
								<input type="password" id="cpassword" name="cpassword"
									placeholder="Confirm Password" required value="">
							</p>
							<button type="submit" class="btn btn-success">Set Password</button>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>
</body>

		
<script type="text/javascript">
	$(document).ready(function() {
		$("#changePassword").validate({
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
				oldpassword : {
					remote : {
						url:"/checkOldPassword",
						type : "post",
						data : {
							q : function(){
								return $("#oldpassword").val(); 
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
			oldpassword : {
				remote : "Enter correct password"					
			}
		},

		errorClass : "help-inline",
		errorElement : "span",
		highlight: function (element) {
		    $(element).closest('.control-group').removeClass('success').addClass('error');
		},
		success: function(element) {
		     element
		        .addClass('valid')
		        .closest('.control-group').removeClass('error').addClass('success');
		}
		});
		
	});
</script>

<script>
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

<style>
body {
	padding-bottom: 40px;
	color: #5a5a5a;
}

h1 {
	margin: 10px 0;
	font-family: walkaway;
	font-weight: bold;
	line-height: 20px;
	color: black;
	text-rendering: optimizelegibility;
	font-style: italic;
}

.copy{
padding-left:60px;
color: grey;

}

.heading {
	padding-top: 40px;
}

.content {
	padding-top: 100px;
	border-color: black;
	border-style: solid;
	border-width: 2px;
}

/* CUSTOMIZE THE NAVBAR
    -------------------------------------------------- */

/* Special class on .container surrounding .navbar, used for positioning it into place. */
.navbar-wrapper {
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	z-index: 10;
	margin-top: 20px;
	margin-bottom: -90px;
	/* Negative margin to pull up carousel. 90px is roughly margins and height of navbar. */
}

.navbar-wrapper .navbar {
	
}

/* Remove border and change up box shadow for more contrast */
.navbar .navbar-inner {
	border: 0;
	-webkit-box-shadow: 0 2px 10px rgba(0, 0, 0, .25);
	-moz-box-shadow: 0 2px 10px rgba(0, 0, 0, .25);
	box-shadow: 0 2px 10px rgba(0, 0, 0, .25);
}

#navbar-inner-scroll {
	border: 0;
	-webkit-box-shadow: 0 2px 10px rgba(0, 0, 0, .25);
	-moz-box-shadow: 0 2px 10px rgba(0, 0, 0, .25);
	box-shadow: 0 2px 10px rgba(0, 0, 0, .25);
	position: relative;
	top: 10px;
}

/* Downsize the brand/project name a bit */
.navbar .brand {
	font-size: 20px;
	font-family: apple chancery;
	font-weight: bold;
	text-shadow: 0 -1px 0 rgba(0, 0, 0, .5);
	padding: 14px 20px 16px;
}

.navbar-inverse .brand,.navbar-inverse .nav>li>a {
	color: #F87217;
	text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
}

/* Navbar links: increase padding for taller navbar */
.navbar .nav>li>a {
	padding: 15px 20px;
}

/* Offset the responsive button for proper vertical alignment */
.navbar .btn-navbar {
	margin-top: 10px;
}

/* MARKETING CONTENT
    -------------------------------------------------- */

/* Center align the text within the three columns below the carousel */
.marketing .span4 {
	text-align: center;
}

.marketing h2 {
	font-weight: normal;
	color: #F87217;
}

.marketing .span4 p {
	margin-left: 10px;
	margin-right: 10px;
}
</style>
